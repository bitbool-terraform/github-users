locals {
  groups = toset(["devs", "admins", "devops", "release-managers"])

  repo_permissions = {
    devs   = "push"
    admins = "admin"
    devops = "admin"
  }

  team_members = {
    for entry in flatten([
      for group in local.groups : [
        for username in lookup(var.users, group, toset([])) : {
          key      = "${group}/${lower(username)}"
          group    = group
          username = username
        }
      ]
    ]) : entry.key => entry
  }

  repo_grants = {
    for pair in setproduct(var.repositories, keys(local.repo_permissions)) :
    "${pair[0]}-${pair[1]}" => {
      repository = pair[0]
      group      = pair[1]
      permission = local.repo_permissions[pair[1]]
    }
  }
}