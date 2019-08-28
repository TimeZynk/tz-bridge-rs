FROM openapitools/openapi-generator-cli:v4.1.1 AS generator

RUN docker-entrypoint.sh generate \
    -i https://raw.githubusercontent.com/TimeZynk/bridge-api-spec/v0.1.0/spec/openapi.yaml \
    -g rust-server \
    -DpackageName=timezynk-bridge-models \
    -o /local/rust-server
WORKDIR /local/rust-server
RUN sed 's/authors.*/authors = ["Timezynk <dev@timezynk.com>"]/' Cargo.toml > cargo.tmp && \
    mv cargo.tmp Cargo.toml

FROM rust:1.36-slim-stretch
RUN apt-get update && \
    apt-get install -y libssl1.0-dev ca-certificates pkg-config && \
    rm -rf /var/lib/apt/lists/*
COPY --from=generator /local/rust-server /opt/timezynk-bridge-models
WORKDIR /opt/timezynk-bridge-models
