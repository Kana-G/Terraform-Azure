# Kubernetes Provider with AKS and MariaDB

## Description 📝

The Kubernetes (K8S) provider is used to interact with the resources supported by Kubernetes. The provider needs to be configured with the proper credentials before it can be used.

There are at least 2 steps involved in scheduling your first container on a Kubernetes cluster. You need the Kubernetes cluster with all its components running somewhere and then define the Kubernetes resources, such as Deployments, Services, etc.

# Architecture components 🏛️

1. Resource group 
2. Virtual Network 
3. Subnets
4. Kubernetes Cluster
5. Kubernetes Namespace
6. Kubernetes Deployment
7. Kubernetes Service
6. Mariadb Server
7. Mariadb Database


# Requirements 

| Name | Configuration |
| --- | --- |
| Terraform | all versions |
| Provider  | Azurerm |
| Provider version  | 3.2 |
| Provider  | Kubernetes |
| Provider version  | 2.16 |



## How to use the architecture

To use this architecture , clone it within your project and change the following components:

Change the configuration of the cloud provider. In order to use the architecture you need to have a kubernetes cluster in place and change the resource group and name of the kubernetes cluster inside the configuration . Then change the variables: 

| Variable | Description |
| --- | --- |
|prefix| Application name |
| db_admin | MariaDB Database Admin Username |
| db_pass | MariaDB Database Admin Password |
| snet_database_prefix | Database Subnet Prefix |
| snet_kube_prefix | Kubernetes Subnet Prefix |
| snet_gateway_prefix | Gateway subnet Prefix |
| vnet_main_addrspace | Virtual Network Address Space |


