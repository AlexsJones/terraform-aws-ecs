variable "region" {
  default = "eu-west-1"
}

variable "autoscale" {
  default = {
    min     = 2
    max     = 5
    desired = 3
  }
}

variable "ecs_cluster_name" {
  default = "clusterbots"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "availability_zone" {
  type = "map"

  default = {
    primary = "eu-west-1a"
  }
}

variable "amazon_amis" {
  type = "map"

  default = {
    #ecs optimized
    eu-west-1 = "ami-03238b70"
  }
}

variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "public_cidr_block1" {
  default = "10.0.128.0/20"
}
