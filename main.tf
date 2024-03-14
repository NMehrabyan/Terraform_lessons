resource "aws_instance" "web-1" {
  ami           = "ami-0e0bf53f6def86294"
  instance_type = "t2.micro"

  tags = {
    Name = "MyEc2-1"
  }
}

resource "aws_instance" "web-2" {
  ami           = "ami-0e0bf53f6def86294"
  instance_type = "t2.micro"

  tags = {
    Name = "MyEc2-2"
  }
}

resource "aws_instance" "web-3" {
  ami           = "ami-0e0bf53f6def86294"
  instance_type = "t2.micro"

  tags = {
    Name = "MyEc2-3"
  }
}