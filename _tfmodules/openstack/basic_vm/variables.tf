variable "project" {}
variable "pubkey" {}

variable "counter" {
  default = 1
}

variable "flavor" {
  default = "1C-1GB-10GB"
}

variable "image" {
  default = "Ubuntu 20.04"
}

variable "zone" {
  default = "south-2"
}

variable "vip_pool" {
  default = "external"
}

variable "secgroups" {
  default = []
}
