resource "proxmox_vm_qemu" "prov_vm1" {
  name        = "node1"
  desc        = "Provisioning VM"
  vmid        = "101"
  target_node = "pve"

  agent = 1

  scsihw   = "virtio-scsi-pci"
  bootdisk = "scsi0"

  clone   = "ubuntu-cloud"
  cores   = 2
  sockets = 1
  memory  = 512

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  # Make sure disk matches the template
  disk {
    storage = "fs01"
    type    = "scsi"
    size    = "2252M"
  }

  # Cloud-init
  os_type   = "cloud-init"
  ipconfig0 = "ip=dhcp"
  #   sshkeys   = file("~/.ssh/id_rsa.pub")

  provisioner "remote-exec" {
    inline = [
      "ip a"
    ]
  }
}
