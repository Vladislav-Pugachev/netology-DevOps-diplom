resource "yandex_vpc_network" "underlay" {
  provider = yandex.dev 
  name = "underlay-${terraform.workspace}"
  folder_id = var.folder_id
}
