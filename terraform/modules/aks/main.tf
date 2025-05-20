resource "azurerm_kubernetes_cluster" "k8s-1" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name                = "default"
    vm_size             = var.vm_size
    enable_auto_scaling = var.enable_auto_scaling
    min_count           = var.min_count
    max_count           = var.max_count
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}
