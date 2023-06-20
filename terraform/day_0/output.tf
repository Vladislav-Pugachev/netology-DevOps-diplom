output "gitlab_external_ip" {
value= module.ci_cd.gitlab_external_ip
}

output "gitlab_internal_ip" {
value= module.ci_cd.gitlab_internal_ip
}

output "registry" {
value= module.registry.registry_id
}

output "admin_bgw_external_ip" {
value= module.bgw.admin_bgw_external_ip
}

output "admin_bgw_internal_ip" {
value= module.bgw.admin_bgw_internal_ip
}

output "gitlab_token" {
value= module.ci_cd.gitlab_token
sensitive = true
}


output "gitlab_atlantis_http" {
value= module.gitlab.gitlab_atlantis_http
}

output "gitlab_web_app_http" {
value= module.gitlab.gitlab_web_app_http
}

output "gitlab_web_app_runners_token" {
value= module.gitlab.gitlab_web_app_runners_token
sensitive = true
}

output "gitlab_atlantis_api_token" {
value= module.gitlab.gitlab_atlantis_api_token
sensitive = true
}

output "folder_ws" {
value= module.folder.folder_ws
}