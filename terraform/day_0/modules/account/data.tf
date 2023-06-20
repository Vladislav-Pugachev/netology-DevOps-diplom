data "yandex_resourcemanager_folder" "folder_admin" {
  name     = "folder-${terraform.workspace}"
  cloud_id = var.cloud_id
}