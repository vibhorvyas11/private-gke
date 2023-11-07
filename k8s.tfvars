####Cluster

module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  project_id                 = "prj-2710-vi52166711vy-svc"
  name                       = "gke-test-1"
  region                     = "europe-north1"
  zones                      = ["europe-north1-a", "europe-north1-b", "europe-north1-c"]
  network                    = "projects/prj-13052023-h-landing-zone-01/regions/europe-north1/vpc-shr-nprd-int-01"
  subnetwork                 = "projects/prj-13052023-h-landing-zone-01/regions/europe-north1/vpc-shr-nprd-int-01-sub-euno1-gke-node-01"
  ip_range_pods              = "sec-gke-pod-2"
  ip_range_services          = "sec-gke-svc-2"
  http_load_balancing        = false
  network_policy             = false
  horizontal_pod_autoscaling = true
  filestore_csi_driver       = false
  enable_private_endpoint    = true
  enable_private_nodes       = true
  master_ipv4_cidr_block     = "10.17.100.0/28"

#####NodePools######
  node_pools = [
    {
      name                      = "default-node-pool"
      machine_type              = "e2-medium"
      node_locations            = "europe-north1-a,europe-north1-b,europe-north1-c"
      min_count                 = 1
      max_count                 = 100
      local_ssd_count           = 0
      spot                      = false
      disk_size_gb              = 100
      disk_type                 = "pd-standard"
      image_type                = "COS_CONTAINERD"
      enable_gcfs               = false
      enable_gvnic              = false
      logging_variant           = "DEFAULT"
      auto_repair               = true
      auto_upgrade              = true
      service_account           = "sdlc-01@prj-2710-vi52166711vy-svc.iam.gserviceaccount.com"
      preemptible               = false
      initial_node_count        = 80
    },
  ]

  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }

  node_pools_labels = {
    all = {}

    default-node-pool = {
      default-node-pool = true
    }
  }

  node_pools_metadata = {
    all = {}

    default-node-pool = {
      node-pool-metadata-custom-value = "my-node-pool"
    }
  }

  node_pools_taints = {
    all = []

    default-node-pool = [
      {
        key    = "default-node-pool"
        value  = true
        effect = "PREFER_NO_SCHEDULE"
      },
    ]
  }

  node_pools_tags = {
    all = []

    default-node-pool = [
      "default-node-pool",
    ]
  }
}