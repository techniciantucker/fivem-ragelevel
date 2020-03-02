resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'SpainRP EMS'

version '1.0'

server_scripts {
	'server/main.lua',
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/es.lua',
	'warmenu.lua',
	'config.lua',
  	'client/main.lua'
}

dependencies {
	'essentialmode',
}