resource "local_file" "playbook_k8s" {
  depends_on = [null_resource.config-nat]
  content     = templatefile("./modules/dev/ansible/k8s/playbook_k8s.tpl",
  {
    external_nat_ip = yandex_compute_instance.nat.network_interface.0.nat_ip_address
})
  filename = "./modules/ansible/k8s/playbook_k8s.yml"
}


resource "null_resource" "predeploy-k8s" {
  depends_on = [local_file.playbook_k8s]
  provisioner "local-exec" {
    command = "ansible-playbook -i ${yandex_compute_instance.nat.network_interface.0.nat_ip_address}, ./modules/ansible/k8s/playbook_k8s.yml --key-file ./ssh/id_rsa"
  }
}

resource "null_resource" "deploy-k8s" {
  depends_on = [null_resource.predeploy-k8s]
    provisioner "remote-exec" {
      connection {
        host = yandex_compute_instance.nat.network_interface.0.nat_ip_address
        type = "ssh"
        port= "2222"
        user = "vlad"  
        private_key = "${file("./ssh/id_rsa")}"
      }
      inline = ["ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ./kubespray/inventory/sample/hosts.yml ./kubespray/cluster.yml -b -v -e 'cluster_access_ip=${yandex_compute_instance.nat.network_interface.0.nat_ip_address}:6443'"]
      }
}


