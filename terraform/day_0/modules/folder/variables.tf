variable "cloud_id" {
  description =  "Yandex cloud_id"
  type = string
}

variable "env" {
  description =  "окружение"
  type = list
  default =  ["dev", "prod", "admin"]
}