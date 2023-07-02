# Infra automation on AWS with Terraform
<p align="center">
<img alt="Terraform" width="270px" src="https://raw.githubusercontent.com/devicons/devicon/master/icons/terraform/terraform-original.svg" style="padding-right:10px;" /> 
</p>
</br>
<h3> <strong> Read the detailed article on: </strong> </h3> <a href = "https://sagarkrp.medium.com/list/terraform-20b3355e3dbb" target ="_blank"> 
 
<picture>
   <source media="(prefers-color-scheme: dark)" srcset="https://github.com/sagarkrp/sagarkrp/blob/main/images/Medium-white1x.png" width="160px" height="35px">
   <source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/sagarkrp/sagarkrp/main/images/Medium-dark.svg" width="160px" height="35px"> 
   <img alt="Medium Alternative Theme." src="https://raw.githubusercontent.com/sagarkrp/sagarkrp/main/images/Medium-dark.svg" width="160px" height="35px">
</picture> </a>

## What is Terraform:
Terraform is an open-source infrastructure as code (IAC) tool that helps us to safely and predictably provision and manage infrastructure in any cloud and on-prem resources in human-readable configuration files that you can version, reuse, and share.

## How if Works:
We write a set of instruction using a declarative DSL called HashiCorp Configuration Language (HCL) and TF executes the instructions to get the expected result for us.

The core TF workflow consists of three stages:

<h4> Write: </h4> You define resources, which may be across multiple cloud providers and services. For example, you might create a configuration to deploy an application on virtual machines in a Virtual Private Cloud (VPC) network with security groups and a load balancer.

<h4> Plan: </h4> Terraform creates an execution plan describing the infrastructure it will create, update, or destroy based on the existing infrastructure and your configuration.

<h4> Apply: </h4>

On approval, Terraform performs the proposed operations in the correct order, respecting any resource dependencies. For example, if you update the properties of a VPC and change the number of virtual machines in that VPC, Terraform will recreate the VPC before scaling the virtual machines.
