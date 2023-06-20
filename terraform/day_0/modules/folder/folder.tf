resource "yandex_resourcemanager_folder" "folder" {
  for_each = toset(var.env)
  cloud_id    = var.cloud_id
  name        = "folder-${each.key}"
  description = "${each.key}"
}
