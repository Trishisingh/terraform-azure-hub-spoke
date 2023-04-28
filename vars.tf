variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
  default     = "network-test"
}

variable "existing_resource_group_name" {
  type        = string
  description = "Resource Group Name"
  default     = null

}

variable "resource_group_location" {
  description = "Location of the resource group"
  type        = string
  default     = "uksouth"
}


variable "network_details" {
  type = map(object({
    name          = string
    address_space = list(string),
    dns_servers   = list(string),
    is_hub        = bool
    subnet_details = map(object({
      sub_name           = string,
      sub_address_prefix = list(string)
      })
    )

  }))

  default = {
    "network1" = {
      name          = "network1"
      address_space = ["10.1.0.0/16"]
      dns_servers   = ["10.1.0.4", "10.1.0.5"]
      is_hub        = true
      subnet_details = {
        "sub1" = {
          sub_name           = "subnet3"
          sub_address_prefix = ["10.1.1.0/24"]
        },

        "sub2" = {
          sub_name           = "subnet4"
          sub_address_prefix = ["10.1.2.0/24"]
        }

    } },


    "network2" = {
      name          = "network2"
      address_space = ["10.2.0.0/16"]
      dns_servers   = ["10.2.0.4", "10.2.0.5"]
      is_hub        = true
      subnet_details = {
        "sub1" = {
          sub_name           = "subnet1"
          sub_address_prefix = ["10.2.1.0/24"]
        },

        "sub2" = {
          sub_name           = "subnet2"
          sub_address_prefix = ["10.2.2.0/24"]
        }

    } }

  }
}
