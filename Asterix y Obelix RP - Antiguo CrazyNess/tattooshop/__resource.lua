resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

export "loadPlayerTattoos"

ui_page "html/tattooshop.html"

files {
 "html/tattooshop.css",
 "html/tattooshop.js",
 "html/tattooshop.html"
}

client_script "tattoo_client.lua"
server_scripts {
 "tattoo_server.lua",
 "tattoos.lua",
}