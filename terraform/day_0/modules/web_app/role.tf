resource "yandex_resourcemanager_folder_iam_binding" "web-upload" {
  folder_id = "${data.yandex_resourcemanager_folder.folder.id}"
  role               = "storage.admin"

  members = [
    "serviceAccount:${yandex_iam_service_account.web-image-uploader.id}",
  ]
}
