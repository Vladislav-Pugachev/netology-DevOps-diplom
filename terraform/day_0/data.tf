data "yandex_resourcemanager_folder" "folder" {
    depends_on = [module.folder]
    for_each = toset("${var.env}")
  name = "folder-${each.key}"
}