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

# Try to read the repo if it exists
data "aws_ecr_repository" "existing" {
  repository_name = local.ecr_repo_name
}
  # If not found, ignore errors instead of failing
# lifecycle {
#    ignore_errors = true
#  }
#

resource "aws_ecr_repository" "private_repo" {
  count                = data.aws_ecr_repository.existing.repository_url == "" ? 1 : 0
  name                 = local.ecr_repo_name
  image_tag_mutability = "MUTABLE"

  # ECR private repository block
  # (Public ECR uses aws_ecrpublic_repository — we are NOT using that)
  encryption_configuration {
    encryption_type = "AES256"
  }

  image_scanning_configuration {
    scan_on_push = true
  }
}

# Output whichever repo exists (terraform-created or existing)
# output "ecr_repository_url" {
#  value = data.aws_ecr_repository.existing.repository_url != "" ?
#          data.aws_ecr_repository.existing.repository_url :
#          aws_ecr_repository.this[0].repository_url
#}
