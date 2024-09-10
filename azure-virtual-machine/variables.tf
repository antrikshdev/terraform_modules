variable "resource_group_name" {
  type        = string
  description = "Specifies the name of the Resource Group in which the Virtual Machine should exist."

}

variable "location" {
  type        = string
  description = "Specifies the Azure Region where the Virtual Machine exists."
}

variable "virtual_network_name" {
  type        = string
  description = "The name of the virtual network"
}

variable "subnet_name" {
  type        = string
  default     = null
  description = "The name of the subnet to use in VM scale set"
}

variable "virtual_network_name_rg" {
  type        = string
  description = "The resource group name for virtual network."
}

variable "random_password_length" {
  type        = number
  default     = 24
  description = "The desired length of random password created"
}

variable "enable_public_ip_address" {
  type        = bool
  default     = false
  description = "Reference to a Public IP Address to associate with the NIC"

}

variable "public_ip_allocation_method" {
  type        = string
  default     = "Static"
  description = "Defines the allocation method for this IP address. Possible values are `Static` or `Dynamic`"
}

variable "public_ip_sku" {
  type        = string
  default     = "Standard"
  description = "The SKU of the Public IP. Accepted values are `Basic` and `Standard`"
}

variable "domain_name_label" {
  type        = string
  default     = null
  description = "Label for the Domain Name. Will be used to make up the FQDN. If a domain name label is specified, an A DNS record is created for the public IP in the Microsoft Azure DNS system."
}

variable "public_ip_zones" {
  type        = set(string)
  default     = null
  description = "A collection containing the availability zone to allocate the Public IP in."
}

variable "public_ip_sku_tier" {
  type        = string
  default     = "Regional"
  description = "The SKU Tier that should be used for the Public IP. Possible values are `Regional` and `Global`"

}

variable "public_ip_ddos_protection_mode" {
  type        = string
  default     = null
  description = "The DDoS protection mode of the public IP. Possible values are Disabled, Enabled, and VirtualNetworkInherited. "
}

variable "public_ip_ddos_protection_plan_id" {
  type        = string
  default     = null
  description = "The ID of DDoS protection plan associated with the public IP."
}

variable "public_ip_edge_zone" {
  type        = string
  default     = null
  description = "Specifies the Edge Zone within the Azure Region where this Public IP should exist."
}

variable "public_ip_idle_timeout_in_minutes" {
  type        = string
  default     = null
  description = "Specifies the timeout for the TCP idle connection."
}

variable "public_ip_ip_tags" {
  type        = map(string)
  default     = {}
  description = "A mapping of IP tags to assign to the public IP."
}

variable "public_ip_ip_version" {
  type        = string
  default     = null
  description = "The IP Version to use, IPv6 or IPv4. "
}

variable "public_ip_public_ip_prefix_id" {
  type        = string
  default     = null
  description = "value"
}

variable "public_ip_reverse_fqdn" {
  type        = string
  default     = null
  description = "A fully qualified domain name that resolves to this public IP address."
}
variable "nic_dns_servers" {
  type        = list(string)
  description = "List of dns servers to use for network interface"
  default     = []
}

variable "nic_enable_ip_forwarding" {
  type        = bool
  default     = false
  description = "Should IP Forwarding be enabled? Defaults to false"
}

variable "nic_auxiliary_mode" {
  type        = string
  default     = null
  description = "Specifies the auxiliary mode used to enable network high-performance feature on Network Virtual Appliances (NVAs)."
}

variable "nic_auxiliary_sku" {
  type        = string
  default     = null
  description = "Specifies the SKU used for the network high-performance feature on Network Virtual Appliances (NVAs)."
}
variable "nic_edge_zone" {
  type        = string
  default     = null
  description = "Specifies the Edge Zone within the Azure Region where this Network Interface should exist."
}

variable "nic_enable_accelerated_networking" {
  type        = bool
  default     = false
  description = "Should Accelerated Networking be enabled? Defaults to false."
}

