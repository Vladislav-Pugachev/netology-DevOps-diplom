resource "yandex_compute_instance" "gitlab" {
    name = "${terraform.workspace}-gitlab-node"
    hostname = "${terraform.workspace}-gitlab-node"
    allow_stopping_for_update = true
    zone = "ru-central1-a"
    platform_id = "standard-v1"
    folder_id = data.yandex_resourcemanager_folder.folder.id
    resources {
      cores = 6
      memory = 6
    }
    boot_disk {
      initialize_params {
        image_id = data.yandex_compute_image.gitlab.id
        size = 50
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
      user = "pugachevvv"  
      private_key = "${file("./ssh/id_rsa")}"
    }
    provisioner "remote-exec" {
    inline = [
      "echo 'instance up'"
    ]
  }
}