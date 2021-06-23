variable "project" {
  default = "blueprint"
}

variable "floatingip_pool" {
  default = "external"
}

variable "zone" {
  default = null
}

variable "external_network_id" {
  default = "00000000-0000-0000-0000-000000000000"
}

variable "pubkey_path" {
  default = "~/.ssh/id_rsa.pub"
}

variable "flavor" {
  default = "bms"
}

variable "image" {
  default = "Ubuntu 20.04"
}

variable "instance_amount" {
  default = 1
}
