```hcl
provider "github" {
  owner = "my-org"
}

module "project_access" {
  source = "./github-users"

  name_prefix  = "myproject"
  repositories = ["backend", "frontend", "otherservice"]

  users = {
    devs               = ["dev1", "dev2"]
    admins             = ["admin1"]
    devops             = ["ops1", "ops2"]
    "release-managers" = ["release1"]
  }
}

output "release_managers_team_slug" {
  value = module.project_access.team_slugs["release-managers"]
}
```


```hcl
terraform {
  required_version = ">= 1.3.0"

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}
```