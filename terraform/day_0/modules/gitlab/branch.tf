resource "gitlab_project" "diplom_web_app" {
  name        = "web_app"
  description = "репозитории для веб приложения"
  visibility_level = "public"
}

resource "gitlab_project" "diplom_atlantis" {
  name        = "atlantis"
  description = "репозитории для atlantiss"
  visibility_level = "public"
}
