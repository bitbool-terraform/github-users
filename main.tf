resource "github_team" "groups" {
  for_each = local.groups

  name        = "${var.name_prefix}-${each.key}"
  description = "Auto-managed ${each.key} team for ${var.name_prefix}"
  privacy     = "closed"
}

resource "github_team_membership" "members" {
  for_each = local.team_members

  team_id  = github_team.groups[each.value.group].id
  username = each.value.username
  role     = each.value.group == "devops" ? "maintainer" : "member"
}

resource "github_team_repository" "access" {
  for_each = local.repo_grants

  team_id    = github_team.groups[each.value.group].id
  repository = each.value.repository
  permission = each.value.permission
}