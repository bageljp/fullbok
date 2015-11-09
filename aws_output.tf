#----------------------------------------------------------------
# Output: template
#----------------------------------------------------------------
resource "template_file" "slave_login" {
    filename = "./templates/output_slave_login.txt"

    vars {
        key_name = "${var.key_name}"
        #slave_ip = "${aws_instance.fullbok-slave.*.public_ip}"
        #slave_ip = "${formatlist("%s", aws_instance.fullbok-slave.*.public_ip)}"
        #slave_ip = "${formatlist("ssh -i /path/to/%s.pem ec2-user@%s", var.key_name, aws_instance.fullbok-slave.*.public_ip)}"
        slave_ips = "${join(", ", aws_instance.fullbok-slave.*.public_ip)}"
    }
}

#----------------------------------------------------------------
# Output: 
#----------------------------------------------------------------
output "ssh to jmeter slave instances" {
    #value = "ssh -i /path/to/${var.key_name}.pem ec2-user@<ip/hostname>"
    #value = "ssh -i /path/to/${var.key_name}.pem ec2-user@${element(aws_instance.fullbok-slave.*.public_ip, count.index)}"
     value = "${template_file.slave_login.rendered}"
}

output "RDP to jmeter master instance" {
    value = "remotedeskop://${aws_instance.fullbok-master.public_ip}"
}

