env ="prod"

app_servers = {
  frontend = {
    name = "frontend"
    type = "t3.micro"
  }
  catalogue = {
    name = "catalogue"
    type = "t3.micro"
  }
  cart = {
    name = "cart"
    type = "t3.micro"
  }
  payment = {
    name = "payment"
    type = "t3.micro"
  }
  user = {
    name = "user"
    type = "t3.micro"
  }
  shipping = {
    name = "shipping"
    type = "t3.micro"
  }
}

db_servers = {
  mangodb = {
    name = "mangodb"
    type = "t3.micro"
    password = "roboshop@1"
  }

  reddis = {
    name = "redis"
    type = "t3.micro"
    password = "roboshop@1"
  }

  rabbitmq = {
    name = "rabbitmq"
    type = "t3.micro"
    password = "roboshop@1"
  }

  mysql = {
    name = "mysql"
    type = "t3.micro"
    password = "roboshop@1"
  }
}
