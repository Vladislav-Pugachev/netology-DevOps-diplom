data "yandex_resourcemanager_folder" "folder" {
    provider = yandex.dev
  name     = "folder-${terraform.workspace}"
  cloud_id = var.cloud_id
}
