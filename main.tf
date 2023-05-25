

resource "aws_vpc" "main" {
  cidr_block       = var.vpc
  instance_tenancy = "default"

  tags = local.tags
}





resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-igw"
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet

  tags = {
    Name = "Main-subnet"
  }
}



resource "aws_route_table" "publicrt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "route-table-public"
  }
}
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.publicrt.id
}


resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = var.ingres


   
    
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  tags = {
    Name = "allow_tls-sg"
  }
}


 

resource "aws_instance" "web" {
  ami           = var.myami
  instance_type = var.instance_type
  vpc_security_group_ids=[aws_security_group.allow_tls.id]
subnet_id = aws_subnet.subnet1.id
associate_public_ip_address = true
  tags = {
    Name = "HelloWorld"
  }
}