variable "nic_internal_dns_name_label" {
  type        = string
  default     = null
  description = "The (relative) DNS Name used for internal communications between Virtual Machines in the same Virtual Network."
}

variable "private_ip_address_version" {
  type        = string
  default     = null
  description = "The IP Version to use. Possible values are IPv4 or IPv6."
}

variable "gateway_load_balancer_frontend_ip_configuration_id" {
  type        = string
  default     = null
  description = "The Frontend IP Configuration ID of a Gateway SKU Load Balancer."
}

variable "private_ip_address_allocation_type" {
  type        = string
  default     = "Dynamic"
  description = "The allocation method used for the Private IP Address. Possible values are Dynamic and Static."
}

variable "private_ip_address" {
  type        = string
  default     = null
  description = "The Static IP Address which should be used. This is valid only when `private_ip_address_allocation` is set to `Static` "
}

variable "enable_vm_availability_set" {
  type        = bool
  default     = false
  description = "Manages an Availability Set for Virtual Machines."
}

variable "vm_availability_set_managed" {
  type        = bool
  default     = true
  description = "Specifies whether the availability set is managed or not."
}

variable "platform_fault_domain_count" {
  type        = number
  default     = 3
  description = "Specifies the number of fault domains that are used"
}
variable "platform_update_domain_count" {
  type        = number
  default     = 5
  description = "Specifies the number of update domains that are used"
}

variable "enable_proximity_placement_group" {
  type        = bool
  default     = false
  description = "Manages a proximity placement group for virtual machines, virtual machine scale sets and availability sets."
}

variable "existing_network_security_group_id" {
  type        = list(string)
  default     = []
  description = "A list containing the resource id of existing network security group"
}

variable "proximity_p_grp_allowed_vm_sizes" {
  type        = set(string)
  default     = null
  description = "Specifies the supported sizes of Virtual Machines that can be created in the Proximity Placement Group."
}

variable "proximity_p_grp_zone" {
  type        = string
  default     = null
  description = "Specifies the supported zone of the Proximity Placement Group."
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
  description = "List of inbound network rules to apply to network interface."
}

variable "virtual_machine_name" {
  type        = string
  default     = ""
  description = "The name of the virtual machine."
}

variable "instances_count" {
  type        = number
  default     = 1
  description = "The number of Virtual Machines required."
}

variable "os_flavor" {
  type        = string
  default     = "windows"
  description = "Specify the flavor of the operating system image to deploy Virtual Machine. Valid values are `windows` and `linux`"
}

variable "virtual_machine_size" {
  type        = string
  default     = "Standard_A2_v2"
  description = "The Virtual Machine SKU for the Virtual Machine, Default is Standard_A2_V2"

}

variable "disable_password_authentication" {
  type        = bool
  default     = true
  description = "Should Password Authentication be disabled on this Virtual Machine? Defaults to true."
}

variable "admin_username" {
  type        = string
  default     = "azureadmin"
  description = "The username of the local administrator used for the Virtual Machine."
}


/*variable "admin_password" {
  type        = string
  default     = null
  description = "The Password which should be used for the local-administrator on this Virtual Machine"
}*/

variable "source_image_id" {
  type        = string
  default     = null
  description = "The ID of an Image which each Virtual Machine should be based on"
}

variable "dedicated_host_id" {
  type        = string
  default     = null
  description = "The ID of a Dedicated Host where this machine should be run on."
}

variable "custom_data" {
  type        = string
  default     = null
  description = "Base64 encoded file of a bash script that gets run once by cloud-init upon VM creation"
}

variable "enable_automatic_updates" {
  type        = bool
  default     = true
  description = "Specifies if Automatic Updates are Enabled for the Windows Virtual Machine."
}

variable "enable_encryption_at_host" {
  type        = bool
  default     = true
  description = "Should all of the disks (including the temp disk) attached to this Virtual Machine be encrypted by enabling Encryption at Host?"
}

variable "vm_availability_zone" {
  type        = string
  default     = null
  description = "The Zone in which this Virtual Machine should be created. Conflicts with availability set and shouldn't use both"
}

