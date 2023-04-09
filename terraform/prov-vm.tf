resource "proxmox_vm_qemu" "prov_vm0" {
  target_node = "pve"
  name        = "node0"
  vmid        = "100"

  clone = "ubuntu-cloud"

  scsihw   = "virtio-scsi-pci"
  bootdisk = "scsi0"

  os_type   = "cloud-init"
  ipconfig0 = "ip=10.0.0.100/24"
}

resource "proxmox_vm_qemu" "prov_vm1" {
  target_node = "pve"
  name        = "node1"
  vmid        = "101"

  clone = "ubuntu-cloud"

  scsihw   = "virtio-scsi-pci"
  bootdisk = "scsi0"

  os_type   = "cloud-init"
  ipconfig0 = "ip=10.0.0.101/24"
}

resource "proxmox_vm_qemu" "prov_vm2" {
  target_node = "pve"
  name        = "node2"
  vmid        = "102"

  clone = "ubuntu-cloud"

  scsihw   = "virtio-scsi-pci"
  bootdisk = "scsi0"

  os_type   = "cloud-init"
  ipconfig0 = "ip=10.0.0.102/24"
}

resource "proxmox_vm_qemu" "prov_vm3" {
  target_node = "pve"
  name        = "node3"
  vmid        = "103"

  clone = "ubuntu-cloud"

  scsihw   = "virtio-scsi-pci"
  bootdisk = "scsi0"

  os_type   = "cloud-init"
  ipconfig0 = "ip=10.0.0.103/24"
}
