variable "ami_id" {
    default = "ami-04086f7789b5bc3b7" 
    # ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20230719
}

variable "instance_type" {
    default = "t2.small"
    # default = "t2.xlarge"
    # default = "g4dn.2xlarge"
    # A g4dn.xlarge instance in Amazon is what we suggest, which is US$0.526 an hour.
}

variable "instance_volume_size" {
    default = 10
}

variable "ssh_key" {
    default = "~/.ssh/razer.pem"
}

/*
variable "instance_profile_name" {
    type    = string
}
*/

/*
variable "instance_name" {
    description = "Name of the instance to be created"
    default = "my-instance"
}
*/


/*
variable "instance_profile_id" {
    type = string
}

variable "key_name" {
    type = string
    default = "ssh_key"
}
*/