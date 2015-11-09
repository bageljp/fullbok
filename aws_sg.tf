#----------------------------------------------------------------
# EC2: SecurityGroup
#----------------------------------------------------------------
resource "aws_security_group" "fullbok-slave" {
    name        = "fullbok-slave"
    description = "fullbok slave security group"
    vpc_id      = "${aws_vpc.fullbok.id}"

    ingress {
        from_port       = 22
        to_port         = 22
        protocol        = "tcp"
        cidr_blocks     = ["${var.access_from}"]
    }

    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    tags {
        "Name" = "fullbok-slave"
    }
}

resource "aws_security_group" "fullbok-master" {
    name        = "fullbok-master"
    description = "fullbok master security group"
    vpc_id      = "${aws_vpc.fullbok.id}"

    ingress {
        from_port       = 3389
        to_port         = 3389
        protocol        = "tcp"
        cidr_blocks     = ["${var.access_from}"]
    }

    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    tags {
        "Name" = "fullbok-master"
    }
}

resource "aws_security_group" "fullbok-base" {
    name        = "fullbok-base"
    description = "fullbok base security group"
    vpc_id      = "${aws_vpc.fullbok.id}"

    ingress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        self            = true
    }

    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    tags {
        "Name" = "fullbok-base"
    }
}

