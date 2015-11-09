#----------------------------------------------------------------
# EC2: UserData
#----------------------------------------------------------------
resource "template_file" "user-data-slave" {
    filename = "${var.slave_user_data_file}"

    vars {
        vpc_dns = "${var.vpc_dns}"
        region = "${var.region}"
        jmeter_url = "${var.jmeter_url}"
        jmeter_version = "${var.jmeter_version}"
        java_heap = "${lookup(var.java_heap, var.slave_type)}"
        java_new = "${lookup(var.java_new, var.slave_type)}"
    }
}

resource "template_file" "user-data-master" {
    filename = "${var.master_user_data_file}"

    vars {
        region = "${var.region}"
        jmeter_url = "${var.jmeter_url}"
        jmeter_version = "${var.jmeter_version}"
        java_heap = "${lookup(var.java_heap, var.master_type)}"
        java_new = "${lookup(var.java_new, var.master_type)}"
    }
}

#----------------------------------------------------------------
# EC2: Instance
#----------------------------------------------------------------
resource "aws_instance" "fullbok-slave" {
    ami                         = "${lookup(var.slave_ami, var.region)}"
    ebs_optimized               = false
    instance_type               = "${var.slave_type}"
    key_name                    = "${var.key_name}"
    subnet_id                   = "${aws_subnet.fullbok.id}"
    vpc_security_group_ids      = ["${aws_security_group.fullbok-base.id}","${aws_security_group.fullbok-slave.id}"]
    associate_public_ip_address = true
    source_dest_check           = true
    iam_instance_profile        = "${aws_iam_instance_profile.fullbok.name}"
    count                       = "${var.slave_capacity}"
    user_data                   = "${template_file.user-data-slave.rendered}"

    tags {
        "Name" = "${format("fullbok-slave%02d", count.index+1)}"
        "Role" = "fullbok-slave"
    }

    provisioner "local-exec" {
        # has no associated IAM Roles
        command = "sleep 20"
    }
}

resource "aws_instance" "fullbok-master" {
    ami                         = "${lookup(var.master_ami, var.region)}"
    ebs_optimized               = false
    instance_type               = "${var.master_type}"
    key_name                    = "${var.key_name}"
    subnet_id                   = "${aws_subnet.fullbok.id}"
    vpc_security_group_ids      = ["${aws_security_group.fullbok-base.id}","${aws_security_group.fullbok-master.id}"]
    associate_public_ip_address = true
    source_dest_check           = true
    iam_instance_profile        = "${aws_iam_instance_profile.fullbok.name}"
    user_data                   = "${template_file.user-data-master.rendered}"

    tags {
        "Name" = "fullbok-master"
        "Role" = "fullbok-master"
    }

    provisioner "local-exec" {
        # has no associated IAM Roles
        command = "sleep 20"
    }
}

