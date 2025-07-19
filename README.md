# 🚀 Terraform Azure Environments & Reusable VNet Module

## 🧠 Challenge Overview

This project is a submission for the Azure Terraform Infrastructure Challenge, showcasing reusable Terraform modules, multi-environment infrastructure provisioning, and GitHub Actions CI/CD workflows.

- **Module Repo:** [terraform-azure-vnet-module](https://github.com/santhosh-chindam/terraform-azure-vnet-module)
- **Environment Repo:** [terraform-azure-environments](https://github.com/santhosh-chindam/terraform-azure-environments)

---

## 📦 Objective

- ✅ Build a **reusable Terraform module** to provision an Azure Virtual Network (VNet).
- ✅ Use this module to **create multiple environments** (e.g., dev, test, prod).
- ✅ Add additional resources like **VM**, **Storage Account**, and **Public IP**.
- ✅ Deploy using a **GitHub Actions workflow**.
- ✅ Emphasize **clean code**, **secure practices**, and **scalability**.

🔁 Module Usage
Module: terraform-azure-vnet-module
Features:
Creates a Virtual Network, Subnets, Network Security Groups, and NSG associations.

Accepts configurable variables for name, address space, subnets, tags, and more.

Outputs:

VNet name and ID

Subnet names and IDs

Resource group and location

Example Use:


module "vnet" {
  source              = "github.com/santhosh-chindam/terraform-azure-vnet-module"
  vnet_name           = var.vnet_name
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  address_space       = var.address_space
  subnets             = var.subnets
  tags                = var.tags
}

🌍 Multi-Environment Setup
Each environment (dev, test, production) uses the shared VNet module but has its own configuration values via terraform.tfvars. This makes the setup:

Scalable (add more envs easily)

Maintainable (central logic in the module)

Secure (environment-level secrets)

⚙️ Resources Created
✅ Core Infrastructure
Virtual Network (VNet)

Subnets

Network Security Group (NSG)

✅ Additional Resources
Linux Virtual Machine

Public IP (Standard, Static)

Azure Storage Account

🔐 GitHub Actions Workflow
File: .github/workflows/terraform-deploy.yml
✅ Features
Triggered manually via workflow_dispatch with dropdowns:

environment (dev/test/production)

region (eastus, westeurope, etc.)

Uses a matrix strategy but only deploys selected environment.

Includes steps:

Checkout

Setup Terraform

init, validate, plan, apply (if main branch)

Uses GitHub Secrets per environment:

AZURE_CLIENT_ID

AZURE_CLIENT_SECRET

AZURE_SUBSCRIPTION_ID

AZURE_TENANT_ID

🚀 Deployment Steps
Go to Actions tab → Run workflow.

Choose the environment and region.

Click Run.

Only the selected environment will be deployed.

🧪 Terraform Plan Output
Example plan output (for dev):

Terraform will perform the following actions:


      + id                        = (known after apply)
      + network_security_group_id = (known after apply)
      + subnet_id                 = (known after apply)
    }

  # module.vnet.azurerm_virtual_network.this will be created
  + resource "azurerm_virtual_network" "this" {
      + address_space                  = [
          + "10.0.0.0/16",
        ]
      + dns_servers                    = (known after apply)
      + guid                           = (known after apply)
      + id                             = (known after apply)
      + location                       = "eastus"
      + name                           = "vnet-dev-eastus"
      + private_endpoint_vnet_policies = "Disabled"
      + resource_group_name            = "opella_assignment_rg"
      + subnet                         = (known after apply)
      + tags                           = {
          + "environment" = "dev"
          + "owner"       = "santhosh"
        }
    }

Plan: 11 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + nsg_id     = (known after apply)
  + subnet_ids = [
      + (known after apply),
      + (known after apply),
    ]
  + vnet_id    = (known after apply)
  + vnet_name  = "vnet-dev-eastus"


