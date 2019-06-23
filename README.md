**Doc's in construction**

# **Terraform and Ansible to build VMware onpremise Infraestructure**

## **Provide a virtual machine infrastructure VMware**

### **Modules**

- **build-vm**<br/>
  Provisions a new virtual machine on vmware vsphere on premise infraestructure.

  The makefile helps automate to build and deploy the new infraestructure.
  
  **Makefile:**

  ```makefile
    .PHONY: help
  .DEFAULT_GOAL := help

  help:
    @grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-25s\033[0m %s\n", $$1, $$2}'

  deploy-vm: ## Create a new virtual machine onpremise infraestructure
    @terraform init
    @terraform plan --out=deploy-vm.tfplan
    @terraform apply deploy-vm.tfplan

  destroy-vm: ## Destroy the onpremise infraestructure
    @terraform init
    @terraform destroy --auto-approve --force

  test-conn: ## Does test connection with virtual machines
    @ansible -i inventory/hosts.ini all -u root -k -m ping

  install-ssh: ## Create and installe a user for ssh connection
    @ansible-playbook -i inventory/hosts.ini ssh.yml -u root -k -e ansible_ssh_user=root

  build-vm: ## Build a new virtual machine onpremise infraestucture
    @ansible-playbook -i inventory/hosts.ini build.yml -u ansible -b -e ansible_ssh_user=ansible
  ```

  Edit for your environment.<br/>

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

- **build-haproxy**<br/>
  Provisions a new servers haproxy on vmware vsphere on premise infraestructure.

- **build-kubernetes-cluster**<br/>
  Provisions a new servers kubernetes on vmware vsphere on premise infraestructure.

  **OBS:** The propose this module is provisions a new cluster with single node master to development and study, do not consider use in production environment. To production environment use homologed solutions. <https://kubernetes.io/docs/setup/production-environment/tools/kubespray/>
