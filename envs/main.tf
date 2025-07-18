provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "opella_assignment_rg"
  location = var.location
  tags     = var.tags
}

module "vnet" {
  source              = "git::https://github.com/santhosh-chindam/terraform-azure-vnet-module.git//?ref=main"
  name                = "vnet-${var.environment}-${var.location}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = var.address_space
  subnets             = var.subnets
  tags                = var.tags
  create_nsg          = var.create_nsg
  nsg_rules           = var.nsg_rules

  depends_on = [azurerm_resource_group.rg]
}
