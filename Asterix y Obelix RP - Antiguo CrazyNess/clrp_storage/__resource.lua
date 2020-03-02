-- Resource Manifest
resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

-- MySQL Support
dependency 'GHMattiMySQL'
client_script 'warmenu.lua'

-- Storage Boxes
client_script 'storage_boxes/client.lua'
server_script 'storage_boxes/server.lua'

-- Cooler Boxes
client_script 'cooler_boxes/client.lua'
server_script 'cooler_boxes/server.lua'

-- Storage Boxes
client_script 'largestorage_boxes/client.lua'
server_script 'largestorage_boxes/server.lua'

-- Storage Boxes
client_script 'weapon_boxes/client.lua'
server_script 'weapon_boxes/server.lua'