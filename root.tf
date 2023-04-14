terraform {
  required_version = ">= 0.13.0"

  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "2.9.14"
    }
  }
}

module "prov-vm" {
  source = "./modules/prov-vms"
  providers = {
    proxmox = proxmox
  }

  private_key_file = var.private_key_file
  public_key_file  = var.public_key_file
  ciuser           = var.ciuser
  cipassword       = var.cipassword
  worker_ips       = var.worker_ips
  master_ips       = var.master_ips

}
