## Set up cloud image

Get the cloud image from https://cloud-images.ubuntu.com/

```bash
# Download cloud image
`wget https://cloud-images.ubuntu.com/minimal/releases/jammy/release/ubuntu-22.04-minimal-cloudimg-amd64.img`

# Create the VM
`qm create 1000 --memory 2048 --core 2 --name ubuntu-cloud --net0 virtio,bridge=vmbr0 --scsihw virtio-scsi-pci`

# Import the downloaded disk to storage
`qm importdisk 1000 ubuntu-22.04-minimal-cloudimg-amd64.img fs01`

# Create the boot device
`qm set 1000 --scsi0 fs01:1000/vm-1000-disk-0.raw`

# Add cloud init drive
`qm set 1000 --ide2 fs01:cloudinit`

# Boot from the image
`qm set 1000 --boot c --bootdisk scsi0`

# Add serial console
`qm set 1000 --serial0 socket --vga serial0`

# Turn it into a template
`qm template 1000`
```

## terraform

```bash
proxmox_api_url          = "https://[!ip-address!]:8006/api2/json"
proxmox_api_token_id     = ""
proxmox_api_token_secret = ""

rancher2_url           = ""
rancher2_access_key    = ""
rancher2_access_secret = ""

cipassword     = ""
private_key_file = ".../.ssh/id_rsa"
public_key_file  = ".../.ssh/id_rsa.pub"
```

## ansible

```
ansible-playbook ./ansible/playbooks/init-vm.yml --user {user} -i ./ansible/inventory/hosts
```
