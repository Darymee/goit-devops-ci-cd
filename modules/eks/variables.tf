variable "cluster_name" {
  description = "Назва EKS кластера"
  type        = string
}

variable "kubernetes_version" {
  description = "Версія Kubernetes для EKS"
  type        = string
  default     = "1.29"
}

variable "subnet_ids" {
  description = "Subnets, у яких буде розміщено EKS cluster/node group"
  type        = list(string)
}

variable "node_group_name" {
  description = "Назва managed node group"
  type        = string
  default     = "workers"
}

variable "instance_types" {
  description = "EC2 instance types для worker nodes"
  type        = list(string)
  default     = ["t3.micro"]
}

variable "desired_size" {
  description = "Бажана кількість worker nodes"
  type        = number
  default     = 2
}

variable "min_size" {
  description = "Мінімальна кількість worker nodes"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Максимальна кількість worker nodes"
  type        = number
  default     = 6
}
