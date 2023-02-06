resource "null_resource" "deploy_k8s" {
depends_on = [yandex_compute_instance.control_node]
connection {
    host = yandex_compute_instance.control_node.network_interface.0.nat_ip_address
    type = "ssh"
    user = "vlad"
    private_key = "${file("./ssh/id_rsa")}"
    }
provisioner "file" {
    source = "./ssh/id_rsa"
    destination = "/home/vlad/.ssh/id_rsa"
    }
provisioner "file" {
    source = "./modules/dev/inventory.yml"
    destination = "/home/vlad/hosts.yml"
    }
  provisioner "file" {
    source      = "./script.sh"
    destination = "/tmp/script.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/script.sh",
      "/tmp/script.sh args",
    ]
    }

}