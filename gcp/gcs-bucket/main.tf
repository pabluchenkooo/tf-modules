# A GCS bucket with uniform access and optional IAM bindings.

resource "google_storage_bucket" "this" {
  project                     = var.project_id
  name                        = var.name
  location                    = var.location
  uniform_bucket_level_access = true
  force_destroy               = var.force_destroy

  versioning {
    enabled = var.versioning
  }
}

resource "google_storage_bucket_iam_member" "members" {
  for_each = { for m in var.members : "${m.role} ${m.member}" => m }
  bucket   = google_storage_bucket.this.name
  role     = each.value.role
  member   = each.value.member
}
