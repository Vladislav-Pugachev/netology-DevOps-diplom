resource "yandex_resourcemanager_folder_iam_binding" "compute-admin-sa" {
  folder_id = "${yandex_resourcemanager_folder.folder.id}"
  role               = "compute.admin"

  members = [
    "serviceAccount:${yandex_iam_service_account.defaultSa.id}",
  ]
}

resource "yandex_resourcemanager_folder_iam_binding" "vpc-admin-iam" {
  folder_id = "${yandex_resourcemanager_folder.folder.id}"
  role               = "vpc.admin"

  members = [
    "serviceAccount:${yandex_iam_service_account.defaultSa.id}",
  ]
}
