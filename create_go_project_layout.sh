#!/bin/bash

# Check if a project name is provided
if [ -z "$1" ]; then
    echo "Usage: ./create_go_project_layout.sh <project-name> [module...]"
    exit 1
fi

PROJECT_NAME="$1"
shift  # Remove the first argument, which is the project name

# Function to create a directory and handle errors
create_dir() {
    mkdir -p "$1" || { echo "Failed to create directory $1"; exit 1; }
}

# Create base directories
create_dir "${PROJECT_NAME}/cmd/app"
create_dir "${PROJECT_NAME}/internal/util"
create_dir "${PROJECT_NAME}/internal/config"
create_dir "${PROJECT_NAME}/api/proto"
create_dir "${PROJECT_NAME}/configs"
create_dir "${PROJECT_NAME}/scripts"

# Create module directories from additional arguments
for module in "$@"; do
    create_dir "${PROJECT_NAME}/pkg/${module}"
done

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
echo 'FROM golang:1.18-alpine

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

go 1.18" > "${PROJECT_NAME}/go.mod"

# Create README.md file
echo "# ${PROJECT_NAME}

This is a Go project with a standard layout.

## How to build and run

1. Build the project using \`go build -o bin/app ./cmd/app/\`
2. Run the compiled binary: \`./bin/app\`

## Docker

1. Build the Docker image: \`docker-compose build\`
2. Run the Docker container: \`docker-compose up\`

" > "${PROJECT_NAME}/README.md"

# Create go.work file for Go 1.18
echo "go 1.18

use (
    .
)" >> "${PROJECT_NAME}/go.work"

echo "Go project layout for ${PROJECT_NAME} has been created successfully."
