data "kubectl_path_documents" "demo_app_docs" {
  pattern          = "../../release/kubernetes-manifests.yaml"
  disable_template = true
}

data "kubectl_path_documents" "grafana_docs" {
  pattern          = "./manifests/grafana/grafana.yaml"
  disable_template = true
}

data "kubernetes_service_v1" "loki_gateway" {
  metadata {
    name      = "loki-gateway"
    namespace = var.monitoring_namespace
  }

  depends_on = [helm_release.loki]
}

data "kubernetes_service_v1" "grafana" {
  metadata {
    name      = "grafana"
    namespace = var.monitoring_namespace
  }

  depends_on = [kubectl_manifest.grafana]
}
