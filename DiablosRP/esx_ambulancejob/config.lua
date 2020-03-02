Config                            = {}

Config.DrawDistance               = 100.0

Config.Marker                     = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }

Config.ReviveReward               = 700  -- revive reward, set to 0 if you don't want it enabled
Config.AntiCombatLog              = true -- enable anti-combat logging?
Config.LoadIpl                    = true -- disable if you're using fivem-ipl or other IPL loaders

Config.Locale = 'en'

local second = 1000
local minute = 60 * second

Config.EarlyRespawnTimer          = 2 * minute  -- Time til respawn is available
Config.BleedoutTimer              = 10 * minute -- Time til the player bleeds out

Config.EnablePlayerManagement     = false

Config.RemoveWeaponsAfterRPDeath  = true
Config.RemoveCashAfterRPDeath     = true
Config.RemoveItemsAfterRPDeath    = true

-- Let the player pay for respawning early, only if he can afford it.
Config.EarlyRespawnFine           = false
Config.EarlyRespawnFineAmount     = 5000

Config.RespawnPoint = { coords = vector3(341.0, -1397.3, 32.5), heading = 48.5 }

Config.Hospitals = {

	CentralLosSantos = {

		Blip = {
			coords = vector3(307.7, -1433.4, 28.9),
			sprite = 61,
			scale  = 1.2,
			color  = 2
		},

		AmbulanceActions = {
			vector3(270.5, -1363.0, 23.5)
		},

		Pharmacies = {
			vector3(230.1, -1366.1, 38.5)
		},

		Vehicles = {
			{
				Spawner = vector3(307.7, -1433.4, 30.0),
				InsideShop = vector3(446.7, -1355.6, 43.5),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(297.2, -1429.5, 29.8), heading = 227.6, radius = 4.0 },
					{ coords = vector3(294.0, -1433.1, 29.8), heading = 227.6, radius = 4.0 },
					{ coords = vector3(309.4, -1442.5, 29.8), heading = 227.6, radius = 6.0 }
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(317.5, -1449.5, 46.5),
				InsideShop = vector3(305.6, -1419.7, 41.5),
				Marker = { type = 34, x = 1.5, y = 1.5, z = 1.5, r = 100, g = 150, b = 150, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(313.5, -1465.1, 46.5), heading = 142.7, radius = 10.0 },
					{ coords = vector3(299.5, -1453.2, 46.5), heading = 142.7, radius = 10.0 }
				}
			}
		},

		FastTravels = {
			{
				From = vector3(294.7, -1448.1, 29.0),
				To = { coords = vector3(272.8, -1358.8, 23.5), heading = 0.0 },
				Marker = { type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},

			{
				From = vector3(275.3, -1361, 23.5),
				To = { coords = vector3(295.8, -1446.5, 28.9), heading = 0.0 },
				Marker = { type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},

			{
				From = vector3(247.3, -1371.5, 23.5),
				To = { coords = vector3(333.1, -1434.9, 45.5), heading = 138.6 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},

			{
				From = vector3(335.5, -1432.0, 45.50),
				To = { coords = vector3(249.1, -1369.6, 23.5), heading = 0.0 },
				Marker = { type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},

			{
				From = vector3(234.5, -1373.7, 20.9),
				To = { coords = vector3(320.9, -1478.6, 28.8), heading = 0.0 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 1.0, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},

			{
				From = vector3(317.9, -1476.1, 28.9),
				To = { coords = vector3(238.6, -1368.4, 23.5), heading = 0.0 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 1.0, r = 102, g = 0, b = 102, a = 100, rotate = false }
			}
		},

		FastTravelsPrompt = {
			{
				From = vector3(237.4, -1373.8, 26.0),
				To = { coords = vector3(251.9, -1363.3, 38.5), heading = 0.0 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false },
				Prompt = _U('fast_travel')
			},

			{
				From = vector3(256.5, -1357.7, 36.0),
				To = { coords = vector3(235.4, -1372.8, 26.3), heading = 0.0 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false },
				Prompt = _U('fast_travel')
			}
		}

	}
}

Config.AuthorizedVehicles = {

	ambulance = {
		{ model = 'anpc_l200', label = 'MITSUBISHI', price = 500},
		{ model = 'ems_gs1200', label = 'MOTO', price = 500},
		{ model = 'mini', label = 'SMART', price = 500},
		{ model = 'fk2', label = 'PEUGEOT', price = 500},
		{ model = 'sprinter', label = 'FURGONETA', price = 500},
		{ model = 'sprinter1', label = 'FURGONETA', price = 500}
	},

	doctor = {
		{ model = 'anpc_l200', label = 'MITSUBISHI', price = 500},
		{ model = 'ems_gs1200', label = 'MOTO', price = 500},
		{ model = 'mini', label = 'SMART', price = 500},
		{ model = 'fk2', label = 'PEUGEOT', price = 500},
		{ model = 'sprinter', label = 'FURGONETA', price = 500},
		{ model = 'sprinter3', label = 'FURGONETA', price = 500},
		{ model = 'zendrack', label = 'MERCEDES', price = 500},
		{ model = 'sheriffx6', label = 'BMW', price = 500},
		{ model = 'polgs350', label = 'LEXUS', price = 500},
		{ model = 'sprinter1', label = 'FURGONETA', price = 500}
	},

	chief_doctor = {
		{ model = 'anpc_l200', label = 'MITSUBISHI', price = 500},
		{ model = 'ems_gs1200', label = 'MOTO', price = 500},
		{ model = 'mini', label = 'SMART', price = 500},
		{ model = 'fk2', label = 'PEUGEOT', price = 500},
		{ model = 'sprinter', label = 'FURGONETA', price = 500},
		{ model = 'sprinter3', label = 'FURGONETA', price = 500},
		{ model = 'zendrack', label = 'MERCEDES', price = 500},
		{ model = 'sheriffx6', label = 'BMW', price = 500},
		{ model = 'polgs350', label = 'LEXUS', price = 500},
		{ model = 'sprinter1', label = 'FURGONETA', price = 500},
		{ model = 'hcampana', label = 'AUTOBUS', price = 500},
		{ model = 'f150', label = 'RAPTOR', price = 500},
		{ model = 'pol718', label = 'PORCHE', price = 500}
	},

	boss = {
		{ model = 'anpc_l200', label = 'MITSUBISHI', price = 500},
		{ model = 'ems_gs1200', label = 'MOTO', price = 500},
		{ model = 'mini', label = 'SMART', price = 500},
		{ model = 'fk2', label = 'PEUGEOT', price = 500},
		{ model = 'sprinter', label = 'FURGONETA', price = 500},
		{ model = 'sprinter3', label = 'FURGONETA', price = 500},
		{ model = 'zendrack', label = 'MERCEDES', price = 500},
		{ model = 'sheriffx6', label = 'BMW', price = 500},
		{ model = 'polgs350', label = 'LEXUS', price = 500},
		{ model = 'sprinter1', label = 'FURGONETA', price = 500},
		{ model = 'hcampana', label = 'AUTOBUS', price = 500},
		{ model = 'f150', label = 'RAPTOR', price = 500},
		{ model = 'pol718', label = 'PORCHE', price = 500},
		{ model = 'polaventa', label = 'LAMBORGUINI', price = 500},
		{ model = 'polmp4', label = 'MCLAREN', price = 500}
	}
}

Config.AuthorizedHelicopters = {

	ambulance = {},

	doctor = {},

	chief_doctor = {
		{ model = 'EC135', label = 'HELICOPTERO', price = 1000 }
	},

	boss = {
		{ model = 'EC135', label = 'HELICOPTERO', price = 1000 },
		{ model = 'seasparrow', label = 'Sea Sparrow', price = 1000 }
	}

}

Config.Uniforms = {
	[1] = { -- bomberos
	  male = {
		['tshirt_1'] = 37,  ['tshirt_2'] = 0,
		['torso_1'] = 35,   ['torso_2'] = 1,
		['decals_1'] = 0,   ['decals_2'] = 0,
		['arms'] = 0,
		['pants_1'] = 46,   ['pants_2'] = 0,
		['shoes_1'] = 27,   ['shoes_2'] = 0,
		['helmet_1'] = -1,  ['helmet_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['ears_1'] = 0,     ['ears_2'] = 0,
		['bproof_1'] = 0,  ['bproof_2'] = 0
	  },
	  female = {
		['tshirt_1'] = 37,  ['tshirt_2'] = 0,
		['torso_1'] = 35,   ['torso_2'] = 1,
		['decals_1'] = 0,   ['decals_2'] = 0,
		['arms'] = 0,
		['pants_1'] = 46,   ['pants_2'] = 0,
		['shoes_1'] = 27,   ['shoes_2'] = 0,
		['helmet_1'] = -1,  ['helmet_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['ears_1'] = 0,     ['ears_2'] = 0,
		['bproof_1'] = 0,  ['bproof_2'] = 0
	  }
	},
	[2] = { -- forense
	  male = {
		['tshirt_1'] = 15,  ['tshirt_2'] = 0,
		['torso_1'] = 36,   ['torso_2'] = 0,
		['decals_1'] = 0,   ['decals_2'] = 0,
		['arms'] = 85,
		['pants_1'] = 84,   ['pants_2'] = 0,
		['shoes_1'] = 25,   ['shoes_2'] = 0,
		['helmet_1'] = -1,  ['helmet_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['ears_1'] = 0,     ['ears_2'] = 0,
		['bproof_1'] = 18,  ['bproof_2'] = 3
	  },
	  female = {
		['tshirt_1'] = 15,  ['tshirt_2'] = 0,
		['torso_1'] = 36,   ['torso_2'] = 0,
		['decals_1'] = 0,   ['decals_2'] = 0,
		['arms'] = 85,
		['pants_1'] = 84,   ['pants_2'] = 0,
		['shoes_1'] = 25,   ['shoes_2'] = 0,
		['helmet_1'] = -1,  ['helmet_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['ears_1'] = 0,     ['ears_2'] = 0,
		['bproof_1'] = 18,  ['bproof_2'] = 3
	  }
	},
	[3] = { -- enfermero
	  male = {
		['tshirt_1'] = 15,  ['tshirt_2'] = 0,
		['torso_1'] = 36,   ['torso_2'] = 0,
		['decals_1'] = 0,   ['decals_2'] = 0,
		['arms'] = 85,
		['pants_1'] = 84,   ['pants_2'] = 0,
		['shoes_1'] = 25,   ['shoes_2'] = 0,
		['helmet_1'] = -1,  ['helmet_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['ears_1'] = 0,     ['ears_2'] = 0,
		['bproof_1'] = 18,  ['bproof_2'] = 0
	  },
	  female = {
		['tshirt_1'] = 15,  ['tshirt_2'] = 0,
		['torso_1'] = 36,   ['torso_2'] = 0,
		['decals_1'] = 0,   ['decals_2'] = 0,
		['arms'] = 85,
		['pants_1'] = 84,   ['pants_2'] = 0,
		['shoes_1'] = 25,   ['shoes_2'] = 0,
		['helmet_1'] = -1,  ['helmet_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['ears_1'] = 0,     ['ears_2'] = 0,
		['bproof_1'] = 18,  ['bproof_2'] = 0
	  }
	},
	[4] = { --técnico
	  male = {
		['tshirt_1'] = 15,  ['tshirt_2'] = 0,
		['torso_1'] = 36,   ['torso_2'] = 0,
		['decals_1'] = 0,   ['decals_2'] = 0,
		['arms'] = 85,
		['pants_1'] = 84,   ['pants_2'] = 0,
		['shoes_1'] = 25,   ['shoes_2'] = 0,
		['helmet_1'] = -1,  ['helmet_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['ears_1'] = 0,     ['ears_2'] = 0,
		['bproof_1'] = 18,  ['bproof_2'] = 1
	  },
	  female = {
		['tshirt_1'] = 15,  ['tshirt_2'] = 0,
		['torso_1'] = 36,   ['torso_2'] = 0,
		['decals_1'] = 0,   ['decals_2'] = 0,
		['arms'] = 85,
		['pants_1'] = 84,   ['pants_2'] = 0,
		['shoes_1'] = 25,   ['shoes_2'] = 0,
		['helmet_1'] = -1,  ['helmet_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['ears_1'] = 0,     ['ears_2'] = 0,
		['bproof_1'] = 18,  ['bproof_2'] = 1
	  }
	},
	[5] = { --médico
	  male = {
		['tshirt_1'] = 15,  ['tshirt_2'] = 0,
		['torso_1'] = 36,   ['torso_2'] = 0,
		['decals_1'] = 0,   ['decals_2'] = 0,
		['arms'] = 85,
		['pants_1'] = 84,   ['pants_2'] = 0,
		['shoes_1'] = 25,   ['shoes_2'] = 0,
		['helmet_1'] = -1,  ['helmet_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['ears_1'] = 0,     ['ears_2'] = 0,
		['bproof_1'] = 18,  ['bproof_2'] = 2
	  },
	  female = {
		['tshirt_1'] = 15,  ['tshirt_2'] = 0,
		['torso_1'] = 36,   ['torso_2'] = 0,
		['decals_1'] = 0,   ['decals_2'] = 0,
		['arms'] = 85,
		['pants_1'] = 84,   ['pants_2'] = 0,
		['shoes_1'] = 25,   ['shoes_2'] = 0,
		['helmet_1'] = -1,  ['helmet_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['ears_1'] = 0,     ['ears_2'] = 0,
		['bproof_1'] = 18,  ['bproof_2'] = 2
	  }
	},
	[6] = { --doctor
	  male = {
		['tshirt_1'] = 15,  ['tshirt_2'] = 0,
		['torso_1'] = 36,   ['torso_2'] = 0,
		['decals_1'] = 0,   ['decals_2'] = 0,
		['arms'] = 85,
		['pants_1'] = 84,   ['pants_2'] = 0,
		['shoes_1'] = 25,   ['shoes_2'] = 0,
		['helmet_1'] = -1,  ['helmet_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['ears_1'] = 0,     ['ears_2'] = 0,
		['bproof_1'] = 18,  ['bproof_2'] = 4
	  },
	  female = {
		['tshirt_1'] = 15,  ['tshirt_2'] = 0,
		['torso_1'] = 36,   ['torso_2'] = 0,
		['decals_1'] = 0,   ['decals_2'] = 0,
		['arms'] = 85,
		['pants_1'] = 84,   ['pants_2'] = 0,
		['shoes_1'] = 25,   ['shoes_2'] = 0,
		['helmet_1'] = -1,  ['helmet_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['ears_1'] = 0,     ['ears_2'] = 0,
		['bproof_1'] = 18,  ['bproof_2'] = 4
	  }
	},
	[7] = { --jefatura
	  male = {
		['tshirt_1'] = 129,  ['tshirt_2'] = 0,
		['torso_1'] = 36,   ['torso_2'] = 0,
		['decals_1'] = 0,   ['decals_2'] = 0,
		['arms'] = 85,
		['pants_1'] = 84,   ['pants_2'] = 0,
		['shoes_1'] = 25,   ['shoes_2'] = 0,
		['helmet_1'] = -1,  ['helmet_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['ears_1'] = 0,     ['ears_2'] = 0,
		['bproof_1'] = 18,  ['bproof_2'] = 5
	  },
	  female = {
		['tshirt_1'] = 15,  ['tshirt_2'] = 0,
		['torso_1'] = 36,   ['torso_2'] = 0,
		['decals_1'] = 0,   ['decals_2'] = 0,
		['arms'] = 85,
		['pants_1'] = 84,   ['pants_2'] = 0,
		['shoes_1'] = 25,   ['shoes_2'] = 0,
		['helmet_1'] = -1,  ['helmet_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['ears_1'] = 0,     ['ears_2'] = 0,
		['bproof_1'] = 18,  ['bproof_2'] = 5
	  }
	}
}
