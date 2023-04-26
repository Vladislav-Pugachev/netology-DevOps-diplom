locals {
  cores="${terraform.workspace}" == "dev" ? 2: 4
  memory="${terraform.workspace}" == "dev" ? 2: 4
  size="${terraform.workspace}" == "dev" ? 5: 10
}
