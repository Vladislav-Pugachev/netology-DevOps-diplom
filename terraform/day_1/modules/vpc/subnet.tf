resource "yandex_vpc_subnet" "subnet" {
  provider = yandex.dev
  depends_on = [yandex_vpc_network.underlay]
  for_each = local.subnet
  v4_cidr_blocks = [each.value]
  zone = each.key
  network_id = yandex_vpc_network.underlay.id
  folder_id = var.folder_id
}

resource "yandex_vpc_subnet" "subnet_bwg" {
  provider = yandex.dev 
  depends_on = [yandex_vpc_network.underlay]
  v4_cidr_blocks = [local.subnet_bgw]
  zone = "ru-central1-a"
  network_id = yandex_vpc_network.underlay.id
  folder_id = var.folder_id
}