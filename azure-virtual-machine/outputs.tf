output "vm_secret" {
  value       = random_password.passwd.result
  description = "The password to the virtual machine."
}
output "vm_username" {
  value       = var.admin_username
  description = "The username to the virtual machine."
}