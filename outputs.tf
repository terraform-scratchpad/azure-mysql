#
# Outputs
#
output "mysql-server-host" {
  value = "${azurerm_mysql_server.mysql-server.name}.mysql.database.azure.com"
}

output "mysql-user" {
  value = "${azurerm_mysql_server.mysql-server.administrator_login}@${azurerm_mysql_server.mysql-server.name}"
}

output "mysql-password" {
  value = "${azurerm_mysql_server.mysql-server.administrator_login_password}"
}

output "db-name" {
  value = "${azurerm_mysql_database.db.name}"
}