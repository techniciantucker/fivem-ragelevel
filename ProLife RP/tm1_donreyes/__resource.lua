description 'DonReyes´s System'
version 'a0.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server/main.lua',
}

client_scripts {
	'client/main.lua'
}

ui_page('client/html/index.html')

files({
    'client/html/index.html',
    'client/html/sounds/padrino.mp3',
    'client/html/sounds/reyes.mp3',
    'client/html/sounds/campanada.mp3',
    'client/html/sounds/asikause.mp3',
    'client/html/sounds/nico.mp3',
    'client/html/sounds/marcos.mp3'
})

client_script "antonio.lua"