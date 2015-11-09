#----------------------------------------------------------------
# IAM: Role
#----------------------------------------------------------------
resource "aws_iam_role" "fullbok" {
    name               = "fullbok"
    path               = "/"
    assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

#----------------------------------------------------------------
# IAM: Policy
#----------------------------------------------------------------
resource "aws_iam_policy" "fullbok" {
    name = "fullbok"
    path = "/"
    description = "fullbok policy"
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeInstances",
                "ec2:DescribeInstanceStatus"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_policy_attachment" "fullbok-attach" {
    name = "fullbok-attachment"
    roles = ["${aws_iam_role.fullbok.name}"]
    policy_arn = "${aws_iam_policy.fullbok.arn}"
}

#----------------------------------------------------------------
# IAM: Instance Profile
#----------------------------------------------------------------
resource "aws_iam_instance_profile" "fullbok" {
    name  = "fullbok"
    path  = "/"
    roles = ["${aws_iam_role.fullbok.name}"]
}

