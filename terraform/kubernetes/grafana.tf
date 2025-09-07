resource "kubectl_manifest" "grafana" {
  for_each  = data.kubectl_path_documents.grafana_docs.manifests
  yaml_body = each.value

  override_namespace = var.monitoring_namespace

  depends_on = [
    kubernetes_namespace.monitoring,
    helm_release.loki,
  ]
}
