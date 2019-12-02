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

terraform {
  # 0.12.6 introduced for_each for resources
  required_version = ">= 0.12.6"
}

locals {
  prefix = var.prefix == "" ? "" : "${var.prefix}-"
  names_map = zipmap(var.names, var.names)
  folders_list = values(google_folder.folders)
  first_folder = local.folders_list[0]
}

resource "google_folder" "folders" {
  for_each = local.names_map

  display_name = "${local.prefix}${each.key}"
  parent       = "${var.parent}"
}

# give project creation access to service accounts
# https://cloud.google.com/resource-manager/docs/access-control-folders#granting_folder-specific_roles_to_enable_project_creation

resource "google_folder_iam_binding" "owners" {
  count  = var.set_roles ? length(var.names) * length(var.folder_admin_roles) : 0
  folder = local.folders[floor(count.index / length(var.folder_admin_roles))].name
  role   = var.folder_admin_roles[count.index % length(var.folder_admin_roles)]

  members = compact(
    concat(
      split(",",
        concat(var.per_folder_admins, [""])[floor(count.index / length(var.folder_admin_roles))],
      ), var.all_folder_admins,
    ),
  )
}
