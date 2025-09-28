terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.38"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 3.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = var.context_name
}

provider "helm" {
  kubernetes = {
    config_path    = "~/.kube/config"
    config_context = var.context_name
  }
}

provider "kubectl" {
  config_path       = "~/.kube/config"
  config_context    = var.context_name
  apply_retry_count = 5
}
