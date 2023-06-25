resource "gitlab_project_access_token" "atlantis_api" {
  project      = gitlab_project.diplom_atlantis.id
  name         = "access token for day_1"
  scopes = ["api"]
  expires_at = "2023-12-31"
}