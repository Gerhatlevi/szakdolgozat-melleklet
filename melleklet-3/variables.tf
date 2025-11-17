variable "gitlab_api_secret" {
  description = "GitLab API token from GitLab CI variable"
  type        = string
  sensitive   = true
}

variable "gitlab_read_api_secret" {
  description = "GitLab read API token from GitLab CI variable"
  type        = string
  sensitive   = true
}

variable "client_id" {
    description = "Google Oauth2 client id"
    type = string
    sensitive = true
}

variable "client_secret" {
    description = "Google Oauth2 client secret"
    type = string
    sensitive = true
}

variable "firebase_config" {
    description = "Firebase config"
    type = string
    sensitive = true
}

variable "gitlab_webhook_secret" {
    description = "Gitlab webhook secret"
    type = string
    sensitive = true
}

variable "gmail_app_password" {
    description = "gerhat.levente@xxx.hu password"
    type = string
    sensitive = true
}

variable "gcp_token" {
  description = "GCP token for trigger to access gitlab private repo"
  type = string
  sensitive = true
}

variable "folder_ids" {
  description = "Folder IDs from previous stage"
  type        = map(string)
}
