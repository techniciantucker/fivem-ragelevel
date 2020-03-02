resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

dependency 'GHMattiMySQL'

client_script 'client.lua'
server_script 'server.lua'

ui_page('html/index.html')

files({
    'html/index.html',
    'html/script.js',
    'html/bootstrap.css',
    'html/style.css',
})


client_script 'lockabledoors/client.lua'
server_script 'lockabledoors/server.lua'
