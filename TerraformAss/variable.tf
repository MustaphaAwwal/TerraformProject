variable "AWS_PROFILE" {
  default = "default"
}
variable "AWS_REGION" {
  default = "us-east-1"
}
variable "ami" {
  default = "ami-00874d747dde814fa"
}
variable "instance_type" {
  default = "t2.micro"
}

variable "public_subnet_azs" {
  type = map(string)
  default = {
    "us-east-1a" = "10.0.1.0/24"
    "us-east-1b" = "10.0.2.0/24"
  }
}
variable "ssh-key" {
  default = "assignmentKey"
}
variable "domain-name" {
  default = "altschoollaravelbyawwal.me"
}
variable "sub-domain-name" {
  default = "terraform-test.altschoollaravelbyawwal.me"
}
