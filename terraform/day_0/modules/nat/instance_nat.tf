resource "yandex_compute_instance" "nat" {
    name = "nat-node-${terraform.workspace}"
    hostname = "nat-node-${terraform.workspace}"
    zone = "ru-central1-a"
    platform_id = "standard-v1"
    folder_id = data.yandex_resourcemanager_folder.folder.id
    resources {
      cores = 2
      memory = 2
    }
    boot_disk {
      initialize_params {
        image_id = "fd8a67rb91j689dqp60h"
        size = 3
        type="network-ssd"
      }
    }
    network_interface {
        nat = true
        subnet_id = data.yandex_vpc_subnet.underlay_subnet.id
        ip_address = "192.168.1.254"
    }
    metadata = {
        user-data = "${file("./users.yml")}"
  }
}