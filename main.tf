resource "azurerm_resource_group" "resource-group" {
  tags     = merge(var.tags, {})
  name     = "rg-kube"
  location = var.location
}

resource "azurerm_virtual_network" "virtual_network" {
  tags                = merge(var.tags, {})
  resource_group_name = azurerm_resource_group.resource-group.name
  name                = "vnet-kube"
  location            = var.location

  address_space = [
    var.vnet_main_addrspace,
  ]
}

