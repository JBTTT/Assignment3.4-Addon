terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

locals {
  ecr_repo_name = "jibin-flask-prepo-assignment3-4-addon"
}

resource "aws_ecr_repository" "private_repo" {
  name                 = local.ecr_repo_name
  image_tag_mutability = "IMMUTABLE"

  # ECR private repository block
  # (Public ECR uses aws_ecrpublic_repository — we are NOT using that)
  encryption_configuration {
    encryption_type = "AES256"
  }

  image_scanning_configuration {
    scan_on_push = true
  }

}
