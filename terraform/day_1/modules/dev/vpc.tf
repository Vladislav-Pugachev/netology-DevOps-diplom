
resource "yandex_vpc_network" "default" {
  name = "foobar"
  folder_id = var.folder_id_dev
}
