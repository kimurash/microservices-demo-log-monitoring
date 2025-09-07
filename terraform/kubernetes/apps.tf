resource "kubectl_manifest" "demo_app" {
  for_each  = data.kubectl_path_documents.demo_app_docs.manifests
  yaml_body = each.value

  override_namespace = var.app_namespace

  depends_on = [
    kubernetes_namespace.app
  ]
}
