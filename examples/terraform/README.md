[![SWUbanner](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/banner2-direct.svg)](https://github.com/vshymanskyy/StandWithUkraine/blob/main/docs/README.md)

![Terraform](https://cloudarmy.io/tldr/images/tf_aws.jpg)
<br>
<br>
<br>
<br>
![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/adamwshero/terraform-aws-api-gateway-vpc-link?color=lightgreen&label=latest%20tag%3A&style=for-the-badge)
<br>
<br>
# terraform-aws-api-gateway-vpc-link


Terraform module to create either REST, HTTP, or both types of [Amazon VPC Link](https://docs.aws.amazon.com/apigateway/latest/developerguide/getting-started-with-private-integration.html) resources.

A VPC link is a resource in Amazon API Gateway that allows for connecting API routes to private resources inside a VPC. A VPC link acts like any other integration endpoint for an API and is an abstraction layer on top of other networking resources. This helps simplify configuring private integrations.
<br>
There are two types of VPC links: VPC links for REST APIs and VPC links for HTTP APIs. Both provide access to resources inside a VPC. They are built on top of an internal AWS service called [AWS Hyperplane](https://youtu.be/8gc2DgBqo9U?t=2065). This is an internal network virtualization platform, which supports inter-VPC connectivity and routing between VPCs. Internally, Hyperplane supports multiple network constructs that AWS services use to connect with the resources in customers’ VPCs. One of those constructs is AWS PrivateLink, which is used by API Gateway to support private APIs and private integrations.
<br>

AWS PrivateLink allows access to AWS services and services hosted by other AWS customers, while maintaining network traffic within the AWS network. Since the service is exposed via a private IP address, all communication is virtually local and private. This reduces the exposure of data to the public internet.
<br>

In AWS PrivateLink, a [VPC endpoint service](https://docs.aws.amazon.com/vpc/latest/userguide/endpoint-service.html) is a networking resource in the service provider side that enables other AWS accounts to access the exposed service from their own VPCs. VPC endpoint services allow for sharing a specific service located inside the provider’s VPC by extending a virtual connection via an elastic network interface in the consumer’s VPC.
<br>

An [interface VPC endpoint](https://docs.aws.amazon.com/vpc/latest/userguide/vpce-interface.html) is a networking resource in the service consumer side, which represents a collection of one or more elastic network interfaces. This is the entry point that allows for connecting to services powered by AWS PrivateLink.
<br>

Amazon API Gateway Version 1 VPC Links enable private integrations that connect REST APIs to private resources in a VPC. To enable private integration for HTTP APIs, use the Amazon API Gateway Version 2 VPC Link [resource](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_vpc_link).
<br>

## Module Capabilities
  * Creates one or many REST VPC Links for use with API Gateway v1.
  * Creates one or many HTTP VPC Links for use with API Gateway v2.
  * Can create both REST and HTTP VPC Link types simultaneously.
<br>

## Examples

Look at our [Terraform example](latest/examples/terraform/) where you can get a better context of usage for both Terraform. The Terragrunt example can be viewed directly from GitHub.

## Assumptions
  * Public REST API Only
    * You already have Network Load Balancer (NLB) with an IP type target group created if you are creating an API using the `regional` or `edge` deployment type.
<br>

## Usage
  * Toggle either the `create_rest_vpc_links` value to `true` or `false` to create or destroy those resources.
  * Toggle either the `create_http_vpc_links` value to `true` or `false` to create or destroy those resources.
  * Both rest or http types can be enabled at the same time during apply.
<br>

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

<br>


## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.30.0 |

<br>

## Resources

| Name | Type |
|------|------|
| [apigateway_vpc_link.rsm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_vpc_link) | resource |
| [apigatewayv2_vpc_link.rsm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_vpc_link) | resource |


<br>


## Available Inputs

| Name                          | Resource                | Variable             | Data Type | Default | Required?
| ----------------------------- | ----------------------- | -------------------- | --------- | ------- | -------- |
| REST VPC Link Name            | `apigateway_vpc_link`   | `name`               | `string`  | `null`  | Yes      |
| REST VPC Link Description     | `apigateway_vpc_link`   | `description`        | `string`  | `null`  | No       |
| REST NLB Target Arns          | `apigateway_vpc_link`   | `target_arns`        | `string`  | `null`  | Yes      |
| HTTP VPC Link Name            | `apigatewayv2_vpc_link` | `name`               | `string`  | `null`  | Yes      |
| HTTP VPC Link Security Groups | `apigatewayv2_vpc_link` | `security_group_ids` | `string`  | `null`  | Yes      |
| HTTP VPC Link Subnet Ids      | `apigatewayv2_vpc_link` | `subnet_ids`         | `string`  | `null`  | Yes      |

<br>

## Predetermined Inputs

| Name                 | Resource               | Property   | Data Type | Default | Required?
| -------------------- | ---------------------- | ---------- | --------- | ------- | -------- |
|                      |                        |            |           |         |          |


<br>

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


<br>

## Supporting Articles & Documentation
  - AWS Hyperplane and AWS PrivateLink
    - https://aws.amazon.com/blogs/compute/understanding-vpc-links-in-amazon-api-gateway-private-integrations/
  - Building private cross-account APIs using Amazon API Gateway and AWS PrivateLink
    - https://aws.amazon.com/blogs/compute/building-private-cross-account-apis-using-amazon-api-gateway-and-aws-privatelink/

