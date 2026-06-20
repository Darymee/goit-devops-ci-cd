variable "bucket_name" {
  description = "Назва S3-бакета для зберігання Terraform state"
  type        = string
}

variable "table_name" {
  description = "Назва DynamoDB таблиці для lock-файлів Terraform"
  type        = string
}
