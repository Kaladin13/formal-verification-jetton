# Ton Jettons formal verification

HTTP server for TON jetton honeypot analysis. Wraps the symbolic analyzer as a REST API with in-memory caching.

Project uses [TSA](https://tonsec.dev/docs) tool as engine runtime for Tolk checkers.

Symbolic cross-contract checkers are the core part of the project as they define the underlying logic.

## Architecture

```
GET /api/analyze?address=0:abc...
  → Rust server (axum)
    → check in-memory cache
    → cache miss: spawn java -jar tsa-jettons.jar -a {address}
    → parse JSON from stdout
    → cache result, return response
```

The analyzer uses symbolic execution to check jetton wallet contracts for:
- **Hidden transfer fees** — balance decreases by more than the transfer amount
- **Conditional blocking** — unauthorized addresses can modify wallet state
- **Getter integrity violations** — `get_wallet_data()` reports a different balance than what's in storage
- **Address blacklists** — transfers blocked to specific destination addresses

## Prerequisites

- **Rust** 1.70+ (`rustup` recommended)
- **JDK 21** (JDK 24 is incompatible with the analyzer's Gradle build)
- **tsa-jettons shadow JAR** (built from the JVM symbolic runtime monorepo)

## Build

### 1. Build the analyzer JAR

From the monorepo root:

```bash
export JAVA_HOME=/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home

./gradlew :tsa-jettons:shadowJar
```

This produces `tsa-jettons/build/libs/tsa-jettons.jar` (~94 MB fat JAR with all dependencies).

Verify it works standalone:

```bash
java -jar tsa-jettons/build/libs/tsa-jettons.jar \
  -a 0:ae5d4a0ebd6220602339d94a939f1fc7e6c444a7f5d49aa0201aa3d264fd7da3
```

### 2. Build the server

```bash
cd tsa-jettons-server
cargo build --release
```

## Configuration

Copy the example env file and adjust paths:

```bash
cp .env.example .env
```

| Variable       | Default             | Description                        |
|----------------|---------------------|------------------------------------|
| `TSA_JAR_PATH` | `./tsa-jettons.jar` | Path to the tsa-jettons shadow JAR |
| `JAVA_HOME`    | system default      | JDK 21 installation path           |
| `PORT`         | `8080`              | Server listen port                 |

## Run

```bash
cargo run --release
```

Or with env vars inline:

```bash
TSA_JAR_PATH=../tsa-jettons/build/libs/tsa-jettons.jar \
JAVA_HOME=/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home \
  cargo run --release
```

## API

### `GET /health`

Health check.

```bash
curl http://localhost:8080/health
```

```json
{"status": "ok"}
```

### `GET /api/analyze?address={minter_address}`

Run honeypot analysis on a jetton minter contract. The address should be in raw format (`0:hex...`).

```bash
curl "http://localhost:8080/api/analyze?address=0:ae5d4a0ebd6220602339d94a939f1fc7e6c444a7f5d49aa0201aa3d264fd7da3"
```

```json
{
  "analyzedAddress": "0:ae5d4a0ebd6220602339d94a939f1fc7e6c444a7f5d49aa0201aa3d264fd7da3",
  "jettonWalletCodeHashBase64": "ImgwVG3JqxaH3HK8il7cxgIQORp8YGmMT+ImYY13jWg=",
  "blacklistedAddresses": [],
  "hasHiddenTransferFee": false,
  "hasConditionalBlocking": false,
  "hasGetterIntegrityViolation": true
}
```

First request takes ~10s (symbolic execution). Subsequent requests for the same address are served from cache instantly.

### Error responses

| Status | Condition                                          |
|--------|----------------------------------------------------|
| 400    | Missing or empty `address` parameter               |
| 500    | Analyzer process failed or returned invalid output |
| 504    | Analysis exceeded 5-minute timeout                 |

```json
{"error": "address parameter required"}
{"error": "analysis failed", "details": "...stderr..."}
```

## Docker

Build the shadow JAR first, copy it into `tsa-jettons-server/`, then build the image:

```bash
# 1. Build the shadow JAR (from repo root)
JAVA_HOME=/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home \
  ./gradlew :tsa-jettons:shadowJar

# 2. Copy JAR into the Docker build context
cp tsa-jettons/build/libs/tsa-jettons.jar tsa-jettons-server/tsa-jettons.jar

# 3. Build the image (from tsa-jettons-server/)
cd tsa-jettons-server
docker build -t tsa-jettons-server .

# 4. Run
docker run -p 8080:8080 tsa-jettons-server

# 5. Test
curl "http://localhost:8080/api/analyze?address=0:ae5d4a0ebd6220602339d94a939f1fc7e6c444a7f5d49aa0201aa3d264fd7da3"
```

The image compiles the Rust binary during build, then produces a minimal runtime with JRE 21 + the server binary + the JAR.

## Limitations

- Only tokens with **inline wallet code** can be analyzed. Tokens using library cells (e.g., USDT) return an error because the analyzer cannot resolve library cell references without a liteserver connection. (tonapi not always has them)
- The getter integrity checker has a known **false positive rate of ~70%** on real tokens
- Each uncached analysis spawns a JVM process (~2s startup + ~10s analysis). The in-memory cache prevents repeated work but is lost on server restart.
