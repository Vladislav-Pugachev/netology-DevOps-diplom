resource "null_resource" "clone_kubspray" {
  provisioner "local-exec" {
    command = "git clone -b v2.21.0 --single-branch https://github.com/kubernetes-sigs/kubespray.git"
    working_dir = "./modules/ansible/roles"
  }
}

resource "null_resource" "install_dependese" {
  depends_on = [null_resource.clone_kubspray]
  provisioner "local-exec" {
    command = "sudo pip3 install -r requirements.txt"
    working_dir = "./modules/ansible/roles/kubespray"
  }
}

resource "null_resource" "deploy_k8s" {
  depends_on = [null_resource.bird_admin_bgw]
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook --key-file ssh/id_rsa --ssh-extra-args='-o ProxyCommand=\"ssh -i ssh/id_rsa -o StrictHostKeyChecking=no -W %h:%p ${var.admin_bgw_external_ip}\"' -i ./modules/ansible/inventory.yml ./modules/ansible/roles/kubespray/cluster.yml -b -v"
  }
}



resource "null_resource" "get_config_k8s" {
  depends_on = [null_resource.deploy_k8s]
  provisioner "local-exec" {
    command = "ssh -i ssh/id_rsa -o ProxyCommand=\"ssh -i ssh/id_rsa -o StrictHostKeyChecking=no -W %h:%p ${var.admin_bgw_external_ip}\" ${local.loopback_control_node} \"sudo cat /etc/kubernetes/admin.conf\""
  }
}