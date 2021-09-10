variable "name" {}
variable "pubkey" {}

resource "openstack_compute_instance_v2" "instance" {
  name            = var.name 
  image_name      = "osism-image-test"
  flavor_name     = "virtuel-flavor"
  key_pair        = var.pubkey
  
  network {
    name = "pxenet"
  }
}

resource "null_resource" "os_check" {
  depends_on = [openstack_compute_instance_v2.instance]

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      host        = openstack_compute_instance_v2.instance.access_ip_v4
      user        = "install"
      private_key = file(pathexpand("~/.ssh/id_rsa"))
    }

    inline = ["cat /etc/machine-id"]
  }
}

