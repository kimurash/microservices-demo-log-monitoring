variable "aws_region" {
  type    = string
  default = "ap-northeast-1"
}

variable "aws_profile" {
  type    = string
  default = "3shake"
}

variable "cluster_name" {
  type    = string
  default = "loki-experiment"
}

variable "loki_chunks_bucket_name" {
  type    = string
  default = "3shake-loki-chunks"
}

variable "loki_ruler_bucket_name" {
  type    = string
  default = "3shake-loki-ruler"
}
