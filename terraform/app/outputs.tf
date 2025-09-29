output "app_domain" {
  description = "app domain name"
  value       = data.kubernetes_service_v1.frontend-external.status[0].load_balancer[0].ingress[0].hostname
}
