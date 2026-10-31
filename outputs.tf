output "team_ids" {
  value       = { for group, team in github_team.groups : group => team.id }
}

output "team_slugs" {
  value       = { for group, team in github_team.groups : group => team.slug }
}
