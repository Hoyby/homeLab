#!/bin/bash

# Must run on Proxmox VE 7 server
# Not sure how to handle a cluster - either run on each node or copy template after creating on one?
# e.g. $ ssh root@proxmox.server < proxmox-create-cloud-template.sh

# Set variables
SRC_IMG="https://cloud-images.ubuntu.com/minimal/releases/jammy/release/ubuntu-22.04-minimal-cloudimg-amd64.img"
IMG_NAME="ubuntu-22.04-minimal-cloudimg-amd64.qcow2"

TEMPL_NAME="ubuntu2204-cloud"
VMID="9000"
MEM="512"
DISK_SIZE="32G"
DISK_STOR="fs01"
NET_BRIDGE="vmbr0"

# Install libguesetfs-tools to modify cloud image
apt update
apt install -y libguestfs-tools

if [ -f "/etc/pve/qemu-server/$VMID.conf" ]; then
    echo "$TEMPL_NAME already exists, waiting 10 seconds before deleting..."
    sleep 10
    qm destroy $VMID
fi

# Check if image is already downloaded
if [ -f "$IMG_NAME" ]; then
    echo "$IMG_NAME already exists."
else 
    echo "Could not find $IMG_NAME. Downloading from $SRC_IMG"
    # Download image and rename
    # Ubuntu img is actually qcow2 format and Proxmox doesn't like wrong extensions
    wget -O $IMG_NAME $SRC_IMG
fi


# Ubuntu cloud img doesn't include qemu-guest-agent required for packer to get IP details from proxmox
# Add any additional packages you want installed in the template
virt-customize --install qemu-guest-agent -a $IMG_NAME

# Create cloud-init enabled Proxmox VM with DHCP addressing
qm create $VMID --name $TEMPL_NAME --memory $MEM --net0 virtio,bridge=$NET_BRIDGE
qm importdisk $VMID $IMG_NAME $DISK_STOR
qm set $VMID --scsihw virtio-scsi-pci --scsi0 $DISK_STOR:$VMID/vm-$VMID-disk-0.raw
sleep 10
qm set $VMID --ide2 $DISK_STOR:cloudinit
qm set $VMID --boot c --bootdisk scsi0
qm set $VMID --serial0 socket --vga serial0
qm set $VMID --ipconfig0 ip=dhcp
qm resize $VMID scsi0 $DISK_SIZE

# Convert to template
qm template $VMID

# Remove downloaded image
rm $IMG_NAME

# Next, use packer to clone this template and customize it!
