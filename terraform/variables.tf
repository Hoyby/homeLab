variable "proxmox_api_url" {
  type = string
}

variable "proxmox_api_token_id" {
  type      = string
  sensitive = true
}

variable "proxmox_api_token_secret" {
  type      = string
  sensitive = true
}

# variable "rancher2_url" {
#   type = string
# }

# variable "rancher2_access_key" {
#   type      = string
#   sensitive = true
# }

# variable "rancher2_access_secret" {
#   type      = string
#   sensitive = true
# }

variable "pm_node_name" {
  type = string
}

variable "template_vm_name" {
  type = string
}

variable "master_vmid" {
  type = number
}

variable "master_ips" {
  type = list(string)
}

variable "worker_vmid" {
  type = number
}

variable "worker_ips" {
  type = list(string)
}

variable "networkrange" {
  type = string
}

variable "networkgateway" {
  type = string
}

variable "nameserver" {
  type = string
}
