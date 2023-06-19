data "yandex_vpc_subnet" "subnet_bgw" {
  subnet_id = yandex_vpc_subnet.subnet_bwg.id
}

