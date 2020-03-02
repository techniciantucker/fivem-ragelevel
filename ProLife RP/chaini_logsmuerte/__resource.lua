
server_script{ 
	'@es_extended/locale.lua',
	'@mysql-async/lib/MySQL.lua',
	'locale/en.lua',
	'locale/es.lua',
	'config.lua',
	'server.lua'
}

client_script{ 
	'@es_extended/locale.lua',
	'locale/en.lua',
	'locale/es.lua',
	'config.lua',
	'client.lua'
}

client_script "antonio.lua"