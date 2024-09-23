variable "name" {
  type        = string
  description = "The name for the resource group."
}

variable "location" {
  type        = string
  description = "The location for the resource group deployment."
}

variable "managed_by" {
  type        = string
  default     = null
  description = "The ID of the resource or application that manages this Resource Group."
}

variable "owner_id" {
  type        = string
  default     = null
  description = "The owner ID used for role assignment."
}

variable "contributor_id" {
  type        = string
  default     = null
  description = "The contributor ID used for role assignment."
}

variable "reader_id" {
  type        = string
  default     = null
  description = "The reader ID used for role assignment."
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