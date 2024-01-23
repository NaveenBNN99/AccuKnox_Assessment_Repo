terraform {
  required_providers {
  aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    
  }
}

provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_security_group" "ec2_sg" {
  name        = "my-ec2-sg"
  description = "Security group for EC2 instance"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "6"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "6"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "6"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "my_ec2_instance" {
  ami             = "ami-051f7e7f6c2f40dc1"
  instance_type   = "t2.medium"
  key_name        = "mapup"
  security_groups = [aws_security_group.ec2_sg.name]

user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install git -y
    sudo yum update -y
    sudo yum upgrade -y
    sudo dnf install java-11-amazon-corretto -y
    sudo yum install docker -y
    sudo systemctl start docker
    sudo systemctl enable docker
    docker --version
    sudo usermod -aG ec2-user
    curl -LO https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl
    chmod +x kubectl
    sudo mv kubectl /usr/local/bin/
    curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
    sudo mv /tmp/eksctl /usr/local/bin
    eksctl version
    wget https://releases.hashicorp.com/terraform/1.5.6/terraform_1.5.6_linux_amd64.zip
    unzip terraform_1.5.6_linux_amd64.zip
    sudo mv terraform /usr/local/bin/
    terraform version
    sudo chmod 666 /var/run/docker.sock
    chmod 600 C:/Users/nnandab/Downloads/terraform.pem
    kubectl create secret generic db-credentials --from-literal=password=admin123
    EOF
}