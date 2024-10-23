resource "azurerm_application_gateway" "application_gateway_c_c" {
  tags                = merge(var.tags, {})
  resource_group_name = azurerm_resource_group.resource-group.name
  name                = "appgateway_demo"
  location            = var.location

  backend_address_pool {
    name = local.backend_address_pool_name
  }

  backend_http_settings {
    request_timeout       = 60
    protocol              = "Http"
    probe_name            = "HttpProbe"
    port                  = 80
    path                  = "/"
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
  }

  frontend_ip_configuration {
    public_ip_address_id = azurerm_public_ip.public_ip_30_c_c.id
    name                 = local.frontend_ip_configuration_name
  }

  frontend_port {
    port = 80
    name = local.frontend_port_name
  }

  gateway_ip_configuration {
    subnet_id = azurerm_subnet.subnet_appgateway.id
    name      = "my-gateway-ip-configuration"
  }

  http_listener {
    protocol                       = "Http"
    name                           = local.listener_name
    frontend_port_name             = local.frontend_port_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
  }

  request_routing_rule {
    rule_type                  = "Basic"
    name                       = local.request_routing_rule_name
    http_listener_name         = local.listener_name
    backend_http_settings_name = local.http_setting_name
    backend_address_pool_name  = local.backend_address_pool_name
  }

  sku {
    tier     = "WAF"
    name     = "WAF_Medium"
    capacity = 1
  }
}

resource "azurerm_public_ip" "public_ip_30_c_c" {
  tags                = merge(var.tags, {})
  resource_group_name = azurerm_resource_group.resource-group.name
  name                = "pip-kubernetes"
  location            = var.location
  allocation_method   = "Dynamic"
}

resource "azurerm_subnet" "subnet_appgateway" {
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  resource_group_name  = azurerm_resource_group.resource-group.name
  name                 = "GatewaySubnet"

  address_prefixes = [
    var.snet_gateway_prefix,
  ]
}

