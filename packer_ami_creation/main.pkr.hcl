############################ Variable declaration ############################
variable "a_key" {
  type    = string
  default = "xxxxxxxxxxxxxxxxxxxx"
}
variable "s_key" {
  type    = string
  default = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}

variable "ami_id" {
  type    = string
  default = "ami-0108d6a82a783b352"
}

variable "user" {
  type    = string
  default = "ec2-user"
}

variable "app_name" {
  type    = string
  default = "v2-httpd-webserver"
}

variable "region" {
  type    = string
  default = "ap-south-1"
}
variable "type" {
  type = string
  default = "t2.micro"
}


############################ AMI declaration ############################


source "amazon-ebs" "httpd-webserver" {
  ami_name      = "PACKER-DEMO-${var.app_name}"
  access_key    = "${var.a_key}"
  secret_key    = "${var.s_key}"
  instance_type = "${var.type}"
  region        = "${var.region}"
  source_ami    = "${var.ami_id}"
  associate_public_ip_address = true
 # ssh_username  = "${var.user}"

  tags = {
    Name = "PACKER-${var.app_name}"
  }
}

############################ Building AMI ################################

build {
  name           = "linux-AMI-builder"
  source "source.amazon-ebs.httpd-webserver" {
    ssh_username = "${var.user}"
  }


  provisioner "shell" {
   
    script = "setup.sh"
  }

}
