data "kubectl_path_documents" "grafana_documents" {
  pattern          = "./manifests/grafana/grafana.yaml"
  disable_template = true
}

data "kubernetes_service_v1" "loki_gateway" {
  metadata {
    name      = "loki-gateway"
    namespace = var.grafana_namespace
  }

  depends_on = [helm_release.loki]
}

data "kubernetes_service_v1" "grafana" {
  metadata {
    name      = "grafana"
    namespace = var.grafana_namespace
  }

  depends_on = [kubectl_manifest.grafana]
}
