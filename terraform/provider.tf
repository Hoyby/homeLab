terraform {
  required_version = ">= 0.13.0"

  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "2.9.14"
    }
    # rancher2 = {
    #   source  = "rancher/rancher2"
    #   version = "1.25.0"
    # }
    # helm = {
    #   source  = "hashicorp/helm"
    #   version = "2.9.0"
    # }
  }
}

variable "proxmox_api_url" {
  type = string
}

variable "proxmox_api_token_id" {
  type      = string
  sensitive = true
}

variable "proxmox_api_token_secret" {
  type      = string
  sensitive = true
}

# variable "rancher2_url" {
#   type = string
# }

# variable "rancher2_access_key" {
#   type      = string
#   sensitive = true
# }

# variable "rancher2_access_secret" {
#   type      = string
#   sensitive = true
# }

provider "proxmox" {
  pm_api_url          = var.proxmox_api_url
  pm_api_token_id     = var.proxmox_api_token_id
  pm_api_token_secret = var.proxmox_api_token_secret

  pm_tls_insecure = true
}

# provider "rancher2" {
#   api_url    = var.rancher2_url
#   access_key = var.rancher2_access_key
#   secret_key = var.rancher2_access_secret
# }


