variable "location" {
  description = "Azure region to deploy resources"
  type        = string
}

variable "environment" {
  description = "Environment name like dev, test, prod"
  type        = string
}

variable "address_space" {
  description = "Address space for the VNet"
  type        = list(string)
}

variable "subnets" {
  description = "Subnets to create within the VNet"
  type = list(object({
    name           = string
    address_prefix = string
  }))
}

variable "create_nsg" {
  description = "Whether to create a Network Security Group"
  type        = bool
  default     = true
}

variable "nsg_rules" {
  description = "List of NSG rules"
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  default = []
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
}

variable "ssh_public_key_path" {
  description = "Path to the SSH public key"
  type        = string
}
