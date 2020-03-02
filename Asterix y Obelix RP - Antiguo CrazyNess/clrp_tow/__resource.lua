-- Resource Manifest
resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'

-- MySQL Support
dependency 'GHMattiMySQL'

-- Menu Support
client_script 'warmenu.lua'

client_script 'client.lua'
server_script 'server.lua'