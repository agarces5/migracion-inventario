resource "kubernetes_manifest" "http_route" {
  depends_on = [kubernetes_namespace.prueba-glpi]
  manifest = {
    "apiVersion" = "traefik.io/v1alpha1"
    "kind"       = "IngressRoute"
    "metadata" = {
      "name"      = "glpi"
      "namespace" = "prueba-glpi"
    }
    "spec" = {
      "entryPoints" = [
        "web",
      ]
      "routes" = [
        {
          "kind"  = "Rule"
          "match" = "Host(`tickets.senatorkube.es`)"
          "services" = [
            {
              "name" = "glpi-service"
              "port" = 80
            },
          ]
        },
      ]
    }
  }
}

