resource "kubernetes_stateful_set" "glpi-deploy" {
  metadata {
    name      = "glpi-deploy"
    namespace = kubernetes_namespace.prueba-glpi.metadata.0.name
  }
  spec {
    replicas = 3
    selector {
      match_labels = {
        app = kubernetes_service.glpi-service.spec.0.selector.app
      }
    }
    service_name = kubernetes_service.glpi-service.metadata.0.name
    template {
      metadata {
        labels = {
          app = kubernetes_service.glpi-service.spec.0.selector.app
        }
      }
      spec {
        init_container {
          name    = "init-htaccess"
          image   = "alpine/git"
          command = ["sh", "-c", "git clone https://github.com/playa-senator/ip-block-forti.git /ip-block-forti && /init/ip-block"]
          volume_mount {
            name       = "glpi-data"
            mount_path = "/init"
          }
        }
        container {
          name  = "glpi"
          image = "diouxx/glpi"
          port {
            container_port = 80
          }
          volume_mount {
            name       = "glpi-data"
            mount_path = "/etc/timezone"
            sub_path   = "timezone"
          }
          volume_mount {
            name       = "glpi-data"
            mount_path = "/etc/localtime"
            sub_path   = "localtime"
          }
          volume_mount {
            name       = "glpi-data"
            mount_path = "/var/www/html/glpi"
            sub_path   = "glpi"
          }
        }
        volume {
          name = "glpi-data"
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.pvc-glpi.metadata.0.name
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "glpi-service" {
  metadata {
    name      = "glpi-service"
    namespace = kubernetes_namespace.prueba-glpi.metadata.0.name
  }
  spec {
    selector = {
      app = "glpi"
    }
    port {
      port        = 80
      target_port = 80
    }
  }

}
