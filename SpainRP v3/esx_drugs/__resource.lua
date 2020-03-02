resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'SpainRP Drogas'

version '3.0.5'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/en.lua',
	'locales/es.lua',
	'locales/fr.lua',
	'locales/sv.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'locales/es.lua',
	'locales/fr.lua',
	'locales/sv.lua',
	'config.lua',
	'client/main.lua',
	'client/weed.lua',
	'client/coca.lua',
	'client/heroina.lua',
	'client/opio.lua',
	'client/meta.lua'
}

dependencies {
	'es_extended'
}
