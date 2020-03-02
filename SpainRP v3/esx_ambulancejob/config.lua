Config                            = {}

Config.DrawDistance               = 100.0

Config.Marker                     = { type = 1, x = 1.5, y = 1.5, z = 1.5, r = 102, g = 0, b = 102, a = 100, rotate = false }

Config.ReviveReward               = 0  -- revive reward, set to 0 if you don't want it enabled
Config.AntiCombatLog              = true -- enable anti-combat logging?
Config.LoadIpl                    = false -- disable if you're using fivem-ipl or other IPL loaders

Config.Locale                     = 'es'

local second = 1000
local minute = 60 * second

Config.EarlyRespawnTimer          = 5 * minute  -- Time til respawn is available
Config.BleedoutTimer              = 10 * minute -- Time til the player bleeds out

Config.EnablePlayerManagement     = true

Config.RemoveWeaponsAfterRPDeath  = true
Config.RemoveCashAfterRPDeath     = true
Config.RemoveItemsAfterRPDeath    = true

-- Let the player pay for respawning early, only if he can afford it.
Config.EarlyRespawnFine           = false
Config.EarlyRespawnFineAmount     = 5000

Config.RespawnPoint = { coords = vector3(353.0, -604.84, 27.78), heading = 48.5 }

Config.Hospitals = {

	CentralLosSantos = {

		Blip = {
			coords = vector3(377.6, -599.90, 27.70),
			sprite = 61,
			scale  = 1.2,
			color  = 2
		},

		AmbulanceActions = {
			vector3(336.0, -580.80, 27.90)
		},

		Pharmacies = {
			vector3(353.6, -578.15, 27.79)
		},

		Vehicles = {
			{
				Spawner = vector3(334.60, -560.2, 29.2),
				InsideShop = vector3(228.5, -993.5, -99.5),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(342.4, -558.0, 29.0), heading = 340.0, radius = 4.0 },
				}
			},

			{
				Spawner = vector3(1837.11, 3666.99, 33.68),
				InsideShop = vector3(228.5, -993.5, -99.5),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(1837.77, 3656.02, 33.28), heading = 340.0, radius = 4.0 },
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(349.35, -589.25, 74.17),
				InsideShop = vector3(305.6, -1419.7, 41.5),
				Marker = { type = 34, x = 1.5, y = 1.5, z = 1.5, r = 200, g = 255, b = 50, a = 150, rotate = true },
				SpawnPoints = {
					{ coords = vector3(351.77, -588.32, 74.17), heading = 22.72, radius = 10.0 },
				}
			},

			{
				Spawner = vector3(1822.27, 3653.27, 34.16),
				InsideShop = vector3(305.6, -1419.7, 41.5),
				Marker = { type = 34, x = 1.5, y = 1.5, z = 1.5, r = 200, g = 255, b = 50, a = 150, rotate = true },
				SpawnPoints = {
					{ coords = vector3(1823.0, 3706.92, 32.75), heading = 22.72, radius = 10.0 },
				}
			},
		},

		FastTravels = {
--[[ 			{
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
			} ]]
		},

		FastTravelsPrompt = {
--[[ 			{
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
			} ]]
		}

	}
}

Config.AuthorizedVehicles = {

	ambulance = {
		{ model = 'ambulance', label = 'Ambulancia', price = 500},
		{ model = 'sheriff2', label = 'Ambulancia', price = 500}, 
		{ model = 'fd1', label = 'Ambulancia', price = 500},
		{ model = 'fd2', label = 'Ambulancia', price = 500},
		{ model = 'fd3', label = 'Ambulancia', price = 500},
		{ model = 'fd4', label = 'Ambulancia', price = 500},
		{ model = 'audiq8', label = 'Ambulancia', price = 500},
		{ model = 'ems', label = 'Ambulancia', price = 500},
		{ model = 'lsambulance', label = 'Ambulancia', price = 500},
		{ model = 'ambulance22', label = 'Ambulancia', price = 500},

	},

	doctor = {
		{ model = 'ambulance', label = 'Ambulancia', price = 500},
		{ model = 'sheriff2', label = 'Ambulancia', price = 500}, 
		{ model = 'fd1', label = 'Ambulancia', price = 500},
		{ model = 'fd2', label = 'Ambulancia', price = 500},
		{ model = 'fd3', label = 'Ambulancia', price = 500},
		{ model = 'fd4', label = 'Ambulancia', price = 500},
		{ model = 'audiq8', label = 'Ambulancia', price = 500},
		{ model = 'ems', label = 'Ambulancia', price = 500},
		{ model = 'lsambulance', label = 'Ambulancia', price = 500},
		{ model = 'ambulance22', label = 'Ambulancia', price = 500},
	},

	chief_doctor = {
		{ model = 'ambulance', label = 'Ambulancia', price = 500},
		{ model = 'sheriff2', label = 'Ambulancia', price = 500}, 
		{ model = 'fd1', label = 'Ambulancia', price = 500},
		{ model = 'fd2', label = 'Ambulancia', price = 500},
		{ model = 'fd3', label = 'Ambulancia', price = 500},
		{ model = 'fd4', label = 'Ambulancia', price = 500},
		{ model = 'audiq8', label = 'Ambulancia', price = 500},
		{ model = 'ems', label = 'Ambulancia', price = 500},
		{ model = 'lsambulance', label = 'Ambulancia', price = 500},
		{ model = 'ambulance22', label = 'Ambulancia', price = 500},
	},

	boss = {
		{ model = 'ambulance', label = 'Ambulancia', price = 500},
		{ model = 'sheriff2', label = 'Ambulancia', price = 500}, 
		{ model = 'fd1', label = 'Ambulancia', price = 500},
		{ model = 'fd2', label = 'Ambulancia', price = 500},
		{ model = 'fd3', label = 'Ambulancia', price = 500},
		{ model = 'fd4', label = 'Ambulancia', price = 500},
		{ model = 'audiq8', label = 'Ambulancia', price = 500},
		{ model = 'ems', label = 'Ambulancia', price = 500},
		{ model = 'lsambulance', label = 'Ambulancia', price = 500},
		{ model = 'ambulance22', label = 'Ambulancia', price = 500},
	}

}

Config.AuthorizedHelicopters = {

	ambulance = {},

	doctor = {
		{ model = 'supervolito', label = 'Helicoptero', price = 1000 },
		{ model = 'polmav', label = 'Helicoptero', price = 1000 }
	},

	chief_doctor = {
		{ model = 'supervolito', label = 'Helicoptero', price = 1000 },
		{ model = 'polmav', label = 'Helicoptero', price = 1000 }
	},

	boss = {
		{ model = 'supervolito', label = 'Helicoptero', price = 1000 },
		{ model = 'polmav', label = 'Helicoptero', price = 1000 }
	}

}
