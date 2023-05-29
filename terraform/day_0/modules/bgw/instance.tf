resource "yandex_compute_instance" "bgw" {
    name = "${terraform.workspace}-bgw-node"
    hostname = "${terraform.workspace}-bgw-node"
    zone = "ru-central1-a"
    platform_id = "standard-v1"
    folder_id = data.yandex_resourcemanager_folder.folder.id
    resources {
      cores = 2
      memory = 2
    }
    boot_disk {
      initialize_params {
        image_id = "fd8tckeqoshi403tks4l"
        size = 10
        type="network-ssd"
      }
    }
    network_interface {
        nat = true
        subnet_id = data.yandex_vpc_subnet.underlay_subnet.id
        ip_address = cidrhost(data.yandex_vpc_subnet.underlay_subnet.v4_cidr_blocks[0], 253)
    }
    metadata = {
        user-data = "${file("./bgw_cloud")}"
  }
}