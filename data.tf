data "aws_vpc" "selected" {
  tags = {
    Name = var.vpc
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "tag:Name"
    values = ["*private*"]
  }
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
}


data "aws_route53_zone" "opensearch" {
  name = var.hosted_zone_name
}
data "aws_acm_certificate" "opensearch" {
  domain = var.hosted_zone_name
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}