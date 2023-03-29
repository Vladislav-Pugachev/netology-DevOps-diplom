data "yandex_resourcemanager_folder" "folder_work_env" {
  for_each = toset("${var.env_day_1}")
  name     = "folder-${each.key}"
}

data "yandex_resourcemanager_folder" "folder_admin" {
  name     = "folder-${terraform.workspace}"
  cloud_id = var.cloud_id
}