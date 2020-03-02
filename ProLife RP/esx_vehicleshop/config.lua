Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerColor                = { r = 120, g = 120, b = 240 }
Config.EnablePlayerManagement     = false -- enables the actual car dealer job. You'll need esx_addonaccount, esx_billing and esx_society
Config.EnableOwnedVehicles        = true
Config.EnableSocietyOwnedVehicles = false -- use with EnablePlayerManagement disabled, or else it wont have any effects
Config.ResellPercentage           = 50

Config.Locale                     = 'es'

Config.LicenseEnable = true -- require people to own drivers license when buying vehicles? Only applies if EnablePlayerManagement is disabled. Requires esx_license

-- looks like this: 'LLL NNN'
-- The maximum plate length is 8 chars (including spaces & symbols), don't go past it!
Config.PlateLetters  = 3
Config.PlateNumbers  = 3
Config.PlateUseSpace = true

Config.Zones = {

	ShopEntering = {
	  Pos   = { x = -231.36, y = 6234.88, z = 30.48 },
	  Size  = { x = 1.5, y = 1.5, z = 1.0 },
	  Type  = 1,
	},
  
	ShopInside = {
	  Pos     = { x = -235.72, y = 6251.64, z = 30.48 },
	  Size    = { x = 1.5, y = 1.5, z = 1.0 },
	  Heading = -20.0,
	  Type    = -1,
	},
  
	ShopOutside = {
	  Pos     = { x = -234.44, y = 6261.36, z = 30.48 },
	  Size    = { x = 1.5, y = 1.5, z = 1.0 },
	  Heading = 90.0,
	  Type    = -1,
	},
  
	BossActions = {
	  Pos   = { x = -223.0, y = 6243.28, z = 30.48 },
	  Size  = { x = 1.5, y = 1.5, z = 1.0 },
	  Type  = -1,
	},
  
	GiveBackVehicle = {
	  Pos   = { x = -216.96, y = 6252.24, z = 30.48 },
	  Size  = { x = 3.0, y = 3.0, z = 1.0 },
	  Type  = (Config.EnablePlayerManagement and 1 or -1),
	},
  
	ResellVehicle = {
	  Pos   = { x = -222.0, y = 6268.96, z = 30.683 },
	  Size  = { x = 3.0, y = 3.0, z = 1.0 },
	  Type  = 1,
	},
  
  }
  