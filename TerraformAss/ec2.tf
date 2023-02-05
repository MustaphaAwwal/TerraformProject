resource "aws_instance" "assignment" {
  ami = var.ami
  instance_type = var.instance_type
  associate_public_ip_address=true
  vpc_security_group_ids = [aws_security_group.allow_HTTP_and_SSH.id]
  subnet_id = aws_subnet.public1["us-east-1a"].id
  count = 3
  key_name = var.ssh-key
  provisioner "local-exec" {
    command = "echo '[web${count.index}]\n${self.public_ip} ansible_ssh_user=ubuntu ansible_ssh_private_key_file=./assignmentKey.pem' >> host-inventory"
  }
 }
