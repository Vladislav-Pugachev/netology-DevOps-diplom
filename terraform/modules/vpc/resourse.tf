
resource "yandex_vpc_network" "default" {
folder_id = var.folder_id 
  name = "foobar"
}
