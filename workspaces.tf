variable "org_name" {
  default     = "demo-rbac"
}

data "tfe_oauth_client" "client" {
  oauth_client_id = "oc-hd7uSxBZW61jiwVp"
}

data "tfe_team" "bu2admin" {
  name         = "bu2admin"
  organization = var.org_name
}

data "tfe_team" "bu2dev" {
  name         = "bu2dev"
  organization = var.org_name
}


resource "tfe_workspace" "bu2-app1-aws-useast1-dev" {
  name           = "bu2-app1-aws-useast1-dev"
  organization   =  var.org_name
  execution_mode = "remote"
}

resource "tfe_team_access" "bu2-app1-aws-useast1-dev-accessadmin" {
  access       = "admin"
  team_id      = data.tfe_team.bu2admin.id
  workspace_id = tfe_workspace.bu2-app1-aws-useast1-dev.id
}

resource "tfe_team_access" "bu2-app1-aws-useast1-dev-accessdev" {
  access       = "write"
  team_id      = data.tfe_team.bu2dev.id
  workspace_id = tfe_workspace.bu2-app1-aws-useast1-dev.id
} 
