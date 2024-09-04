variable "name" {
  description = "Name of the private endpoint"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name where the private endpoint should be created"
  type        = string
}

variable "location" {
  description = "Azure region for the private endpoint"
  type        = string
}

variable "subnet_id" {
  description = "The subnet ID where the private endpoint will reside"
  type        = string
}

variable "custom_network_interface_name" {
  description = "Name for the custom network interface"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags for the private endpoint"
  type        = map(string)
  default     = {}
}

variable "private_service_connection_name" {
  description = "Name for the private service connection"
  type        = string
}

variable "private_connection_resource_id" {
  description = "The resource ID that the private endpoint will connect to"
  type        = string
}

variable "private_connection_resource_alias" {
  description = "The alias for the resource that the private endpoint will connect to"
  type        = string
  default     = null
}

variable "manual_connection" {
  description = "Whether the connection is manually set or not"
  type        = bool
  default     = false
}

variable "subresource_names" {
  description = "The subresource names for the service to be connected"
  type        = list(string)
}

variable "request_message" {
  description = "Message for the request"
  type        = string
  default     = null
}

variable "private_dns_zone_group_name" {
  description = "Name of the private DNS zone group"
  type        = string
}

variable "private_dns_zone_ids" {
  description = "IDs for the private DNS zones"
  type        = list(string)
}

variable "ip_configurations" {
  description = "IP configurations for the private endpoint"
  type = list(object({
    name               = string
    private_ip_address = string
    subresource_name   = string
    member_name        = string
  }))

}

variable "env" {
  type        = string
  description = "The environment: dev, uat, preprod or prod."
  validation {
    condition     = contains(["dev", "uat", "preprod", "prod"], var.env)
    error_message = "The environment must be either dev, uat, preprod or prod."
  }
}