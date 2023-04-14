variable "wait_for" {
  type    = any
  default = []
}

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
  type = list(string)
}

variable "worker_vmid" {
  type    = number
  default = 110
}

variable "worker_ips" {
  type = list(string)
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

variable "private_key_file" {
  default   = "/home/user/.ssh/id_rsa"
  sensitive = true
}

variable "public_key_file" {
  default   = "/home/user/.ssh/id_rsa.pub"
  sensitive = true
}
