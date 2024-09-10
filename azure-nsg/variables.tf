variable "name" {
  type        = string
  description = "The name of the network security group."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the network security group."
}

variable "location" {
  type        = string
  description = "The location/region where the network security group is created. "
}

variable "inbound_rules" {
  type = list(object(
    {
      name                                       = string
      priority                                   = string
      access                                     = string
      protocol                                   = string
      source_address_prefix                      = string
      source_address_prefixes                    = optional(list(string))
      source_port_range                          = optional(string)
      source_port_ranges                         = optional(list(string))
      source_application_security_group_ids      = optional(list(string))
      destination_address_prefix                 = optional(string)
      destination_address_prefixes               = optional(list(string))
      destination_port_range                     = optional(string)
      destination_port_ranges                    = optional(list(string))
      destination_application_security_group_ids = optional(list(string))
      description                                = optional(string)
    }
  ))
  default     = []
  description = "List of objects that represent the configuration of each inbound rule."
}

variable "outbound_rules" {
  type = list(object(
    {
      name                                       = string
      priority                                   = string
      access                                     = string
      protocol                                   = string
      source_address_prefix                      = string
      source_address_prefixes                    = optional(list(string))
      source_port_range                          = optional(string)
      source_port_ranges                         = optional(list(string))
      source_application_security_group_ids      = optional(list(string))
      destination_address_prefix                 = optional(string)
      destination_address_prefixes               = optional(list(string))
      destination_port_range                     = optional(string)
      destination_port_ranges                    = optional(list(string))
      destination_application_security_group_ids = optional(list(string))
      description                                = optional(string)
    }
  ))
  default     = []
  description = "List of objects that represent the configuration of each outbound rule."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A mapping of tags to assign to the resource."
}

variable "env" {
  type        = string
  description = "The environment: dev, uat, preprod or prod."
  validation {
    condition     = contains(["dev", "uat", "preprod", "prod"], var.env)
    error_message = "The environment must be either dev, uat, preprod or prod."
  }
}