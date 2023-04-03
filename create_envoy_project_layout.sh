#!/bin/bash

# Check if the project name is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <project-name> [--with-ngrok]"
  exit 1
fi

PROJECT_NAME="$1"
WITH_NGROK=false

if [ "$2" == "--with-ngrok" ]; then
  WITH_NGROK=true
fi

# Create the directory structure
mkdir -p "${PROJECT_NAME}/envoy-config"
mkdir -p "${PROJECT_NAME}/docker"
mkdir -p "${PROJECT_NAME}/services/service1"
mkdir -p "${PROJECT_NAME}/services/service2"
mkdir -p "${PROJECT_NAME}/tls/certs"
mkdir -p "${PROJECT_NAME}/tls/ca"
mkdir -p "${PROJECT_NAME}/scripts"

# Create configuration files
touch "${PROJECT_NAME}/envoy-config/envoy.yaml"
touch "${PROJECT_NAME}/envoy-config/front-envoy.yaml"
touch "${PROJECT_NAME}/envoy-config/back-envoy.yaml"
touch "${PROJECT_NAME}/services/service1/service1-config.yaml"
touch "${PROJECT_NAME}/services/service2/service2-config.yaml"
touch "${PROJECT_NAME}/scripts/deploy.sh"

# Create main Envoy configuration file
cat > "${PROJECT_NAME}/envoy-config/envoy.yaml" << EOF
# envoy-config/envoy.yaml
static_resources:
  listeners:
  - name: listener_0
    address:
      socket_address: { address: 0.0.0.0, port_value: 10000 }
    filter_chains:
    - filters:
      - name: envoy.filters.network.http_connection_manager
        typed_config:
          "@type": type.googleapis.com/envoy.extensions.filters.network.http_connection_manager.v3.HttpConnectionManager
          stat_prefix: ingress_http
          route_config:
            name: local_route
            virtual_hosts:
            - name: local_service
              domains: ["*"]
              routes:
              - match: { prefix: "/" }
                route: { cluster: some_service }
          http_filters:
          - name: envoy.filters.http.router

  clusters:
  - name: some_service
    connect_timeout: 0.25s
    type: STRICT_DNS
    lb_policy: ROUND_ROBIN
    load_assignment:
      cluster_name: some_service
      endpoints:
      - lb_endpoints:
        - endpoint:
            address:
              socket_address: { address: some_service, port_value: 8080 }
EOF

# Create Dockerfile
cat > "${PROJECT_NAME}/docker/Dockerfile" << EOF
# Use the official Envoy Docker image as a base
FROM envoyproxy/envoy:v1.18-latest

# Copy the Envoy configuration file
COPY ./envoy-config/envoy.yaml /etc/envoy/envoy.yaml

# Expose the ports used by Envoy
EXPOSE 10000 9901

# Start Envoy using the provided configuration file
CMD ["/usr/local/bin/envoy", "-c", "/etc/envoy/envoy.yaml"]
EOF

# Create docker-compose.yml
cat > "${PROJECT_NAME}/docker/docker-compose.yml" << EOF
version: "3.9"

services:
  envoy:
    build:
      context: ..
      dockerfile: docker/Dockerfile
    ports:
      - "9901:9901"
      - "10000:10000"
    volumes:
      - ../envoy-config:/etc/envoy
    networks:
      - envoy-net

  some_service:
    image: your-service-image
    networks:
      - envoy-net

networks:
  envoy-net:
EOF

if [ "$WITH_NGROK" = true ]; then
  # Create ngrok.yml
  touch "${PROJECT_NAME}/docker/ngrok.yml"
  cat > "${PROJECT_NAME}/docker/ngrok.yml" << EOF
authtoken: <your-ngrok-auth-token>
tunnels:
  envoy:
    addr: envoy:10000
    proto: http
EOF
  # Add ngrok service to docker-compose.yml
  cat >> "${PROJECT_NAME}/docker/docker-compose.yml" << EOF

  ngrok:
    image: wernight/ngrok
    depends_on:
      - envoy
    command: ngrok http envoy:10000 --config /etc/ngrok/ngrok.yml
    volumes:
      - ./ngrok.yml:/etc/ngrok/ngrok.yml
    ports:
      - "4040:4040"
    networks:
      - envoy-net
EOF
fi

# Create .gitignore
cat > "${PROJECT_NAME}/.gitignore" << EOF
# Ignore TLS certificates and keys
/tls/certs/*
/tls/ca/*
!/.gitkeep

# Ignore other sensitive or temporary files
*.bak
*.tmp
*.swp
EOF

# Create README.md
cat > "${PROJECT_NAME}/README.md" << EOF
# ${PROJECT_NAME}

This is an Envoy Proxy project.

## Directory structure

- envoy-config/: Contains the main Envoy configuration files.
- docker/: Contains Dockerfile, docker-compose.yml files for building and running Envoy and associated services, and optional ngrok.yml configuration file for Ngrok integration.
- services/: Contains subdirectories for each service, with their respective configuration files.
- tls/: Contains TLS certificates and keys for secure communication.
  - certs/: Holds the certificate and private key files for each domain.
  - ca/: Holds the Certificate Authority (CA) certificates.
- scripts/: Contains any utility or deployment scripts.
- .gitignore: Specifies files and directories that Git should ignore.
- README.md: Provides an overview of the project, how to set up and run the project, and any other relevant information.

## Setup and running

To set up and run the Envoy Proxy project using Docker Compose:

1. Make sure Docker and Docker Compose are installed on your system.
2. Navigate to the \`docker\` directory: \`cd ${PROJECT_NAME}/docker\`.
3. Build and start the Envoy Proxy container: \`docker-compose up --build\`.

The Envoy Proxy will now be running and listening on ports 9901 (admin interface) and 10000 (proxy listener).

## Optional Ngrok integration

If you have set up the project with Ngrok integration, you can expose your Envoy Proxy through an Ngrok tunnel:

1. Sign up for an Ngrok account and get your authtoken: https://ngrok.com/
2. Replace \`<your-ngrok-auth-token>\` in the \`docker/ngrok.yml\` file with your actual Ngrok authtoken.
3. Start the Ngrok tunnel by running \`docker-compose up --build\` if you haven't already.
4. Access the Ngrok web interface at http://localhost:4040 to view the public URL for your Envoy Proxy.

EOF

echo "Envoy project layout for '${PROJECT_NAME}' has been created."
