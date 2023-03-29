resource "yandex_vpc_network" "underlay" {
  name = "underlay"
  folder_id = data.yandex_resourcemanager_folder.folder.id
}