resource "metal_ssh_key" "key" {
  name       = var.name
  public_key = file(pathexpand(var.pubkey))
}

resource "metal_device" "device" {
  depends_on = [metal_ssh_key.key]

  hostname         = var.name
  plan             = var.flavor
  metro            = var.metro
  operating_system = var.image
  billing_cycle    = "hourly"
  project_id       = var.project_id
}