variable "patch_mode" {
  type        = string
  default     = "AutomaticByOS"
  description = "Specifies the mode of in-guest patching to this Windows Virtual Machine. Possible values are `Manual`, `AutomaticByOS` and `AutomaticByPlatform`"
}

variable "license_type" {
  type        = string
  default     = "None"
  description = "Specifies the type of on-premise license which should be used for this Virtual Machine. Possible values are None, Windows_Client and Windows_Server."
}

variable "vm_time_zone" {
  type        = string
  default     = null
  description = "Specifies the Time Zone which should be used by the Virtual Machine"
}

variable "generate_admin_ssh_key" {
  type        = bool
  default     = false
  description = "Generates a secure private key and encodes it as PEM."
}

variable "admin_ssh_key_data" {
  type        = string
  default     = null
  description = "specify the path to the existing SSH key to authenticate Linux virtual machine"
}

variable "custom_image" {

  type = map(object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  }))
  default     = null
  description = "Provide the custom image to this module if the default variants are not sufficient"
}

variable "linux_distribution_list" {
  description = "Pre-defined Azure Linux VM images list"
  type = map(object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  }))

  default = {
    ubuntu1604 = {
      publisher = "Canonical"
      offer     = "UbuntuServer"
      sku       = "16.04-LTS"
      version   = "latest"
    },

    ubuntu1804 = {
      publisher = "Canonical"
      offer     = "UbuntuServer"
      sku       = "18.04-LTS"
      version   = "latest"
    },

    ubuntu1904 = {
      publisher = "Canonical"
      offer     = "UbuntuServer"
      sku       = "19.04"
      version   = "latest"
    },

    ubuntu2004 = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-focal-daily"
      sku       = "20_04-daily-lts"
      version   = "latest"
    },

    ubuntu2004-gen2 = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-focal-daily"
      sku       = "20_04-daily-lts-gen2"
      version   = "latest"
    },

    centos77 = {
      publisher = "OpenLogic"
      offer     = "CentOS"
      sku       = "7.7"
      version   = "latest"
    },

    centos78-gen2 = {
      publisher = "OpenLogic"
      offer     = "CentOS"
      sku       = "7_8-gen2"
      version   = "latest"
    },

    centos79-gen2 = {
      publisher = "OpenLogic"
      offer     = "CentOS"
      sku       = "7_9-gen2"
      version   = "latest"
    },

    centos81 = {
      publisher = "OpenLogic"
      offer     = "CentOS"
      sku       = "8_1"
      version   = "latest"
    },

    centos81-gen2 = {
      publisher = "OpenLogic"
      offer     = "CentOS"
      sku       = "8_1-gen2"
      version   = "latest"
    },

    centos82-gen2 = {
      publisher = "OpenLogic"
      offer     = "CentOS"
      sku       = "8_2-gen2"
      version   = "latest"
    },

    centos83-gen2 = {
      publisher = "OpenLogic"
      offer     = "CentOS"
      sku       = "8_3-gen2"
      version   = "latest"
    },

    centos84-gen2 = {
      publisher = "OpenLogic"
      offer     = "CentOS"
      sku       = "8_4-gen2"
      version   = "latest"
    },

    coreos = {
      publisher = "CoreOS"
      offer     = "CoreOS"
      sku       = "Stable"
      version   = "latest"
    },

    rhel78 = {
      publisher = "RedHat"
      offer     = "RHEL"
      sku       = "7.8"
      version   = "latest"
    },

    rhel78-gen2 = {
      publisher = "RedHat"
      offer     = "RHEL"
      sku       = "78-gen2"
      version   = "latest"
    },

    rhel79 = {
      publisher = "RedHat"
      offer     = "RHEL"
      sku       = "7.9"
      version   = "latest"
    },

    rhel79-gen2 = {
      publisher = "RedHat"
      offer     = "RHEL"
      sku       = "79-gen2"
      version   = "latest"
    },

    rhel81 = {
      publisher = "RedHat"
      offer     = "RHEL"
      sku       = "8.1"
      version   = "latest"
    },

    rhel81-gen2 = {
      publisher = "RedHat"
      offer     = "RHEL"
      sku       = "81gen2"
      version   = "latest"
    },

    rhel82 = {
      publisher = "RedHat"
      offer     = "RHEL"
      sku       = "8.2"
      version   = "latest"
    },

    rhel82-gen2 = {
      publisher = "RedHat"
      offer     = "RHEL"
      sku       = "82gen2"
      version   = "latest"
    },

    rhel83 = {
      publisher = "RedHat"
      offer     = "RHEL"
      sku       = "8.3"
      version   = "latest"
    },

    rhel83-gen2 = {
      publisher = "RedHat"
      offer     = "RHEL"
      sku       = "83gen2"
      version   = "latest"
    },

    rhel84 = {
      publisher = "RedHat"
      offer     = "RHEL"
      sku       = "8.4"
      version   = "latest"
    },

    rhel84-gen2 = {
      publisher = "RedHat"
      offer     = "RHEL"
      sku       = "84gen2"
      version   = "latest"
    },

    rhel84-byos = {
      publisher = "RedHat"
      offer     = "rhel-byos"
      sku       = "rhel-lvm84"
      version   = "latest"
    },

    rhel84-byos-gen2 = {
      publisher = "RedHat"
      offer     = "rhel-byos"
      sku       = "rhel-lvm84-gen2"
      version   = "latest"
    },

    mssql2019ent-rhel8 = {
      publisher = "MicrosoftSQLServer"
      offer     = "sql2019-rhel8"
      sku       = "enterprise"
      version   = "latest"
    },

    mssql2019std-rhel8 = {
      publisher = "MicrosoftSQLServer"
      offer     = "sql2019-rhel8"
      sku       = "standard"
      version   = "latest"
    },

    mssql2019dev-rhel8 = {
      publisher = "MicrosoftSQLServer"
      offer     = "sql2019-rhel8"
      sku       = "sqldev"
      version   = "latest"
    },

    mssql2019ent-ubuntu1804 = {
      publisher = "MicrosoftSQLServer"
      offer     = "sql2019-ubuntu1804"
      sku       = "enterprise"
      version   = "latest"
    },

    mssql2019std-ubuntu1804 = {
      publisher = "MicrosoftSQLServer"
      offer     = "sql2019-ubuntu1804"
      sku       = "standard"
      version   = "latest"
    },

    mssql2019dev-ubuntu1804 = {
      publisher = "MicrosoftSQLServer"
      offer     = "sql2019-ubuntu1804"
      sku       = "sqldev"
      version   = "latest"
    },

    mssql2019ent-ubuntu2004 = {
      publisher = "MicrosoftSQLServer"
      offer     = "sql2019-ubuntu2004"
      sku       = "enterprise"
      version   = "latest"
    },

    mssql2019std-ubuntu2004 = {
      publisher = "MicrosoftSQLServer"
      offer     = "sql2019-ubuntu2004"
      sku       = "standard"
      version   = "latest"
    },

    mssql2019dev-ubuntu2004 = {
      publisher = "MicrosoftSQLServer"
      offer     = "sql2019-ubuntu2004"
      sku       = "sqldev"
      version   = "latest"
    },
  }
}

