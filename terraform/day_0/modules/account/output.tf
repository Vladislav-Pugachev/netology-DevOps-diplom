output "user-access-key-cred-backend" {
    value = yandex_iam_service_account_static_access_key.editor-backend-static-key.access_key
}

output "user-secret-key-cred-backend" {
    value = yandex_iam_service_account_static_access_key.editor-backend-static-key.secret_key
    sensitive = true
}

output "user-access-key-cred-web" {
    value = yandex_iam_service_account_static_access_key.web-image-uploader-static-key.access_key
}

output "user-secret-key-cred-web" {
    value = yandex_iam_service_account_static_access_key.web-image-uploader-static-key.secret_key
    sensitive = true
}
