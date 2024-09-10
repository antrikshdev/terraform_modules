# Generate SSH key pair for Linux
resource "tls_private_key" "rsa" {
  count     = var.generate_admin_ssh_key ? 1 : 0
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "random_password" "passwd" {
  length           = var.random_password_length
  min_upper        = 4
  min_lower        = 2
  min_numeric      = 4
  special          = true
  override_special = "!@#$%&*()-_[]{}<>:?" //"!$&#%,."

  keepers = {
    admin_password = var.virtual_machine_name
  }
}

# Create Network Interface for Virtual Machine
resource "azurerm_network_interface" "nic" {
  count                         = var.instances_count
  name                          = var.instances_count == 1 ? lower("nic-${format("vm%s", lower(replace(var.virtual_machine_name, "/[[:^alnum:]]/", "")))}") : lower("nic-${format("vm%s%s", lower(replace(var.virtual_machine_name, "/[[:^alnum:]]/", "")), count.index + 1)}")
  resource_group_name           = var.resource_group_name
  location                      = var.location
  dns_servers                   = var.nic_dns_servers
  auxiliary_mode                = var.nic_auxiliary_mode
  auxiliary_sku                 = var.nic_auxiliary_sku
  edge_zone                     = var.nic_edge_zone
  enable_ip_forwarding          = var.nic_enable_ip_forwarding
  enable_accelerated_networking = var.nic_enable_accelerated_networking
  internal_dns_name_label       = var.nic_internal_dns_name_label
  tags = merge({
    "ResourceName" = var.instances_count == 1 ? lower("nic-${format("vm%s", lower(replace(var.virtual_machine_name, "/[[:^alnum:]]/", "")))}") : lower("nic-${format("vm%s%s", lower(replace(var.virtual_machine_name, "/[[:^alnum:]]/", "")), count.index + 1)}")
    env            = var.env
  }, var.tags)

  ip_configuration {
    name                                               = lower("ipconig-${format("vm%s%s", lower(replace(var.virtual_machine_name, "/[[:^alnum:]]/", "")), count.index + 1)}")
    primary                                            = true
    gateway_load_balancer_frontend_ip_configuration_id = var.gateway_load_balancer_frontend_ip_configuration_id
    subnet_id                                          = data.azurerm_subnet.snet.id
    private_ip_address_allocation                      = var.private_ip_address_allocation_type
    private_ip_address_version                         = var.private_ip_address_version
    private_ip_address                                 = var.private_ip_address_allocation_type == "Static" ? element(concat(var.private_ip_address, [""]), count.index) : null
    public_ip_address_id                               = null //var.enable_public_ip_address == true ? element(concat(azurerm_public_ip.pip.*.id, [""]), count.index) : null
  }

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}

# Create Proximity placement group for virtual machines, virtual machine scale sets and availability sets, if enabled.
resource "azurerm_proximity_placement_group" "appgrp" {
  count               = var.enable_proximity_placement_group ? 1 : 0
  name                = lower("proxigrp-${var.virtual_machine_name}-${data.azurerm_resource_group.rg.location}")
  resource_group_name = var.resource_group_name //data.azurerm_resource_group.rg.name
  location            = var.location            //data.azurerm_resource_group.rg.location
  allowed_vm_sizes    = var.proximity_p_grp_allowed_vm_sizes
  zone                = var.proximity_p_grp_zone
  tags = merge({
    "ResourceName" = lower("proxigrp-${var.virtual_machine_name}-${data.azurerm_resource_group.rg.location}")
    env            = var.env
  }, var.tags)

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}


# Create managed Availability Set for Virtual Machines, if available.
resource "azurerm_availability_set" "aset" {
  count                        = var.enable_vm_availability_set ? 1 : 0
  name                         = lower("avail-${var.virtual_machine_name}-${data.azurerm_resource_group.rg.location}")
  resource_group_name          = var.resource_group_name //data.azurerm_resource_group.rg.name
  location                     = var.location            //data.azurerm_resource_group.rg.location
  platform_fault_domain_count  = var.platform_fault_domain_count
  platform_update_domain_count = var.platform_update_domain_count
  proximity_placement_group_id = var.enable_proximity_placement_group ? azurerm_proximity_placement_group.appgrp.0.id : null
  managed                      = var.vm_availability_set_managed
  tags = merge({
    "ResourceName" = lower("avail-${var.virtual_machine_name}-${data.azurerm_resource_group.rg.location}")
    env            = var.env
  }, var.tags)

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}


# Create network security group for Virtual Machine Network Interface, if enabled
module "nsg" {
  source = "../azure-nsg"

  count               = length(var.existing_network_security_group_id) > 0 ? 0 : 1
  name                = lower("nsg_${var.virtual_machine_name}_${data.azurerm_resource_group.rg.location}_in")
  resource_group_name = var.resource_group_name
  location            = var.location
  env                 = var.env
  tags = merge({
    "ResourceName" = lower("nsg_${var.virtual_machine_name}_${data.azurerm_resource_group.rg.location}_in")
    env            = var.env
  }, var.tags)
  inbound_rules = var.nsg_inbound_rules
}


resource "azurerm_network_interface_security_group_association" "nsgassoc" {
  count                     = var.instances_count
  network_interface_id      = element(concat(azurerm_network_interface.nic.*.id, [""]), count.index)
  network_security_group_id = length(var.existing_network_security_group_id) > 0 ? var.existing_network_security_group_id[0] : module.nsg.0.id
}


# Create Linux Virutal machine
resource "azurerm_linux_virtual_machine" "linux_vm" {
  count                                                  = var.os_flavor == "linux" ? var.instances_count : 0
  name                                                   = var.instances_count == 1 ? substr(var.virtual_machine_name, 0, 64) : substr(format("%s%s", lower(replace(var.virtual_machine_name, "/[[:^alnum:]]/", "")), count.index + 1), 0, 64)
  resource_group_name                                    = var.resource_group_name //data.azurerm_resource_group.rg.name
  location                                               = var.location            //data.azurerm_resource_group.rg.location
  size                                                   = var.virtual_machine_size
  admin_username                                         = var.admin_username
  admin_password                                         = var.disable_password_authentication ? null : random_password.passwd.result
  disable_password_authentication                        = var.disable_password_authentication
  network_interface_ids                                  = [element(concat(azurerm_network_interface.nic.*.id, [""]), count.index)]
  source_image_id                                        = var.source_image_id != null ? var.source_image_id : null
  license_type                                           = var.license_type
  bypass_platform_safety_checks_on_user_schedule_enabled = var.bypass_platform_safety_checks_on_user_schedule_enabled
  capacity_reservation_group_id                          = var.vm_capacity_reservation_group_id
  computer_name                                          = var.instances_count == 1 ? substr(var.virtual_machine_name, 0, 15) : substr(format("%s%s", lower(replace(var.virtual_machine_name, "/[[:^alnum:]]/", "")), count.index + 1), 0, 15)
  dedicated_host_group_id                                = var.vm_dedicated_host_group_id
  edge_zone                                              = var.vm_edge_zone
  eviction_policy                                        = var.vm_eviction_policy
  extensions_time_budget                                 = var.vm_extensions_time_budget
  patch_assessment_mode                                  = var.vm_patch_assessment_mode
  patch_mode                                             = var.patch_mode
  max_bid_price                                          = var.vm_max_bid_price
  platform_fault_domain                                  = var.vm_platform_fault_domain
  priority                                               = var.vm_priority
  reboot_setting                                         = var.vm_reboot_setting
  secure_boot_enabled                                    = var.vm_secure_boot_enabled
  user_data                                              = var.vm_user_data
  vtpm_enabled                                           = var.vm_vtpm_enabled
  virtual_machine_scale_set_id                           = var.vm_virtual_machine_scale_set_id

  provision_vm_agent           = var.vm_provision_vm_agent
  allow_extension_operations   = var.vm_allow_extension_operations
  dedicated_host_id            = var.dedicated_host_id
  custom_data                  = var.custom_data != null ? var.custom_data : null
  availability_set_id          = var.enable_vm_availability_set == true ? element(concat(azurerm_availability_set.aset.*.id, [""]), 0) : null
  encryption_at_host_enabled   = var.enable_encryption_at_host
  proximity_placement_group_id = var.enable_proximity_placement_group ? azurerm_proximity_placement_group.appgrp.0.id : null
  zone                         = var.vm_availability_zone
  tags = merge({
    "ResourceName" = var.instances_count == 1 ? var.virtual_machine_name : format("%s%s", lower(replace(var.virtual_machine_name, "/[[:^alnum:]]/", "")), count.index + 1)
    env            = var.env
  }, var.tags)

  dynamic "gallery_application" {
    for_each = try(var.gallery_application, [])
    content {
      version_id             = gallery_application.value["version_id"]
      configuration_blob_uri = lookup(gallery_application.value, "configuration_blob_uri", null)
      order                  = lookup(gallery_application.value, "order", null)
      tag                    = lookup(gallery_application.value, "tag", null)
    }
  }

  dynamic "secret" {
    for_each = try(var.vm_secret, [])
    content {
      dynamic "certificate" {
        for_each = try(secret.value["certificate"], {})
        content {
          url = certificate.value["url"]
        }
      }
      key_vault_id = secret.value["key_vault_id "]

    }
  }

  dynamic "termination_notification" {
    for_each = try(var.termination_notification, [])
    content {
      enabled = termination_notification.value["enabled"]
      timeout = lookup(termination_notification.value, "timeout", null)
    }
  }

  dynamic "admin_ssh_key" {
    for_each = var.disable_password_authentication ? [1] : []
    content {
      username   = var.admin_username
      public_key = var.admin_ssh_key_data == null ? tls_private_key.rsa[0].public_key_openssh : file(var.admin_ssh_key_data)
    }
  }

  dynamic "plan" {
    for_each = var.is_marketplace_image ? [1] : []

    content {
      name      = var.vm_marketplace_os_sku
      product   = var.vm_marketplace_os_offer
      publisher = var.vm_marketplace_os_publisher
    }
  }

  dynamic "source_image_reference" {
    for_each = var.source_image_id != null ? [] : [1]
    content {
      publisher = var.custom_image != null ? var.custom_image["publisher"] : var.linux_distribution_list[lower(var.linux_distribution_name)]["publisher"]
      offer     = var.custom_image != null ? var.custom_image["offer"] : var.linux_distribution_list[lower(var.linux_distribution_name)]["offer"]
      sku       = var.custom_image != null ? var.custom_image["sku"] : var.linux_distribution_list[lower(var.linux_distribution_name)]["sku"]
      version   = var.custom_image != null ? var.custom_image["version"] : var.linux_distribution_list[lower(var.linux_distribution_name)]["version"]
    }
  }

  os_disk {
    storage_account_type      = var.os_disk_storage_account_type
    caching                   = var.os_disk_caching
    disk_encryption_set_id    = var.disk_encryption_set_id
    disk_size_gb              = var.disk_size_gb
    write_accelerator_enabled = var.enable_os_disk_write_accelerator
    name                      = var.os_disk_name
  }

  additional_capabilities {
    ultra_ssd_enabled = var.enable_ultra_ssd_data_disk_storage_support
  }

  dynamic "identity" {
    for_each = var.managed_identity_type != null ? [1] : []
    content {
      type         = var.managed_identity_type
      identity_ids = var.managed_identity_type == "UserAssigned" || var.managed_identity_type == "SystemAssigned, UserAssigned" ? var.managed_identity_ids : null
    }
  }

  dynamic "boot_diagnostics" {
    for_each = var.enable_boot_diagnostics ? [1] : []
    content {
      storage_account_uri = var.storage_account_name != null ? data.azurerm_storage_account.store_account.0.primary_blob_endpoint : var.storage_account_uri
    }
  }

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}

# Windows Virutal machine
resource "azurerm_windows_virtual_machine" "win_vm" {
  count                 = var.os_flavor == "windows" ? var.instances_count : 0
  name                  = var.instances_count == 1 ? substr(var.virtual_machine_name, 0, 15) : substr(format("%s%s", lower(replace(var.virtual_machine_name, "/[[:^alnum:]]/", "")), count.index + 1), 0, 15)
  computer_name         = var.instances_count == 1 ? substr(var.virtual_machine_name, 0, 15) : substr(format("%s%s", lower(replace(var.virtual_machine_name, "/[[:^alnum:]]/", "")), count.index + 1), 0, 15)
  resource_group_name   = var.resource_group_name //data.azurerm_resource_group.rg.name
  location              = var.location            //data.azurerm_resource_group.rg.location
  size                  = var.virtual_machine_size
  admin_username        = var.admin_username
  admin_password        = random_password.passwd.result
  network_interface_ids = [element(concat(azurerm_network_interface.nic.*.id, [""]), count.index)]
  source_image_id       = var.source_image_id != null ? var.source_image_id : null

  bypass_platform_safety_checks_on_user_schedule_enabled = var.bypass_platform_safety_checks_on_user_schedule_enabled
  capacity_reservation_group_id                          = var.vm_capacity_reservation_group_id
  dedicated_host_group_id                                = var.vm_dedicated_host_group_id
  edge_zone                                              = var.vm_edge_zone
  eviction_policy                                        = var.vm_eviction_policy
  extensions_time_budget                                 = var.vm_extensions_time_budget
  patch_assessment_mode                                  = var.vm_patch_assessment_mode
  patch_mode                                             = var.patch_mode
  max_bid_price                                          = var.vm_max_bid_price
  platform_fault_domain                                  = var.vm_platform_fault_domain
  priority                                               = var.vm_priority
  reboot_setting                                         = var.vm_reboot_setting
  secure_boot_enabled                                    = var.vm_secure_boot_enabled
  user_data                                              = var.vm_user_data
  vtpm_enabled                                           = var.vm_vtpm_enabled
  virtual_machine_scale_set_id                           = var.vm_virtual_machine_scale_set_id

  provision_vm_agent           = true
  allow_extension_operations   = var.vm_allow_extension_operations
  dedicated_host_id            = var.dedicated_host_id
  custom_data                  = var.custom_data != null ? var.custom_data : null
  enable_automatic_updates     = var.enable_automatic_updates
  license_type                 = var.license_type
  availability_set_id          = var.enable_vm_availability_set == true ? element(concat(azurerm_availability_set.aset.*.id, [""]), 0) : null
  encryption_at_host_enabled   = var.enable_encryption_at_host
  proximity_placement_group_id = var.enable_proximity_placement_group ? azurerm_proximity_placement_group.appgrp.0.id : null
  zone                         = var.vm_availability_zone
  timezone                     = var.vm_time_zone
  tags = merge({
    "ResourceName" = var.instances_count == 1 ? var.virtual_machine_name : format("%s%s", lower(replace(var.virtual_machine_name, "/[[:^alnum:]]/", "")), count.index + 1)
    env            = var.env
  }, var.tags)


  dynamic "gallery_application" {
    for_each = try(var.gallery_application, [])
    content {
      version_id             = gallery_application.value["version_id"]
      configuration_blob_uri = lookup(gallery_application.value, "configuration_blob_uri", null)
      order                  = lookup(gallery_application.value, "order", null)
      tag                    = lookup(gallery_application.value, "tag", null)
    }
  }

  dynamic "secret" {
    for_each = try(var.vm_secret, [])
    content {
      dynamic "certificate" {
        for_each = try(secret.value["certificate"], {})
        content {
          url   = certificate.value["url"]
          store = certificate.value["store"]
        }
      }
      key_vault_id = secret.value["key_vault_id "]

    }
  }

  dynamic "termination_notification" {
    for_each = try(var.termination_notification, [])
    content {
      enabled = termination_notification.value["enabled"]
      timeout = lookup(termination_notification.value, "timeout", null)
    }
  }

  dynamic "plan" {
    for_each = var.is_marketplace_image ? [1] : []

    content {
      name      = var.vm_marketplace_os_sku
      product   = var.vm_marketplace_os_offer
      publisher = var.vm_marketplace_os_publisher
    }
  }

  dynamic "source_image_reference" {
    for_each = var.source_image_id != null ? [] : [1]
    content {
      publisher = var.custom_image != null ? var.custom_image["publisher"] : var.windows_distribution_list[lower(var.windows_distribution_name)]["publisher"]
      offer     = var.custom_image != null ? var.custom_image["offer"] : var.windows_distribution_list[lower(var.windows_distribution_name)]["offer"]
      sku       = var.custom_image != null ? var.custom_image["sku"] : var.windows_distribution_list[lower(var.windows_distribution_name)]["sku"]
      version   = var.custom_image != null ? var.custom_image["version"] : var.windows_distribution_list[lower(var.windows_distribution_name)]["version"]
    }
  }

  os_disk {
    storage_account_type      = var.os_disk_storage_account_type
    caching                   = var.os_disk_caching
    disk_encryption_set_id    = var.disk_encryption_set_id
    disk_size_gb              = var.disk_size_gb
    write_accelerator_enabled = var.enable_os_disk_write_accelerator
    name                      = var.os_disk_name
  }

  additional_capabilities {
    ultra_ssd_enabled = var.enable_ultra_ssd_data_disk_storage_support
  }

  dynamic "identity" {
    for_each = var.managed_identity_type != null ? [1] : []
    content {
      type         = var.managed_identity_type
      identity_ids = var.managed_identity_type == "UserAssigned" || var.managed_identity_type == "SystemAssigned, UserAssigned" ? var.managed_identity_ids : null
    }
  }

  dynamic "winrm_listener" {
    for_each = var.winrm_protocol != null ? [1] : []
    content {
      protocol        = var.winrm_protocol
      certificate_url = var.winrm_protocol == "Https" ? var.key_vault_certificate_secret_url : null
    }
  }

  dynamic "additional_unattend_content" {
    for_each = var.additional_unattend_content != null ? [1] : []
    content {
      content = var.additional_unattend_content
      setting = var.additional_unattend_content_setting
    }
  }

  dynamic "boot_diagnostics" {
    for_each = var.enable_boot_diagnostics ? [1] : []
    content {
      storage_account_uri = var.storage_account_name != null ? data.azurerm_storage_account.store_account.0.primary_blob_endpoint : var.storage_account_uri
    }
  }

  lifecycle {
    ignore_changes = [
      tags,
      patch_mode,
      identity
    ]
  }
}

# Virtual machine data disks
resource "azurerm_managed_disk" "data_disk" {
  for_each               = local.vm_data_disks
  name                   = "${var.virtual_machine_name}_DataDisk_${each.value.index}"
  resource_group_name    = var.resource_group_name
  location               = var.location
  storage_account_type   = lookup(each.value.data_disk, "storage_account_type", "StandardSSD_LRS")
  create_option          = "Empty"
  disk_size_gb           = each.value.data_disk.disk_size_gb
  disk_encryption_set_id = var.disk_encryption_set_id
  tags = merge({
    "ResourceName" = "${var.virtual_machine_name}_DataDisk_${each.value.index}"
    env            = var.env
  }, var.tags)

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}

resource "azurerm_virtual_machine_data_disk_attachment" "data_disk" {
  for_each           = local.vm_data_disks
  managed_disk_id    = azurerm_managed_disk.data_disk[each.key].id
  virtual_machine_id = var.os_flavor == "windows" ? azurerm_windows_virtual_machine.win_vm[0].id : azurerm_linux_virtual_machine.linux_vm[0].id
  lun                = each.value.index
  caching            = "ReadWrite"
}


# Azure Log Analytics Workspace Agent Installation for windows
resource "azurerm_virtual_machine_extension" "omsagentwin" {
  count                      = var.vm_allow_extension_operations && var.deploy_log_analytics_agent && var.log_analytics_workspace_id != null && var.os_flavor == "windows" ? var.instances_count : 0
  name                       = var.instances_count == 1 ? "OmsAgentForWindows" : format("%s%s", "OmsAgentForWindows", count.index + 1)
  virtual_machine_id         = azurerm_windows_virtual_machine.win_vm[count.index].id
  publisher                  = "Microsoft.EnterpriseCloud.Monitoring"
  type                       = "MicrosoftMonitoringAgent"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true

  settings = <<SETTINGS
    {
      "workspaceId": "${var.log_analytics_customer_id}"
    }
  SETTINGS

  protected_settings = <<PROTECTED_SETTINGS
    {
    "workspaceKey": "${var.log_analytics_workspace_primary_shared_key}"
    }
  PROTECTED_SETTINGS
}


# Azure Log Analytics Workspace Agent Installation for Linux
resource "azurerm_virtual_machine_extension" "omsagentlinux" {
  count                      = var.vm_allow_extension_operations && var.deploy_log_analytics_agent && var.log_analytics_workspace_id != null && var.os_flavor == "linux" ? var.instances_count : 0
  name                       = var.instances_count == 1 ? "OmsAgentForLinux" : format("%s%s", "OmsAgentForLinux", count.index + 1)
  virtual_machine_id         = azurerm_linux_virtual_machine.linux_vm[count.index].id
  publisher                  = "Microsoft.EnterpriseCloud.Monitoring"
  type                       = "OmsAgentForLinux"
  type_handler_version       = "1.13"
  auto_upgrade_minor_version = true

  settings = <<SETTINGS
    {
      "workspaceId": "${var.log_analytics_customer_id}"
    }
  SETTINGS

  protected_settings = <<PROTECTED_SETTINGS
    {
    "workspaceKey": "${var.log_analytics_workspace_primary_shared_key}"
    }
  PROTECTED_SETTINGS
}
