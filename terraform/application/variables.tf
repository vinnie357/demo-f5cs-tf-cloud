variable "name" {
  description = "app name"
  default = "app"
}

variable "appPort" {
  description = "app exposed port"
  default = "80"
}

variable "adminAccountName" {
  description = "username for ssh key access"
}

variable "gce_ssh_pub_key_file" {
    description = "path to public key for ssh access"
}

variable "ext_vpc" {
  
}
variable "ext_subnet" {
  
}

variable "projectPrefix" {
  description = "prefix for resources"
}
variable "buildSuffix" {
 description = "suffix for resources"
}
variable "instanceCount" {
  description = "number of app instances"
}
