variable "environment" {
  type = string
}

variable "location" {
  type = string
}

variable "address_space" {
  type = list(string)
  default = ["10.0.0.0/16"]
}

variable "subnets" {
  type = map(list(string))
  default = {
    web     = ["10.0.1.0/24"]
    backend = ["10.0.2.0/24"]
  }
}

variable "tags" {
  type = map(string)
  default = {
    project = "iac"
  }
}

variable "create_nsg" {
  type    = bool
  default = true
}

variable "nsg_rules" {
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
      priority                   = 1001
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
