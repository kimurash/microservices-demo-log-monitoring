resource "kubernetes_config_map" "alloy_config" {
  metadata {
    name      = "alloy-config"
    namespace = var.monitoring_namespace
  }

  data = {
    "config.alloy" = file("${path.module}/config.alloy")
  }

  depends_on = [
    kubernetes_namespace.monitoring
  ]
}

resource "helm_release" "alloy" {
  name       = "alloy"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "alloy"
  version    = "1.2.1"
  namespace  = var.monitoring_namespace

  values = [
    file("${path.module}/manifests/alloy/values.yaml")
  ]

  depends_on = [
    kubernetes_namespace.monitoring,
    kubernetes_config_map.alloy_config,
    helm_release.loki,
  ]
}
