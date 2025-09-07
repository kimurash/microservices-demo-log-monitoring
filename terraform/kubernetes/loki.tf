resource "kubernetes_secret" "loki_basic_auth" {
  metadata {
    name      = "loki-basic-auth"
    namespace = var.monitoring_namespace
  }
  data = {
    ".htpasswd" = file("${path.module}/.htpasswd")
  }
  type = "Opaque"

  depends_on = [kubernetes_namespace.monitoring]
}

resource "kubernetes_secret" "canary_basic_auth" {
  metadata {
    name      = "canary-basic-auth"
    namespace = var.monitoring_namespace
  }
  data = {
    username = "loki"
    password = "loki"
  }
  type = "kubernetes.io/basic-auth"

  depends_on = [kubernetes_namespace.monitoring]
}

resource "helm_release" "loki" {
  name       = "loki"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "loki"
  version    = "6.39.0"
  namespace  = var.monitoring_namespace

  values = [
    templatefile("${path.module}/templates/loki/values.tftpl", {
      aws_region              = var.aws_region
      loki_chunks_bucket_name = var.loki_chunks_bucket_name
      loki_ruler_bucket_name  = var.loki_ruler_bucket_name
    })
  ]

  depends_on = [
    kubernetes_namespace.monitoring,
    kubernetes_secret.loki_basic_auth,
    kubernetes_secret.canary_basic_auth,
  ]
}
