use axum::{
    extract::{Query, State},
    http::StatusCode,
    response::IntoResponse,
    routing::get,
    Json, Router,
};
use serde::{Deserialize, Serialize};
use std::{
    collections::HashMap,
    env,
    process::Stdio,
    sync::Arc,
    time::Duration,
};
use tokio::{process::Command, sync::RwLock, time::timeout};
use tower_http::services::ServeDir;

struct AppState {
    cache: RwLock<HashMap<String, serde_json::Value>>,
    jar_path: String,
    java_home: Option<String>,
}

#[derive(Deserialize)]
struct AnalyzeQuery {
    address: Option<String>,
}

#[derive(Serialize)]
struct ErrorResponse {
    error: String,
    #[serde(skip_serializing_if = "Option::is_none")]
    details: Option<String>,
}

#[derive(Serialize)]
struct HealthResponse {
    status: String,
}

async fn health() -> Json<HealthResponse> {
    Json(HealthResponse {
        status: "ok".to_string(),
    })
}

async fn analyze(
    State(state): State<Arc<AppState>>,
    Query(query): Query<AnalyzeQuery>,
) -> Result<impl IntoResponse, (StatusCode, Json<ErrorResponse>)> {
    let address = query.address.ok_or_else(|| {
        (
            StatusCode::BAD_REQUEST,
            Json(ErrorResponse {
                error: "address parameter required".to_string(),
                details: None,
            }),
        )
    })?;

    if address.is_empty() {
        return Err((
            StatusCode::BAD_REQUEST,
            Json(ErrorResponse {
                error: "address parameter must not be empty".to_string(),
                details: None,
            }),
        ));
    }

    // Check cache
    {
        let cache = state.cache.read().await;
        if let Some(cached) = cache.get(&address) {
            return Ok(Json(cached.clone()));
        }
    }

    // Run analysis
    let result = run_analysis(&state.jar_path, &state.java_home, &address).await?;

    // Store in cache
    {
        let mut cache = state.cache.write().await;
        cache.insert(address, result.clone());
    }

    Ok(Json(result))
}

async fn run_analysis(
    jar_path: &str,
    java_home: &Option<String>,
    address: &str,
) -> Result<serde_json::Value, (StatusCode, Json<ErrorResponse>)> {
    let java_bin = match java_home {
        Some(home) => format!("{}/bin/java", home),
        None => "java".to_string(),
    };

    let child = Command::new(&java_bin)
        .args(["-jar", jar_path, "-a", address])
        .stdout(Stdio::piped())
        .stderr(Stdio::piped())
        .spawn()
        .map_err(|e| {
            (
                StatusCode::INTERNAL_SERVER_ERROR,
                Json(ErrorResponse {
                    error: "failed to start analyzer".to_string(),
                    details: Some(e.to_string()),
                }),
            )
        })?;

    let output = timeout(Duration::from_secs(360), child.wait_with_output())
        .await
        .map_err(|_| {
            (
                StatusCode::GATEWAY_TIMEOUT,
                Json(ErrorResponse {
                    error: "analysis timed out".to_string(),
                    details: Some("analysis exceeded 6 minute timeout".to_string()),
                }),
            )
        })?
        .map_err(|e| {
            (
                StatusCode::INTERNAL_SERVER_ERROR,
                Json(ErrorResponse {
                    error: "analyzer process failed".to_string(),
                    details: Some(e.to_string()),
                }),
            )
        })?;

    if !output.status.success() {
        let stderr = String::from_utf8_lossy(&output.stderr);
        return Err((
            StatusCode::INTERNAL_SERVER_ERROR,
            Json(ErrorResponse {
                error: "analysis failed".to_string(),
                details: Some(stderr.to_string()),
            }),
        ));
    }

    let stdout = String::from_utf8_lossy(&output.stdout);
    let stderr = String::from_utf8_lossy(&output.stderr);

    if !stderr.is_empty() {
        eprintln!("[analyzer stderr] {}", stderr);
    }
    eprintln!("[analyzer stdout] {}", stdout);

    // The JAR outputs JSON preceded by possible warning lines on stderr.
    // Find the JSON object in stdout (starts with '{', ends with '}').
    let json_start = stdout.find('{').ok_or_else(|| {
        (
            StatusCode::INTERNAL_SERVER_ERROR,
            Json(ErrorResponse {
                error: "invalid analyzer output".to_string(),
                details: Some("no JSON found in output".to_string()),
            }),
        )
    })?;

    let json_str = &stdout[json_start..];

    serde_json::from_str(json_str).map_err(|e| {
        (
            StatusCode::INTERNAL_SERVER_ERROR,
            Json(ErrorResponse {
                error: "invalid analyzer output".to_string(),
                details: Some(e.to_string()),
            }),
        )
    })
}

#[tokio::main]
async fn main() {
    dotenvy::dotenv().ok();

    let jar_path = env::var("TSA_JAR_PATH").unwrap_or_else(|_| "./tsa-jettons.jar".to_string());
    let java_home = env::var("JAVA_HOME").ok();
    let port: u16 = env::var("PORT")
        .ok()
        .and_then(|p| p.parse().ok())
        .unwrap_or(8080);

    let state = Arc::new(AppState {
        cache: RwLock::new(HashMap::new()),
        jar_path: jar_path.clone(),
        java_home: java_home.clone(),
    });

    let frontend_dir = env::var("FRONTEND_DIR").unwrap_or_else(|_| "./frontend".to_string());

    let app = Router::new()
        .route("/health", get(health))
        .route("/api/analyze", get(analyze))
        .with_state(state)
        .fallback_service(ServeDir::new(&frontend_dir));

    let bind_addr = format!("0.0.0.0:{}", port);
    println!("Starting tsa-jettons-server on {}", bind_addr);
    println!("  JAR path: {}", jar_path);
    println!("  Frontend: {}", frontend_dir);
    println!(
        "  JAVA_HOME: {}",
        java_home.as_deref().unwrap_or("(system default)")
    );

    let listener = tokio::net::TcpListener::bind(&bind_addr).await.unwrap();
    axum::serve(listener, app).await.unwrap();
}
