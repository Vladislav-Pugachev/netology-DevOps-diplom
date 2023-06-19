variable "service_account_key_file" {
  type = string
}

variable "folder_id" {
  description =  "Yandex folder_id"
  type = string
}
variable "cloud_id" {
  description =  "Yandex cloud_id"
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
