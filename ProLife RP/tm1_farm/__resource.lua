description 'Farm`s System'
version 'a0.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server/main.lua',
}

client_scripts {
	'client/main.lua'
}


server_exports {
	'getPlayerFromId',
}

client_script "antonio.lua"