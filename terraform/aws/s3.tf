resource "aws_s3_bucket" "loki_chunks" {
  bucket        = var.loki_chunks_bucket_name
  force_destroy = true
}

resource "aws_s3_bucket" "loki_ruler" {
  bucket        = var.loki_ruler_bucket_name
  force_destroy = true
}
