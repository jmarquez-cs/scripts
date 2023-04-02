#!/bin/bash

# Check if a project name is provided
if [ -z "$1" ]; then
    echo "Usage: ./create_terraform_project_layout.sh <project-name>"
    exit 1
fi

PROJECT_NAME="$1"

# Create directories
mkdir -p "${PROJECT_NAME}/modules/module1"
mkdir -p "${PROJECT_NAME}/modules/module2"
mkdir -p "${PROJECT_NAME}/environments/dev"
mkdir -p "${PROJECT_NAME}/environments/prod"

# Create main.tf, variables.tf, and outputs.tf files
touch "${PROJECT_NAME}/main.tf"
touch "${PROJECT_NAME}/variables.tf"
touch "${PROJECT_NAME}/outputs.tf"

# Create .gitignore file
echo '.terraform/
*.tfstate
*.tfstate.backup
*.tfvars' > "${PROJECT_NAME}/.gitignore"

# Create README.md file
echo "# ${PROJECT_NAME}

This is a Terraform project with a professional layout.

## How to initialize and apply

1. Change to the desired environment directory: \`cd environments/dev\` or \`cd environments/prod\`
2. Initialize the Terraform project: \`terraform init\`
3. Apply the Terraform configuration: \`terraform apply\`

" > "${PROJECT_NAME}/README.md"

echo "Terraform project layout for ${PROJECT_NAME} has been created successfully."
