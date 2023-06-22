resource "null_resource" "atlantis" {
    depends_on= [local_file.atlantis_config]
    provisioner "local-exec" {
        command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ${var.gitlab_external_ip}, ./modules/gitlab/atlantis.yml --key-file ./ssh/id_rsa"
  }
}