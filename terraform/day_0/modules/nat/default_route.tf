resource "yandex_vpc_route_table" "default" {
  network_id = yandex_vpc_network.underlay.id
  folder_id = data.yandex_resourcemanager_folder.folder.id
  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address = "192.168.1.254"
  }
}