variable "aws_region" {
  type    = string
  default = "ap-northeast-1"
}

variable "cluster_name" {
  type    = string
  default = "loki-experiment"
}

variable "context_name" {
  type = string
}

variable "app_namespace" {
  type    = string
  default = "app"
}

variable "monitoring_namespace" {
  type    = string
  default = "monitoring"
}

variable "amazon_cloudwatch_namespace" {
  type    = string
  default = "amazon-cloudwatch"
}

variable "loki_chunks_bucket_name" {
  type    = string
  default = "3shake-loki-chunks"
}

variable "loki_ruler_bucket_name" {
  type    = string
  default = "3shake-loki-ruler"
}
