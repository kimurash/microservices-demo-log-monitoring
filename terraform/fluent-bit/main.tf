resource "kubernetes_namespace" "amazon_cloudwatch" {
  metadata {
    name = var.amazon_cloudwatch_namespace
  }
}

resource "kubernetes_config_map" "fluent_bit_cluster_info" {
  metadata {
    name      = "fluent-bit-cluster-info"
    namespace = var.amazon_cloudwatch_namespace
  }

  data = {
    "cluster.name" = var.cluster_name
    "http.port"    = "2020"
    "http.server"  = "On"
    "read.head"    = "Off"
    "read.tail"    = "On"
    "logs.region"  = var.aws_region
  }
}

resource "kubectl_manifest" "fluent_bit" {
  for_each  = data.kubectl_path_documents.fluent_bit_documents.manifests
  yaml_body = each.value

  override_namespace = var.amazon_cloudwatch_namespace

  depends_on = [
    kubernetes_namespace.amazon_cloudwatch,
    kubernetes_config_map.fluent_bit_cluster_info,
  ]
}
