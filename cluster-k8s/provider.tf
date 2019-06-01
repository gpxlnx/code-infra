# Configure the vSphere Provider
provider "vsphere" {
  vsphere_server       = "192.168.0.107"
  user                 = "fabiano"
  password             = "F=e5acd1808"
  allow_unverified_ssl = true
}
