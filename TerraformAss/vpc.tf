resource "aws_vpc" "myVpc" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
 }
 resource "aws_subnet" "public1" {
  for_each = var.public_subnet_azs
   vpc_id = aws_vpc.myVpc.id
   cidr_block = each.value
   map_public_ip_on_launch = "true"
   availability_zone = each.key
   tags = {
     "Name" = "public-public "
   }
 }
 resource "aws_internet_gateway" "internet_gateway" {
   vpc_id = aws_vpc.myVpc.id
   tags = {
    Name = "Internet Gateway"
  }
 }

 resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.myVpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
  route {
    ipv6_cidr_block = "::/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
  tags = {
    Name = "public route"
  }
 }
 resource "aws_route_table_association" "public_1_rt_a" {
  for_each = var.public_subnet_azs
   subnet_id = aws_subnet.public1[each.key].id 
   route_table_id = aws_route_table.public_route.id
 }
resource "aws_security_group" "allow_HTTP_and_SSH" {
  name = "allow_HTTP_and_SSH"
  description =  "allow_HTTP_and_SSH"
  vpc_id = aws_vpc.myVpc.id
  ingress  {
    description = "allow_http"
    from_port = "80"
    to_port = "80"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "allow_ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}
