# Home Lab

Provides a home lab environment in Proxmox.
Features provisioning of Templates and VMs using terraform and ansible and packer.

Roadmap:
- [x] Automate creation of ubuntu22.04 templates with qemu-guest-agent and cloud-init.
- [x] Automate creation and basic configuration of VMs using terraform and ansible.
- [ ] Automate Kubernetes setup.


## How to use

### Prerequisites
- terraform
- ansible
- make
- Environment variables described below

### Create templates

Change template setting variables found in [templateConfig.sh](templates\packer\scripts\templateConfig.sh) and [base.pkr.hcl](templates\packer\base.pkr.hcl) to your needs.

Run the following command uses ssh to create the template in Proxmox.
```bash	
make create-template
```

When the template is ready in proxmox, run packer to run additional provisioning on the image and create a new template.
```bash
make run-packer
```

Configure [modules\prov-vms\main.tf](modules\prov-vms\main.tf) to you needs.
Use new template to create VMs using terraform by running the following commands.

```bash
terraform init
terraform apply --auto-approve
```


## Environment variables

`.env` file

```bash
{proxmox_pass}
```

`credentials.auto.tfvars` file

```bash
# Config for terraform VM provisioning

proxmox_api_url          = "https://{ip}:8006/api2/json"
proxmox_api_token_id     = "{token_id}"
proxmox_api_token_secret = "{token}"

master_ips = ["{ip_1}", "{ip_2}", "{ip_3}"]
worker_ips = ["{ip_1}", "{ip_2}"]

public_key_file  = "{path}"
private_key_file = "{path}"

ciuser     = "{vm_username}"
cipassword = "{vm_pass}"
```

`templates\packer\credentials.pkrvars.hcl` file

```bash
# Config for packer template creation

proxmox_api_url          = "https://{ip}:8006/api2/json"
proxmox_api_token_id     = "{token_id}"
proxmox_api_token_secret = "{token}"

proxmox_template_name = "ubuntu-cloud" # will be used by terraform for provisioning VMs
proxmox_source_template = "ubuntu2204-cloud" # same as in templateConfig
```
