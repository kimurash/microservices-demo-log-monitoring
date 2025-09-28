variable "aws_region" {
  type    = string
  default = "ap-northeast-1"
}

variable "context_name" {
  type = string
}

variable "grafana_namespace" {
  type    = string
  default = "grafana"
}

variable "loki_chunks_bucket_name" {
  type    = string
  default = "3shake-loki-chunks"
}

variable "loki_ruler_bucket_name" {
  type    = string
  default = "3shake-loki-ruler"
}
