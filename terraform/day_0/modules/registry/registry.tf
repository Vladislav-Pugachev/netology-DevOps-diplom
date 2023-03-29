resource "yandex_container_registry" "diplom" {
  name      = "diplom"
  folder_id = data.yandex_resourcemanager_folder.folder.id
}