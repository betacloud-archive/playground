variable "project" {}
variable "pubkey" {}

variable "counter" {
  default = 1
}

variable "flavor" {
  default = "cx11"
}

variable "image" {
  default = "ubuntu-20.04"
}

variable "location" {
  default = "nbg1" # fsn1 hel1
}
