resource "yandex_storage_bucket" "bucket" {
  access_key = var.access_key
  secret_key = var.secret_key
  bucket     = "pvv-netology-diplom-backend"
  force_destroy = true
  server_side_encryption_configuration {
    rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = yandex_kms_symmetric_key.kms.id
      sse_algorithm     = "aws:kms"
    }
    }
  }
}