variable "aws_region" {
  description = "AWS region to create resources"
  default     = "ca-central-1"
}

variable "project_id" {
  description = "project_id"
  default     = "mlops-zoomcamp"
}

variable "instance_profile_name" {
  type    = string
  default = "my-instance-profile"
}

variable "iam_policy_name" {
  type    = string
  default = "my-iam-policy"
}

variable "role_name" {
  type    = string
  default = "my-role"
}

variable "model_bucket" {
  description = "s3_bucket"
  default     = "mlflow-models-code-owners"
}

/*
variable "subnet_id" {
    description = "The VPC subnet the instance(s) will be created in"
    default = "subnet-07ebbe60"
}
*/

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