resource "yandex_iam_service_account" "admin-resourse" {
  name        = "admin-resourse"
  description = "service account for CRUD resourse in folder"
  folder_id = "${yandex_resourcemanager_folder.folder.id}"
}

resource "yandex_iam_service_account_key" "admin-resourse-sa-auth-key" {
  service_account_id = "${yandex_iam_service_account.admin-resourse.id}"
  description        = "key for service account admin resourse"
  key_algorithm      = "RSA_4096"
}


resource "local_file" "admin-resourse-cred-json" {
  content     = jsonencode({
    "id" = yandex_iam_service_account_key.admin-resourse-sa-auth-key.id
    "service_account_id"  = yandex_iam_service_account_key.admin-resourse-sa-auth-key.service_account_id
    "created_at" = yandex_iam_service_account_key.admin-resourse-sa-auth-key.created_at
    "key_algorithm" = yandex_iam_service_account_key.admin-resourse-sa-auth-key.key_algorithm
    "public_key" = yandex_iam_service_account_key.admin-resourse-sa-auth-key.public_key
    "private_key" = yandex_iam_service_account_key.admin-resourse-sa-auth-key.private_key
})
  filename = "./admin-resourse.json"
}

resource "yandex_resourcemanager_folder_iam_binding" "compute-admin-sa" {
  folder_id = "${yandex_resourcemanager_folder.folder.id}"
  role               = "compute.admin"

  members = [
    "serviceAccount:${yandex_iam_service_account.admin-resourse.id}",
  ]
}

resource "yandex_resourcemanager_folder_iam_binding" "vpc-admin-iam" {
  folder_id = "${yandex_resourcemanager_folder.folder.id}"
  role               = "vpc.admin"

  members = [
    "serviceAccount:${yandex_iam_service_account.admin-resourse.id}",
  ]
}
