resource "aws_instance" "ec2_instance" {
  ami                    = data.aws_ami.ec2_ami.image_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [ data.aws_security_group.allow-all.id ]
  iam_instance_profile = aws_iam_instance_profile.iam_instance_profile.name
  tags = var.app_type == "app" ? local.app_tags : local.db_tags
#  tags = {
#    Name = var.component_name
#  }
}

resource "aws_route53_record" "dns_records" {
  zone_id = "Z05398713LIRV3MCPOPMB"
  name    = "${var.component_name}-${var.env}.rtdevopspract.online"
  type    = "A"
  ttl     = 300
  records = [aws_instance.ec2_instance.private_ip]
}

resource "null_resource" "provisioner" {
#  count = var.provisioner ? 1 : 0
  depends_on = [aws_instance.ec2_instance, aws_route53_record.dns_records]

  triggers = {
    private_ip= aws_instance.ec2_instance.private_ip
  }

  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = "centos"
      password = "DevOps321"
      host     = aws_instance.ec2_instance.private_ip
    }
#     inline = [
#       "rm -rf learnshell",
#       "git clone https://github.com/tej4360/learnshell.git",
#       "cd learnshell",
#       "sudo bash Roboshop/${var.component_name}.sh ${var.password} -y"
#     ]
    inline = var.app_type == "db" ? local.db_commands : local.app_commands
  }
}

resource "aws_iam_instance_profile" "iam_instance_profile" {
  name = "${var.env}.${var.component_name}-instance-profile2"
  role = aws_iam_role.ssm-role.name
}

resource "aws_iam_role" "ssm-role" {
  name = "${var.env}-${var.component_name}-role"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "sts:AssumeRole"
        ],
        "Principal": {
          "Service": [
            "ec2.amazonaws.com"
          ]
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "ssm_role_policy" {
  name = "${var.env}-${var.component_name}-policy"
  role = aws_iam_role.ssm-role.name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "VisualEditor0",
        "Effect": "Allow",
        "Action": [
          "kms:Decrypt",
          "ssm:GetParameterHistory",
          "ssm:GetParametersByPath",
          "ssm:GetParameters",
          "ssm:GetParameter"
        ],
        "Resource": [
          "arn:aws:ssm:us-east-1:318708475688:parameter/${var.env}.*",
          "arn:aws:kms:us-east-1:318708475688:key/b051b135-92e8-49ff-a98f-5f141dbc8087"
        ]
      },
      {
        "Sid": "VisualEditor1",
        "Effect": "Allow",
        "Action": "ssm:DescribeParameters",
        "Resource": "*"
      }
    ]
  })
}
##
