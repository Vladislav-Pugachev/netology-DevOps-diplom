resource "yandex_storage_bucket" "web-bucket" {
  access_key = var.access_key
  secret_key = var.secret_key
  bucket     = "pvv-netology-diplom-web"
  force_destroy = true
}