resource "google_container_cluster" "primary" {
    project  = var.project_id
    name = var.name
    location = "us-central1"



    remove_default_node_pool = true
    initial_node_count  = 1

}
 



resource "google_container_node_pool" "primary_nodes" {
    name =  "my-node-pool2"
    location = "us-central1"
    cluster = google_container_cluster.primary.id
    node_count = 1

    autoscaling {
      min_node_count = 1
      max_node_count = 5
    }
    management {
      auto_repair = true
      auto_upgrade = true
    }

    node_config {
      preemptible = true
      machine_type = "e2-medium"



      metadata = {
          disable-legacy-endpoints = true
      }

      oauth_scopes =[
          "https://www.googleapis.com/auth/cloud-platform"
      ]
    }
  
}
