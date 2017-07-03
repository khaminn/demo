# Ubuntu free-tier instance

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "demo" {
	ami           = "ami-d15a75c7"
	instance_type = "t2.micro"


	tags {
		Name = "seccon-demo"
	}
}
