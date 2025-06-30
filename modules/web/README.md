# Web Module

The Web layer for our example project that includes a sample web server and the necessary supporting infrastructure to make it accessible as an example.

This module will create:

- An ec2 instance
- Uses a sample user_data.sh script to install httpd and expose a simple index.html
- The security group + rules to make the ec2 instance accessible from the public
- A route53 record using an existing domain to make the public IP accessible via a domain name URL

See `web-module-diagram.png` for further details.
