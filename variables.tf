####################################
# API Gateway V1 VPC Link Variables
####################################
variable "create_rest_vpc_links" {
  description = "Whether or not to allow creation of an REST VPC Link."
  type        = bool
  default     = false
}

variable "rest_vpc_links" {
  description = "Map of objects that define the vpc links that get created."
  type        = any
  default     = []
}

####################################
# API Gateway V2 VPC Link Variables
####################################
variable "create_http_vpc_links" {
  description = "Whether or not to allow creation of an HTTP VPC Link."
  type        = bool
  default     = false
}

variable "http_vpc_links" {
  description = "Map of objects that define the vpc links that get created."
  type        = any
  default     = []
}

variable "tags" {
  description = "Tags to assign to each VPC Link resource."
  type        = any
  default     = {}
}
