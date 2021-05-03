[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
# Terraform Azure Network
Terraform module to deploy a simple resource group with network configuration. In most cases, this module is going to be used to get a starting point from where you can attach your other modules too. Check the tables of content to see the set of variables and outputs.

&nbsp;
# Table of Contents
- [Requiremets](#requirements)
- [Getting Started](#getting-started)
    - [Basic usage](#basic-usage)
    - [Custom usage](#custom-usage)
- [Variables](#variables)
- [Outputs](#outputs)
- [Contributing](#contributing)

&nbsp;
# Requirements
| Software     |  Version  |
| :--------    | :-------- |
| terraform    | >=0.15.0  |
| azruerm      | >=2.42.0  |

&nbsp;
# Getting started
In its simplest form, you can use the module by just providing adding it to your terraform file without adding any attributes. However, this should be only done in the testing environment, check the variable defaults to see the configuration. Take a look at the two usage examples to get a better understanding on how to deploy resources with this moudule.
&nbsp;
## Basic usage:
```hcl
module "network" {

    source = "github.com/holgerson97/terraform-azure-network"

}
```
&nbsp;
## Custom usage:
```hcl
module "network" {

    source = "github.com/holgerson97/terraform-azure-network"

    namespace = "simple-app-service"
    location = "West Europe"

    vnet_address_spaces = [ "10.10.0.0/16" ]
    dns_servers         = [ "10.10.1.1", "10.10.1.2" ]
    vm_protections      = true

    subnet_address_spaces = [ "10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24" ]
}
```
&nbsp;
# Variables
| Variable                          |  Type        | Description                                                                          | Default                    |
| :-------------------------------- | :----------: | :----------------------------------------------------------------------------------- | :------------------------- |
| `enabled`                         |  bool        | Enables the module to create resources.                                              | true                       |
| `resourcegroup_name`              | string       | Provide the name of your resourcegroup. If null module creates one.                  | null                       |
| `namespace`                       | string       | Naming prefix for resources deployed by this module.                                 | default-name               |
| `location`                        | string       | Location where to deploy.                                                            | West Eruope                |
| `vnet_address_spaces`             | list(string) | List of CIDRs you want your VNET to provide.                                         | ["10.10.0.0./16]           |
| `dns_servers`                     | list(string) | List of DNS servers for your VNET. If null no DNS Servers will be deployed.          | ["10.10.1.1", "10.10.1.2"] |
| `vm_protection`                   |  bool        | Enables the protection for your vms inside the VNET.                                 | false                      |
| `ddos_protection`                 |  bool        | Enables DDOS protection for your VNET.                                               | false                      |
| `subnet_address_spaces`           | list(string) | List of subenets do depoy inside your VNET.                                          | ["10.10.1.0/24"]           |
| `private_link_endpoint_policies`  | bool         | Enable NSG for your private link endpoint.                                           | false                      |
| `private_link_service_policies`   | bool         | Enable NSG for the private link service.                                             | false                      |
| `service_endpoints`               | list(string) | The list of Service endpoints to associate with the subnet.                          | null                       |
| `service_endpoint_policy_ids`     | list(string) | List of subenets do depoy inside your VNET.                                          | null                       |

# Outputs
| Name                                  |  Value                                                                       |
| :------------------------------------ | :--------------------------------------------------------------------------: | 
| `resource_group_name`                 | Name of the resource group resources were deployed to by this module.        | 
| `virtual_network_id`                  | ID of the virtual network that is going to be attached to the rg.            | 
| `virtual_network_name`                | Name of the virtual network that is going to be attached to the rg.          |
| `virtual_network_resource_group_name` | RG of the virtual network that is going to be attached to the rg.            | 
| `virtual_network_location`            | Location of the virtual network that is going to be attached to the rg.      | 
| `virtual_network_address_space`       | Address space of the virtual network that is going to be attached to the rg. | 
| `virtual_network_guid`                | GUID of the resource group resources were deployed to by this module.        | 
| `subnet_address_id`                   | IDs of the subnets that are attached to the virtual network.                 |
| `subnet_address_name`                 | Names of the subnets that are attached to the virtual network.               | 
| `subnet_address_resource_group_name`  | RG of the subnets that are attached to the virtual network.                  | 
| `subnet_address_virtual_network_name` | VNET name of the subnets that are attached to the virtual network.           | 
| `subnet_address_prefix`               | Address prefix of the subnets that are attached to the virtual network.      | 
| `subnet_address_prefixes`             | Address prefixes of the subnets that are attached to the virtual network.    | 
| `dns_servers_ip`                      | IPs of DNS server that are deployed inside your VNET.                        | 

&nbsp;
## Contributing
Feel free to create pull requests.