data "yandex_resourcemanager_folder" "folder" {
    for_each = toset("${var.env_day_1}")
    name = "folder-${each.key}"
}