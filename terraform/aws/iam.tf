resource "aws_iam_policy" "loki_s3_access_policy" {
  name        = "LokiS3AccessPolicy"
  path        = "/"
  description = "Allows Loki to access S3 buckets"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject",
          "s3:ListBucket",
        ],
        Resource = [
          "arn:aws:s3:::${var.loki_chunks_bucket_name}",
          "arn:aws:s3:::${var.loki_chunks_bucket_name}/*",
          "arn:aws:s3:::${var.loki_ruler_bucket_name}",
          "arn:aws:s3:::${var.loki_ruler_bucket_name}/*",
        ],
      },
    ],
  })
}

resource "aws_iam_role" "loki_pod_identity_role" {
  name = "LokiPodIdentityRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "pods.eks.amazonaws.com"
        },
        Action = [
          "sts:TagSession",
          "sts:AssumeRole",
        ],
      },
    ],
  })
}

resource "aws_iam_role_policy_attachment" "loki_s3_access_attach" {
  role       = aws_iam_role.loki_pod_identity_role.name
  policy_arn = aws_iam_policy.loki_s3_access_policy.arn
}

resource "aws_eks_pod_identity_association" "loki" {
  cluster_name    = var.cluster_name
  namespace       = "grafana"
  service_account = "loki"
  role_arn        = aws_iam_role.loki_pod_identity_role.arn

  depends_on = [
    # IAM ロールを先に作成するため
    aws_iam_role_policy_attachment.loki_s3_access_attach,
  ]
}

resource "aws_iam_role" "fluent_bit_pod_identity_role" {
  name = "FluentBitPodIdentityRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "pods.eks.amazonaws.com"
        },
        Action = [
          "sts:TagSession",
          "sts:AssumeRole",
        ],
      },
    ],
  })
}

resource "aws_iam_role_policy_attachment" "fluent_bit_cloudwatch_access_attach" {
  role       = aws_iam_role.fluent_bit_pod_identity_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_eks_pod_identity_association" "fluent_bit" {
  cluster_name    = var.cluster_name
  namespace       = "amazon-cloudwatch"
  service_account = "fluent-bit"
  role_arn        = aws_iam_role.fluent_bit_pod_identity_role.arn

  depends_on = [
    # IAM ロールを先に作成するため
    aws_iam_role_policy_attachment.fluent_bit_cloudwatch_access_attach,
  ]
}
