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
