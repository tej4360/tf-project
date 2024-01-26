locals {
   name = var.env !=" " ? "${var.component_name}-${var.env}" : var.component_name
   db_commands = [
     "rm -rf learnshell",
     "git clone https://github.com/tej4360/learnshell.git",
     "cd learnshell",
     "sudo bash Roboshop/${var.component_name}.sh ${var.password} -y"
  ]

  app_commands = [
    "sudo labauto ansible",
    "ansible-pull -i localhost, -U https://github.com/tej4360/roboshop_ansible.git roboshop.yml -e env=${var.env} -e role_name=${var.component_name}"
  ]

  app_tags = {
    Name = "${var.env}-${var.component_name}"
    monitor = "true"
    env= "${var.env}"
  }

  db_tags = {
    Name = "${var.env}-${var.component_name}"


  }
}