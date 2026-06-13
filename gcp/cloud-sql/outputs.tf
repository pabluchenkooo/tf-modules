output "instance_name" {
  value = google_sql_database_instance.this.name
}

output "instance_connection_name" {
  description = "PROJECT:REGION:INSTANCE — for the Cloud SQL Auth Proxy if ever needed."
  value       = google_sql_database_instance.this.connection_name
}

output "private_ip" {
  value = google_sql_database_instance.this.private_ip_address
}

output "databases" {
  value = [for d in var.databases : d]
}

output "users" {
  description = "Map of user -> { name, password }."
  sensitive   = true
  value = {
    for u in var.users : u => {
      name     = google_sql_user.this[u].name
      password = random_password.user[u].result
    }
  }
}
