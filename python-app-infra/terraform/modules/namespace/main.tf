resource "kubernetes_namespace" "kubernetes_namespace_v1" {
  metadata {
    name = var.name
  }
}
