####################  New Resource Info ###########################
variable "vm_name" {
    type = string
      default = "TESTDC"
    description = "Provide Server name"
}
variable "vm_ip" {
    type = string
      default = "10.0.2.8"
    description = " Server private ip address"
}
#############  Existing Resources Info ################################# 
variable "rg_name" {
    type = string
      default = "vm-test"
    description = "Resource group name "
}
variable "virtual_network_name" {
    type = string
      default = "TESTDC1-Vnet"
    description = "Virtual network  name"
}
variable "subnet_name" {
    type = string
      default = "TESTDC1-Subnet"
    description = "Subnet name"
}
