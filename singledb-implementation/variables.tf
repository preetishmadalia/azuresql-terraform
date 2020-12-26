variable "resource_group_name" {
    type = string
    description = "name of resource group"
    default = "default-rg"
}

variable "location" {
    type = string
    description = "location of your resource group"
}

variable "db_version" {
    type = string
    description = "version of SQL database server"
}

variable "environment" {
    type = string
    description = "variable that describes enviornment name"
}

variable "vault" {
    type = string
    description = "variable that describes vault name"
}
