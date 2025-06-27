output "vpc_id" {
    value = aws_vpc.vpc.id
}

output "vpc_cidr_block" {
    value = aws_vpc.vpc.cidr_block
}

output "public_subnet_id" {
    value = aws_subnet.public.id
}

output "public_route_table_id" {
    value = aws_route_table.public.id
}