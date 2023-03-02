resource "yandex_vpc_network" "underlay" {
  name = "underlay-${terraform.workspace}"
  folder_id = data.yandex_resourcemanager_folder.folder.id
}