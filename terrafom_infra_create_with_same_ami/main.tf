#================================================
#       AMI selction
#================================================


data "aws_ami" "my_image" {
  
  most_recent      = true
  owners           = ["self"]

  filter {
    name   = "name"
    values = ["PACKER*"]
  }

}

# =====================================================
# Creating Public Key
# =====================================================

resource "aws_key_pair"  "key" {
 
  key_name   = "terraform"
  public_key = file("./../../terraform.pub")
  tags     = {
    Name    = "webserver-key"
  }
}

# =====================================================
# Creating Security Group - frontend
# =====================================================

resource "aws_security_group" "webserver" {   
  name        = "webserver"
  description = "Allows 80 from all,22 from bastion"
  vpc_id      = ""
  ingress     = [ 
      
  {
    description      = "allow from 22"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [ "0.0.0.0/0" ]
    ipv6_cidr_blocks = [ "::/0" ]
    self             = false 
    prefix_list_ids  = []
    security_groups  = []
  },
  {
    description      = "allow from 80"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [ "0.0.0.0/0" ]
    ipv6_cidr_blocks = [ "::/0" ]
    prefix_list_ids  = []
    security_groups  = []
    self             = false 
  },
  {
    description      = "allow from 443"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [ "0.0.0.0/0" ]
    ipv6_cidr_blocks = [ "::/0" ]
    prefix_list_ids  = []
    security_groups  = []
    self             = false 
  }

  ]
      
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags     = {
    Name    = "webserver"
  }
}
# =====================================================
# Creating Ec2 Instance For Bastion
# =====================================================

resource "aws_instance"  "webserver" {
    
  ami                          =  data.aws_ami.my_image.id
  instance_type                =  var.type
  subnet_id                    =  ""
  key_name                     =  aws_key_pair.key.id
  vpc_security_group_ids       =  [ aws_security_group.webserver.id ]

  tags     = {
    Name    = "webserver"
  }
    
}