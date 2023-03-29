resource "yandex_storage_object" "image1" {
  depends_on = [yandex_storage_bucket.web-bucket]
  access_key = var.access_key
  secret_key = var.secret_key
  bucket     = "pvv-netology-diplom-web"
  key        = "first"
  source     = "./web/image/first.jpg"
}

resource "yandex_storage_object" "image2" {
  depends_on = [yandex_storage_bucket.web-bucket]
  access_key = var.access_key
  secret_key = var.secret_key
  bucket     = "pvv-netology-diplom-web"
  key        = "second"
  source     = "./web/image/second.jpg"
}