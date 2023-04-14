terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "2.9.14"
    }
  }
}


resource "proxmox_vm_qemu" "init_masters" {
  count       = 3
  target_node = var.pm_node_name
  name        = "k3s-master-${count.index}"
  vmid        = var.master_vmid + count.index
  clone       = var.template_vm_name

  scsihw   = "virtio-scsi-pci"
  bootdisk = "scsi0"
  oncreate = true

  os_type    = "cloud-init"
  ciuser     = var.ciuser
  cipassword = var.cipassword
  ipconfig0  = "ip=${var.master_ips[count.index]}/${var.networkrange},gw=${var.networkgateway}"
  nameserver = var.nameserver
  sshkeys    = file(abspath(var.public_key_file))

  lifecycle {
    ignore_changes = [
      disk,
      network,
      scsihw,
      bootdisk,
      qemu_os,
    ]
  }

  provisioner "remote-exec" {
    connection {
      host        = var.master_ips[count.index]
      user        = var.ciuser
      private_key = file(abspath(var.private_key_file))
    }
    inline = [
      "echo 'Waiting for cloud-init to complete...'",
      "cloud-init status --wait > /dev/null",
      "echo 'Completed cloud-init!'",
    ]
  }
}

resource "proxmox_vm_qemu" "init_workers" {
  count       = 2
  target_node = var.pm_node_name
  name        = "k3s-worker-${count.index}"
  vmid        = var.worker_vmid + count.index
  clone       = var.template_vm_name

  scsihw   = "virtio-scsi-pci"
  bootdisk = "scsi0"
  oncreate = true

  os_type    = "cloud-init"
  ciuser     = var.ciuser
  cipassword = var.cipassword
  ipconfig0  = "ip=${var.worker_ips[count.index]}/${var.networkrange},gw=${var.networkgateway}"
  nameserver = var.nameserver
  sshkeys    = file(abspath(var.public_key_file))

  lifecycle {
    ignore_changes = [
      disk,
      network,
      scsihw,
      bootdisk,
      qemu_os
    ]
  }

  provisioner "remote-exec" {
    connection {
      host        = var.master_ips[count.index]
      user        = var.ciuser
      private_key = file(abspath(var.private_key_file))
    }
    inline = [
      "echo 'Waiting for cloud-init to complete...'",
      "cloud-init status --wait > /dev/null",
      "echo 'Completed cloud-init!'",
    ]
  }
}



resource "local_file" "ansible_inventory" {
  depends_on = [
    var.wait_for,
    proxmox_vm_qemu.init_masters,
    proxmox_vm_qemu.init_workers
  ]

  content = templatefile("${path.module}/ansible/templates/inventory.tpl",
    {
      worker_ips = var.worker_ips
      master_ips = var.master_ips
  })
  filename = "${path.module}/ansible/inventory"
}

resource "local_file" "ansible_config" {
  depends_on = [
    var.wait_for,
    proxmox_vm_qemu.init_masters,
    proxmox_vm_qemu.init_workers
  ]

  content = templatefile("${path.module}/ansible/templates/ansible.tpl",
    {
      ciuser           = var.ciuser
      private_key_file = var.private_key_file
  })
  filename = "${path.module}/ansible/ansible.cfg"
}

resource "local_file" "ansible_playbook" {
  depends_on = [
    var.wait_for,
    proxmox_vm_qemu.init_masters,
    proxmox_vm_qemu.init_workers
  ]

  content  = templatefile("${path.module}/ansible/templates/playbook.tpl", {})
  filename = "${path.module}/ansible/playbook.yml"

  provisioner "local-exec" {
    working_dir = "${path.module}/ansible"
    command     = "ansible-playbook -i inventory playbook.yml"
  }
}

resource "local_file" "revert_ansible_playbook" {
  depends_on = [
    var.wait_for,
    proxmox_vm_qemu.init_masters,
    proxmox_vm_qemu.init_workers
  ]

  content  = templatefile("${path.module}/ansible/templates/revert-playbook.tpl", {})
  filename = "${path.module}/ansible/revert-playbook.yml"
}


