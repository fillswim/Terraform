# ==============================================================================
#                              CNPG Namespace
# ==============================================================================

# resource "kubernetes_namespace" "cnpg_namespace" {

#   metadata {

#     annotations = {
#       name = "${var.namespace_name}-namespace-annotation"
#     }

#     labels = {
#       mylabel = "${var.namespace_name}-label"
#     }

#     name = var.namespace_name

#   }
# }
