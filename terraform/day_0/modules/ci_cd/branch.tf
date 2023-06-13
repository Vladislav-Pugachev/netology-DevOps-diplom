# provider "gitlab" {
#   token = element(local.token_git_lab.0)
# }

resource "gitlab_project" "example" {
  name        = "example"
  description = "My awesome codebase"

  visibility_level = "public"
}
