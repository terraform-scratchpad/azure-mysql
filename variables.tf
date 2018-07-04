variable "location" {
  description = "geographical location"
}

variable "resource_group_name" {
  description = "main resource group"
}

variable "tags" {
  type = "map"
  description = "tags"
}

variable mysql_start_ip_address {}
variable mysql_end_ip_address {}