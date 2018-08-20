resource "random_string" "mysql-unique-id" {
  length = 10
  special = false
  upper = false
}

resource "random_string" "mysql-admin-username" {
  length = 10
  special = false
  upper = false
  number = false
}

resource "random_string" "mysql-db-name" {
  length = 8
  special = false
  upper = false
  number = false
}

resource "random_string" "mysql-admin-password" {
  length = 16
  special = true
}