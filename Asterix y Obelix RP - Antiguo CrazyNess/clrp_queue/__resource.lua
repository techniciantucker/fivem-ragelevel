resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

dependency 'GHMattiMySQL'

client_script "client/client.lua"
server_script "server/server.lua"

server_export "AddPriority"
server_export "RemovePriority"