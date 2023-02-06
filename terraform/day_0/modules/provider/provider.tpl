terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.84.0"
    }
  }
  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "${bucket_id}"
    region     = "ru-central1"
    key        = "terraform.tfstate"
    access_key = "${access_key}"
    secret_key = "${secret_key}"
    skip_region_validation      = true
    skip_credentials_validation = true
    dynamodb_endpoint = "${ydb_end_point}"
    dynamodb_table = "${dynamodb_table}"    
}
}
provider "yandex" {
 token     = var.token
 cloud_id  = var.cloud_id
}
%{ for folder in "${folder_id}"~}
provider "yandex" {
  alias = "${folder}"
  cloud_id  = var.cloud_id
  service_account_key_file = "$${file("admin-resourse-env-${folder}.json")}"
  folder_id= var.folder_id_${folder}
}
%{ endfor ~}