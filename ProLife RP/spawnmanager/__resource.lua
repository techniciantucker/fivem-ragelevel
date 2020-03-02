client_script 'spawnmanager.lua'

export 'getRandomSpawnPoint'
export 'spawnPlayer'
export 'addSpawnPoint'
export 'removeSpawnPoint'
export 'loadSpawns'
export 'setAutoSpawn'
export 'setAutoSpawnCallback'
export 'forceRespawn'

server_scripts{
	'config.lua',
	'server.lua'
} 

client_scripts {
	'config.lua',
	'client.lua',
}











