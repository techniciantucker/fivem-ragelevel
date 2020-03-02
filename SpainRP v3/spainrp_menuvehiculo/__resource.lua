resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

description "itinerance"
-- Requiring essentialmode
dependency "essentialmode"


client_script{'client.lua',
	'gui.lua',
	'map.lua',
}

server_scripts {
	'@mysql-async/lib/MySQL.lua'
}