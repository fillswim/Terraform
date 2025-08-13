# resource "maas_ssh_keys" "ansible-altlinux" {
#   keys = [
#     "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPmG6YaBwgO7A16mjltukXfKz90ht34u01JPJwRn9UCU cloud-user@ansible-altlinux-1"
#   ]
# }

resource "maas_ssh_keys" "multiple_keys" {
  keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICj4ywwwGTRc0ofU6qIJ3xhcb5sAgfr3uhIfZvBXQO1w rt-dc\\oafilatov@CT-WN-001221",
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPmG6YaBwgO7A16mjltukXfKz90ht34u01JPJwRn9UCU cloud-user@ansible-altlinux-1",
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIChOrc4XQxlBH9ZEHI35Hj1p5521D8+qjIrHzEWITkx2 fill@terraform",
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ2W0RtA/rZ2WGh7quQ7TnSskiE4pCtlgugm7hbQuBR+ fill@dell",
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG66OF4gBR3vkBuAOF6hHMUc1je5cyW5b2HRbzKYARde fill@CT-WN-001221",
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKw4DeqKB8KPkByJQkZddF5tL/kAn+HqjuNmpPocARuI fill@dell",
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGDP2fshFzuLsPzkM6ldLcagXSWnY7dL6jYRiE0jzdKv fill@dell"
  ]
}