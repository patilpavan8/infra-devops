output "server_ip" {
  value = aws_instance.nginx_vm.public_ip
}
