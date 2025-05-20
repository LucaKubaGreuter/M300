variable "cluster_name" {
  description = "The name of the AKS cluster."
  type        = string
}
variable "dns_prefix" {
  description = "The DNS prefix for the AKS cluster."
  type        = string
}
variable "location" {
  description = "The Azure region where the AKS cluster will be created."
  type        = string
}
variable "resource_group_name" {
  description = "The name of the resource group where the AKS cluster will be created."
  type        = string
}
variable "environment" {
  description = "The environment for the AKS cluster (e.g., dev, prod)."
  type        = string
}
variable "tags" {
  description = "A map of tags to assign to the AKS cluster and its resources."
  type        = map(string)
  default     = {}
}
variable "node_count" {
  description = "The number of nodes in the AKS cluster."
  type        = number
  default     = 3
}
variable "max_count" {
  description = "The maximum number of pods per node."
  type        = number
  default     = 3
}
variable "min_count" {
  description = "The minimum number of nodes in the AKS cluster."
  type        = number
  default     = 1 
}
variable "vm_size" {
  description = "The size of the virtual machines in the AKS cluster."
  type        = string
  default     = "Standard_B2s"  
}
variable "enable_auto_scaling" {
  description = "Enable or disable the AKS cluster autoscaler."
  type        = bool
  default     = false
}