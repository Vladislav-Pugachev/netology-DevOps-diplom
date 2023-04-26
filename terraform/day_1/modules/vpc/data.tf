data "yandex_vpc_subnet" "subnet_bgw" {
  provider = yandex.dev
  subnet_id = yandex_vpc_subnet.subnet_bwg.id
}

