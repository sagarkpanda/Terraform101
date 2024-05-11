output "sec_group_details" {
  value = aws_security_group.vm_sg
}

output "The_default_vpc_details" {
  value = aws_default_vpc.default
}

output "AZ_linux_2023_ami_ids" {
   value = data.aws_ami.amazon_linux_2023
}

output "all_the_subnets_in_the_default_vpc" {
  value = data.aws_subnets.default_subnets.ids
}





