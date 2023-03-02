data "yandex_resourcemanager_folder" "folder" {
  name     = "folder-${terraform.workspace}"
  cloud_id = var.cloud_id
}