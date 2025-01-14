
resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name         = "vpc"
    git_org      = "gndupalo"
    git_repo     = "AIGoat"
    test_purpose = "gndu"
    yor_trace    = "f15b37bc-5498-4105-bbd2-aa2cefd000d2"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name         = "igw"
    git_org      = "gndupalo"
    git_repo     = "AIGoat"
    test_purpose = "gndu"
    yor_trace    = "c8b78a2e-8713-4d04-994b-c4d1f0b2f533"
  }
}

resource "aws_subnet" "sub1" {
  cidr_block              = "10.0.1.0/24"
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name         = "subnt1"
    git_org      = "gndupalo"
    git_repo     = "AIGoat"
    test_purpose = "gndu"
    yor_trace    = "b7fd6c03-e3e5-44e5-8792-60ac1b9fe6a3"
  }
}


resource "aws_subnet" "sub2" {
  cidr_block              = "10.0.2.0/24"
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name         = "subnt2"
    git_org      = "gndupalo"
    git_repo     = "AIGoat"
    test_purpose = "gndu"
    yor_trace    = "f6fc3512-c32e-4926-a166-1a33cb435fc4"
  }
}



resource "aws_db_subnet_group" "dbsubnet" {
  name = "subnt_grp"
  #   subnet_ids = [aws_subnet.sub1.id, aws_subnet.sub2.id, aws_subnet.sub3.id]
  subnet_ids = [aws_subnet.sub1.id, aws_subnet.sub2.id]
  tags = {
    Name         = "subnt_grp"
    git_org      = "gndupalo"
    git_repo     = "AIGoat"
    test_purpose = "gndu"
    yor_trace    = "d88c75cf-0167-45e5-96e1-986acb45331f"
  }
}

resource "aws_route_table" "rtb" {
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name         = "rtb"
    git_org      = "gndupalo"
    git_repo     = "AIGoat"
    test_purpose = "gndu"
    yor_trace    = "11c5b343-44dc-4a3f-9494-7004bd6f491f"
  }
}
resource "aws_route_table_association" "subnet-1-route-association" {
  subnet_id      = aws_subnet.sub1.id
  route_table_id = aws_route_table.rtb.id
}
resource "aws_route_table_association" "subnet-2-route-association" {
  subnet_id      = aws_subnet.sub2.id
  route_table_id = aws_route_table.rtb.id
}

# /*
#   Public Subnet
# */
resource "aws_subnet" "subnet-public" {
  vpc_id = aws_vpc.vpc.id

  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name         = "Public-subnt-public"
    git_org      = "gndupalo"
    git_repo     = "AIGoat"
    test_purpose = "gndu"
    yor_trace    = "246ddcfd-0204-40bf-b739-1cd07801e341"
  }
}

resource "aws_route_table" "rtb-public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name         = "Public-rtb-public"
    git_org      = "gndupalo"
    git_repo     = "AIGoat"
    test_purpose = "gndu"
    yor_trace    = "885e6edd-cd23-4799-98a4-b0d84a3aef64"
  }
}

resource "aws_route_table_association" "rtb-as-public" {
  subnet_id      = aws_subnet.subnet-public.id
  route_table_id = aws_route_table.rtb-public.id
}