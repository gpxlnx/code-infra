**Doc's in construction**

# **Terraform and Ansible to build VMware onpremise Infraestructure**

## **Modules**

- ## **build-vm**  
Provisions a new virtual machine on vmware vsphere on premise infraestructure.

  The makefile helps automate to build and deploy the new infraestructure.
  
  **Makefile:**

  ![make help](/docs/img/img1.png)

  Edit for your environment.

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
  
- ## **build-haproxy**  
  Provisions a new servers haproxy mode http on vmware vsphere on premise infraestructure.
  
  **Requirements:**  
  - deploy a new's virtual machines with **```build-vm```** module first.

  The makefile helps automate to build and deploy the new infraestructure.
  
  **Makefile:**

  ![make help](/docs/img/img2.png)

  Edit for your environment.

  **all.yml:**

  ```yaml
  ssh_key: 
  # SSH Information: ~${USER}/.ssh/id_rsa.pub
  - ""
  ```

  **haproxy.yml:**

  ```yaml
  # Virtual IP for high avalibility with keepalived.
  virtual_ipaddress: ""

  # Hostname for first haproxy service, use the same hostname in inventory_hostname.
  # Ex:
  # haproxy_master: "haproxy-1"
  haproxy_master: ""

  # Select one algorithm for load balance: first, leastconn, static-rr or roundrobin.
  balance_algorithm: ""

  # Domain used in infraestructure
  my_domain: ""

  # If you need configure new app repeat block above new_app variable .
  # Ex:
  # new_app:
  #   app_1:
  #     name: "api_1"
  #     port: 30870
  #     backend: {
  #       "hostname_1": "10.0.0.1",
  #       "hostname_2": "172.16.0.1",
  #       "hostname_3": "192.168.0.1"
  #     }
  #   app_2:
  #     name: "api_2"
  #     port: 30871
  #     backend: {
  #       "hostname_1": "10.0.0.1", # Finish previous line with "," for more than one backend.
  #       "hostname_2": "172.16.0.1",
  #       "hostname_3": "192.168.0.1"
  #     }
  new_app:
    <APP NAME>:
      name: "<APP NAME>"
      port: <APP PORT>
      backend: {
        "<HOSTNAME BACKEND>": "<IP BACKEND>"
      }

  ```

  **hosts.ini:**
  
  ```ini
  [all]
  # haproxy-1 ansible_host=172.16.245.10  ip=172.16.245.10
  # haproxy-2 ansible_host=172.16.245.11  ip=172.16.245.11

  [haproxy]
  # haproxy-1
  # haproxy-2
  ```

- ## **build-kubernetes-cluster**  
  Provisions a new servers kubernetes on vmware vsphere on premise infraestructure.

  **OBS:** The propose this module is provisions a new cluster with single node master to development and study, do not consider use in production environment. To production environment use homologed solutions. <https://kubernetes.io/docs/setup/production-environment/tools/kubespray/>

  The makefile helps automate to build and deploy the new infraestructure.
  
  **Makefile:**

  ![make help](/docs/img/img3.png)

  Edit for your environment.
  
  **provider.tf:**
  
  ```terraform
  provider "vsphere" {
    vsphere_server       = "< HOSTNAME / IP >"
    user                 = "< USER >"
    password             = "< PASSWORD >"
    allow_unverified_ssl = true
  }
  ```

  **vars.tf**

  ```terraform
  #
  # Variables with default values, alter according to the your environment.
  #
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

  **all.yml:**

  ```yaml
  ---
  # Configure the IP for master node.
  k8s_master_node_ip: ""
  k8s_api_secure_port: 6443

  ssh_key:
  # SSH Information: ~${USER}/.ssh/id_rsa.pub
  - ""
  ```
  
  **master.yml:**

  ```yaml
  ---
  # Confifure the network for POD's network. Ex: 192.168.0.0/16
  pod_network_cidr: ""

  # Weavenet Network Plugin
  # If you look user weavenet plugin network let true option.
  weavenet_network: true
  default_kubernetes_cni_weavenet_manifestUrl: "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
  ```

  **host.ini:**

  ```ini
  [all]
  # node1 ansible_host=1.2.3.4  ip=1.6.3.4
  k8s-mst-1 ansible_host=192.168.0.1 ip=192.168.0.1
  k8s-wrk-1 ansible_host=192.168.0.2 ip=192.168.0.2
  k8s-wrk-2 ansible_host=192.168.0.3 ip=192.168.0.3


  [master]
  k8s-mst-1

  [worker]
  k8s-wrk-1
  k8s-wrk-2
  ```
