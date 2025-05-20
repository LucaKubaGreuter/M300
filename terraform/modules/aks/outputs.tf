output "kube_config" {
  value     = azurerm_kubernetes_cluster.k8s-1.kube_config_raw
  sensitive = true
}

output "aks_name" {
  value = azurerm_kubernetes_cluster.k8s-1.name
}
