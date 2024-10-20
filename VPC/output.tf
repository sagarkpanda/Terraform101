output "main_route_table_id" {
  value = data.aws_route_table.main.id
}

output "sagar_public_instance_ip" {
  value = aws_instance.sagar_public_instance.public_ip
}

output "sagar_private_instance_ip" {
  value = aws_instance.sagar_public_instance.public_ip
}
