locals {
  external_deps = read_terragrunt_config(find_in_parent_folders("external-deps.hcl"))
  account_vars  = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  product_vars  = read_terragrunt_config(find_in_parent_folders("product.hcl"))
  env_vars      = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  product       = local.product_vars.locals.product_name
  prefix        = local.product_vars.locals.prefix
  account       = local.account_vars.locals.account_id
  env           = local.env_vars.locals.env

  tags = merge(
    local.env_vars.locals.tags,
    local.additional_tags
  )

  additional_tags = {
  }
}

include {
  path = find_in_parent_folders()
}

dependency "internal_nlb_1" {
  config_path = "../nlb/internal/1"
}

dependency "internal_nlb_2" {
  config_path = "../nlb/internal/2"
}

dependency "vpc" {
  config_path = "../vpc"
}

terraform {
  source = "git::git@github.com:adamwshero/terraform-aws-api-gateway-vpc-link.git//.?ref=1.0.0"

}

inputs = {
  create_rest_vpc_links = true
  create_http_vpc_links = true

  rest_vpc_links = [
    {
      name        = "rest-vpc-link1-dev"
      description = "VPC Link for development REST APIs."
      target_arns = [dependency.internal_nlb_1.outputs.lb_arn]
    },
    {
      name        = "rest-vpc-link2-qa"
      description = "VPC Link for production REST APIs."
      target_arns = [dependency.internal_nlb_2.outputs.lb_arn]
    }
  ]

  http_vpc_links = [
    {
      name               = "http-vpc-link1-dev"
      security_group_ids = [dependency.vpc.outputs.default_security_group_id]
      subnet_ids         = dependency.vpc.outputs.private_subnets
    },
    {
      name               = "http-vpc-link1-qa"
      security_group_ids = [dependency.vpc.outputs.default_security_group_id]
      subnet_ids         = dependency.vpc.outputs.private_subnets
    },
  ]

  tags = local.tags
}
