variable "project_id" {
  type        = string
  description = "GCP project ID."
}

variable "name" {
  type        = string
  description = "Globally-unique bucket name."
}

variable "location" {
  type        = string
  description = "Bucket location (e.g. region)."
}

variable "force_destroy" {
  type        = bool
  description = "Allow terraform to delete a non-empty bucket."
  default     = false
}

variable "versioning" {
  type        = bool
  description = "Object versioning."
  default     = false
}

variable "members" {
  type = list(object({
    role   = string
    member = string
  }))
  description = "IAM bindings on the bucket, e.g. { role = \"roles/storage.objectAdmin\", member = \"serviceAccount:...\" }."
  default     = []
}
