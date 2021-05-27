data "external" "get_os_tenant_name" {
  program = ["sh", "-c", "echo '{\"return\":\"'$(env | grep OS_PROJECT_NAME | cut -d \"=\" -f 2)'\"}'"]
}

data "openstack_images_image_v2" "image" {
  name        = var.image
  most_recent = true
}

locals {
  result  = data.external.get_os_tenant_name.result["return"]
  network = "net-to-external-${local.result}"
}

resource "openstack_compute_instance_v2" "instance" {
  count = var.counter

  name              = "${var.project}-${count.index}"
  flavor_name       = var.flavor
  image_name        = var.image
  key_pair          = var.pubkey
  availability_zone = var.zone
  security_groups   = var.secgroups

  network {
    name = local.network
  }

  block_device {
    boot_index            = 0
    delete_on_termination = true
    destination_type      = "local"
    source_type           = "image"
    uuid                  = data.openstack_images_image_v2.image.id
  }

  block_device {
    boot_index            = -1
    delete_on_termination = true
    destination_type      = "volume"
    volume_size           = var.vol_size
    source_type           = "blank"
  }
}

resource "openstack_networking_floatingip_v2" "fip" {
  count = var.counter

  pool = var.vip_pool
}

resource "openstack_compute_floatingip_associate_v2" "fip_assoc" {
  count = var.counter

  instance_id = element(openstack_compute_instance_v2.instance.*.id, count.index)
  floating_ip = element(openstack_networking_floatingip_v2.fip.*.address, count.index)
}
