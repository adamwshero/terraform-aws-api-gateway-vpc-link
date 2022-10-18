### Terragrunt Basic Example (REST)
```
terraform {
  source = "git::git@github.com:adamwshero/terraform-aws-api-gateway-vpc-link.git//.?ref=1.0.2"
}

inputs = {
  create_rest_vpc_links = true
  create_http_vpc_links = false

  rest_vpc_links = [
    {
      name        = "rest-vpc-link1-dev"
      description = "VPC Link for development REST APIs."
      target_arns = [dependency.internal_nlb_1.outputs.lb_arn]
    }
  ]

  tags = local.tags
}
```
### Terragrunt Basic Example (HTTP)
```
terraform {
  source = "git::git@github.com:adamwshero/terraform-aws-api-gateway-vpc-link.git//.?ref=1.0.2"
}

inputs = {
  create_rest_vpc_links = false
  create_http_vpc_links = true

  http_vpc_links = [
    {
      name               = "http-vpc-link1-dev"
      security_group_ids = [dependency.vpc.outputs.default_security_group_id]
      subnet_ids         = dependency.vpc.outputs.private_subnets
    }
  ]

  tags = local.tags
}
```
### Terragrunt Complete Example
```
terraform {
  source = "git::git@github.com:adamwshero/terraform-aws-api-gateway-vpc-link.git//.?ref=1.0.2"
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
```