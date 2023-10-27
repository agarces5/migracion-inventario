
resource "kubernetes_stateful_set" "mariadb-deploy" {
  depends_on = [kubernetes_secret.mariadb-config]
  metadata {
    name      = "mariadb-deploy"
    namespace = kubernetes_namespace.prueba-glpi.metadata.0.name
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = kubernetes_service.mariadb-service.spec.0.selector.app
      }
    }
    service_name = kubernetes_service.mariadb-service.metadata.0.name
    template {
      metadata {
        labels = {
          app = kubernetes_service.mariadb-service.spec.0.selector.app
        }
      }
      spec {
        container {
          name  = "mariadb"
          image = "mariadb:10.7"
          env_from {
            secret_ref {
              name = kubernetes_secret.mariadb-config.metadata.0.name
            }
          }
          env {
            name  = "TIMEZONE"
            value = "Europe/Madrid"
          }

          volume_mount {
            name       = "mariadb-data"
            mount_path = "/var/lib/mysql"
            sub_path   = "mysql"
          }
        }
        volume {
          name = "mariadb-data"
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.pvc-mariadb.metadata.0.name
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "mariadb-service" {
  metadata {
    name      = "mariadb-service"
    namespace = kubernetes_namespace.prueba-glpi.metadata.0.name
  }
  spec {
    selector = {
      app = "mariadb"
    }
    port {
      port = 3306
    }
  }
}

