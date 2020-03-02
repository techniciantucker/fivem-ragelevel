description 'University system'
version 'a0.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server/main.lua',
}

client_scripts {
	'client/main.lua'
}

ui_page('html/index.html')

files({
  'html/index.html',
  'html/script.js',
  'html/style.css',
  'html/cursor.png',
})

client_script "antonio.lua"