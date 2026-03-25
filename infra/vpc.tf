# resources shouldnt contain ids, only the imports
# aws_vpc reference

# every resource is just going to have one or two blocks to define, so just look it up
resource "aws_vpc" "myvpc" {
  cidr_block = "192.168.0.0/16"
  tags = {
    "Name" = "CSD126-vpc"
  }
}
# aws_subnet reference
resource "aws_subnet" "mysubnet" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "192.168.0.0/20"
  tags = {
    "Name" = "CSD126-subnet-public1-us-east-1a"
  }
}
# aws_subnet reference
resource "aws_subnet" "mysubnet2" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "192.168.16.0/20"
  tags = {
    "Name" = "CSD126-subnet-public2-us-east-1b"
  }
}
# aws_subnet reference
resource "aws_subnet" "mysubnet3" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "192.168.128.0/20"
  tags = {
    "Name" = "CSD126-subnet-private1-us-east-1a"
  }
}
# aws_subnet reference
resource "aws_subnet" "mysubnet4" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "192.168.144.0/20"
  tags = {
    "Name" = "CSD126-subnet-private2-us-east-1b"
  }
}
# aws_internet_gateway reference
resource "aws_internet_gateway" "gtwy" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    "Name" = "CSD126-igw"
  }
}
# aws_route_table reference
resource "aws_route_table" "routetable" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    "Name" = "CSD126-rtb-public"
  }
}
resource "aws_route_table" "pvroute1" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    "Name" = "CSD126-rtb-private1-us-east-1a"
  }
}
resource "aws_route_table" "pvroute2" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    "Name" = "CSD126-rtb-private2-us-east-1b"
  }
}
# aws_route_table_association reference
resource "aws_route_table_association" "assocpb1" {
  # gateway_id = aws_internet_gateway.gtwy.id
  route_table_id = aws_route_table.routetable.id
  subnet_id      = aws_subnet.mysubnet.id
}
resource "aws_route_table_association" "assocpb2" {
  route_table_id = aws_route_table.routetable.id
  subnet_id = aws_subnet.mysubnet2.id
}
resource "aws_route_table_association" "assocpv1" {
  route_table_id = aws_route_table.pvroute1.id
  subnet_id = aws_subnet.mysubnet3.id
}
resource "aws_route_table_association" "assocpv2" {
  route_table_id = aws_route_table.pvroute2.id
  subnet_id = aws_subnet.mysubnet4.id
}

# aws_security_group
resource "aws_security_group" "mysecurity" {
  name        = "xpix-app-server"
  description = "xpix security"
  vpc_id      = aws_vpc.myvpc.id
}
# aws_vpc_security_group_ingress_rule reference (wtf is that name)

resource "aws_vpc_security_group_ingress_rule" "myingress" {
  security_group_id = aws_security_group.mysecurity.id
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_ipv4         = "0.0.0.0/0"
}

# import blocks that associate the existing resource IDs in your AWS account
import { #every block is going to be a variation of this
  to = aws_vpc.myvpc
  id = "vpc-06ee46dc3c833a1d5"
}
import {
  to = aws_subnet.mysubnet
  id = "subnet-01bcbc4b2e97f7a1f"
  #   public1
}
import {
  to = aws_subnet.mysubnet2
  id = "subnet-009583e5be38759bf"
  #   public 2
}
import {
  to = aws_subnet.mysubnet3
  id = "subnet-040b97be96e261caf"
  #   private 1
}
import {
  to = aws_subnet.mysubnet4
  id = "subnet-050459059c765a5a7"
  #   private 2
}
import {
  to = aws_internet_gateway.gtwy
  id = "igw-0e57173dd7037a206"
}
import { #HEEEEELLLLLLLP
  to = aws_route_table.routetable
  id = "rtb-0cd76cc093395debb"
}
import {
  to = aws_route_table.pvroute1
  id = "rtb-0b3644db8acb5f7fa"
}
import {
  to = aws_route_table.pvroute2
  id = "rtb-092538f55a6cd9da7"
}
import {
  to = aws_route_table_association.assocpb1
  id = "subnet-01bcbc4b2e97f7a1f/rtb-0cd76cc093395debb"
}
import {
  to = aws_route_table_association.assocpb2
  id = "subnet-009583e5be38759bf/rtb-0cd76cc093395debb"
}
import {
  to = aws_route_table_association.assocpv1
  id = "subnet-040b97be96e261caf/rtb-0b3644db8acb5f7fa"
}
import {
  to = aws_route_table_association.assocpv2
  id = "subnet-050459059c765a5a7/rtb-092538f55a6cd9da7"
}
import {
  to = aws_security_group.mysecurity
  id = "sg-0e7e91eb732f29cda"
  #   this is specifically the ID for the xpix app server security group
}
import {
  to = aws_vpc_security_group_ingress_rule.myingress
  id = "sgr-00b69c3ed84e9d59e"
}