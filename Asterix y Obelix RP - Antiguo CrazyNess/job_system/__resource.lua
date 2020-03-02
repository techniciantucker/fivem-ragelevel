-- Resource Manifest
resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

-- MySQL Support
dependency 'GHMattiMySQL'

-- Menu Support
client_script 'base/warmenu.lua'
server_script 'base/server.lua'
client_script 'base/client.lua'

-- Jobs

-- Lumberjack
client_script 'lumberjack/client.lua'
client_script 'lumberjack/trees.json'
server_script 'lumberjack/server.lua'

-- Fishing 
client_script 'fishing/client.lua'

-- Taxi
client_script 'taxi/client.lua'
server_script 'taxi/server.lua'

-- Weazel News
--client_script 'WNews/client.lua'

-- Bus & Coach 
--client_script 'coach/client.lua'

-- Weazel News
client_script 'scrapyard/client.lua'