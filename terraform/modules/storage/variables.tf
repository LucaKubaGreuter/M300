variable "storage_account_name" {
  description = "The name of the storage account."
  type        = string
  default     = "stlucgr01"
}
variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
  default     = "rg-lucgr-001"
}
variable "location" {
  description = "The Azure region where the resources will be created."
  type        = string
  default     = "northeurope"
}
variable "environment" {
  description = "The environment for the resources (e.g., dev, prod)."
  type        = string
  default     = "dev"
}
variable "tags" {
  description = "Tags to apply to the resources."
  type        = map(string)
  default     = {
    project     = "weather-app"
    environment = "dev"
  }
}
variable "container_name" {
  description = "The name of the blob container."
  type        = string
  default     = "weather-app"
}