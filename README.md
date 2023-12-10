# Scripts

[![Test Scripts](https://github.com/ScooterHelmet/scripts/actions/workflows/test-scripts.yml/badge.svg)](https://github.com/ScooterHelmet/scripts/actions/workflows/test-scripts.yml)

## To use `create_go_project_layout.sh`, follow these steps

- Give the script execution permission by running `chmod +x create_go_project_layout.sh`.
- Execute the script by running `./create_go_project_layout.sh <project-name> <modules...>`
  - Replace `<project-name>` with the desired project name. (i.e., `./create_go_project_layout.sh my-service`)
  - Replace `<modules...>` with the desired modules. (i.e., `./create_go_project_layout.sh my-service module1 module2 module3`)
- This script creates the project layout with basic files, such as the main.go, .gitignore, Dockerfile, docker-compose.yml, go.mod, go.work, and README.md. You can customize and expand the script as needed for your specific project requirements.

output:

```console
project-name/
├── api/
│   └── proto/
├── cmd/
│   └── app/
│       └── main.go
├── configs/
├── internal/
│   ├── util/
│   └── config/
├── pkg/
│   ├── module1/
│   └── module2/
│   └── module3/
├── scripts/
├── .gitignore
├── docker-compose.yml
├── Dockerfile
├── go.mod
├── go.work
└── README.md
```

### To use `create_terraform_project_layout.sh`, follow these steps

- Give the script execution permission by running `chmod +x create_terraform_project_layout.sh`
- Execute the script by running `./create_terraform_project_layout.sh <project-name>`, replacing `<project-name>` with the desired project name.
- This script creates the project layout with basic files such as main.tf, variables.tf, outputs.tf, .gitignore, and README.md. You can customize and expand the script as needed for your specific project requirements.
- Don't forget to create actual content in the main.tf, variables.tf, and outputs.tf files, as well as configuring the backend and provider settings for each environment in the backend.tf and provider.tf files. Also, update the README.md file to reflect any specific instructions for your project.
- This layout will help you manage your Terraform projects with best practices, ensuring a clean, organized, and secure infrastructure-as-code implementation.

output:

```console
terraform-project/
├── main.tf
├── variables.tf
├── outputs.tf
├── modules/
│   ├── module1/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── README.md
│   └── module2/
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       └── README.md
├── environments/
│   ├── dev/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   ├── backend.tf
│   │   └── provider.tf
│   └── prod/
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       ├── backend.tf
│       └── provider.tf
├── .gitignore
└── README.md
```

### To use `create_envoy_project_layout.sh`, follow these steps

- Make the script executable by running `chmod +x create_envoy_project_layout.sh`.
- Execute the script by running `./create_envoy_project_layout.sh <project-name>`, replacing `<project-name>` with the desired project name.
- Optionally, The Ngrok integration will be added only if the user provides the `--with-ngrok` flag when running the script. This will generate a sample ngrok.yml configuration file and add an optional ngrok service to the docker-compose.yml file.
- This script creates the directory structure and basic files for an Envoy Proxy project. You can customize and expand the script as needed for your specific project requirements. Don't forget to fill in the actual content in the configuration files and update the README.md file to provide specific instructions for your project.

output:

```console
envoy-project/
├── envoy-config/
│   ├── envoy.yaml
│   ├── front-envoy.yaml
│   └── back-envoy.yaml
├── docker/
│   ├── Dockerfile
│   └── docker-compose.yml
├── services/
│   ├── service1/
│   │   └── service1-config.yaml
│   └── service2/
│       └── service2-config.yaml
├── tls/
│   ├── certs/
│   │   ├── example.com.crt
│   │   └── example.com.key
│   └── ca/
│       └── ca.crt
├── scripts/
│   └── deploy.sh
├── .gitignore
└── README.md
```

## To use `create_discord_bot_project_layout.sh`, follow these steps

- Make the script executable by running `chmod +x create_discord_bot_project_layout.sh`
- Execute the script by running `./create_discord_bot_project_layout.sh <project-name>`, replacing `<project-name>` with the desired project name.
- This script creates the directory structure and basic files for a Discord Bot project. You can customize and expand the script as needed for your specific project requirements. Don't forget to fill in the actual content in the configuration files and update the README.md file to provide specific instructions for your project.

output:

```console
discord-bot-project/
│
├── src/
│   ├── commands/
│   ├── events/
│   ├── interfaces/
│   ├── models/
│   ├── structures/
│   ├── utils/
│   └── index.ts
│
├── test/
│
├── .gitignore
├── .editorconfig
├── .eslintrc.json
├── .prettierrc.json
├── tsconfig.json
├── package.json
└── .env
```

## To use `create_k8s_project_layout.sh`, follow these steps

- Make the script executable by running `chmod +x create_k8s_project_layout.sh`
- Execute the script by running `./create_k8s_project_layout.sh <project-name>`, replacing `<project-name>` with the desired project name.
- This script creates the directory structure and basic files for a Kubernetes project. You can customize and expand the script as needed for your specific project requirements. Don't forget to fill in the actual content in the configuration files and update the README.md file to provide specific instructions for your project.

output:

```console
k8s-project/
│
├── configmaps/
├── deployments/
│   ├── app/
│   └── db/
├── helm-charts/
│   ├── app/
│       └── templates/
│   └── db/
│       └── templates/
├── ingress/
├── scripts/
├── secrets/
├── services/
│   ├── app/
│   └── db/
└── README.md
```
