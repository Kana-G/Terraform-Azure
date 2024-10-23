variable "db_admin" {
  description = "MariaDB Database Admin Username"
  type        = string
  default     = "mariadbadmin"
  sensitive   = true
}

variable "db_server_sku" {
  type    = string
  default = "B_Gen5_2"
}

variable "db_server_version" {
  type    = string
  default = "10.2"
}

variable "kube_vm_size" {
  type    = string
  default = "Standard_D2_v2"
}

variable "location" {
  type    = string
  default = "East US"
}

variable "snet_database_prefix" {
  description = "Database Subnet Prefix"
  type        = string
  default     = "10.221.10.0/24"
}

variable "snet_gateway_prefix" {
  description = "Gateway subnet prefix"
  type        = string
  default     = "10.221.9.0/24"
}

variable "snet_kube_prefix" {
  description = "Kubernetes Subnet Prefix"
  type        = string
  default     = "10.221.8.0/24"
}

variable "tags" {
  description = "Default tags to apply to all resources."
  type        = map(any)
  default = {
    archuuid = "2fdfad4b-dccd-4957-b1e1-51fb689e24c8"
    env      = "Development"
  }
}

variable "vnet_main_addrspace" {
  description = "Virtual Network Address Space"
  type        = string
  default     = "10.221.0.0/16"
}

