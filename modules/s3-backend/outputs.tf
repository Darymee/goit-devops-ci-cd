output "bucket_name" {
  description = "Назва S3-бакета"
  value       = aws_s3_bucket.terraform_state.bucket
}

output "bucket_url" {
  description = "URL S3-бакета"
  value       = "s3://${aws_s3_bucket.terraform_state.bucket}"
}

output "dynamodb_table_name" {
  description = "Назва DynamoDB таблиці"
  value       = aws_dynamodb_table.terraform_locks.name
}
