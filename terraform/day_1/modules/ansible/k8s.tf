resource "null_resource" "deploy_k8s" {
  depends_on = [null_resource.bird_admin_bgw]
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook --key-file ssh/id_rsa --ssh-extra-args='-o ProxyCommand=\"ssh -i ssh/id_rsa -o StrictHostKeyChecking=no -W %h:%p ${var.admin_bgw_external_ip}\"' -i ./modules/ansible/inventory.yml ./modules/ansible/kubespray/cluster.yml -b -v"
  }
}



resource "null_resource" "get_config_k8s" {
  depends_on = [null_resource.deploy_k8s]
  provisioner "local-exec" {
    command = "ssh -i ssh/id_rsa -o ProxyCommand=\"ssh -i ssh/id_rsa -o StrictHostKeyChecking=no -W %h:%p ${var.admin_bgw_external_ip}\" ${local.loopback_control_node} \"sudo cat /etc/kubernetes/admin.conf\" > ${terraform.workspace}-kubeadmin"
  }
}

# resource "null_resource" "get_openvpn_client_file" {
#   depends_on = [null_resource.deploy_k8s]
#   provisioner "local-exec" {
#     command = "scp -i ssh/id_rsa ${var.admin_bgw_external_ip}:client-configs/files/vlad.ovpn vlad.ovpn"
#   }
# }