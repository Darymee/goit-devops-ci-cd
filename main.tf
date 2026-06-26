terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

locals {
  project_name = "lesson-7"
  cluster_name = "lesson-7-eks"
}

module "s3_backend" {
  source      = "./modules/s3-backend"
  bucket_name = "danieledaniele3005-lesson-5-tfstate"
  table_name  = "terraform-locks"
}

module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr_block     = "10.0.0.0/16"
  public_subnets     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets    = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  availability_zones = ["us-west-2a", "us-west-2b", "us-west-2c"]
  vpc_name           = "lesson-7-vpc"
  cluster_name       = local.cluster_name
}

module "ecr" {
  source       = "./modules/ecr"
  ecr_name     = "lesson-7-django"
  scan_on_push = true
}

module "eks" {
  source             = "./modules/eks"
  cluster_name       = local.cluster_name
  kubernetes_version = "1.33"
  subnet_ids         = module.vpc.private_subnet_ids
  node_group_name    = "lesson-7-workers"
  instance_types     = ["t3.micro"]
  desired_size       = 2
  min_size           = 2
  max_size           = 6
}
