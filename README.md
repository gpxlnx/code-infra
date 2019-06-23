**Doc's in construction**

# **Terraform and Ansible to build VMware onpremise Infraestructure**

### **Modules**

- **build-vm**  
  Provisions a new virtual machine on vmware vsphere on premise infraestructure.

  The makefile helps automate to build and deploy the new infraestructure.
  
  **Makefile:**

  ![make help](/docs/img/img1.png)

  Edit for your environment.

  **all.yml:**

  ```yaml
  ssh_key: 
  # SSH Information: ~${USER}/.ssh/id_rsa.pub
  - ""
  ```

  **host.ini:**

  ```ìni
  [all]
  # node1 ansible_host=1.2.3.4  ip=1.2.3.4
  ```

  **provider.tf:**
  
  ```terraform
  provider "vsphere" {
    vsphere_server       = "< HOSTNAME / IP >"
    user                 = "< USER >"
    password             = "< PASSWORD >"
    allow_unverified_ssl = true
  }
  ```
  
  **vars.tf:**

  ```terraform
  variable "data_center" {
    default = "ha-datacenter"
  }

  variable "data_store" {
    default = "vmdt-01"
  }

  variable "mgmt_lan" {
    default = "VM Network"
  }

  variable "net_adapter_type" {
    default = "vmxnet3"
  }


  variable "guest_id" {
    default = "centos7_64Guest"
  }

  variable "custom_iso_path" {
    default = "iso_images/CentOS-7-x86_64-Minimal-1810.iso"
  }
  ```

- **build-haproxy**  
  Provisions a new servers haproxy on vmware vsphere on premise infraestructure.

- **build-kubernetes-cluster**  
  Provisions a new servers kubernetes on vmware vsphere on premise infraestructure.

  **OBS:** The propose this module is provisions a new cluster with single node master to development and study, do not consider use in production environment. To production environment use homologed solutions. <https://kubernetes.io/docs/setup/production-environment/tools/kubespray/>
