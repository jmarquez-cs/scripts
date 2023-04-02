#!/bin/bash

# Check if a project name is provided
if [ -z "$1" ]; then
    echo "Usage: ./create_go_project_layout.sh <project-name>"
    exit 1
fi

PROJECT_NAME="$1"

# Create directories
mkdir -p "${PROJECT_NAME}/cmd/app"
mkdir -p "${PROJECT_NAME}/pkg/module1"
mkdir -p "${PROJECT_NAME}/pkg/module2"
mkdir -p "${PROJECT_NAME}/internal/util"
mkdir -p "${PROJECT_NAME}/internal/config"
mkdir -p "${PROJECT_NAME}/api/proto"
mkdir -p "${PROJECT_NAME}/configs"
mkdir -p "${PROJECT_NAME}/scripts"

# Create main.go file
echo 'package main

import "fmt"

func main() {
    fmt.Println("Hello, World!")
}' > "${PROJECT_NAME}/cmd/app/main.go"

# Create .gitignore file
echo 'vendor/
*.log
*.out
*.test
*.test.coverprofile
*.prof
bin/
.idea/
.vscode/' > "${PROJECT_NAME}/.gitignore"

# Create Dockerfile
echo 'FROM golang:1.17-alpine

WORKDIR /app

COPY go.mod .
COPY go.sum .

RUN go mod download

COPY . .

RUN go build -o /app/bin/app ./cmd/app

ENTRYPOINT ["/app/bin/app"]' > "${PROJECT_NAME}/Dockerfile"

# Create docker-compose.yml file
echo 'version: "3.8"

services:
  app:
    build: .
    ports:
      - "8080:8080"' > "${PROJECT_NAME}/docker-compose.yml"

# Create go.mod file
echo "module ${PROJECT_NAME}

go 1.17" > "${PROJECT_NAME}/go.mod"

# Create README.md file
echo "# ${PROJECT_NAME}

This is a Go project with a standard layout.

## How to build and run

1. Build the project using \`go build -o bin/app ./cmd/app\`
2. Run the compiled binary: \`./bin/app\`

## Docker

1. Build the Docker image: \`docker-compose build\`
2. Run the Docker container: \`docker-compose up\`

" > "${PROJECT_NAME}/README.md"

echo "Go project layout for ${PROJECT_NAME} has been created successfully."
