
# Security Group configuration
resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow inbound traffic to port 80 and all outbound traffic"
  vpc_id      = var.ec2_vpc_id

  tags = {
    Name = "allow_http"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
  security_group_id = aws_security_group.allow_http.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_http.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

# Web Server configuration
resource "aws_instance" "web-server" {
  ami           = var.ec2_ami
  instance_type = var.ec2_instance_type

  subnet_id = var.ec2_subnet_id
  associate_public_ip_address = true

  vpc_security_group_ids = [aws_security_group.allow_http.id]

  # User data script to install Apache and expose a simple index.html
  user_data = templatefile("${path.module}/assets/user_data.sh", {
    server_name = "${var.ec2_name}"
  })

  tags = merge(var.base_tags, 
    {
      Name = "${var.ec2_name}"
    }
  )
}


# route53 record