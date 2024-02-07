output "endpoint" {
  description = "The connection endpoint"
  value       = aws_db_instance.default.endpoint
}

output "port" {
  description = "The database port"
  value       = aws_db_instance.default.port
}