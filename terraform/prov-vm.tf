resource "proxmox_vm_qemu" "init_masters" {
  count       = 1
  target_node = var.pm_node_name
  name        = "k3s-master-${count.index}"
  vmid        = var.master_vmid + count.index

  clone = var.template_vm_name

  scsihw   = "virtio-scsi-pci"
  bootdisk = "scsi0"

  os_type   = "cloud-init"
  ipconfig0 = "ip=${var.master_ips[count.index]}/${var.networkrange},gw=${var.networkgateway}"

  nameserver = var.nameserver
}

resource "proxmox_vm_qemu" "init_workers" {
  count       = 3
  target_node = var.pm_node_name
  name        = "k3s-worker-${count.index}"
  vmid        = var.worker_vmid + count.index

  clone = var.template_vm_name

  scsihw   = "virtio-scsi-pci"
  bootdisk = "scsi0"

  os_type   = "cloud-init"
  ipconfig0 = "ip=${var.worker_ips[count.index]}/${var.networkrange},gw=${var.networkgateway}"

  nameserver = var.nameserver
}