variable "linux_distribution_name" {
  default     = "ubuntu1804"
  description = "Variable to pick an OS flavour for Linux based VM. Possible values include: centos8, ubuntu1804"
}

variable "windows_distribution_list" {
  description = "Pre-defined Azure Windows VM images list"
  type = map(object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  }))

  default = {
    windows2012r2dc = {
      publisher = "MicrosoftWindowsServer"
      offer     = "WindowsServer"
      sku       = "2012-R2-Datacenter"
      version   = "latest"
    },

    windows2016dc = {
      publisher = "MicrosoftWindowsServer"
      offer     = "WindowsServer"
      sku       = "2016-Datacenter"
      version   = "latest"
    },

    windows2019dc = {
      publisher = "MicrosoftWindowsServer"
      offer     = "WindowsServer"
      sku       = "2019-Datacenter"
      version   = "latest"
    },

    windows2019dc-gensecond = {
      publisher = "MicrosoftWindowsServer"
      offer     = "WindowsServer"
      sku       = "2019-datacenter-gensecond"
      version   = "latest"
    },

    windows2019dc-gs = {
      publisher = "MicrosoftWindowsServer"
      offer     = "WindowsServer"
      sku       = "2019-datacenter-gs"
      version   = "latest"
    },

    windows2019dc-containers = {
      publisher = "MicrosoftWindowsServer"
      offer     = "WindowsServer"
      sku       = "2019-Datacenter-with-Containers"
      version   = "latest"
    },

    windows2019dc-containers-g2 = {
      publisher = "MicrosoftWindowsServer"
      offer     = "WindowsServer"
      sku       = "2019-datacenter-with-containers-g2"
      version   = "latest"
    },

    windows2019dccore = {
      publisher = "MicrosoftWindowsServer"
      offer     = "WindowsServer"
      sku       = "2019-Datacenter-Core"
      version   = "latest"
    },

    windows2019dccore-g2 = {
      publisher = "MicrosoftWindowsServer"
      offer     = "WindowsServer"
      sku       = "2019-datacenter-core-g2"
      version   = "latest"
    },

    windows2016dccore = {
      publisher = "MicrosoftWindowsServer"
      offer     = "WindowsServer"
      sku       = "2016-Datacenter-Server-Core"
      version   = "latest"
    },

    mssql2017exp = {
      publisher = "MicrosoftSQLServer"
      offer     = "SQL2017-WS2019"
      sku       = "express"
      version   = "latest"
    },

    mssql2017dev = {
      publisher = "MicrosoftSQLServer"
      offer     = "SQL2017-WS2019"
      sku       = "sqldev"
      version   = "latest"
    },

    mssql2017std = {
      publisher = "MicrosoftSQLServer"
      offer     = "SQL2017-WS2019"
      sku       = "standard"
      version   = "latest"
    },

    mssql2017ent = {
      publisher = "MicrosoftSQLServer"
      offer     = "SQL2017-WS2019"
      sku       = "enterprise"
      version   = "latest"
    },

    mssql2019std = {
      publisher = "MicrosoftSQLServer"
      offer     = "sql2019-ws2019"
      sku       = "standard"
      version   = "latest"
    },

    mssql2019dev = {
      publisher = "MicrosoftSQLServer"
      offer     = "sql2019-ws2019"
      sku       = "sqldev"
      version   = "latest"
    },

    mssql2019ent = {
      publisher = "MicrosoftSQLServer"
      offer     = "sql2019-ws2019"
      sku       = "enterprise"
      version   = "latest"
    },

    mssql2019ent-byol = {
      publisher = "MicrosoftSQLServer"
      offer     = "sql2019-ws2019-byol"
      sku       = "enterprise"
      version   = "latest"
    },

    mssql2019std-byol = {
      publisher = "MicrosoftSQLServer"
      offer     = "sql2019-ws2019-byol"
      sku       = "standard"
      version   = "latest"
    }
  }
}

