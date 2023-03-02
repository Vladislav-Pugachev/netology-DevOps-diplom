resource "yandex_vpc_subnet" "subnet" {
  depends_on = [
    yandex_vpc_network.underlay
  ]
  for_each = var.subnet
  v4_cidr_blocks = [each.value]
  zone = each.key
  network_id = yandex_vpc_network.underlay.id
  folder_id = var.folder_id
  route_table_id = yandex_vpc_route_table.default.id
}

