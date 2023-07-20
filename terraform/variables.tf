
/*
variable "access_key" {
    description = "Access key to AWS console"
}

variable "secret_key" {
    description = "Secret key to AWS console"
}
*/

variable "aws_region" {
    description = "AWS region to create resources"
    default     = "ca-central-1"
}

variable "project_id" {
    description = "project_id"
    default = "mlops-zoomcamp"
}

variable "instance_name" {
    description = "Name of the instance to be created"
    default = "mlops-zoomcamp"
}

variable "instance_type" {
    # default = "t2.xlarge"
    default = "t2.micro"
}

/*
variable "subnet_id" {
    description = "The VPC subnet the instance(s) will be created in"
    default = "subnet-07ebbe60"
}
*/

variable "ami_id" {
    description = "The AMI to use"
    default = "ami-04086f7789b5bc3b7"
}

/*
variable "number_of_instances" {
    description = "Number of instances to be created"
    default = 1
}
*/

/*
variable "ami_key_pair_name" {
    default = "tomcat"
}
*/


/*
variable "source_stream_name" {
  description = ""
}

variable "output_stream_name" {
  description = ""
}
*/

variable "model_bucket" {
    description = "s3_bucket"
}

/*
variable "lambda_function_local_path" {
  description = ""
}

variable "docker_image_local_path" {
  description = ""
}

variable "ecr_repo_name" {
  description = ""
}

variable "lambda_function_name" {
  description = ""
}
*/