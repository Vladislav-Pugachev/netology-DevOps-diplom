resource "yandex_vpc_subnet" "nat" {
  v4_cidr_blocks = ["192.168.1.0/24"]
  zone = "ru-central1-a"
  network_id = yandex_vpc_network.underlay.id
  folder_id = data.yandex_resourcemanager_folder.folder.id
}
