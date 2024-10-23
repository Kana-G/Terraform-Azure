resource "azurerm_key_vault" "kubernetes" {
  tenant_id           = data.azurerm_client_config.current.tenant_id
  tags                = merge(var.tags, {})
  sku_name            = "standard"
  resource_group_name = azurerm_resource_group.resource-group.name
  name                = "kubernetes"
  location            = var.location

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id
    key_permissions = [
      "Get",
      "Create",
      "List",
    ]
    secret_permissions = [
      "Set",
      "Get",
      "Delete",
      "Purge",
      "List",
      "Recover",
    ]
    storage_permissions = [
      "Get",
      "List",
    ]
  }
}

resource "azurerm_key_vault_secret" "db_password" {
  value        = random_password.db_password.result
  tags         = merge(var.tags, {})
  name         = "db-password"
  key_vault_id = azurerm_key_vault.kubernetes.id
}

data "azurerm_client_config" "current" {
}

resource "random_password" "db_password" {
  length    = 64
  special   = true
  min_lower = 2
  min_upper = 2
}

