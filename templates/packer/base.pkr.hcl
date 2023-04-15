

variable "proxmox_api_url" {
  type = string
}

variable "proxmox_api_token_id" {
  type = string
}

variable "proxmox_api_token_secret" {
  type      = string
  sensitive = true
}

variable "proxmox_host_node" {
  type    = string
  default = "pve"
}

variable "proxmox_source_template" {
  type = string
}

variable "proxmox_template_name" {
  type    = string
  default = "ubuntu-cloud"
}

variable "proxmox_username" {
  type    = string
  default = "root"
}

source "proxmox-clone" "template-create" {
  proxmox_url   = "${var.proxmox_api_url}"
  username     = "${var.proxmox_api_token_id}"
  token       = "${var.proxmox_api_token_secret}"
  node       = "${var.proxmox_host_node}"

  insecure_skip_tls_verify = true
  full_clone = true

  template_name = "${var.proxmox_template_name}"
  clone_vm      = "${var.proxmox_source_template}"
  
  vm_id           = 8000
  scsi_controller = "virtio-scsi-pci"

  ssh_username = "root"
  qemu_agent = true

  network_adapters {
    bridge = "vmbr0"
    model  = "virtio"
  }
}

build {
  sources = ["source.proxmox-clone.template-create"]

  provisioner "shell" {
    inline         = ["sudo cloud-init clean"]
  }
}