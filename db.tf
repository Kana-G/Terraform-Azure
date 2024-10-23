resource "azurerm_subnet" "subnet_db" {
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  resource_group_name  = azurerm_resource_group.resource-group.name
  name                 = "DatabaseSubnet"

  address_prefixes = [
    var.snet_database_prefix,
  ]
}

resource "azurerm_mariadb_server" "mariadb_server" {
  version                       = var.db_server_version
  tags                          = merge(var.tags, {})
  storage_mb                    = 5120
  ssl_enforcement_enabled       = true
  sku_name                      = var.db_server_sku
  resource_group_name           = azurerm_resource_group.resource-group.name
  public_network_access_enabled = false
  name                          = "mariadb-demo"
  location                      = var.location
  geo_redundant_backup_enabled  = false
  backup_retention_days         = 7
  auto_grow_enabled             = true
  administrator_login_password  = azurerm_key_vault_secret.db_password.value
  administrator_login           = var.db_admin
}

resource "azurerm_mariadb_database" "mariadb_database" {
  server_name         = azurerm_mariadb_server.mariadb_server.id
  resource_group_name = azurerm_resource_group.resource-group.name
  name                = "mariadb_database"
  collation           = "utf8_general_ci"
  charset             = "utf8"
}

