variable "cluster_name" {
  type    = string
  default = "my-lke-cluster"
}

variable "region" {
  type    = string
  default = "us-east"
}

variable "node_type" {
  type    = string
  default = "g6-standard-2"
}

variable "node_count" {
  type    = number
  default = 3
}
