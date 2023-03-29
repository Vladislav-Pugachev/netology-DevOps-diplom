data "yandex_resourcemanager_folder" "folder" {
  name     = "folder-${terraform.workspace}"
  cloud_id = var.cloud_id
}

data "yandex_vpc_subnet" "underlay_subnet" {
  folder_id= data.yandex_resourcemanager_folder.folder.id
  name = "underlay_subnet"
}