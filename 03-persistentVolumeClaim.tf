resource "kubernetes_persistent_volume_claim" "pvc-glpi" {
  metadata {
    name      = "pvc-glpi"
    namespace = kubernetes_namespace.prueba-glpi.metadata.0.name
    labels = {
      app = kubernetes_persistent_volume.pv-glpi.metadata.0.labels.app
    }
  }
  spec {
    storage_class_name = kubernetes_persistent_volume.pv-glpi.spec.0.storage_class_name
    volume_name        = kubernetes_persistent_volume.pv-glpi.metadata.0.name
    access_modes       = kubernetes_persistent_volume.pv-glpi.spec.0.access_modes
    resources {
      requests = {
        storage = kubernetes_persistent_volume.pv-glpi.spec.0.capacity.storage
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim" "pvc-mariadb" {
  metadata {
    name      = "pvc-mariadb"
    namespace = kubernetes_namespace.prueba-glpi.metadata.0.name
    labels = {
      app = kubernetes_persistent_volume.pv-mariadb.metadata.0.labels.app
    }
  }
  spec {
    storage_class_name = kubernetes_persistent_volume.pv-mariadb.spec.0.storage_class_name
    volume_name        = kubernetes_persistent_volume.pv-mariadb.metadata.0.name
    access_modes       = kubernetes_persistent_volume.pv-mariadb.spec.0.access_modes
    resources {
      requests = {
        storage = kubernetes_persistent_volume.pv-mariadb.spec.0.capacity.storage
      }
    }
  }
}
