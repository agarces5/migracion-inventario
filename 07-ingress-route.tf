resource "kubernetes_manifest" "http-redirect" {
  manifest = {
    "apiVersion" = "traefik.io/v1alpha1"
    "kind"       = "Middleware"
    "metadata" = {
      "name"      = "http-redirect-https"
      "namespace" = "inventario"
    }
    "spec" = {
      "redirectScheme" = {
        "scheme"    = "https"
        "port"      = "443"
        "permanent" = true
      }
    }
  }
}
resource "kubernetes_manifest" "http_route" {
  depends_on = [kubernetes_namespace.prueba-glpi]
  manifest = {
    "apiVersion" = "traefik.io/v1alpha1"
    "kind"       = "IngressRoute"
    "metadata" = {
      "name"      = "glpi"
      "namespace" = "inventario"
    }
    "spec" = {
      "entryPoints" = [
        "web",
      ]
      "routes" = [
        {
          "kind"  = "Rule"
          "match" = "Host(`tickets.senator.tools`)"
          "middlewares" = [
            {
              "name" = "http-redirect-https"
            }
          ]
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
resource "kubernetes_manifest" "https_route" {
  depends_on = [kubernetes_namespace.prueba-glpi]
  manifest = {
    "apiVersion" = "traefik.io/v1alpha1"
    "kind"       = "IngressRoute"
    "metadata" = {
      "name"      = "glpi-secure"
      "namespace" = "inventario"
    }
    "spec" = {
      "entryPoints" = [
        "websecure",
      ]
      "routes" = [
        {
          "kind"  = "Rule"
          "match" = "Host(`tickets.senator.tools`)"
          "middlewares" = [
            {
              "name" = "http-redirect-https"
            }
          ]
          "services" = [
            {
              "name" = "glpi-service"
              "port" = 80
            },
          ]
        },
      ]
      "tls" = {
        "certResolver" = "letsencrypt"
      }
    }
  }
}

