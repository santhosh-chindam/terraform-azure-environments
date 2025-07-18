variable "location" {
  type        = string
  description = "Azure region"
  default     = "eastus"
}

variable "environment" {
  type        = string
  description = "Environment name like dev, prod"
  default     = "dev"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
  default = {
    environment = "dev"
    owner       = "santhosh"
  }
}

variable "address_space" {
  type        = list(string)
  description = "Address space for the virtual network"
  default     = ["10.0.0.0/16"]
}

variable "subnets" {
  description = "Map of subnet names to their address prefixes"
  type        = map(list(string))
  default = {
    subnet1 = ["10.0.1.0/24"]
    subnet2 = ["10.0.2.0/24"]
  }
}

variable "create_nsg" {
  type        = bool
  description = "Whether to create a network security group"
  default     = true
}

variable "nsg_rules" {
  description = "Map of NSG rules"
  type = map(object({
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  default = {
    allow_ssh = {
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
}

variable "ssh_public_key_path" {
  type        = string
  description = "Path to the SSH public key"
  default     = "~/.ssh/id_rsa.pub"
}
