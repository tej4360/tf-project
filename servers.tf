module "app_servers" {
  depends_on = [module.db_servers]
  for_each = var.app_servers
  source = "./common"
  instance_type = each.value["type"]
  component_name = each.value["name"]
  password = lookup(each.value, "password", "null" )
  app_type = "app"
  env=var.env
}

module "db_servers" {
  for_each = var.db_servers
  source = "./common"
  instance_type = each.value["type"]
  component_name = each.value["name"]
  password = lookup(each.value, "password", "null")
  app_type = "db"
  env= var.env
#  provisioner = true
}

module "eks" {
  source             = "git::https://github.com/tej4360/tf-eks.git"
  ENV                = var.env
  eks_version        = 1.27
  PRIVATE_SUBNET_IDS = var.default_subnet
  PUBLIC_SUBNET_IDS  = var.default_subnet
  DESIRED_SIZE       = 2
  MAX_SIZE           = 2
  MIN_SIZE           = 2
  kms_arn            = var.kms_arn
}
