resource "null_resource" "token_gitlab" {
    depends_on= [yandex_compute_instance.gitlab]
    provisioner "local-exec" {
        command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ${yandex_compute_instance.gitlab.network_interface.0.nat_ip_address}, ./modules/ci_cd/token_gitlab.yml --key-file ./ssh/id_rsa --ssh-common-args='-o StrictHostKeyChecking=no'"
  }
}

resource "null_resource" "rm_token_gitlab" {
  provisioner "local-exec" {
  command = "rm ./modules/ci_cd/token_gitlab.json"
  when=destroy
  }
}