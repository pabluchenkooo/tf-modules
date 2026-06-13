output "repository_id" {
  value = google_artifact_registry_repository.this.repository_id
}

output "registry_host" {
  description = "Docker registry host prefix, e.g. us-east1-docker.pkg.dev/PROJECT/REPO."
  value       = "${var.region}-docker.pkg.dev/${var.project_id}/${google_artifact_registry_repository.this.repository_id}"
}
