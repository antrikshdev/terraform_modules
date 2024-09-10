variable "name" {
  type        = string
  description = "The name to use for the virtual network."
}

variable "resource_group_name" {
  type        = string
  description = "The resource group name to use for the virtual network."
}

variable "location" {
  type        = string
  description = "Specifies the Azure Region where the IP address exists."
}

variable "address_space" {
  type        = list(string)
  description = "The address space that is used the virtual network. You can supply more than one address space."
}

variable "dns_servers" {
  type        = list(string)
  description = "List of IP addresses of DNS servers."
  default     = []
}

variable "bgp_community" {
  type        = string
  description = "The BGP community attribute."
  default     = null
}

variable "ddos_protection_plan" {
  type = object({
    id     = string
    enable = string
  })
  description = "A DDoS protection plan."
  default     = null
}

variable "encryption" {
  type = object({
    enforcement = string
  })
  description = "Specifies encryption support."
  default     = null
}

variable "edge_zone" {
  type        = string
  description = "Specifies the Edge Zone within the Azure Region where this Virtual Network should exist."
  default     = null
}

variable "flow_timeout_in_minutes" {
  type        = number
  description = "The flow timeout in minutes for the Virtual Network, which is used to enable connection tracking for intra-VM flows. Possible values are between 4 and 30 minutes"
  default     = null
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to add to all resources"
}

variable "env" {
  type        = string
  description = "The environment: dev, uat, preprod or prod."
  validation {
    condition     = contains(["dev", "uat", "preprod", "prod"], var.env)
    error_message = "The environment must be either dev, uat, preprod or prod."
  }
}