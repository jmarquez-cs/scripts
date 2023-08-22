#!/bin/bash

# Check if a project name was provided
if [[ -z $1 ]]; then
    echo "Usage: $0 <project_name>"
    exit 1
fi

# Set the project name from the argument
PROJECT_NAME=$1

# Create the directory structure
mkdir -p $PROJECT_NAME/deployments/app
mkdir -p $PROJECT_NAME/deployments/db
mkdir -p $PROJECT_NAME/services/app
mkdir -p $PROJECT_NAME/services/db
mkdir -p $PROJECT_NAME/configmaps
mkdir -p $PROJECT_NAME/secrets
mkdir -p $PROJECT_NAME/ingress
mkdir -p $PROJECT_NAME/helm-charts/app/templates
mkdir -p $PROJECT_NAME/helm-charts/db/templates
mkdir -p $PROJECT_NAME/scripts

# Create sample README.md file
cat > "${PROJECT_NAME}/README.md" << EOF
# ${PROJECT_NAME}

This is a Kubernetes project.

## Directory structure

- /deployments: This directory contains all the Deployment configurations for your project. You might want to create subdirectories for each deployment (for example, for your application and database deployments).
- /services: This directory contains all the Service configurations. Similar to deployments, you might want to create subdirectories for each service.
- /configmaps: This directory is for ConfigMap configurations. ConfigMaps allow you to decouple configuration artifacts from image content to keep containerized applications portable.
- /secrets: This directory contains Kubernetes Secrets. Secrets let you store and manage sensitive information, such as passwords, OAuth tokens, and ssh keys.
- /ingress: This directory holds Ingress configurations. An Ingress is an API object that manages external access to the services in a cluster, typically HTTP.
- /helm-charts: Helm is a package manager for Kubernetes. It allows developers to create packages of pre-configured Kubernetes resources. If you're using Helm, this is where you'd keep your Helm charts.
- /scripts: Any scripts that aid in setting up or tearing down resources can be kept in this directory. This might include shell scripts, python scripts, etc.
- README.md: A markdown file that includes information about the project, how to install and deploy it, and any other important details.


Remember, this is just a guideline. You can adapt this structure based on your specific needs and the complexity of your project.
EOF

# Output the created project structure
echo "Project $PROJECT_NAME with the Kubernetes project structure has been created successfully."
