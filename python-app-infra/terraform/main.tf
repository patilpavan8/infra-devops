provider "kubernetes" {
  config_path = "~/.kube/config"
}

module "lamp_namespace" {
  source = "./modules/namespace"
  name   = var.namespace
}
