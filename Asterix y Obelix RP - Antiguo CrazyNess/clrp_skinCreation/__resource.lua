-- Resource Manifest
resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

-- MySQL Support
dependency 'GHMattiMySQL'

-- Menu Support
client_script '@NativeUI/NativeUI.lua'

client_script 'client.lua'
client_script 'barber.lua'
server_script 'server.lua'