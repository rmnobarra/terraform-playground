variable "db_username" {
  description = "The username for the database"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "The password for the database"
  type        = string
  sensitive   = true
}

variable "subnets_id_primary" {
  type = list(string)
}

variable "subnets_id_replica" {
  type = list(string)
}

variable "db_name" {
  description = "The name to use for the database"
  type        = string
  default     = "example_database_prod"
}
