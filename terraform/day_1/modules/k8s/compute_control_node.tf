resource "yandex_compute_instance" "control_node" {
  provider = yandex.dev
  allow_stopping_for_update = true
  name = "${terraform.workspace}-control-node"
  hostname = "${terraform.workspace}-control-node"
  zone = "ru-central1-a"
  platform_id = "standard-v1"
  folder_id = var.folder_id
  resources {
    cores = local.cores_control_node
    memory = local.memory_control_node
  }
  boot_disk {
    initialize_params {
      image_id = var.k8s_image["control_node"]
      size = local.size_control_node
    }
  }
  network_interface {
      nat = false
      subnet_id = var.subnet_id_k8s["ru-central1-a"]
      ip_address = cidrhost(data.yandex_vpc_subnet.subnet_k8s["ru-central1-a"].v4_cidr_blocks[0], 253)
  }
  metadata = {
    user-data = "${file("./cloud")}"
  }
  connection {
    type ="ssh"
    bastion_host = var.node_external_ip_bgw
    bastion_private_key = "${file("./ssh/id_rsa")}"
    bastion_user = "vlad"
    private_key = "${file("./ssh/id_rsa")}"
    user="vlad"
    host=self.network_interface.0.ip_address
  }
  provisioner "remote-exec" {
    inline = [
      "echo 'instance up'"
    ]
  }
}