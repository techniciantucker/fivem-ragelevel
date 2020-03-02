client_script '@global_api/client.lua'

-- Baseline
client_script 'base/client.lua'
server_script 'base/server.lua'

client_script 'craftables/client.lua'
server_script 'craftables/server.lua'

ui_page('nui/index.html')

files({
    'nui/index.html',
})
