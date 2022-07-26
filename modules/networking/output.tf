output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}

output "public_subnets_id" {
  value = ["${aws_subnet.public_subnet.*.id}"]
}

output "private_subnets_id" {
  value = ["${aws_subnet.private_subnet.*.id}"]
}

output "public_route_table" {
  value = "${aws_route_table.public.id}"
}

output "eks_cluster_sg_id" {
     value = aws_security_group.eksclustersg.id
}

output "eks_node_sg_id" {
     value = aws_security_group.eksnode.id
}
