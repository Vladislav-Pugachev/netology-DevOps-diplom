output "ci_cd_ext_ip" {
value= module.ci_cd.gitlab_ip
}


output "registry" {
value= module.registry.registry_id
}
