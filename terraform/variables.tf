variable "host" {
  description = "The database host"
  type        = string
}

variable "port" {
  description = "The database port"
  type        = string
}

variable "username" {
  description = "The database username"
  type        = string
}

variable "password" {
  description = "The database password"
  type        = string
  sensitive   = true
}