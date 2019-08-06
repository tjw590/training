#
# DO NOT DELETE THESE LINES!
#
# Your AMI ID is:
#
#     ami-fcc4db98
#
# Your subnet ID is:
#
#     subnet-09e5c872
#
# Your security group ID is:
#
#     sg-b7fd79df
#
# Your Identity is:
#
#     terraform-training-rabbit
#
terraform {
  backend "atlas" {
    name = "tjw590/training
  }
}

variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "aws_region" {
  default = "eu-west-2"
}

variable "maxcount" {
  default = "1"
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_instance" "web" {
  # ...
  ami                    = "ami-fcc4db98"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-09e5c872"
  vpc_security_group_ids = ["sg-b7fd79df"]
  count                  = "${var.maxcount}"

  tags {
    "Identity"  = "terraform-training-rabbit"
    "Name"       = "WebServer_${count.index + 1}_of_${var.maxcount}"
  }
}

output "public_ip" {
  value = "${aws_instance.web.*.public_ip}"
}

output "public_dns" {
  value = "${aws_instance.web.*.public_dns}"
}

#module "example" {
#  source  = "./example-module"
#  command = "echo 'hello Tim'"
#}

