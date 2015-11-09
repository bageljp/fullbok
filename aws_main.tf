#----------------------------------------------------------------
# Main: Variable
#----------------------------------------------------------------
variable "region" {}
variable "vpc_cidr" {}
variable "vpc_az" {}
variable "subnet_cidr" {}
variable "key_name" {}
variable "access_from" {}
variable "vpc_dns" {}
variable "master_ami" {}
variable "master_type" {}
variable "master_user_data_file" {}
variable "slave_type" {}
variable "slave_user_data_file" {}
variable "slave_capacity" {}
variable "slave_spot_price" {}
variable "jmeter_version" {}
variable "jmeter_url" {
    default = "http://ftp.tsukuba.wide.ad.jp/software/apache/jmeter/binaries/apache-jmeter-"
}
variable "master_ami" {
    # Windows Server 2012 R2 Base
    default = {
        ap-northeast-1 = "ami-3e93fe3e"
    }
}
variable "slave_ami" {
    # Amazon Linux 2015.09.1 (HVM)
    default = {
        ap-northeast-1 = "ami-383c1956"
    }
}
variable "java_heap" {
    default = {
        t2.micro = "-Xms256m -Xmx256m"
        t2.small = "-Xms1G -Xmx1G"
        t2.medium = "-Xms2G -Xmx2G"
        t2.large = "-Xms4G -Xmx4G"
        c3.large = "-Xms2G -Xmx2G"
        c3.xlarge = "-Xms4G -Xmx4G"
        m3.large = "-Xms4G -Xmx4G"
        m4.large = "-Xms4G -Xmx4G"
        m4.xlarge = "-Xms4G -Xmx4G"
    }
}

variable "java_new" {
    default = {
        t2.micro = "-XX:NewSize=128m -XX:MaxNewSize=128m"
        t2.small = "-XX:NewSize=256m -XX:MaxNewSize=512m"
        t2.medium = "-XX:NewSize=512m -XX:MaxNewSize=1G"
        t2.large = "-XX:NewSize=1G -XX:MaxNewSize=2G"
        c3.large = "-XX:NewSize=512m -XX:MaxNewSize=1G"
        c3.xlarge = "-XX:NewSize=1G -XX:MaxNewSize=2G"
        m3.large = "-XX:NewSize=1G -XX:MaxNewSize=2G"
        m4.large = "-XX:NewSize=1G -XX:MaxNewSize=2G"
        m4.xlarge = "-XX:NewSize=1G -XX:MaxNewSize=2G"
    }
}

#----------------------------------------------------------------
# Main: Provider
#----------------------------------------------------------------
provider "aws" {
    region = "${var.region}"
}

