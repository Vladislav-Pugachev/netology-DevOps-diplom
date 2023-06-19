resource "yandex_compute_instance" "gitlab" {
    name = "${terraform.workspace}-gitlab-node"
    hostname = "${terraform.workspace}-gitlab-node"
    allow_stopping_for_update = true
    zone = "ru-central1-a"
    platform_id = "standard-v1"
    folder_id = data.yandex_resourcemanager_folder.folder.id
    resources {
      cores = 4
      memory = 4
    }
    boot_disk {
      initialize_params {
        image_id = "fd83vstafqja7ql1kj0b"
        size = 50
        type="network-ssd"
      }
    }
    network_interface {
        nat = true
        subnet_id = data.yandex_vpc_subnet.underlay_subnet.id
    }
    metadata = {
        user-data = "${file("./cloud")}"
  }
      connection {
      host = yandex_compute_instance.gitlab.network_interface.0.nat_ip_address
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