variable "peer1_name" {
  type        = string
  description = "The name of the first virtual network peering"
}

variable "resource_group_name_peer1" {
  type        = string
  description = "The name of the resource group in which to create the virtual network peering for the first peer."
}

variable "virtual_network_name_peer1" {
  type        = string
  description = "The name of the virtual network for the first peer."
}

variable "remote_virtual_network_id_peer1" {
  type        = string
  description = "The full Azure resource ID of the remote virtual network for the first peer."
}

variable "allow_virtual_network_access_peer1" {
  type        = bool
  description = "Controls if the VMs in the remote virtual network can access VMs in the local virtual network for the first peer."
  default     = true
}

variable "allow_forwarded_traffic_peer1" {
  type        = bool
  description = "Controls if forwarded traffic from VMs in the remote virtual network is allowed for the first peer."
  default     = false
}

variable "allow_gateway_transit_peer1" {
  type        = bool
  description = "Controls gatewayLinks can be used in the remote virtual network’s link to the local virtual network for the first peer."
  default     = false
}

variable "use_remote_gateways_peer1" {
  type        = bool
  description = "Controls if remote gateways can be used on the local virtual network for the first peer."
  default     = null
}

variable "triggers_peer1" {
  type        = map(any)
  description = "A mapping of key values pairs that can be used to sync network routes from the remote virtual network to the local virtual network for the first peer."
  default     = null
}

variable "enable_double_peer" {
  type        = bool
  description = "Controls if the bidirectional peering should be created between local(first) and remote(second) virtual network"
  default     = false
}


variable "peer2_name" {
  type        = string
  description = "The name of the second virtual network peering"
  default     = null
}

variable "resource_group_name_peer2" {
  type        = string
  description = "The name of the resource group in which to create the virtual network peering for the second peer."
  default     = null
}

variable "virtual_network_name_peer2" {
  type        = string
  description = "The name of the virtual network for the second peer."
  default     = null
}

variable "remote_virtual_network_id_peer2" {
  type        = string
  description = "The full Azure resource ID of the remote virtual network for the second peer."
  default     = null
}

variable "allow_virtual_network_access_peer2" {
  type        = bool
  description = "Controls if the VMs in the remote virtual network can access VMs in the local virtual network for the second peer."
  default     = true
}

variable "allow_forwarded_traffic_peer2" {
  type        = bool
  description = "Controls if forwarded traffic from VMs in the remote virtual network is allowed for the second peer."
  default     = false
}

variable "allow_gateway_transit_peer2" {
  type        = bool
  description = "Controls gatewayLinks can be used in the remote virtual network’s link to the local virtual network for the second peer."
  default     = false
}

variable "use_remote_gateways_peer2" {
  type        = bool
  description = "Controls if remote gateways can be used on the local virtual network for the second peer."
  default     = null
}

variable "triggers_peer2" {
  type        = map(any)
  description = "A mapping of key values pairs that can be used to sync network routes from the remote virtual network to the local virtual network for the second peer."
  default     = null
}