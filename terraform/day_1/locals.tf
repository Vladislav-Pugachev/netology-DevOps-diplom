locals {
  folder_id_vpc="${terraform.workspace}" == "dev" ? var.folder_id_dev: var.folder_id_prod
}