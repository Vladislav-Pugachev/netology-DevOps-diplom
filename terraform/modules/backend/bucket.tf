resource "yandex_storage_bucket" "bucket" {
  access_key = var.access_key
  secret_key = var.secret_key
  acl = "public-read-write"
  bucket     = "pvv-netology-diplom-env-${terraform.workspace}"
  server_side_encryption_configuration {
    rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = yandex_kms_symmetric_key.key-a.id
      sse_algorithm     = "aws:kms"
    }
    }
  }
}