# localc {
#     token_git_lab = regex("","${ssh -i ssh/id_rsa 130.193.36.21 "sudo cat /etc/gitlab/initial_root_password" }")
# }

#   provisioner "local-exec" {
#     command = "ssh -i ssh/id_rsa 130.193.36.21 \"sudo cat /etc/gitlab/initial_root_password\" > token.txt"
#   }

resource "null_resource" "token_gitlab" {
    depends_on= [yandex_compute_instance.gitlab]
    provisioner "local-exec" {
        command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ${yandex_compute_instance.gitlab.network_interface.0.nat_ip_address}, ./modules/ci_cd/token.yml --key-file ./ssh/id_rsa --ssh-common-args='-o StrictHostKeyChecking=no'"
  }
}

locals {
    depends_on= [null_resource.token_gitlab]
    token_git_lab = regex("Password:\\s(\\S+)","${file("./modules/ci_cd/initial_root_password")}")
}