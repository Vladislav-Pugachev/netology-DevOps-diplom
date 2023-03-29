resource "local_file" "playbook_nat" {
  depends_on = [yandex_compute_instance.nat]
  content     = templatefile("./modules/dev/nat/ansible/playbook_nat.tpl",
  {
    control_node_private_ip = yandex_compute_instance.control_node.network_interface.0.ip_address
})
  filename = "./modules/dev/nat/ansible/playbook_nat.yml"
}


resource "null_resource" "config-nat" {
  depends_on = [local_file.playbook_nat]
  provisioner "local-exec" {
    command = "ansible-playbook -i ${yandex_compute_instance.nat.network_interface.0.nat_ip_address}, ./modules/dev/nat/ansible/playbook_nat.yml --key-file ./ssh/id_rsa"
  }
}