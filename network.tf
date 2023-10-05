resource "aws_vpc" "hrapp_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "HR APP VPC"
  }
}

resource "aws_subnet" "pub_eu_west_1_a" {
  vpc_id            = aws_vpc.hrapp_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = var.availability_zone_a

  tags = {
    Name = "Public Subnet 1"
  }
}

resource "aws_subnet" "pub_eu_west_1_b" {
  vpc_id            = aws_vpc.hrapp_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = var.availability_zone_b

  tags = {
    Name = "Public Subnet 2"
  }
}

resource "aws_subnet" "pub_eu_west_1_c" {
  vpc_id            = aws_vpc.hrapp_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = var.availability_zone_c

  tags = {
    Name = "Public Subnet 3"
  }
}

resource "aws_db_subnet_group" "hrapp_db_subnet_group" {
  name       = "hrapp_db_subnet_group"
  subnet_ids = [aws_subnet.pub_eu_west_1_c.id, aws_subnet.pub_eu_west_1_b.id]

  tags = {
    Name = "HR APP DB subnet group"
  }
}

resource "aws_internet_gateway" "hrapp_vpc_igw" {
  vpc_id = aws_vpc.hrapp_vpc.id

  tags = {
    Name = "HR APP IGW"
  }
}

resource "aws_route_table" "route1" {
  vpc_id = aws_vpc.hrapp_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.hrapp_vpc_igw.id
  }
}

resource "aws_route_table_association" "sub_route1" {
  subnet_id      = aws_subnet.pub_eu_west_1_a.id
  route_table_id = aws_route_table.route1.id
}
resource "aws_route_table_association" "sub_route2" {
  subnet_id      = aws_subnet.pub_eu_west_1_b.id
  route_table_id = aws_route_table.route1.id
}
resource "aws_route_table_association" "sub_route3" {
  subnet_id      = aws_subnet.pub_eu_west_1_c.id
  route_table_id = aws_route_table.route1.id
}

# ## Load Balancing
# resource "aws_lb" "hrapp_lb" {
#   name               = "hrapp-lb"
#   internal           = false
#   load_balancer_type = "application"
#   subnets            = [aws_subnet.pub_eu_west_1_a.id, aws_subnet.pub_eu_west_1_b.id]
# }

# resource "aws_lb_target_group" "hrapp_tg" {
#   name     = "hrapp-tg"
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = aws_vpc.hrapp_vpc.id
# }

# resource "aws_lb_target_group_attachment" "hrapp_tg_attachment" {
#   count            = 2
#   target_group_arn = aws_lb_target_group.hrapp_tg.arn
#   target_id        = aws_instance.hrapp_node[count.index].id
# }