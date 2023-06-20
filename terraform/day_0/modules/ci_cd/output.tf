output "gitlab_external_ip" {
    value = yandex_compute_instance.gitlab.network_interface.0.nat_ip_address
}

output "gitlab_token" {
    value = data.external.gitlab_token.result.token_gitlab
}

output "gitlab_internal_ip" {
    value = yandex_compute_instance.gitlab.network_interface.0.ip_address
}