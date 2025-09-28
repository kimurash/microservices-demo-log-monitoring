data "kubectl_path_documents" "demo_app_documents" {
  pattern          = "../../release/kubernetes-manifests.yaml"
  disable_template = true
}

data "kubernetes_service_v1" "frontend-external" {
  metadata {
    name      = "frontend-external"
    namespace = var.app_namespace
  }

  depends_on = [kubectl_manifest.demo_app]
}
