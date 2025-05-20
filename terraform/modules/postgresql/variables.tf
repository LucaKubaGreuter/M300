variable "db_name" {
  description = "Name of the PostgreSQL database"
  type        = string
}
variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}
variable "location" {
  description = "Location for the PostgreSQL database"
  type        = string
}
variable "environment" {
  description = "Environment for the PostgreSQL database"
  type        = string
}
variable "tags" {
  description = "Tags for the PostgreSQL database"
  type        = map(string)
}
variable "admin_username" {
  description = "PostgreSQL admin username"
  type        = string
}
variable "admin_password" {
  description = "PostgreSQL admin password"
  type        = string
  sensitive   = true
}