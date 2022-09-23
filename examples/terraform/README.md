## Complete Terraform Example
```
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
```
<br>

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.67.0 |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.0 
| <a name="requirement_terragrunt"></a> [terragrunt](#requirement\_terragrunt) | >= 0.28.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.30.0 |

## Resources

| Name | Type |
|------|------|
| [apigateway_vpc_link.rsm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_vpc_link) | resource |
| [apigatewayv2_vpc_link.rsm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_vpc_link) | resource |

## Available Inputs

| Name                          | Resource                | Variable             | Data Type | Default | Required?
| ----------------------------- | ----------------------- | -------------------- | --------- | ------- | -------- |
| REST VPC Link Name            | `apigateway_vpc_link`   | `name`               | `string`  | `null`  | Yes      |
| REST VPC Link Description     | `apigateway_vpc_link`   | `description`        | `string`  | `null`  | No       |
| REST NLB Target Arns          | `apigateway_vpc_link`   | `target_arns`        | `string`  | `null`  | Yes      |
| HTTP VPC Link Name            | `apigatewayv2_vpc_link` | `name`               | `string`  | `null`  | Yes      |
| HTTP VPC Link Security Groups | `apigatewayv2_vpc_link` | `security_group_ids` | `string`  | `null`  | Yes      |
| HTTP VPC Link Subnet Ids      | `apigatewayv2_vpc_link` | `subnet_ids`         | `string`  | `null`  | Yes      |

## Predetermined Inputs

| Name                 | Resource               | Property   | Data Type | Default | Required?
| -------------------- | ---------------------- | ---------- | --------- | ------- | -------- |
|                      |                        |            |           |         |          |

## Outputs

| Name                                     | Description                            |
|------------------------------------------|--------------------------------------- | 
| apigateway_vpc_link.id                   | Id of the REST VPC Link.               |
| apigateway_vpc_link.name                 | Name of the REST VPC Link.             |
| apigateway_vpc_link.description          | Description of the REST VPC Link.      |
| apigateway_vpc_link.target_arns          | NLB Arns of the REST VPC link.         |
| apigatewayv2_vpc_link.name               | Name of the HTTP VPC Link.             |
| apigatewayv2_vpc_link.security_group_ids | Security Groups for the HTTP VPC link. |
| apigatewayv2_vpc_link.subnet_ids         | Subnet Ids for the HTTP VPC link.      |

## Supporting Articles & Documentation
  - AWS Hyperplane and AWS PrivateLink
    - https://aws.amazon.com/blogs/compute/understanding-vpc-links-in-amazon-api-gateway-private-integrations/
  - Building private cross-account APIs using Amazon API Gateway and AWS PrivateLink
    - https://aws.amazon.com/blogs/compute/building-private-cross-account-apis-using-amazon-api-gateway-and-aws-privatelink/

