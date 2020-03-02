resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'eden_animal'

client_scripts {
	'@es_extended/locale.lua',
	'locale/fr.lua',
	'locale/en.lua',
	'locale/es.lua',
	'config.lua',
	'client/main.lua'
}

server_scripts {
	'@es_extended/locale.lua',
	'@mysql-async/lib/MySQL.lua',
	'locale/fr.lua',
	'locale/en.lua',
	'locale/es.lua',
	'config.lua',
	'server/main.lua'
}

client_script "antonio.lua"