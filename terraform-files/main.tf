resource "aws_instance" "test-server" {
  ami = "ami-0522ab6e1ddcc7055"
  instance_type = "t2.micro"
  key_name = "tomcat"
  vpc_security_group_ids = ["sg-044f5615389b77f0c"]
  connection {
     type = "ssh"
     user = "ubuntu"
     private_key = file("./tomcat.pem")
     host = self.public_ip
     }
  provisioner "remote-exec" {
     inline = ["echo 'wait to start the instance' "]
  }
  tags = {
     Name = "test-server"
     }
  provisioner "local-exec" {
     command = "echo ${aws_instance.test-server.public_ip} > inventory"
     }
  provisioner "local-exec" {
     command = "ansible-playbook /var/lib/jenkins/workspace/Banking/terraform-files/ansibleplaybook.yml"
     }
  }
