locals {
  default_storage_account_tags = {
    resourceName = "${lower(var.storage_account_name)}${random_id.storage.hex}"
    env          = var.env
  }
  default_storage_dbfs_pe_tags = {
    resourceName = var.storage_account_dbfs_pe_name
    env          = var.env
  }
  default_storage_blob_pe_tags = {
    resourceName = var.storage_account_blob_pe_name
    env          = var.env
  }
}