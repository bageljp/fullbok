region = "<AWS Region (ex. ap-northeast-1)>"
vpc_cidr = "<VPC CIDR (ex. 192.168.0.0/16)"
subnet_cidr = "<Subnet CIDR (ex. 192.168.0.0/24)>"
vpc_az = "<Availability Zone (ex. ap-northeast-1a)>"
key_name = "<key-name>"
access_from = "0.0.0.0/0"
vpc_dns = "<AmazonProvidedDNS (ex. 192.168.0.2)>"
master_type = "t2.large"
master_user_data_file = "./templates/user_data_fullbok-master.txt"
slave_type = "t2.medium"
slave_user_data_file = "./templates/user_data_fullbok-slave.txt"
slave_capacity = "2"
jmeter_version = "2.13"
