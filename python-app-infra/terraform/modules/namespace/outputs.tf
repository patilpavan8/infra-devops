output "namespace" {
  value = kubernetes_namespace.kubernetes_namespace_v1.metadata[0].name
}
