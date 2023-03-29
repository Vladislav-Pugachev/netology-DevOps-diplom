variable "cloud_id" {
  description =  "Yandex cloud_id"
  type = string
}

variable "access_key" {

  type = string
}

variable "secret_key" {

  type = string
  sensitive = true
}