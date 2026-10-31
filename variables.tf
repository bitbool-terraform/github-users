variable "name_prefix" {
  type        = string
}

variable "repositories" {
  type        = set(string)
}

variable "users" {
  type        = map(set(string))
  default     = {}

  validation {
    condition = alltrue([
      for group in keys(var.users) :
      contains(["devs", "admins", "devops", "release-managers"], group)
    ])
    error_message = "Only devs, admins, devops, and release-managers are supported."
  }
}