variable "windows_distribution_name" {
  type        = string
  default     = "windows2019dc"
  description = "Variable to pick an OS flavour for Windows based VM. Possible values include: winserver, wincore, winsql"
}

variable "os_disk_storage_account_type" {
  type        = string
  default     = "StandardSSD_LRS"
  description = "The Type of Storage Account which should back this the Internal OS Disk. Possible values include Standard_LRS, StandardSSD_LRS and Premium_LRS."
}

variable "os_disk_caching" {
  type        = string
  default     = "ReadWrite"
  description = "The Type of Caching which should be used for the Internal OS Disk. Possible values are `None`, `ReadOnly` and `ReadWrite`"
}

variable "disk_encryption_set_id" {
  type        = string
  description = "The ID of the Disk Encryption Set which should be used to Encrypt this OS Disk. The Disk Encryption Set must have the `Reader` Role Assignment scoped on the Key Vault - in addition to an Access Policy to the Key Vault"
}

variable "disk_size_gb" {
  type        = string
  default     = null
  description = "The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine is sourced from."
}

variable "enable_os_disk_write_accelerator" {
  type        = bool
  default     = false
  description = "Should Write Accelerator be Enabled for this OS Disk? This requires that the `storage_account_type` is set to `Premium_LRS` and that `caching` is set to `None`."
}

