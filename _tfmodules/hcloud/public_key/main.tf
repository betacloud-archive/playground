data "local_file" "pubkey" {
  filename = pathexpand(var.pubkey_location)
}

resource "hcloud_ssh_key" "keypair" {
  name       = var.project
  public_key = data.local_file.pubkey.content
}
