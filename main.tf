resource "aws_instance" "hrapp_node" {
  ami           = var.ec2_ami
  instance_type = var.ec2_instance_type
  key_name      = var.ec2_key_name
  count         = 2
  # subnet_id = count.index % 2 == 0 ? aws_subnet.pub1.id : aws_subnet.pub2.id
  subnet_id                   = count.index == 0 ? aws_subnet.pub_eu_west_1_a.id : aws_subnet.pub_eu_west_1_b.id
  vpc_security_group_ids      = [aws_security_group.hrapp_sg.id]
  associate_public_ip_address = true
  tags                        = merge(var.default_tags, { "Name" = "${join(" ", [var.default_tags.Name, count.index + 1])}" })
}

resource "aws_instance" "monitoring_node" {
  ami                         = var.ec2_ami
  instance_type               = var.ec2_instance_type
  key_name                    = var.ec2_key_name
  subnet_id                   = aws_subnet.pub_eu_west_1_c.id
  vpc_security_group_ids      = [aws_security_group.hrapp_monitoring_sg.id]
  associate_public_ip_address = true
  tags = {
    Name = "Monitoring Node"
  }
}