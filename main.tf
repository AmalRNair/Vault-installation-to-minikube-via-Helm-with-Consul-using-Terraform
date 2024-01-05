provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"  # Update with your kubeconfig path if needed
  }
}
# variable "replicas" {
#   default = 1
# }
variable "dns_name" {
}
resource "helm_release" "consul" {
  name       = "consul"
  repository = "https://helm.releases.hashicorp.com"
  chart      = "consul"


  set {
    name  = "global.datacenter"
    value = "vault-kubernetes-tutorial"
  }
  set {
    name  = "client.enabled"
    value = "true"
  }

  set {
    name  = "server.replicas"
    value = "1"
  }

  set {
    name  = "server.bootstrapExpect"
    value = "1"
  }

  set {
    name  = "server.disruptionBudget.maxUnavailable"
    value = "0"
  }


  # Add other configuration options as needed
}

resource "helm_release" "vault" {
  name       = "vault"
  repository = "https://helm.releases.hashicorp.com"
  chart      = "vault"
  

  set {
    name  = "server.affinity"
    value = ""
  }
  set {
    name  = "server.ha.enabled"
    value = "true"
  }

  # Add other configuration options as needed
}
