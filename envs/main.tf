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

resource "azurerm_network_interface" "vm_nic" {
  name                = "nic-${var.environment}-${var.location}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = module.vnet.subnet_ids[0]
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm_public_ip.id
  }

  tags = var.tags
}

resource "azurerm_public_ip" "vm_public_ip" {
  name                = "pip-${var.environment}-${var.location}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  tags                = var.tags
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = "vm-${var.environment}-${var.location}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  size                = "Standard_B1s"
  admin_username      = "azureuser"
  network_interface_ids = [
    azurerm_network_interface.vm_nic.id
  ]

  admin_ssh_key {
    username   = "azureuser"
    public_key = file(var.ssh_public_key_path)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "22_04-lts"
    version   = "latest"
  }

  tags = var.tags
}

resource "azurerm_storage_account" "storage" {
  name                     = lower(replace("st${var.environment}${var.location}", "-", ""))
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = var.tags
}

