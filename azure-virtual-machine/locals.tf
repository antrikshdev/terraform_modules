locals {
  vm_data_disks = { for index, data_disk in var.data_disks : data_disk.name => {
    index : index,
    data_disk : data_disk,
    }
  }
}