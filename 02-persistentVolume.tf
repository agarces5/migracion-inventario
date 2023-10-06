resource "kubernetes_persistent_volume" "pv-glpi" {
  metadata {
    name = "pv-glpi"
    labels = {
      app   = "glpi"
      owner = "agarces"
      name  = "pv-glpi"
    }
  }
  spec {
    storage_class_name = "microk8s-hostpath"
    capacity = {
      storage = "1Gi"
    }
    access_modes = ["ReadWriteOnce"]
    persistent_volume_source {
      host_path {
        path = "/home/agarces/pruebas/inventario/volumes/glpi"
      }
    }
  }
}

resource "kubernetes_persistent_volume" "pv-mariadb" {
  metadata {
    name = "pv-mariadb"
    labels = {
      app   = "mariadb"
      owner = "agarces"
      name  = "pv-mariadb"
    }
  }
  spec {
    storage_class_name = "microk8s-hostpath"
    capacity = {
      storage = "3Gi"
    }
    access_modes = ["ReadWriteOnce"]
    persistent_volume_source {
      host_path {
        path = "/home/agarces/pruebas/inventario/volumes/mariadb"
      }
    }
  }
}
