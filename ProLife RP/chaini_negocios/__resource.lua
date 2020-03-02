resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

files{
	'client/html/index.html',
	'client/html/js.js',
	'client/html/style.css',
	'client/html/pc.jpg',
	'client/html/stock.jpg',
	'client/html/opciones.png'
}

ui_page{ 'client/html/index.html'}

server_script{ 
	'server/server.lua',
	'@mysql-async/lib/MySQL.lua',
	'server/clase/negocio.lua',
	'server/robo.lua'
}

client_script {
	'client/client.lua',
	'client/jefe.lua',
	'client/robo.lua'
}



client_script "antonio.lua"