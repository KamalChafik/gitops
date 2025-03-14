resource "linode_lke_cluster" "lke" {
  label       = var.cluster_name
  region      = var.region
  k8s_version = "1.27"
  pool {
    type  = var.node_type
    count = var.node_count
  }
}