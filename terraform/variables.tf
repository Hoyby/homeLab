variable "proxmox_api_url" {
  type      = string
  sensitive = true
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
  type    = string
  default = "pve"
}

variable "template_vm_name" {
  type    = string
  default = "ubuntu-cloud"
}

variable "master_vmid" {
  type    = number
  default = 100
}

variable "ciuser" {
  type    = string
  default = "admin"
}

variable "cipassword" {
  type      = string
  sensitive = true
}

variable "master_ips" {
  type    = list(string)
  default = ["10.0.0.100"]
}

variable "worker_vmid" {
  type    = number
  default = 110
}

variable "worker_ips" {
  type    = list(string)
  default = ["10.0.0.110", "10.0.0.111", "10.0.0.112"]
}

variable "networkrange" {
  type    = string
  default = "24"
}

variable "networkgateway" {
  type    = string
  default = "10.0.0.1"
}

variable "nameserver" {
  type    = string
  default = ""
}

variable "ssh_public_key" {
  type      = string
  sensitive = true
}
