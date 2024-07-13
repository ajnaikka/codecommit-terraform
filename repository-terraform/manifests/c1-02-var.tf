

variable "dynamodb_name" {
  description = "dynamodb table name"
  type        = string
  default     = "menachery-terraform-lock"
}

variable "username" {
  description = "jenkins username"
  type        = string
  default     = "vignesh"
}

variable "password" {
  description = "jenkins password"
  type        = string
  default     = "11edf067dd4d1a989c6ad6118fe4bf75c5" #jenkins api token(vignesh) 
}

variable "host" {
  description = "jenkins url"
  type        = string
  default     = "https://jenkins.loyalitsolutions.com"
}

variable "job_name" {
  description = "jenkins job name to trigger"
  type        = string
  default     = "menachery-cc-git-sync-pipeline"
}

variable "s3_bucket" {
  description = "s3 bucket name to locate zipfile for lambda"
  type        = string
  default     = "lambda-codezip"
}

variable "s3_key" {
  description = "s3 object name (deploy.zip)"
  type        = string
  default     = "lambda_deploy.zip"
}

variable "function_name" {
  description = "name of the lambda function"
  type        = string
  default     = "menachery-jenkins"
}

variable "repository_name" {
  description = "name of the cc repo"
  type        = string
  default     = "menachery"
}

variable "custom_inline_policy_name" {
  description = "name of custom inline policy nam e"
  type        = string  
  default   =  "stage-prod-deny-menachery" # replace with unique one for each project while building infra
}