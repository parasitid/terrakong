variable "username" {}
variable "password" {}
variable "tenant_name" {}
variable "auth_url" {}
variable "public_key" {}

variable "nb_of_nodes" {
    default = "4"
}

variable "pub_net_id" {
    default = {
         tr2="PublicNetwork-01"
         tr2-1 = ""
    }
}

variable "region" {
    default = "tr2"
}

variable "images" {
    default = {
         tr2 = "3e5aca4a-bf12-4721-87df-7bc8fd1fc36c"
         tr2-1 = ""
    }
}

variable "flavors" {
    default = {
         tr2 = "100"
         tr2-1 = ""
    }
}
