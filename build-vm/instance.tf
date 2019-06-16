# Build New VM
data "vsphere_datacenter" "dc" {
    name = "ha-datacenter"
}

data "vsphere_datastore" "datastore" {
    name          = "vmdt-01"
    datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_resource_pool" "pool" {}

data "vsphere_network" "mgmt_lan" {
    name          = "VM Network"
    datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

resource "vsphere_virtual_machine" "new_vm" {
    count                      = "${var.vm_count}"
    name                       = "${var.name_new_vm}-${count.index + 1}"
    resource_pool_id           = "${data.vsphere_resource_pool.pool.id}"
    datastore_id               = "${data.vsphere_datastore.datastore.id}"
    force_power_off            = true
    shutdown_wait_timeout      = 1
    num_cpus                   = 2
    memory                     = 1024
    wait_for_guest_net_timeout = 0
    guest_id                   = "centos7_64Guest"
    nested_hv_enabled          = true
    network_interface {
        network_id   = "${data.vsphere_network.mgmt_lan.id}"
        adapter_type = "vmxnet3"
    }
    cdrom {
        datastore_id = "${data.vsphere_datastore.datastore.id}"
        path         = "iso_images/CentOS-7-x86_64-Minimal-1810.iso"
    }
    disk {
        size             = 25
        label            = "first-disk.vmdk"
        eagerly_scrub    = false
        thin_provisioned = true
    }
}