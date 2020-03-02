resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'
client_script '@global_api/client.lua'
dependency 'GHMattiMySQL'

-- Player [Core]
client_script 'player/client.lua'
server_script 'player/player.lua'
server_script 'player/server.lua'

-- Character [Selection]
client_script 'character/client.lua'
server_script 'character/server.lua'

ui_page('html/index.html')

files({
    'html/index.html',
    'html/script.js',
    'html/style.css'
})

-- Character Clothing
client_script 'character_clothing/client.lua'
client_script 'character_clothing/gui.lua'


-- Inventory
client_script 'inventory/client.lua'
server_script 'inventory/server.lua'
client_script 'inventory/items.lua'

-- Menu
client_script 'menu/client.lua'
client_script 'menu/warmenu.lua'

-- Stores
client_script 'stores/client.lua'
server_script 'stores/server.lua'

-- Vehicle Storage
client_script 'vehicle_storages/client.lua'
server_script 'vehicle_storages/server.lua'

-- VAT
client_script 'vat/client.lua'
server_script 'vat/server.lua'

export 'getInventory'
export 'getQuantity'
export 'getWeapons'
export 'GetClothes'
export 'GetItemQuantity'
export 'globalObject'
server_export 'getCops'
server_export 'getEMS'
server_export 'getMechanics'
server_export 'GetActiveCharacter'
server_export 'GetActiveCharacterID'
server_export 'GetCharacterID'
server_export 'getVat'
export 'getVat'