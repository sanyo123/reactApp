output "kubeconfig" {
  description = "KUBECONFIG for EKS cluster"
  value       = yamlencode({
    apiVersion = "v1",
    kind       = "Config",
    clusters   = [
      {
        cluster = {
          "certificate-authority-data" = aws_eks_cluster.this.certificate_authority.0.data,
          server                       = aws_eks_cluster.this.endpoint,
        },
        name = "eks-cluster",
      },
    ],
    contexts = [
      {
        context = {
          cluster = "eks-cluster",
          user    = "eks-cluster",
        },
        name = "eks-cluster",
      },
    ],
    "current-context" = "eks-cluster",
    users = [
      {
        name = "eks-cluster",
        user = {
          exec = {
            apiVersion = "client.authentication.k8s.io/v1alpha1",
            args       = [
              "eks",
              "get-token",
              "--cluster-name",
              aws_eks_cluster.this.name,
            ],
            command    = "aws",
          },
        },
      },
    ],
  })
}
