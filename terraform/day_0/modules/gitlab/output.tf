output "gitlab_atlantis_http" {
    value = gitlab_project.diplom_atlantis.http_url_to_repo
}


output "gitlab_web_app_http" {
    value = gitlab_project.diplom_web_app.http_url_to_repo
}

output "gitlab_web_app_runners_token" {
    value = gitlab_project.diplom_web_app.runners_token
}


output "gitlab_atlantis_api_token" {
    value = gitlab_project_access_token.atlantis_api.token
}
