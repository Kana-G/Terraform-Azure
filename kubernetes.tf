resource "azurerm_subnet" "subnet_kube" {
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  resource_group_name  = azurerm_resource_group.resource-group.name
  name                 = "KubernetesSubnet"

  address_prefixes = [
    var.snet_kube_prefix,
  ]
}

resource "azurerm_kubernetes_cluster" "kubernetes_cluster" {
  tags                = merge(var.tags, {})
  resource_group_name = azurerm_resource_group.resource-group.name
  name                = "example"
  location            = var.location
  dns_prefix          = "exampleaks1"

  default_node_pool {
    vm_size    = var.kube_vm_size
    node_count = 1
    name       = "default"
  }

  identity {
    type = "SystemAssigned"
  }

  ingress_application_gateway {
    gateway_name = azurerm_application_gateway.application_gateway_c_c.name
    gateway_id   = azurerm_application_gateway.application_gateway_c_c.id
  }
}

resource "kubernetes_namespace" "namespace" {
  metadata {
    name = "nginx"
  }

}

resource "kubernetes_deployment" "deployment" {
  metadata {
    name      = "nginx"
    namespace = kubernetes_namespace.namespace.metadata.0.name
  }
  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "MyTestApp"
      }
    }
    template {
      metadata {
        labels = {
          app = "MyTestApp"
        }
      }
      spec {
        container {
          image = "nginx"
          name  = "nginx-container"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "service" {
  metadata {
    name      = "nginx"
    namespace = kubernetes_namespace.namespace.metadata.0.name
  }
  spec {
    selector = {
      app = kubernetes_deployment.deployment.spec.0.template.0.metadata.0.labels.app
    }
    type = "NodePort"
    port {
      node_port   = 30201
      port        = 80
      target_port = 80
    }
  }
}

