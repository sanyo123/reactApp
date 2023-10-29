resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "eks-cluster-vpc"
  }
}

resource "aws_subnet" "this" {
  count = 2
  cidr_block = count.index == 0 ? "10.0.1.0/24" : "10.0.2.0/24"
  vpc_id     = aws_vpc.this.id
  tags = {
    Name = "eks-cluster-subnet-${count.index + 1}"
  }
}
