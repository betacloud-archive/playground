data "external" "get_os_tenant_name" {
  program = ["sh", "-c", "echo '{\"return\":\"'$(env | grep OS_PROJECT_NAME | cut -d \"=\" -f 2)'\"}'"]
}

locals {
  result  = data.external.get_os_tenant_name.result["return"]
  network = "net-to-external-${local.result}"
}

resource "hcloud_server" "instance" {
  count = var.counter

  name        = "${var.project}-${count.index}"
  server_type = var.flavor
  image       = var.image
  ssh_keys    = [var.pubkey]
  location    = var.location
}
