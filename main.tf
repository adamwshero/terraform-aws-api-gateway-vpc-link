resource "aws_api_gateway_vpc_link" "this" {
  for_each = {
    for key in var.rest_vpc_links : key.name => {
      name        = key.name
      description = key.description
      target_arns = key.target_arns
    }
    if var.create_rest_vpc_links == true
  }
  name        = each.value.name
  description = each.value.description
  target_arns = each.value.target_arns
  tags        = var.tags
}

resource "aws_apigatewayv2_vpc_link" "this" {
  for_each = {
    for key in var.http_vpc_links : key.name => {
      name               = key.name
      security_group_ids = key.security_group_ids
      subnet_ids         = key.subnet_ids
    }
    if var.create_http_vpc_links == true
  }
  name               = each.value.name
  security_group_ids = each.value.security_group_ids
  subnet_ids         = each.value.subnet_ids
  tags               = var.tags
}
