#----------------------------------------------------------------
# VPC: 
#----------------------------------------------------------------
resource "aws_vpc" "fullbok" {
    cidr_block           = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    enable_dns_support   = true
    instance_tenancy     = "default"

    tags {
        "Name" = "fullbok"
    }
}

#----------------------------------------------------------------
# VPC: DHCP Option
#----------------------------------------------------------------
resource "aws_vpc_dhcp_options" "fullbok" {
    domain_name = "${var.region}.compute.internal"
    domain_name_servers = [ "AmazonProvidedDNS" ]

    tags {
        Name = "fullbok"
    }
}

resource "aws_vpc_dhcp_options_association" "fullbok" {
    vpc_id = "${aws_vpc.fullbok.id}"
    dhcp_options_id = "${aws_vpc_dhcp_options.fullbok.id}"
}

#----------------------------------------------------------------
# VPC: Subnet
#----------------------------------------------------------------
resource "aws_subnet" "fullbok" {
    vpc_id                  = "${aws_vpc.fullbok.id}"
    cidr_block              = "${var.subnet_cidr}"
    availability_zone       = "${var.vpc_az}"
    map_public_ip_on_launch = true

    tags {
        Name = "fullbok"
    }
}

#----------------------------------------------------------------
# VPC: Internet Gateway
#----------------------------------------------------------------
resource "aws_internet_gateway" "fullbok" {
    vpc_id = "${aws_vpc.fullbok.id}"

    tags {
        Name = "fullbok"
    }
}

#----------------------------------------------------------------
# VPC: RouteTable
#----------------------------------------------------------------
resource "aws_route_table" "fullbok" {
    vpc_id = "${aws_vpc.fullbok.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.fullbok.id}"
    }

    tags {
        Name = "fullbok"
    }
}

resource "aws_route_table_association" "fullbok" {
    subnet_id = "${aws_subnet.fullbok.id}"
    route_table_id = "${aws_route_table.fullbok.id}"
}

