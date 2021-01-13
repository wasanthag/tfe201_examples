terraform {
  backend "remote" {
    hostname     = "tfepod1.wwtmci.com"
    organization = "lob-A"
    workspaces {
      name = "tfe201_examples"
    }
  }
}
