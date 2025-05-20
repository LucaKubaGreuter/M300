variable "vm_name" {
  description = "Name of the VM"
  type        = string
}
variable "location" {
  description = "Location for the resources"
  type        = string
}
variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}
variable "tags" {
  description = "Tags for the resources"
  type        = map(string)
}
variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
}
variable "ssh_public_key" {
  description = "SSH public key for the VM"
  type        = string
}