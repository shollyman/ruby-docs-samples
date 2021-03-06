# Copyright 2018 Google, LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# [START bigquery_load_table_gcs_orc]
require "google/cloud/bigquery"

def load_table_gcs_orc dataset_id = "your_dataset_id"
  bigquery = Google::Cloud::Bigquery.new
  dataset  = bigquery.dataset dataset_id
  gcs_uri  = "gs://cloud-samples-data/bigquery/us-states/us-states.orc"
  table_id = "us_states"

  load_job = dataset.load_job table_id, gcs_uri, format: "orc"
  puts "Starting job #{load_job.job_id}"

  load_job.wait_until_done!  # Waits for table load to complete.
  puts "Job finished."

  table = dataset.table(table_id)
  puts "Loaded #{table.rows_count} rows to table #{table.id}"
end
# [END bigquery_load_table_gcs_orc]
