# Security Group Configuration (remove any duplicates)
resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow HTTP, HTTPS, and SSH inbound traffic; allow all outbound traffic"
#   vpc_id      = aws_vpc.ansible_tower.id  # Make sure this matches the VPC you're using

  # Inbound rules
  ingress {
    description = "Allow HTTP traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Adjust if you want to restrict access
  }

  ingress {
    description = "Allow HTTPS traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Adjust if you want to restrict access
  }

  ingress {
    description = "Allow SSH traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Adjust if you want to restrict access
  }

  # Outbound rules (allow all traffic)
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # -1 allows all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}
