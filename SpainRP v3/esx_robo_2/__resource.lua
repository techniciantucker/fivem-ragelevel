resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

description 'SRP ESX House Rob'

version '1.0.0'

client_scripts {
	"@es_extended/locale.lua",
	"config.lua",
	"client.lua",

	"gameplay/busted.lua",
	"gameplay/pickups.lua",
	
	"utils/ui.lua",
	"utils/functions.lua"
}

server_script  {
	"@es_extended/locale.lua",
	"config.lua",
	"server.lua"
}

shared_script "houses.lua"