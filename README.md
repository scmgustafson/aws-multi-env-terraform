# AWS Multi-Environment Terraform Infrastructure

This repository contains a modular, production-style infrastructure-as-code (IaC) setup using Terraform to deploy a web application stack on AWS. It follows HashiCorp best practices and is designed to support multiple isolated environments (dev, staging, prod) with remote state.

---

## 📦 Project Structure

aws-multi-env-terraform/
├── README.md # This file
├── environments/ # Per-environment configs (dev, staging, prod)
│ ├── dev/
│ ├── staging/
│ └── prod/
├── modules/ # Reusable modules (network, web, db, etc.)
│ ├── network/
│ ├── web/
│ └── db/
└── .devcontainer/ # VS Code remote container setup

---

## ☁️ Backend Setup

Before using any environment, you must provision the S3 bucket and DynamoDB table that Terraform will use for remote state locking and storage.

### 🔧 Steps to Initialize Backend

1. Change this `main.tf` file to use your desired S3 bucket info

2. Initialize and apply the backend config:
   terraform init
   terraform apply

This will create:

- An S3 bucket (to store Terraform state files)

Once complete, you can safely deploy infrastructure from any environment directory using workspaces and remote state.

---

## 🚀 Deploy an Environment

Each environment (dev, staging, prod) has its own configuration directory. To deploy an environment:

cd environments/dev # or staging, or prod
terraform init
terraform apply

Outputs will include:

- Public DNS of the EC2 web server

---

## 🧪 Testing and Cleanup

To destroy a specific environment:

cd environments/dev
terraform destroy

---

## 🧠 Notes

- Secrets (e.g., DB credentials) should be passed via .tfvars (never hardcoded).
- You can customize environments using separate .tfvars files.
- This setup is safe to use with VS Code Dev Containers.

---

## 📄 License

MIT © [Seth Gustafson]
