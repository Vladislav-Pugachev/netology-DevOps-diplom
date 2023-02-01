resource "yandex_iam_service_account" "defaultSa" {
  name        = "defaultsa"
  description = "сервисный аккаунт по умолчанию для каталога"
  folder_id = "${yandex_resourcemanager_folder.folder.id}"
}

resource "yandex_iam_service_account_key" "default-sa-auth-key" {
  service_account_id = "${yandex_iam_service_account.defaultSa.id}"
  description        = "key for service account"
  key_algorithm      = "RSA_4096"
}


resource "local_file" "key-json" {
  content     = jsonencode({
    "id" = yandex_iam_service_account_key.default-sa-auth-key.id
    "service_account_id"  = yandex_iam_service_account_key.default-sa-auth-key.service_account_id
    "created_at" = yandex_iam_service_account_key.default-sa-auth-key.created_at
    "key_algorithm" = yandex_iam_service_account_key.default-sa-auth-key.key_algorithm
    "public_key" = yandex_iam_service_account_key.default-sa-auth-key.public_key
    "private_key" = yandex_iam_service_account_key.default-sa-auth-key.private_key
})
  filename = "./key.json"
}