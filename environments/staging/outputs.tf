output web_server_public_ip {
    value = module.web.ec2_public_ip_address
}