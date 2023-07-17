docker buildx build --build-arg DATABASE_TYPE=postgresql . --output type=docker,name=elestio4test/umami:latest | docker load
