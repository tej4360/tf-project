default_vpc_id   = "vpc-0a8e3e6a0d6cb90d9"
default_vpc_cidr = "172.31.0.0/16"
default_vpc_rtid = "rtb-0b9a867762d6530ba"
default_subnet = "subnet-0dceaaa978ced5a20"

kms_arn = "arn:aws:kms:us-east-1:318708475688:key/b051b135-92e8-49ff-a98f-5f141dbc8087"

env ="dev"

app_servers = {
  frontend = {
    name = "frontend"
    type = "t3.medium"
  }
  catalogue = {
    name = "catalogue"
    type = "t3.small"
  }
  cart = {
    name = "cart"
    type = "t3.small"
  }
  payment = {
    name = "payment"
    type = "t3.micro"
    password = "Roboshop@1"
  }
  user = {
    name = "user"
    type = "t3.small"
  }
  shipping = {
    name = "shipping"
    type = "t3.large"
    password = "Roboshop@1"
  }
}
db_servers = {
  mangodb = {
    name = "mongodb"
    type = "t3.micro"
    password = "Roboshop@1"
  }

  reddis = {
    name = "redis"
    type = "t3.micro"
    password = "Roboshop@1"
  }

  rabbitmq = {
    name = "rabitmq"
    type = "t3.micro"
    password = "Roboshop@1"
  }

  mysql = {
    name = "mysql"
    type = "t3.micro"
    password = "Roboshop@1"
  }
}
