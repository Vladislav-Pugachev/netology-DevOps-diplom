variable "folder_id_prod" {
  description =  "Yandex folder_id prod"
  type = string
}

variable "folder_id_dev" {
  description =  "Yandex folder_id dev"
  type = string
}
variable "cloud_id" {
  description =  "Yandex cloud_id"
  type = string
}

variable "token" {
  description =  "Yandex token"
  type = string
}

variable "admin_bgw_external_ip" {
    description = "ip ext адрес admin-bgw"
    type= string
}

variable "admin_bgw_internal_ip" {
    description = "ip int адрес admin-bgw"
    type= string
}
