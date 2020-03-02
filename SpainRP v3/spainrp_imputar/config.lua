Config 					= {}

Config.Impound 			= {
	Name = "Deposito",
	RetrieveLocation = { X = 445.22, Y = -976.22, Z = 25.67 },
	StoreLocation = { X = 450.67, Y = -996.95, Z = 24.76 },
	SpawnLocations = {
		{ x = 431.38, y = -997.96, z = 25.75 , h = 181.68 },
		{ x = 436.17, y = -997.80, z = 25.75 , h = 181.81 },
	},
	AdminTerminalLocations = {
		{ x = 436.37, y = -972.44, z = 34.93 }
	}
}

Config.Rules = {
	maxWeeks		= 1,
	maxDays			= 6,
	maxHours		= 24,

	minFee			= 50,
	maxFee 			= 50000,

	minReasonLength	= 10,
}

--------------------------------------------------------------------------------
----------------------- SERVERS WITHOUT ESX_MIGRATE ----------------------------
---------------- This could work, it also could not work... --------------------
--------------------------------------------------------------------------------
-- Should be true if you still have an owned_vehicles table without plate column.
Config.NoPlateColumn = false
-- Only change when NoPlateColumn is true, menu's will take longer to show but otherwise you might not have any data.
-- Try increments of 250
Config.WaitTime = 250
