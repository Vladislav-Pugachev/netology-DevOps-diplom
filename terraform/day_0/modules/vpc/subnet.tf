resource "yandex_vpc_subnet" "underlay_subnet" {
  name= "underlay_subnet"
  v4_cidr_blocks = ["10.0.0.0/24"]
  zone = "ru-central1-a"
  network_id = yandex_vpc_network.underlay.id
  folder_id = data.yandex_resourcemanager_folder.folder.id
}
