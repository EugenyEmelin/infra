variable "project" {
  description = "Project ID"
}
variable "region" {
  description = "Region"
  default     = "europe-west2"
}
variable "public_key_path" {
  description = "Path to the public key used for ssh access"
}
variable "disk_image" {
  description = "Disk image"
}
variable "zone" {
  description = "Application instance zone"
  default     = "europe-west2-b"
}
variable "privat_key_path" {
  description = "SSH privat key path"
}
variable app_disk_image {
  description = "Disk image for reddit app"
  default = "reddit-app"
}
variable db_disk_image {
  description = "Disk image for reddit db"
  default = "reddit-db"
}
