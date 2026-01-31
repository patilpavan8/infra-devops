provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "nginx_vm" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"
  key_name      = var.key_name

  tags = {
    Name = "nginx-reverse-proxy"
  }
}

resource "aws_route53_record" "dns" {
  zone_id = var.zone_id
  name    = "devops-example.com"
  type    = "A"
  ttl     = 300
  records = [aws_instance.nginx_vm.public_ip]
}
