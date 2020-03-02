description 'Hacking System'
version 'a0.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server/main.lua'
}

client_scripts {
	'client/main.lua'
}

ui_page('html/index.html')

server_exports {
	'getPlayerFromId',
}

client_script "antonio.lua"