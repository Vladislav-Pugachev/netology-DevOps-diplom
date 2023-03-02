resource "yandex_storage_bucket" "web-bucket" {
  access_key = "${yandex_iam_service_account_static_access_key.web-image-uploader-static-key.access_key}"
  secret_key = "${yandex_iam_service_account_static_access_key.web-image-uploader-static-key.secret_key}"
  bucket     = "pvv-netology-diplom-web"
  force_destroy = true
}