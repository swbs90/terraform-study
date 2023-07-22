# resource "google_sql_database_instance" "master" {
#   database_version = var.database_version
#   deletion_protection=false
#   settings {
#     tier              = var.database_type
#     availability_type = "ZONAL"
#     ip_configuration {
#       ipv4_enabled = "true"
#       authorized_networks {
#         value = "${var.db_instance_access_cidr}"
#       }
#     }
#   }
# }