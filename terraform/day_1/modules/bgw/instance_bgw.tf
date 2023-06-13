resource "yandex_compute_instance" "bgw" {
  provider = yandex.dev
    name = "${terraform.workspace}-bgw-node"
    hostname = "${terraform.workspace}-bgw-node"
    allow_stopping_for_update = true
    zone = "ru-central1-a"
    platform_id = "standard-v1"
    folder_id = var.folder_id
    resources {
      cores = local.cores
      memory = local.memory
    }
    boot_disk {
      initialize_params {
        image_id = "fd8tckeqoshi403tks4l"
        size = local.size
        type="network-ssd"
      }
    }
    network_interface {
        nat = true
        subnet_id = var.subnet_id_bgw
        ip_address = cidrhost(data.yandex_vpc_subnet.subnet_bgw.v4_cidr_blocks[0], 253)
    }
    metadata = {
        user-data = "${file("./bgw_cloud")}"
  }
    connection {
      host = yandex_compute_instance.bgw.network_interface.0.nat_ip_address
      type = "ssh"
      user = "vlad"  
      private_key = "${file("./ssh/id_rsa")}"
    }
    provisioner "remote-exec" {
    inline = [
      "echo 'instance up'"
    ]
  }
}