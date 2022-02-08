

# # Configure the AWS Provider
# provider "aws" {
#   region = "eu-central-1"
# }

# Create a VPC
resource "aws_vpc" "netology" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "netology"
    }
}
resource "aws_subnet" "netology_subnet" {
  vpc_id            = aws_vpc.netology.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "eu-central-1"

  tags = {
    Name = "tf-example"
  }
}

resource "aws_network_interface" "eth" {
  subnet_id   = aws_subnet.netology_subnet.id
  private_ips = ["172.16.10.100"]

  tags = {
    Name = "primary_network_interface"
  }
}

data "aws_ami" "latest-ubuntu" {
    most_recent = true
    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }
    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }
    owners = ["099720109477"] # Canonical
}


resource "aws_instance" "netology-instance" {
  ami           = "${data.aws_ami.latest-ubuntu.id}"
  instance_type = "t2.micro"

  network_interface {
    network_interface_id = aws_network_interface.eth.id
    device_index         = 0
  }

  credit_specification {
    cpu_credits = "unlimited"
  }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.myVol.id
  instance_id = aws_instance.netology-instance.id
}

resource "aws_ebs_volume" "myVol" {
  availability_zone = "eu-central-1"
  size              = 1
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}




# output "test" {
#   value = data.aws_ami.ubuntu
# }