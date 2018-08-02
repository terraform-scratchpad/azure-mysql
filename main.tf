provider "azurerm" {
  version = "1.8.0"
}

provider "random" {
  version = "1.3.1"
}

resource "random_string" "mysql-admin-username" {
  length = 10
  special = false
  upper = false
}

resource "random_string" "mysql-db-name" {
  length = 8
  special = false
  upper = false
}

resource "random_string" "mysql-admin-password" {
  length = 16
  special = true
  override_special = "/@><*&\" "
}

resource "azurerm_mysql_server" "mysql-server" {

  name                          = "${random_string.mysql-admin-username.id}-mysql-server-${count.index}"
  location                      = "${var.location}"
  resource_group_name           = "${var.resource_group_name}"
  administrator_login           = "${random_string.mysql-admin-username.id}"
  administrator_login_password  = "${random_string.mysql-admin-password.id}"


  sku {
    name = "B_Gen4_2"
    # TODO externalize
    capacity = 2
    tier = "Basic"
    family = "Gen4"
  }

  "storage_profile" {
    # TODO externalize
    storage_mb = 51200
    backup_retention_days = 7
    geo_redundant_backup = "Disabled"
  }

  ssl_enforcement = "Disabled"

  # TODO upgradable
  version = "5.7"

  tags = "${var.tags}"
}


resource "azurerm_mysql_firewall_rule" "stg-mysql-firewall-rules" {
  start_ip_address = "${var.mysql_start_ip_address}"
  end_ip_address = "${var.mysql_end_ip_address}"
  name = "stg-mysql-firewall-rules-${count.index}"
  resource_group_name = "${var.resource_group_name}"
  server_name = "${azurerm_mysql_server.mysql-server.name}"
}

#
# Create database
#
resource "azurerm_mysql_database" "db" {
  name = "${random_string.mysql-db-name.id}"
  resource_group_name = "${var.resource_group_name}"
  server_name = "${azurerm_mysql_server.mysql-server.name}"
  charset = "utf8"
  collation = "utf8_unicode_ci"
}