# https://www.andreagrandi.it/2017/08/25/getting-latest-ubuntu-ami-with-terraform/

/*
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}
*/

resource "aws_instance" "instance" {
  ami                         = var.ami_id
  # ami = data.aws_ami.ubuntu.id
  # availability_zone = "ca-central-1a"
  instance_type               = var.instance_type
  key_name                    = "razer"
  vpc_security_group_ids      = [aws_security_group.sg.id]
  associate_public_ip_address = true
  user_data = file("${path.module}/setup.sh")
  root_block_device {
    volume_size           = 30
    delete_on_termination = true
  }
  tags = {
    Name = "ubuntu"
  }
}

output "public_ip" {
  value = aws_instance.instance.public_ip
}

# Our user_data script will be executed as part of cloud-init final
# Block terraform until cloud-init has finished executing our script and the instance is ready.
# Create a special null_resource that will use remote-exec to wait until cloud-init has finished
resource "null_resource" "cloud_init_wait" {
  connection {
    type = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/razer.pem")
    host        = "${aws_instance.instance.public_ip}"
    timeout     = "10m"
  }
  provisioner "remote-exec" {
    inline = ["sudo cloud-init status --wait"]
  }
  depends_on = [aws_instance.instance]
}

# Define a basic security group that restricts inbound access to ssh but allows
# all outgoing access
resource "aws_security_group" "example" {
  name        = "ssh_only_security_group"
  description = "Only allow inbound ssh access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8888
    to_port     = 8888
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow access from anywhere (you can restrict this to your local IP if desired)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ssh_only_security_group"
  }
}