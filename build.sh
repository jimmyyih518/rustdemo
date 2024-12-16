#!/usr/bin/env bash

set -euo pipefail

# Optional: specify your Docker image name/tag
IMAGE_NAME="rust-pytorch-model"

echo "=== Cargo Clean ==="
cargo clean

echo "=== Cargo Build (release) ==="
cargo build --release

echo "=== Cargo Test ==="
cargo test --release

echo "=== Local Test Run ==="
# Run the binary locally to verify correct behavior before containerizing.
# Remove or comment out if not needed.
# ./target/release/your_binary_name

echo "=== Docker Build ==="
docker build -t "$IMAGE_NAME" .

echo "=== Docker Run ==="
# Adjust port mapping and other options as needed. For example:
docker run --rm -p 8080:8080 "$IMAGE_NAME"
