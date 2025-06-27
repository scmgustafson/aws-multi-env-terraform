#!/bin/bash
yum update -y
yum install -y httpd
echo "<h1>Hello from ${server_name}</h1>" > /var/www/html/index.html
systemctl enable httpd
systemctl start httpd
