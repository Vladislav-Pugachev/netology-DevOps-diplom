variable "token" {
  description =  "Yandex Api Token"
  type = string
}
variable "cloud_id" {
  description =  "Yandex cloud_id"
  type = string
}

variable "env" {
  description =  "окружение"
  type = list
  default =  ["dev", "prod", "admin"]
}

variable "env_backend" {
  description =  "окружение для бэкенд"
  type = list
  default =  ["admin"]
}

variable "env_day_1" {
  description =  "окружение для среды разработки"
  type = list
  default =  ["dev", "prod"]
}

variable "mikrotik_login" {
  description =  "логин mikrotik.com"
  type = string
}

variable "mikrotik_pass" {
  description =  "пароль mikrotik.com"
  type = string
}
