provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Project = "eks-service"
    }
  }
}

resource "aws_ecr_repository" "eks-service-app-ecr" {
  name                 = "eks-service-app-ecr"
  image_tag_mutability = "MUTABLE"
}

resource "aws_ecr_repository" "eks-service-backend-ecr" {
  name                 = "eks-service-backend-ecr"
  image_tag_mutability = "MUTABLE"
}