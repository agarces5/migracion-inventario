# resource "kubernetes_secret" "mariadb-config-example" {
#   metadata {
#     name      = "mariadb-config"
#     namespace = kubernetes_namespace.prueba-glpi.metadata.0.name
#   }
#   type = "Opaque"
#   data = {
#     MARIADB_ROOT_PASSWORD = base64encode("passwd")
#     MARIADB_DATABASE      = base64encode("db")
#     MARIADB_USER          = base64encode("user")
#     MARIADB_PASSWORD      = base64encode("passwd")
#   }
# }
