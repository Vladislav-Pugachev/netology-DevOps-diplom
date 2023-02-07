resource "yandex_compute_instance" "nat" {
    name = "mikrotik-node-${terraform.workspace}"
    hostname = "mikrotik-node-${terraform.workspace}"
    zone = "ru-central1-a"
    platform_id = "standard-v1"
    folder_id = var.folder_id
    resources {
      cores = 2
      memory = 2
    }
    boot_disk {
      initialize_params {
        image_id = "fd84rbp1354f0g87qsup"
        size = 5
      }
    }
    network_interface {
        nat = true
        subnet_id = yandex_vpc_subnet.nat.id
        ip_address = "192.168.1.254"
    }
    network_interface {
    nat = false
    subnet_id = yandex_vpc_subnet.subnet["ru-central1-a"].id
    ip_address = "10.0.0.254"
    }
    metadata = {
        user-data = "${file("./users.yml")}"
  }
}