resource "gitlab_application_settings" "allow_local_hook" {
  allow_local_requests_from_system_hooks= true
  allow_local_requests_from_web_hooks_and_services=true
}

resource "gitlab_project_hook" "webhook_atlantis" {
  depends_on = [gitlab_application_settings.allow_local_hook]
  project               = gitlab_project.diplom_atlantis.id
  url                   = format("http://%s/events",var.gitlab_internal_ip)
  merge_requests_events = true
  push_events = true
  note_events = true
  enable_ssl_verification = false
}