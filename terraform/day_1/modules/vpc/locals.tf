locals {
  subnet={
        "ru-central1-a" = "${terraform.workspace}" == "dev" ? "10.1.1.0/24": "10.2.1.0/24"
        "ru-central1-b" = "${terraform.workspace}" == "dev" ? "10.1.2.0/24": "10.2.2.0/24"
        "ru-central1-c" = "${terraform.workspace}" == "dev" ? "10.1.3.0/24": "10.2.3.0/24"
}
}

locals {
  subnet_bgw="${terraform.workspace}" == "dev" ? "10.1.0.0/24": "10.2.0.0/24"
}
