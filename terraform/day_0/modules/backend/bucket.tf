resource "yandex_storage_bucket" "bucket" {
  access_key = "${yandex_iam_service_account_static_access_key.editor-bucket-static-key.access_key}"
  secret_key = "${yandex_iam_service_account_static_access_key.editor-bucket-static-key.secret_key}"
#  acl = "public-read-write"
  bucket     = "pvv-netology-diplom-env-${var.workdir}"
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