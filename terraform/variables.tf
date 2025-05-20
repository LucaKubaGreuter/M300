variable "db_user" {
  description = "PostgreSQL admin username"
  type        = string
}
variable "db_pass" {
  description = "PostgreSQL admin password"
  type        = string
  sensitive   = true
}
