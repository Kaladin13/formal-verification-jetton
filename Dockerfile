# Stage 1: Build the Rust binary
FROM rust:1.85-bookworm AS builder

WORKDIR /build

# Cache dependencies by building a dummy project first
COPY Cargo.toml ./
RUN mkdir src && echo "fn main() {}" > src/main.rs \
    && cargo build --release \
    && rm -rf src target/release/deps/tsa_jettons_server*

# Build the real binary
COPY src/ src/
RUN cargo build --release


# Stage 2: Runtime image with JRE 21
FROM eclipse-temurin:21-jre-noble

RUN useradd --create-home --shell /bin/bash app

WORKDIR /app

COPY --from=builder /build/target/release/tsa-jettons-server ./tsa-jettons-server

# Pre-built shadow JAR — build locally first:
#   JAVA_HOME=/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home \
#     ./gradlew :tsa-jettons:shadowJar
COPY tsa-jettons.jar ./tsa-jettons.jar

ENV TSA_JAR_PATH=/app/tsa-jettons.jar
ENV JAVA_HOME=/opt/java/openjdk
ENV PORT=8080

USER app

EXPOSE 8080

CMD ["./tsa-jettons-server"]
