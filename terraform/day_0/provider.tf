terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.84.0"
    }
      gitlab = {
      source = "gitlabhq/gitlab"
      version = "16.0.3"
    }
  }
}

provider "yandex" {
 token     = var.token
 cloud_id  = var.cloud_id
}

provider "gitlab" {
  base_url  = "https://gitlab.home.lan/api/v4/"
  insecure  = true
  token = local.token
}
