

## 1 ---

## 2
[server.yaml](07-terraform-04-teamwork/server.yaml)
[atlantis.yaml](07-terraform-04-teamwork/atlantis.yaml)
## 3
Особых отличий в создании инстанса не заметил. Тот-же набор параметров. Думаю что использовать его необходимости нет.

main.tf
```buildoutcfg
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

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "netology-instance"

  ami                    = "${data.aws_ami.latest-ubuntu.id}"
  instance_type          = "t2.micro"
  key_name               = "net-user"
  monitoring             = true
  subnet_id              = aws_network_interface.eth.id

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

```