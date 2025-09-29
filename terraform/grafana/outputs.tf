output "loki_domain" {
  description = "Grafana Loki domain name"
  value       = data.kubernetes_service_v1.loki_gateway.status[0].load_balancer[0].ingress[0].hostname
}

output "grafana_domain" {
  description = "Grafana domain name"
  value       = data.kubernetes_service_v1.grafana.status[0].load_balancer[0].ingress[0].hostname
}
