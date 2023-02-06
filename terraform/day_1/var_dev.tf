variable "folder_id_dev" {
  description =  "Yandex folder_id dev"
  type = string
}

variable "subnet_dev" {
    description = "подсети. окружение dev"
    type= map
    default = {
        "ru-central1-a" = "10.0.0.0/24"
        "ru-central1-b" = "10.0.1.0/24"
        "ru-central1-c" = "10.0.2.0/24"
}
}

variable "k8s_contole_node_dev" {
    description = "мощности для control node. окружение dev"
    type = map
    default = {
        "cores"= 4
        "memory" = 8
        "image_id" = "fd8a67rb91j689dqp60h"
        "local_disk" = 50 
}  
}

variable "k8s_contole_worker_dev" {
    description = "мощности для worker node. окружение dev"
    type = map
    default = {
        "count" = 2
        "cores"= 2
        "memory" = 4
        "image_id" = "fd8a67rb91j689dqp60h"
        "local_disk" = 80 
}  
}

