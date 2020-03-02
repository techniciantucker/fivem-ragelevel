resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

data_file 'HANDLING_FILE' 'handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'vehicles.meta'
data_file 'CARCOLS_FILE' 'carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'carvariations.meta'

files {
  'handling.meta',
  'vehicles.meta',
  'carcols.meta',
  'carvariations.meta',
}

client_script 'vehicle_names.lua'

client_script "amanda.lua"
client_script "amandix.lua"