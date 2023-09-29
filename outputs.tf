output "aws_vpc" {
  value = aws_vpc.hrapp_vpc.id
}
output "aws_subnet_1" {
  value = aws_subnet.pub_eu_west_1_a.id
}
output "aws_subnet_2" {
  value = aws_subnet.pub_eu_west_1_b.id
}
output "aws_subnet_3" {
  value = aws_subnet.pub_eu_west_1_c.id
}
output "hrapp_sg" {
  value = aws_security_group.hrapp_sg.name
}
output "hrapp_monitoring_sg" {
  value = aws_security_group.hrapp_monitoring_sg.name
}
output "hrapp_ip_1" {
  value = aws_instance.hrapp_node[0].public_ip
}

output "hrapp_ip_2" {
  value = aws_instance.hrapp_node[1].public_ip
}


output "hrapp_monitoring_ip" {
  value = aws_instance.monitoring_node.public_ip
}
