locals {
  tag_prefix = "MyEc2-${format("%02d",  1)}"
}


data "aws_ssm_parameter" "my-amzn-linux-ami" {
    name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = var.vpc_cidr
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}



resource "aws_launch_template" "web" {
  name                    = "web"
  instance_type           = "t2.micro"
  image_id           = data.aws_ssm_parameter.my-amzn-linux-ami.insecure_value
  security_group_names = [aws_security_group.allow_tls.name]

  user_data = "IyEvYmluL2Jhc2gKZWNobyAiSGVsbG8sIFdvcmxkISIgPiAvdG1wL2hlbGxvLnR4dAo="
}



resource "aws_instance" "web" {
  count          = 3
  instance_type  = var.instance_type

  launch_template {
    id = aws_launch_template.web.id
  }
  
  tags = {
    Name = local.tag_prefix
  }
}


