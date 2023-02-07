variable "folder_id" {
  description =  "Yandex folder_id dev"
  type = string
}

variable "cloud_id" {
  description =  "Yandex cloud_id"
  type = string
}

variable "subnet" {
  description =  "Yandex subnet"
  type = map
}

variable "k8s_contole_node" {
  description =  "мощности для control node"
  type = map
}

variable "k8s_contole_worker" {
  description =  "мощности для worker node"
  type = map
}

variable "mikrotik_login" {
  description =  "логин mikrotik.com"
  type = string
}

variable "mikrotik_pass" {
  description =  "пароль mikrotik.com"
  type = string
}