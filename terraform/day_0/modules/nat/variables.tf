# variable "workdir" {
#   description =  "окружение"
#   type = string
# }

variable "token" {
  description =  "Yandex Api Token"
  type = string
}
variable "cloud_id" {
  description =  "Yandex cloud_id"
  type = string
}

# variable "folder_id" {
#     description =  "Yandex folder_id"
#   type = string
#   default = "folder-${terraform.workspace}"
# }