module "vpc-links" {
  source                = "git@github.com:adamwshero/terraform-aws-api-gateway-vpc-link.git//.?ref=1.0.0"
  create_rest_vpc_links = true
  create_http_vpc_links = true

  rest_vpc_links = [
    {
      name        = "rest-vpc-link1-dev"
      description = "VPC Link for development REST APIs."
      target_arns = ["arn:aws:elasticloadbalancing:us-east-1:1111111111111:loadbalancer/net/test1/abcd12345"]
    },
    {
      name        = "rest-vpc-link2-qa"
      description = "VPC Link for production REST APIs."
      target_arns = ["arn:aws:elasticloadbalancing:us-east-1:1111111111111:loadbalancer/net/test2/abcd12345"]
    }
  ]

  http_vpc_links = [
    {
      name               = "http-vpc-link1-dev"
      security_group_ids = ["sg-123456789abcdefg"]
      subnet_ids         = ["subnet-132456789abcdefg"]
    },
    {
      name               = "http-vpc-link1-qa"
      security_group_ids = ["sg-123456789abcdefg"]
      subnet_ids         = ["subnet-132456789abcdefg"]
    },
  ]
  tags = {
    Environment        = "dev"
    Owner              = "DevOps"
    CreatedByTerraform = true
  }
}
