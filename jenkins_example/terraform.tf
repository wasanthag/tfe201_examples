terraform {
  backend "remote" {
    hostname     = "tfe.wwtmci.com"
    organization = "finance"
    workspaces {
      name = "app1"
    }
  }
}
