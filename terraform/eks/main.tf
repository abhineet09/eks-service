provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Project = "eks-service"
    }
  }
}

resource "random_string" "suffix" {
  length  = 8
  special = false
}

locals {
  cluster_name = "eks-cluster-${random_string.suffix.result}"
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.24.2"

  cluster_name    = local.cluster_name
  cluster_version = "1.30"

  vpc_id         = var.vpc_id
  subnet_ids     = var.subnet_ids
  cluster_endpoint_public_access = true

  eks_managed_node_group_defaults = {
    ami_type = "AL2_ARM_64"
  }

  eks_managed_node_groups = {
    one = {
      name = "node-group-1"
      instance_types = ["m7g.large"]
      min_size     = 1
      max_size     = 1
      desired_size = 1
    }
  }
  
}