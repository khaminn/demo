# Ubuntu free-tier instance

provider "aws" {
	region = "us-east-1"
}

resource "aws_instance" "demo" {
	ami           = "ami-d15a75c7"
	instance_type = "t2.micro"
	vpc_security_group_ids = ["${aws_security_group.instance.id}"]

user_data = <<-EOF
              #!/bin/bash
              echo "Hello World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF

	tags {
		Name = "seccon-demo"
	}

}

resource "aws_security_group" "instance" {
	name = "seccon-demo"
	ingress {    
		from_port   = "${var.server_port}"
		to_port     = "${var.server_port}"    
		protocol    = "tcp"    
		cidr_blocks = ["0.0.0.0/0"]  
	}
}

variable "server_port" {
  description = "Using HTTP requests"
  default = 8080
}

output "public_ip" {  
	value = "${aws_instance.demo.public_ip}"
}
