output "gitlab_ip" {
value= module.ci_cd.gitlab_ip
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
}