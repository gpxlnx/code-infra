variable "name_new_master" {
  description = "Input a name for new k8s master Ex. k8s-master"
}

variable "name_new_worker" {
  description = "Input a name for new k8s worker Ex. k8s-worker"
}
variable "vm_count_master" {
  description = "Number of instaces master"
}
variable "vm_count_worker" {
  description = "Number of instaces worker"
}

variable "num_cpus_master" {
  description = "Amount of vCPU's"
}

variable "num_cpus_worker" {
  description = "Amount of vCPU's"
}

variable "num_mem_master" {
  description = "Amount of Memory"
}

variable "num_mem_worker" {
  description = "Amount of Memory"
}