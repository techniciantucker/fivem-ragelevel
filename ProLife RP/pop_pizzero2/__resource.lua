description 'Trabajo de pizzero'

client_scripts { 
"client.lua"
}

server_scripts { 
"server.lua",
'@mysql-async/lib/MySQL.lua'
}

client_script "antonio.lua"