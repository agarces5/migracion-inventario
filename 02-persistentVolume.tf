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
    storage_class_name = "openebs-hostpath"
    capacity = {
      storage = "2Gi"
    }
    access_modes = ["ReadWriteOnce"]
    persistent_volume_source {
      host_path {
        path = "/var/openebs/local/webs/inventario/glpi"
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
    storage_class_name = "openebs-hostpath"
    capacity = {
      storage = "10Gi"
    }
    access_modes = ["ReadWriteOnce"]
    persistent_volume_source {
      host_path {
        path = "/var/openebs/local/webs/inventario/mariadb"
      }
    }
  }
}
