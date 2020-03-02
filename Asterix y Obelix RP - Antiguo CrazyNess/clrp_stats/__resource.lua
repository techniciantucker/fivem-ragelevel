-- Resource Manifest
resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

-- MySQL Support
dependency 'GHMattiMySQL'
client_script 'warmenu.lua'

client_script 'client.lua'
server_script 'server.lua'