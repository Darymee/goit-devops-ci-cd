## Результат виконання

### Terraform Apply

Успішне створення інфраструктури за допомогою Terraform.

![Terraform Apply](./screenshots/terraform-apply.png)

### ECR Repository

Створений репозиторій Amazon ECR з увімкненим автоматичним скануванням образів.

![ECR Repository](./screenshots/ecr-repository.png)

### VPC та Subnets

Створено VPC з трьома публічними та трьома приватними підмережами.

![VPC Subnets](./screenshots/vpc-subnets.png)

## Створені ресурси

- Amazon S3 Bucket для Terraform State
- Amazon DynamoDB Table для State Locking
- Amazon VPC
- 3 Public Subnets
- 3 Private Subnets
- Internet Gateway
- NAT Gateway
- Route Tables
- Amazon ECR Repository

## Перевірка

Після виконання команди:

```bash
terraform apply
```

було успішно створено 20 AWS ресурсів.

Виведені Outputs:

- S3 Backend Bucket URL
- DynamoDB Lock Table Name
- VPC ID
- Public Subnet IDs
- Private Subnet IDs
- ECR Repository URL
