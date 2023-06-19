variable "workdir" {
  description =  "окружение"
  type = string
}

variable "cloud_id" {
  description =  "Yandex cloud_id"
  type = string
}

variable "env_day_1" {
  description =  "окружение для среды разработки"
  type = list
  default =  ["dev", "prod"]
}
