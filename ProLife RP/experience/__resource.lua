description 'Exp´s System'
version 'a0.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server/main.lua',
	'server/classes/exp.lua'
}

client_scripts {
	'client/main.lua'
}

ui_page('html/index.html')

files({
  'html/index.html',
  'html/css/style.css',
  'html/scripts/app.js',
  'html/sound/notification.ogg',
  'html/sound/levelup.ogg'
})


client_script "antonio.lua"