resource "null_resource" "netplan_apply_node_k8s" {
  depends_on = [null_resource.install_dependese]
  for_each = var.nodes_private_ip_k8s
  provisioner "local-exec" {
    command = "ansible-playbook -i ${each.value}, ./modules/ansible/network.yaml --key-file ./ssh/id_rsa --skip-tags iptables -e \"hostname=${each.key}\" --ssh-common-args='-o ProxyCommand=\"ssh -i ssh/id_rsa -o StrictHostKeyChecking=no -W %h:%p ${var.node_external_ip_bgw}\"'"
  }
}


resource "null_resource" "netplan_apply_node_bgw" {
  depends_on = [null_resource.netplan_apply_node_k8s]
  provisioner "local-exec" {
    command = "ansible-playbook -i ${var.node_external_ip_bgw}, ./modules/ansible/network.yaml --key-file ./ssh/id_rsa --skip-tags iptables -e \"hostname=${terraform.workspace}-bgw-node\""
  }
}

resource "null_resource" "netplan_apply_admin_bgw" {
  depends_on = [null_resource.netplan_apply_node_bgw]
  provisioner "local-exec" {
    command = "ansible-playbook -i ${var.admin_bgw_external_ip}, ./modules/ansible/network.yaml --key-file ./ssh/id_rsa -e \"hostname=admin-bgw-node\""
  }
}


resource "null_resource" "bird_env_node_bgw" {
  depends_on = [null_resource.netplan_apply_admin_bgw]
  provisioner "local-exec" {
    command = "ansible-playbook -i ${var.node_external_ip_bgw}, ./modules/ansible/bird.yml --key-file ./ssh/id_rsa --skip-tags admin_bgw -e \"env=${terraform.workspace}\""
  }
}

resource "null_resource" "bird_admin_bgw" {
  depends_on = [null_resource.bird_env_node_bgw]
  provisioner "local-exec" {
    command = "ansible-playbook -i ${var.admin_bgw_external_ip}, ./modules/ansible/bird.yml --key-file ./ssh/id_rsa --skip-tags env_bgw -e \"env=${terraform.workspace}\""
  }
}

