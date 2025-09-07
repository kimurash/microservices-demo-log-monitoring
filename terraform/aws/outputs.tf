output "loki_s3_access_policy" {
  value = aws_iam_policy.loki_s3_access_policy.name
}

output "loki_pod_identity_role" {
  value = aws_iam_role.loki_pod_identity_role.name
}

output "loki_chunks_bucket_name" {
  value = aws_s3_bucket.loki_chunks.id
}

output "loki_ruler_bucket_name" {
  value = aws_s3_bucket.loki_ruler.id
}
