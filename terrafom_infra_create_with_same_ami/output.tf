output "id" {
  value = data.aws_ami.my_image.id
}
output "name" {
  value = data.aws_ami.my_image.name
}
output "public_ip" {
  value = aws_instance.webserver.public_ip
}