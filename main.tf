provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "ansible" {
  ami = "ami-05fa00d4c63e32376" # us-west-2
  instance_type = "t2.micro"
  tags = {
    Name = "Ansible"
  }
}
resource "aws_instance" "dev_server" {
  ami = "ami-05fa00d4c63e32376" # us-west-2
  instance_type = "t2.micro"
  tags = {
    Name = "Dev-server"
  }
}
