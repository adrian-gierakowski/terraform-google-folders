/**
 * Copyright 2018 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

output "folder" {
  description = "Folder resource (for single use)."
  value       = local.first_folder
}

output "id" {
  description = "Folder id (for single use)."
  value       = local.first_folder.name
}

output "name" {
  description = "Folder name (for single use)."
  value       = local.first_folder.display_name
}

output "folders" {
  description = "Folder resources."
  value       = local.folders
}

output "folders_map" {
  description = "Folder resources."
  value       = google_folder.folders
}

output "ids" {
  description = "Folder ids."
  value       = zipmap(var.names, slice(local.folders[*].name, 0, length(var.names)))
}

output "names" {
  description = "Folder names."
  value       = zipmap(var.names, slice(local.folders[*].display_name, 0, length(var.names)))
}

output "ids_list" {
  description = "List of folder ids."
  value       = local.folders[*].name
}

output "names_list" {
  description = "List of folder names."
  value       = local.folders[*].display_name
}
