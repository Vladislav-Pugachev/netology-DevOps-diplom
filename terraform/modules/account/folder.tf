resource "yandex_resourcemanager_folder" "folder" {
  cloud_id    = var.cloud_id
  name        = "folder-${terraform.workspace}"
  description = terraform.workspace
}