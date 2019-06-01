# Build New VM
data "vsphere_datacenter" "dc" {
    name = "ha-datacenter"
}

data "vsphere_datastore" "datastore" {
    name          = "datastore-1"
    datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_resource_pool" "pool" {}

data "vsphere_network" "mgmt_lan" {
    name          = "VM Network"
    datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

resource "vsphere_virtual_machine" "new_master" {
    count                      = "${var.vm_count_master}"
    name                       = "${var.name_new_master}_0${count.index + 1}"
    resource_pool_id           = "${data.vsphere_resource_pool.pool.id}"
    datastore_id               = "${data.vsphere_datastore.datastore.id}"
    force_power_off            = true
    shutdown_wait_timeout      = 1
    num_cpus                   = 2
    memory                     = 1664
    wait_for_guest_net_timeout = 0
    guest_id                   = "centos7_64Guest"
    nested_hv_enabled          = true
    network_interface {
        network_id   = "${data.vsphere_network.mgmt_lan.id}"
        adapter_type = "vmxnet3"
    }
    disk {
        size             = 25
        label            = "first-disk.vmdk"
        eagerly_scrub    = false
        thin_provisioned = true
    }
}

resource "vsphere_virtual_machine" "new_worker" {
    count                      = "${var.vm_count_worker}"
    name                       = "${var.name_new_worker}_0${count.index + 1}"
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
    disk {
        size             = 50
        label            = "first-disk.vmdk"
        eagerly_scrub    = false
        thin_provisioned = true
    }
}