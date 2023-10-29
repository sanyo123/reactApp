resource "aws_eks_fargate_profile" "development" {
  cluster_name           = aws_eks_cluster.this.name
  fargate_profile_name   = "development"
  pod_execution_role_arn = aws_iam_role.fargate_pod_execution_role.arn
  subnet_ids             = aws_subnet.this.*.id
  selector {
    namespace = "development"
  }
}

resource "aws_eks_fargate_profile" "production" {
  cluster_name           = aws_eks_cluster.this.name
  fargate_profile_name   = "production"
  pod_execution_role_arn = aws_iam_role.fargate_pod_execution_role.arn
  subnet_ids             = aws_subnet.this.*.id
  selector {
    namespace = "production"
  }
}

resource "aws_iam_role" "fargate_pod_execution_role" {
  name = "fargate_pod_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "eks-fargate-pods.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "fargate_pod_execution_role" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
  role       = aws_iam_role.fargate_pod_execution_role.name
}
