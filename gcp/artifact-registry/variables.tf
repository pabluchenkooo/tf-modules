variable "project_id" {
  type        = string
  description = "GCP project ID."
}

variable "region" {
  type        = string
  description = "Region for the repository."
}

variable "repository_id" {
  type        = string
  description = "Repository name."
}

variable "format" {
  type        = string
  description = "Artifact format."
  default     = "DOCKER"
}

variable "description" {
  type        = string
  description = "Repository description."
  default     = "Container images"
}
