sed -i "s~ENV DATABASE_TYPE \$DATABASE_TYPE~ENV DATABASE_TYPE postgresql~g" ./Dockerfile

docker buildx build . --output type=docker,name=elestio4test/umami:latest | docker load
