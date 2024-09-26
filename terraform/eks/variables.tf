variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_id" {
  description = "AWS Default VPC Id"
  type        = string
  default     = "vpc-048688c09aadbde87"
}

variable "subnet_ids" {
  description = "AWS Default Subnet IDs"
  type        = list(string)
  default     = ["subnet-026e20aa55430f3ba", "subnet-0beb17dcd186293af"]
}

variable "project-prefix" {
  description = "project name"
  type = string
  default = "eks-service"
}

variable "admin_user_arn" {
  type = string
}