variable "os_disk_name" {
  type        = string
  default     = null
  description = "The name which should be used for the Internal OS Disk"
}

variable "enable_ultra_ssd_data_disk_storage_support" {
  type        = bool
  default     = false
  description = "Should the capacity to enable Data Disks of the UltraSSD_LRS storage account type be supported on this Virtual Machine"
}

variable "managed_identity_type" {
  type        = string
  default     = null
  description = "The type of Managed Identity which should be assigned to the Linux Virtual Machine. Possible values are `SystemAssigned`, `UserAssigned` and `SystemAssigned, UserAssigned`"
}

variable "managed_identity_ids" {
  type        = list(string)
  default     = null
  description = "A list of User Managed Identity ID's which should be assigned to the Linux Virtual Machine."
}

variable "winrm_protocol" {
  type        = string
  default     = null
  description = "Specifies the protocol of winrm listener. Possible values are `Http` or `Https`"
}

variable "key_vault_certificate_secret_url" {
  type        = string
  default     = null
  description = "The Secret URL of a Key Vault Certificate, which must be specified when `protocol` is set to `Https`"
}

variable "additional_unattend_content" {
  type        = string
  default     = null
  description = "The XML formatted content that is added to the unattend.xml file for the specified path and component."
}

variable "additional_unattend_content_setting" {
  type        = string
  default     = null
  description = "The name of the setting to which the content applies. Possible values are `AutoLogon` and `FirstLogonCommands`."
}

variable "enable_boot_diagnostics" {
  type        = bool
  default     = false
  description = "Should the boot diagnostics enabled?"
}

variable "storage_account_uri" {
  type        = string
  default     = null
  description = "The Primary/Secondary Endpoint for the Azure Storage Account which should be used to store Boot Diagnostics, including Console Output and Screenshots from the Hypervisor. Passing a `null` value will utilize a Managed Storage Account to store Boot Diagnostics."
}

variable "data_disks" {
  type = list(object({
    name                 = string
    storage_account_type = string
    disk_size_gb         = number
  }))
  default     = []
  description = "Managed Data Disks for azure viratual machine."
}

variable "bypass_platform_safety_checks_on_user_schedule_enabled" {
  type        = bool
  default     = null
  description = "Specifies whether to skip platform scheduled patching when a user schedule is associated with the VM. Defaults to false."
}

variable "vm_computer_name" {
  type        = string
  default     = null
  description = "Specifies the Hostname which should be used for this Virtual Machine."
}

variable "vm_dedicated_host_group_id" {
  type        = string
  default     = null
  description = "The ID of a Dedicated Host Group that this Linux Virtual Machine should be run within. Conflicts with dedicated_host_id."
}

variable "vm_edge_zone" {
  type        = string
  default     = null
  description = "Specifies the Edge Zone within the Azure Region where this Linux Virtual Machine should exist."
}

variable "vm_eviction_policy" {
  type        = string
  default     = null
  description = "Specifies what should happen when the Virtual Machine is evicted for price reasons when using a Spot instance."
}

variable "vm_extensions_time_budget" {
  type        = string
  default     = null
  description = "Specifies the duration allocated for all extensions to start."
}

variable "vm_capacity_reservation_group_id" {
  type        = string
  default     = null
  description = "Specifies the ID of the Capacity Reservation Group which the Virtual Machine should be allocated to."
}

