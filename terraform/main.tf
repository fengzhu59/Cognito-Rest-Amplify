resource "aws_secretsmanager_secret" "db_secret" {
    name = "db-secret"
    recovery_window_in_days = 0 // Overriding the default recovery window of 30 days
}

resource "aws_secretsmanager_secret_version" "db_secret_version" {
    secret_id     = aws_secretsmanager_secret.db_secret.id
    secret_string = jsonencode({
        host     = var.host
        port     = var.port
        username = var.username
        password = var.password
    })
}