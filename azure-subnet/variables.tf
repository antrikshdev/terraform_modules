variable "name" {
  type        = string
  description = "The name to use for the subnet."
}
variable "resource_group_name" {
  type        = string
  description = "The resource group name to use for the subnet."
}
variable "virtual_network_name" {
  type        = string
  description = "The virtual networkname to use for the subnet."
}
variable "address_prefixes" {
  type        = list(string)
  description = "The address prefixes to use for the subnet."
}

variable "nat_gateway_id" {
  type        = string
  default     = null
  description = "The ID of the NAT Gateway which should be associated with the Subnet. Changing this forces a new resource to be created."
}

/*variable "network_security_group_id" {
    type = string
    description = "The ID of the Network Security Group which should be associated with the Subnet."
}*/

variable "private_endpoint_network_policies_enabled" {
  type        = bool
  default     = true
  description = "Enable or Disable network policies for the private endpoint on the subnet. Setting this to `true` will **Enable** the policy and setting this to `false` will **Disable** the policy. Defaults to `true`."
}

variable "private_link_service_network_policies_enabled" {
  type        = bool
  default     = true
  description = "Enable or Disable network policies for the private link service on the subnet. Setting this to `true` will **Enable** the policy and setting this to `false` will **Disable** the policy. Defaults to `true`."
}

variable "route_table_id" {
  type        = string
  default     = null
  description = "The ID of the Route Table which should be associated with the Subnet. Changing this forces a new association to be created."
}

variable "service_endpoints" {
  type        = set(string)
  default     = []
  description = "The list of Service endpoints to associate with the subnet. Possible values include: `Microsoft.AzureActiveDirectory`, `Microsoft.AzureCosmosDB`, `Microsoft.ContainerRegistry`, `Microsoft.EventHub`, `Microsoft.KeyVault`, `Microsoft.ServiceBus`, `Microsoft.Sql`, `Microsoft.Storage` and `Microsoft.Web`."
}

variable "service_endpoint_policy_ids" {
  type        = set(string)
  default     = null
  description = "The list of IDs of Service Endpoint Policies to associate with the subnet."
}

variable "delegations" {
  type = list(
    object(
      {
        name = string # (Required) A name for this delegation.
        service_delegation = object({
          name    = string                 # (Required) The name of service to delegate to. Possible values include `Microsoft.ApiManagement/service`, `Microsoft.AzureCosmosDB/clusters`, `Microsoft.BareMetal/AzureVMware`, `Microsoft.BareMetal/CrayServers`, `Microsoft.Batch/batchAccounts`, `Microsoft.ContainerInstance/containerGroups`, `Microsoft.ContainerService/managedClusters`, `Microsoft.Databricks/workspaces`, `Microsoft.DBforMySQL/flexibleServers`, `Microsoft.DBforMySQL/serversv2`, `Microsoft.DBforPostgreSQL/flexibleServers`, `Microsoft.DBforPostgreSQL/serversv2`, `Microsoft.DBforPostgreSQL/singleServers`, `Microsoft.HardwareSecurityModules/dedicatedHSMs`, `Microsoft.Kusto/clusters`, `Microsoft.Logic/integrationServiceEnvironments`, `Microsoft.MachineLearningServices/workspaces`, `Microsoft.Netapp/volumes`, `Microsoft.Network/managedResolvers`, `Microsoft.Orbital/orbitalGateways`, `Microsoft.PowerPlatform/vnetaccesslinks`, `Microsoft.ServiceFabricMesh/networks`, `Microsoft.Sql/managedInstances`, `Microsoft.Sql/servers`, `Microsoft.StoragePool/diskPools`, `Microsoft.StreamAnalytics/streamingJobs`, `Microsoft.Synapse/workspaces`, `Microsoft.Web/hostingEnvironments`, `Microsoft.Web/serverFarms`, `NGINX.NGINXPLUS/nginxDeployments` and `PaloAltoNetworks.Cloudngfw/firewalls`.
          actions = optional(list(string)) # (Optional) A list of Actions which should be delegated. This list is specific to the service to delegate to. Possible values include `Microsoft.Network/networkinterfaces/*`, `Microsoft.Network/virtualNetworks/subnets/action`, `Microsoft.Network/virtualNetworks/subnets/join/action`, `Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action` and `Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action`.
        })
      }
    )
  )
  default     = []
  description = "The list of delegations"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A mapping of tags to assign to the resource."
}

variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists."
}

variable "existing_nsg_id" {
  type        = string
  default     = null
  description = "The ID of an existing network security group."
}

variable "nsg_name" {
  type        = string
  default     = null
  description = "The name of the network security group."
}
variable "nsg_inbound_rules" {
  type = list(object(
    {
      name                                       = string
      priority                                   = string
      access                                     = string
      protocol                                   = string
      source_address_prefix                      = string
      source_address_prefixes                    = optional(list(string))
      source_port_range                          = string
      source_port_ranges                         = optional(list(string))
      source_application_security_group_ids      = optional(list(string))
      destination_address_prefix                 = string
      destination_address_prefixes               = optional(list(string))
      destination_port_range                     = string
      destination_port_ranges                    = optional(list(string))
      destination_application_security_group_ids = optional(list(string))
      description                                = optional(string)
    }
  ))
  default     = []
  description = "List of objects that represent the configuration of each inbound rule."
}

variable "nsg_outbound_rules" {
  type = list(object(
    {
      name                                       = string
      priority                                   = string
      access                                     = string
      protocol                                   = string
      source_address_prefix                      = string
      source_address_prefixes                    = optional(list(string))
      source_port_range                          = string
      source_port_ranges                         = optional(list(string))
      source_application_security_group_ids      = optional(list(string))
      destination_address_prefix                 = string
      destination_address_prefixes               = optional(list(string))
      destination_port_range                     = string
      destination_port_ranges                    = optional(list(string))
      destination_application_security_group_ids = optional(list(string))
      description                                = optional(string)
    }
  ))
  default     = []
  description = "List of objects that represent the configuration of each outbound rule."
}

variable "existing_route_table_id" {
  type        = string
  default     = null
  description = "The ID of an existing route table."
}

variable "route_name" {
  type        = string
  default     = null
  description = "The name of the route table."
}

variable "disable_bgp_route_propagation" {
  type        = bool
  default     = false
  description = "Boolean flag which controls propagation of routes learned by BGP on that route table."
}

variable "route_tags" {
  type        = map(string)
  default     = {}
  description = "A mapping of tags to assign to the route table resource"
}

variable "route_list" {
  type = list(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = optional(string)
  }))
  default     = []
  description = "List of objects representing routes"
}

variable "existing_nat_gateway_id" {
  type        = string
  default     = null
  description = "The ID of an existing NAT gateway."
}

variable "nat_gateway_name" {
  type        = string
  default     = null
  description = "Specifies the name of the NAT Gateway. Changing this forces a new resource to be created."
}

variable "nat_gateway_idle_timeout_in_minutes" {
  type        = number
  default     = 4
  description = "The idle timeout which should be used in minutes. Defaults to 4."
}

variable "nat_gateway_sku_name" {
  type        = string
  default     = null
  description = "The SKU which should be used. At this time the only supported value is Standard."
}

variable "nat_gateway_zones" {
  type        = list(string)
  default     = []
  description = "A list of Availability Zones in which this NAT Gateway should be located."
}

variable "nat_gateway_tags" {
  type        = map(string)
  default     = {}
  description = "A mapping of tags to assign to the nat gateway resource"
}

variable "env" {
  type        = string
  description = "The environment: dev, uat, preprod or prod."
  validation {
    condition     = contains(["dev", "uat", "preprod", "prod"], var.env)
    error_message = "The environment must be either dev, uat, preprod or prod."
  }
}