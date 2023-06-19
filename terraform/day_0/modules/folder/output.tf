output "folder_ws" {
    value = {for k in yandex_resourcemanager_folder.folder[*]: k.description=>k.id}
}