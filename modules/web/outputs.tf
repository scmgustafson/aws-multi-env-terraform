output ec2_public_ip_address {
    value = aws_instance.web-server.public_ip
}