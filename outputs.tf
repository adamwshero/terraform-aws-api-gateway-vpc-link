output "rest_vpc_links" {
  description = "List of VPC Link Ids that have been created."
  value = tomap({
    for k, rest_vpc_links in aws_api_gateway_vpc_link.this : k => {
      rest_vpc_link_id         = rest_vpc_links.id
      rest_vpc_link_arn        = rest_vpc_links.arn
      rest_vpc_link_name       = rest_vpc_links.name
      rest_vpc_nlb_target_arns = rest_vpc_links.target_arns
    }
  })
}

output "http_vpc_links" {
  description = "List of VPC Link Ids that have been created."
  value = tomap({
    for k, http_vpc_links in aws_apigatewayv2_vpc_link.this : k => {
      http_vpc_link_id                 = http_vpc_links.id
      http_vpc_link_arn                = http_vpc_links.arn
      http_vpc_link_name               = http_vpc_links.name
      http_vpc_link_subnet_ids         = http_vpc_links.subnet_ids
      http_vpc_link_security_group_ids = http_vpc_links.security_group_ids
    }
  })
}