variable "vm_patch_assessment_mode" {
  type        = string
  default     = null
  description = "Specifies the mode of VM Guest Patching for the Virtual Machine."
}

variable "vm_max_bid_price" {
  type        = number
  default     = null
  description = "The maximum price you're willing to pay for this Virtual Machine, in US Dollars; which must be greater than the current spot price."
}

variable "vm_platform_fault_domain" {
  type        = number
  default     = null
  description = "Specifies the Platform Fault Domain in which this Linux Virtual Machine should be created."
}

variable "vm_priority" {
  type        = number
  default     = null
  description = "Specifies the priority of this Virtual Machine. Possible values are Regular and Spot."
}

variable "vm_reboot_setting" {
  type        = string
  default     = null
  description = "Specifies the reboot setting for platform scheduled patching."
}

variable "vm_secure_boot_enabled" {
  type        = bool
  default     = null
  description = "Specifies whether secure boot should be enabled on the virtual machine."
}

variable "vm_user_data" {
  type        = string
  default     = null
  description = "The Base64-Encoded User Data which should be used for this Virtual Machine."
}

variable "vm_vtpm_enabled" {
  type        = string
  default     = null
  description = "Specifies whether vTPM should be enabled on the virtual machine. Changing this forces a new resource to be created."
}

variable "vm_virtual_machine_scale_set_id" {
  type        = string
  default     = null
  description = "Specifies the Orchestrated Virtual Machine Scale Set that this Virtual Machine should be created within. Changing this forces a new resource to be created."
}

variable "vm_provision_vm_agent" {
  type        = bool
  default     = true
  description = "Should the Azure VM Agent be provisioned on this Virtual Machine? Defaults to true."
}

variable "vm_allow_extension_operations" {
  type        = bool
  default     = false
  description = "Should Extension Operations be allowed on this Virtual Machine? Defaults to true."
}

variable "gallery_application" {
  type = list(object({
    version_id             = string
    configuration_blob_uri = optional(string)
    order                  = optional(number)
    tag                    = optional(string)
  }))
  default     = []
  description = "A gallery_application block as defined."
}
variable "vm_secret" {
  type = list(object({
    key_vault_id = string
    certificate = list(object({
      url   = string
      store = optional(string) //Required if windows
    }))
  }))
  default     = []
  description = "A secret block as defined."
}
variable "termination_notification" {
  type = list(object({
    enabled = string
    timeout = optional(number)
  }))
  default     = []
  description = "A termination_notification block as defined."
}

variable "is_marketplace_image" {
  type        = bool
  default     = false
  description = "If a marketplace image should be used. Defaults to false."
}

variable "vm_marketplace_os_sku" {
  type        = string
  default     = null
  description = "Specifies the Name of the Marketplace Image this Virtual Machine should be created from."
}

variable "vm_marketplace_os_offer" {
  type        = string
  default     = null
  description = "Specifies the Product of the Marketplace Image this Virtual Machine should be created from."
}

variable "vm_marketplace_os_publisher" {
  type        = string
  default     = null
  description = "Specifies the Publisher of the Marketplace Image this Virtual Machine should be created from."
}

variable "nsg_diag_logs" {
  type        = list(string)
  default     = ["NetworkSecurityGroupEvent", "NetworkSecurityGroupRuleCounter"]
  description = "NSG Monitoring Category details for Azure Diagnostic setting."
}

variable "log_analytics_workspace_id" {
  type        = string
  default     = null
  description = "The name of log analytics workspace resource id"

}

variable "log_analytics_customer_id" {
  type        = string
  default     = null
  description = "The Workspace (or Customer) ID for the Log Analytics Workspace."

}

variable "log_analytics_workspace_primary_shared_key" {
  type        = string
  default     = null
  description = "The Primary shared key for the Log Analytics Workspace"

}

variable "storage_account_name" {
  type        = string
  default     = null
  description = "Specifies the name of the storage account to store logs"

}

variable "deploy_log_analytics_agent" {
  type        = bool
  default     = false
  description = "Install log analytics agent to windows or linux VM"

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