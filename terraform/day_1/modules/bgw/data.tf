data "yandex_vpc_subnet" "subnet_bgw" {
  provider = yandex.dev
  subnet_id = var.subnet_id_bgw
}