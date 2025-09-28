resource "kubectl_manifest" "grafana" {
  for_each  = data.kubectl_path_documents.grafana_documents.manifests
  yaml_body = each.value

  override_namespace = var.grafana_namespace

  depends_on = [
    kubernetes_namespace.grafana,
    helm_release.loki,
  ]
}
