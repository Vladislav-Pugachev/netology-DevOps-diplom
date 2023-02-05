resource "yandex_resourcemanager_folder_iam_binding" "editor-backet" {
  folder_id = "${data.yandex_resourcemanager_folder.folder.id}"
  role               = "storage.editor"

  members = [
    "serviceAccount:${yandex_iam_service_account.editor-backend.id}",
  ]
}

resource "yandex_resourcemanager_folder_iam_binding" "editor-ydb" {
  folder_id = "${data.yandex_resourcemanager_folder.folder.id}"
  role               = "ydb.editor"

  members = [
    "serviceAccount:${yandex_iam_service_account.editor-backend.id}",
  ]
}

resource "yandex_resourcemanager_folder_iam_binding" "encrypt-kms" {
  folder_id = "${data.yandex_resourcemanager_folder.folder.id}"
  role               = "kms.keys.encrypterDecrypter"

  members = [
    "serviceAccount:${yandex_iam_service_account.editor-backend.id}",
  ]
}