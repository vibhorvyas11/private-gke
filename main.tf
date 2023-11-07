module "kubernetes-engine_private-cluster" {
  source  = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  version = "29.0.0"
  description     = var.description
  name            = var.name
  project         = var.project_id
  resource_labels = var.cluster_resource_labels

  location            = local.location
  node_locations      = local.node_locations
  cluster_ipv4_cidr   = var.cluster_ipv4_cidr
  network             = "projects/${local.network_project_id}/global/networks/${var.network}"
  deletion_protection = var.deletion_protection
  
}
