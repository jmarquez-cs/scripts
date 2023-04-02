### To use `create_go_project_layout.sh`, follow these steps:

-    Give the script execution permission by running `chmod +x create_go_project_layout.sh`.  
-    Execute the script by running `./create_go_project_layout.sh <project-name>`, replacing `<project-name>` with the desired project name. (i.e., `./create_go_project_layout.sh my-service`)  
-    This script creates the project layout with basic files, such as the main.go, .gitignore, Dockerfile, docker-compose.yml, go.mod, and README.md. You can customize and expand the script as needed for your specific project requirements.  

output:
```console
project-name/
├── cmd/
│   └── app/
│       └── main.go
├── pkg/
│   ├── module1/
│   │   ├── module1.go
│   │   └── module1_test.go
│   └── module2/
│       ├── module2.go
│       └── module2_test.go
├── internal/
│   ├── util/
│   │   ├── util.go
│   │   └── util_test.go
│   └── config/
│       ├── config.go
│       └── config_test.go
├── api/
│   └── proto/
│       └── api.proto
├── configs/
│   ├── config.yaml
│   └── config.development.yaml
├── scripts/
│   └── build.sh
├── Dockerfile
├── docker-compose.yml
├── .gitignore
├── go.mod
├── go.sum
└── README.md
```  

### To use `create_terraform_project_layout.sh`, follow these steps:

-    Give the script execution permission by running `chmod +x create_terraform_project_layout.sh`
-    Execute the script by running `./create_terraform_project_layout.sh <project-name>`, replacing `<project-name>` with the desired project name.  
-    This script creates the project layout with basic files such as main.tf, variables.tf, outputs.tf, .gitignore, and README.md. You can customize and expand the script as needed for your specific project requirements.  
-    Don't forget to create actual content in the main.tf, variables.tf, and outputs.tf files, as well as configuring the backend and provider settings for each environment in the backend.tf and provider.tf files. Also, update the README.md file to reflect any specific instructions for your project.   
-    This layout will help you manage your Terraform projects with best practices, ensuring a clean, organized, and secure infrastructure-as-code implementation.

output:
```terminal
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