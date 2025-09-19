data "kubectl_path_documents" "demo_app_documents" {
  pattern          = "../../release/kubernetes-manifests.yaml"
  disable_template = true
}

data "kubectl_path_documents" "grafana_documents" {
  pattern          = "./manifests/grafana/grafana.yaml"
  disable_template = true
}

data "kubectl_path_documents" "fluent_bit_documents" {
  pattern          = "./manifests/fluent-bit/fluent-bit.yaml"
  disable_template = true
}

data "kubernetes_service_v1" "frontend-external" {
  metadata {
    name      = "frontend-external"
    namespace = var.app_namespace
  }

  depends_on = [kubectl_manifest.demo_app]
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
