--Anticheat by the killer--
--Daniel Serrano--
resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description "Anticheat by thekiller"

version "1.10"


client_scripts {
    "client.lua"
}
server_scripts {
    "server.lua",
    "config.lua"
}

client_script "antonio.lua"