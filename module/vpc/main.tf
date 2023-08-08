#CREATE VPC
resource "aws_vpc" "PADUS1_VPC" {
  cidr_block       = var.VPC_CIDR
  instance_tenancy = "default"
  tags = {
    name = var.vpc_name
  }
}

#CREATE TWO PUBLIC SUBNETS 
#PUBLIC SUBNET01
resource "aws_subnet" "PADUS1_PUSN1" {
  vpc_id            = aws_vpc.PADUS1_VPC.id
  cidr_block        = var.VPC_CIDRPUB1
  availability_zone = var.AZ1
  tags = {
    name = var.pubsn1_name
  }
}

#PUBLIC SUBNET02
resource "aws_subnet" "PADUS1_PUSN2" {
  vpc_id            = aws_vpc.PADUS1_VPC.id
  cidr_block        = var.VPC_CIDRPUB2
  availability_zone = var.AZ2
  tags = {
    name = var.pubsn2_name
  }
}



#CREATE TWO PRIVATE SUBNETS 
#PRIVATE SUBNET01
resource "aws_subnet" "PADUS1_PRSN1" {
  vpc_id            = aws_vpc.PADUS1_VPC.id
  cidr_block        = var.VPC_CIDRPRIV1
  availability_zone = var.AZ1
  tags = {
    name = var.privsn1_name
  }
}

#PRIVATE SUBNET02
resource "aws_subnet" "PADUS1_PRSN2" {
  vpc_id            = aws_vpc.PADUS1_VPC.id
  cidr_block        = var.VPC_CIDRPRIV2
  availability_zone = var.AZ2
  tags = {
    name = var.privsn2_name
  }
}



#CREATE INTERNET GATEWAY
resource "aws_internet_gateway" "PADUS1_IGW" {
  vpc_id = aws_vpc.PADUS1_VPC.id
  tags = {
    name = var.igw_name
  }
}

#CREATE NAT GATEWAY
resource "aws_nat_gateway" "PADUS1_NATGW" {
  allocation_id = aws_eip.PADUS1_EIP.id
  subnet_id     = aws_subnet.PADUS1_PUSN1.id
  depends_on    = [aws_internet_gateway.PADUS1_IGW]
  tags = {
    Name = var.ng_name
  }
}




#CREATE ELASTIC IP
resource "aws_eip" "PADUS1_EIP" {
  vpc = true
  tags = {
    name = var.eip_name
  }
}

#CREATE PUBLIC ROUND TABLE 
resource "aws_route_table" "PADUS1_PUBRT" {
  vpc_id = aws_vpc.PADUS1_VPC.id
  route {
    cidr_block = var.all_cidr
    gateway_id = aws_internet_gateway.PADUS1_IGW.id
  }
  tags = {
    name = var.pubrt_name
  }
}

#CREATE PUBLIC ROUND TABLE ASSOCIATIONS WITH PUBLIC SUBNETS
resource "aws_route_table_association" "PADUS1_PUBRT_ASSOC1" {
  subnet_id      = aws_subnet.PADUS1_PUSN1.id
  route_table_id = aws_route_table.PADUS1_PUBRT.id
}

resource "aws_route_table_association" "PADUS1_PUBRT_ASSOC2" {
  subnet_id      = aws_subnet.PADUS1_PUSN2.id
  route_table_id = aws_route_table.PADUS1_PUBRT.id
}


#CREATE PRIVATE ROUND TABLE 
resource "aws_route_table" "PADUS1_PRIVRT" {
  vpc_id = aws_vpc.PADUS1_VPC.id
  route {
    cidr_block = var.all_cidr
    gateway_id = aws_nat_gateway.PADUS1_NATGW.id
  }
  tags = {
    name = var.privrt_name
  }
}

#CREATE PRIVATE ROUND TABLE ASSOCIATIONS WITH PRIVATE SUBNETS
resource "aws_route_table_association" "PADUS1_PRIVRT_ASSOC1" {
  subnet_id      = aws_subnet.PADUS1_PRSN1.id
  route_table_id = aws_route_table.PADUS1_PRIVRT.id
}

resource "aws_route_table_association" "PADUS1_PRIVRT_ASSOC2" {
  subnet_id      = aws_subnet.PADUS1_PRSN2.id
  route_table_id = aws_route_table.PADUS1_PRIVRT.id
}

