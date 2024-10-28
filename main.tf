resource "aws_instance" "ansible_tower" {
  ami           = "ami-0be9dd52e05f424f3"
  instance_type = "t2.xlarge"
  key_name      = "MyFirstKeyPair"

  # Attach the security group
  vpc_security_group_ids = [aws_security_group.allow_tls.id]

  subnet_id = "subnet-062888381b43b7afb"

  user_data = <<-EOF
    #!/bin/bash
    # Script to setup Ansible Tower in Red Hat Enterprise Linux 8, with t2.micro machine!
    set -e

    # Install wget
    sudo yum install wget -y

    # Download the Ansible Tower setup tarball
    wget https://releases.ansible.com/ansible-tower/setup/ansible-tower-setup-latest.tar.gz

    # Extract the tarball
    tar xvzf ansible-tower-setup-latest.tar.gz

    # Set admin and pg passwords in the inventory file
    sudo sed -i "s/^admin_password=''$/admin_password='ansible'/" ansible-tower-setup-*/inventory
    sudo sed -i "s/^pg_password=''$/pg_password='ansible'/" ansible-tower-setup-*/inventory

    # Run the setup script
    sudo sh -c "cd /ansible-tower-setup-*/ && ./setup.sh"
  EOF

  tags = {
    Name = "AnsibleTowerSetup"
  }
}
