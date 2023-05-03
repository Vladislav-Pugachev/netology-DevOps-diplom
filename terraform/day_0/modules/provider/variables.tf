variable "env_day_1" {
  description =  "окружение для среды разработки"
  type = list
  default =  ["dev", "prod"]
}

variable "cloud_id" {
  description =  "Yandex cloud_id"
  type = string
}

variable "token_false" {
  description = "token false"
  type= string
  default = "false_token"
}

variable "yadb_endpoint" {
  type = string
}

variable "access_key" {
  type = string
}

variable "secret_key" {
  type = string
  sensitive = true
}

variable "admin_bgw_external_ip" {
  description = "внешний адрес bgw"
  type = string
}

variable "admin_bgw_internal_ip" {
  description = "внутренний адрес bgw"
  type = string
}