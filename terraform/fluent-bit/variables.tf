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

variable "amazon_cloudwatch_namespace" {
  type    = string
  default = "amazon-cloudwatch"
}
