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
- ✅ Emphasize **clean code**, **secure practices**, and **scalability**..

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

<img width="845" height="281" alt="image" src="https://github.com/user-attachments/assets/4701fe4b-d78a-471d-8374-85b29c20e576" />


🌍 Multi-Environment Setup
Secrets are configured in the GitHub repository environments (via Settings > Environments), and the respective secret values must be updated accordingly.
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

Run terraform plan -input=false -var="environment=dev" -var="location=eastus"

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # azurerm_network_interface.vm_nic will be created
  + resource "azurerm_network_interface" "vm_nic" {
      + accelerated_networking_enabled = false
      + applied_dns_servers            = (known after apply)
      + id                             = (known after apply)
      + internal_domain_name_suffix    = (known after apply)
      + ip_forwarding_enabled          = false
      + location                       = "eastus"
      + mac_address                    = (known after apply)
      + name                           = "nic-dev-eastus"
      + private_ip_address             = (known after apply)
      + private_ip_addresses           = (known after apply)
      + resource_group_name            = "opella_assignment_rg"
      + tags                           = {
          + "environment" = "dev"
          + "owner"       = "santhosh"
        }
      + virtual_machine_id             = (known after apply)

      + ip_configuration {
          + gateway_load_balancer_frontend_ip_configuration_id = (known after apply)
          + name                                               = "internal"
          + primary                                            = (known after apply)
          + private_ip_address                                 = (known after apply)
          + private_ip_address_allocation                      = "Dynamic"
          + private_ip_address_version                         = "IPv4"
          + public_ip_address_id                               = (known after apply)
          + subnet_id                                          = (known after apply)
        }
    }

  # azurerm_public_ip.vm_public_ip will be created
  + resource "azurerm_public_ip" "vm_public_ip" {
      + allocation_method       = "Static"
      + ddos_protection_mode    = "VirtualNetworkInherited"
      + fqdn                    = (known after apply)
      + id                      = (known after apply)
      + idle_timeout_in_minutes = 4
      + ip_address              = (known after apply)
      + ip_version              = "IPv4"
      + location                = "eastus"
      + name                    = "pip-dev-eastus"
      + resource_group_name     = "opella_assignment_rg"
      + sku                     = "Standard"
      + sku_tier                = "Regional"
      + tags                    = {
          + "environment" = "dev"
          + "owner"       = "santhosh"
        }
    }

  # azurerm_resource_group.rg will be created
  + resource "azurerm_resource_group" "rg" {
      + id       = (known after apply)
      + location = "eastus"
      + name     = "opella_assignment_rg"
      + tags     = {
          + "environment" = "dev"
          + "owner"       = "santhosh"
        }
    }

  # azurerm_storage_account.storage will be created
  + resource "azurerm_storage_account" "storage" {
      + access_tier                        = (known after apply)
      + account_kind                       = "StorageV2"
      + account_replication_type           = "LRS"
      + account_tier                       = "Standard"
      + allow_nested_items_to_be_public    = true
      + cross_tenant_replication_enabled   = false
      + default_to_oauth_authentication    = false
      + dns_endpoint_type                  = "Standard"
      + https_traffic_only_enabled         = true
      + id                                 = (known after apply)
      + infrastructure_encryption_enabled  = false
      + is_hns_enabled                     = false
      + large_file_share_enabled           = (known after apply)
      + local_user_enabled                 = true
      + location                           = "eastus"
      + min_tls_version                    = "TLS1_2"
      + name                               = "stdeveastus"
      + nfsv3_enabled                      = false
      + primary_access_key                 = (sensitive value)
      + primary_blob_connection_string     = (sensitive value)
      + primary_blob_endpoint              = (known after apply)
      + primary_blob_host                  = (known after apply)
      + primary_blob_internet_endpoint     = (known after apply)
      + primary_blob_internet_host         = (known after apply)
      + primary_blob_microsoft_endpoint    = (known after apply)
      + primary_blob_microsoft_host        = (known after apply)
      + primary_connection_string          = (sensitive value)
      + primary_dfs_endpoint               = (known after apply)
      + primary_dfs_host                   = (known after apply)
      + primary_dfs_internet_endpoint      = (known after apply)
      + primary_dfs_internet_host          = (known after apply)
      + primary_dfs_microsoft_endpoint     = (known after apply)
      + primary_dfs_microsoft_host         = (known after apply)
      + primary_file_endpoint              = (known after apply)
      + primary_file_host                  = (known after apply)
      + primary_file_internet_endpoint     = (known after apply)
      + primary_file_internet_host         = (known after apply)
      + primary_file_microsoft_endpoint    = (known after apply)
      + primary_file_microsoft_host        = (known after apply)
      + primary_location                   = (known after apply)
      + primary_queue_endpoint             = (known after apply)
      + primary_queue_host                 = (known after apply)
      + primary_queue_microsoft_endpoint   = (known after apply)
      + primary_queue_microsoft_host       = (known after apply)
      + primary_table_endpoint             = (known after apply)
      + primary_table_host                 = (known after apply)
      + primary_table_microsoft_endpoint   = (known after apply)
      + primary_table_microsoft_host       = (known after apply)
      + primary_web_endpoint               = (known after apply)
      + primary_web_host                   = (known after apply)
      + primary_web_internet_endpoint      = (known after apply)
      + primary_web_internet_host          = (known after apply)
      + primary_web_microsoft_endpoint     = (known after apply)
      + primary_web_microsoft_host         = (known after apply)
      + public_network_access_enabled      = true
      + queue_encryption_key_type          = "Service"
      + resource_group_name                = "opella_assignment_rg"
      + secondary_access_key               = (sensitive value)
      + secondary_blob_connection_string   = (sensitive value)
      + secondary_blob_endpoint            = (known after apply)
      + secondary_blob_host                = (known after apply)
      + secondary_blob_internet_endpoint   = (known after apply)
      + secondary_blob_internet_host       = (known after apply)
      + secondary_blob_microsoft_endpoint  = (known after apply)
      + secondary_blob_microsoft_host      = (known after apply)
      + secondary_connection_string        = (sensitive value)
      + secondary_dfs_endpoint             = (known after apply)
      + secondary_dfs_host                 = (known after apply)
      + secondary_dfs_internet_endpoint    = (known after apply)
      + secondary_dfs_internet_host        = (known after apply)
      + secondary_dfs_microsoft_endpoint   = (known after apply)
      + secondary_dfs_microsoft_host       = (known after apply)
      + secondary_file_endpoint            = (known after apply)
      + secondary_file_host                = (known after apply)
      + secondary_file_internet_endpoint   = (known after apply)
      + secondary_file_internet_host       = (known after apply)
      + secondary_file_microsoft_endpoint  = (known after apply)
      + secondary_file_microsoft_host      = (known after apply)
      + secondary_location                 = (known after apply)
      + secondary_queue_endpoint           = (known after apply)
      + secondary_queue_host               = (known after apply)
      + secondary_queue_microsoft_endpoint = (known after apply)
      + secondary_queue_microsoft_host     = (known after apply)
      + secondary_table_endpoint           = (known after apply)
      + secondary_table_host               = (known after apply)
      + secondary_table_microsoft_endpoint = (known after apply)
      + secondary_table_microsoft_host     = (known after apply)
      + secondary_web_endpoint             = (known after apply)
      + secondary_web_host                 = (known after apply)
      + secondary_web_internet_endpoint    = (known after apply)
      + secondary_web_internet_host        = (known after apply)
      + secondary_web_microsoft_endpoint   = (known after apply)
      + secondary_web_microsoft_host       = (known after apply)
      + sftp_enabled                       = false
      + shared_access_key_enabled          = true
      + table_encryption_key_type          = "Service"
      + tags                               = {
          + "environment" = "dev"
          + "owner"       = "santhosh"
        }
    }

  # module.vnet.azurerm_network_security_group.this[0] will be created
  + resource "azurerm_network_security_group" "this" {
      + id                  = (known after apply)
      + location            = "eastus"
      + name                = "vnet-dev-eastus-nsg"
      + resource_group_name = "opella_assignment_rg"
      + security_rule       = (known after apply)
      + tags                = {
          + "environment" = "dev"
          + "owner"       = "santhosh"
        }
    }

  # module.vnet.azurerm_network_security_rule.this["allow_ssh"] will be created
  + resource "azurerm_network_security_rule" "this" {
      + access                      = "Allow"
      + destination_address_prefix  = "*"
      + destination_port_range      = "22"
      + direction                   = "Inbound"
      + id                          = (known after apply)
      + name                        = "allow_ssh"
      + network_security_group_name = "vnet-dev-eastus-nsg"
      + priority                    = 100
      + protocol                    = "Tcp"
      + resource_group_name         = "opella_assignment_rg"
      + source_address_prefix       = "*"
      + source_port_range           = "*"
    }

  # module.vnet.azurerm_subnet.this["subnet1"] will be created
  + resource "azurerm_subnet" "this" {
      + address_prefixes                              = [
          + "10.0.1.0/24",
        ]
      + default_outbound_access_enabled               = true
      + id                                            = (known after apply)
      + name                                          = "subnet1"
      + private_endpoint_network_policies             = "Disabled"
      + private_link_service_network_policies_enabled = true
      + resource_group_name                           = "opella_assignment_rg"
      + virtual_network_name                          = "vnet-dev-eastus"
    }

  # module.vnet.azurerm_subnet.this["subnet2"] will be created
  + resource "azurerm_subnet" "this" {
      + address_prefixes                              = [
          + "10.0.2.0/24",
        ]
      + default_outbound_access_enabled               = true
      + id                                            = (known after apply)
      + name                                          = "subnet2"
      + private_endpoint_network_policies             = "Disabled"
      + private_link_service_network_policies_enabled = true
      + resource_group_name                           = "opella_assignment_rg"
      + virtual_network_name                          = "vnet-dev-eastus"
    }

  # module.vnet.azurerm_subnet_network_security_group_association.this["subnet1"] will be created
  + resource "azurerm_subnet_network_security_group_association" "this" {
      + id                        = (known after apply)
      + network_security_group_id = (known after apply)
      + subnet_id                 = (known after apply)
    }

  # module.vnet.azurerm_subnet_network_security_group_association.this["subnet2"] will be created
  + resource "azurerm_subnet_network_security_group_association" "this" {
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

