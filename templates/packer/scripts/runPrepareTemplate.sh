#!/bin/bash
USERNAME=root
HOSTS="10.0.0.190"
SCRIPT="./templates/packer/scripts/templateConfig.sh"
# .env file contains the password for the proxmox server
sshpass -f.env ssh ${USERNAME}@${HOSTS} < ${SCRIPT}