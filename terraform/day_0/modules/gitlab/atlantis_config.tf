resource "local_file" "atlantis_config" {
    depends_on = [ gitlab_project_hook.webhook_atlantis ]
  content     = templatefile("./modules/gitlab/atlantis_config.tpl",
    {
    url = var.gitlab_internal_ip
    gitlab_atlantis_api_token=gitlab_project_access_token.atlantis_api.token
})
  filename = "./modules/gitlab/atlantis_config.yaml"
  
  provisioner "local-exec" {
  command = "rm ./modules/gitlab/atlantis_config.yaml"
  when=destroy
  }
}