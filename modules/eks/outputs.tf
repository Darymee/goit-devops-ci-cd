output "cluster_name" {
  description = "Назва EKS кластера"
  value       = aws_eks_cluster.main.name
}

output "cluster_endpoint" {
  description = "Endpoint EKS API server"
  value       = aws_eks_cluster.main.endpoint
}

output "cluster_arn" {
  description = "ARN EKS кластера"
  value       = aws_eks_cluster.main.arn
}

output "node_group_name" {
  description = "Назва EKS node group"
  value       = aws_eks_node_group.main.node_group_name
}
