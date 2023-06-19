resource "yandex_vpc_network" "underlay" {
  name = "underlay-${terraform.workspace}"
  folder_id = var.folder_id
}
