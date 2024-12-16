# Use an official Rust image as a base
FROM rust:latest

# Install dependencies for downloading and extracting libtorch
RUN apt-get update && apt-get install -y wget unzip && rm -rf /var/lib/apt/lists/*

# Download and unpack the Linux CPU version of libtorch
RUN wget https://download.pytorch.org/libtorch/cpu/libtorch-cxx11-abi-shared-with-deps-1.13.1%2Bcpu.zip -O libtorch.zip && \
    unzip libtorch.zip -d /usr/local && \
    rm libtorch.zip

# Set LD_LIBRARY_PATH so that rust_pytorch_model can find libtorch libraries
ENV LD_LIBRARY_PATH=/usr/local/libtorch/lib:$LD_LIBRARY_PATH

# Create a working directory
WORKDIR /app

# Copy the current directory's contents to the container
COPY . .

# Build the Rust application
RUN cargo build --release

# Expose a port (for potential APIs)
EXPOSE 8080

# Command to run the application
CMD ["./target/release/rust_pytorch_model"]
