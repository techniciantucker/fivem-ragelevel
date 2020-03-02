Config                            = {}

Config.DrawDistance               = 100.0
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 0.5 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }

Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- enable if you're using esx_identity
Config.EnableNonFreemodePeds      = true -- turn this on if you want custom peds
Config.EnableLicenses             = true -- enable if you're using esx_license

Config.EnableHandcuffTimer        = true -- enable handcuff timer? will unrestrain player after the time ends
Config.HandcuffTimer              = 10 * 60000 -- 10 mins

Config.EnableJobBlip              = true -- enable blips for colleagues, requires esx_society

Config.MaxInService               = -1
Config.Locale = 'en'

Config.PoliceStations = {

	LSPD = {

		Blip = {
			Coords  = vector3(425.1, -979.5, 30.7),
			Sprite  = 60,
			Display = 4,
			Scale   = 1.2,
			Colour  = 29
		},
		Blip = {
			Coords  = vector3(-459.83, 6014.5, 30.7),
			Sprite  = 60,
			Display = 4,
			Scale   = 1.2,
			Colour  = 29
		},

		Cloakrooms = {
			vector3(452.6, -992.8, 30.6)
		},

		Armories = {
			vector3(461.61, -981.02, 30.6)
		},
--afuera
		Vehicles = {
			{
				Spawner = vector3(454.6, -1017.4, 28.4),

				InsideShop = vector3(228.5, -993.5, -99.5),
				SpawnPoints = {
					{ coords = vector3(438.4, -1018.3, 27.7), heading = 90.0, radius = 6.0 },
					{ coords = vector3(441.0, -1024.2, 28.3), heading = 90.0, radius = 6.0 },
					{ coords = vector3(453.5, -1022.2, 28.0), heading = 90.0, radius = 6.0 },
					{ coords = vector3(450.9, -1016.5, 28.1), heading = 90.0, radius = 6.0 }
				},

			},
			{
				Spawner = vector3(-477.74, 6016.34, 31.34),
				InsideShop = vector3(228.5, -993.5, -99.5),
				SpawnPoints = {
					{ coords = vector3(-468.52, 6038.75, 31.3), heading = 226.99, radius = 6.0 },
					{ coords = vector3(-482.35, 6025.75, 31.3), heading = 226.99, radius = 6.0 },
					{ coords = vector3(-479.81, 6028.0, 31.3), heading = 226.99, radius = 6.0 },
					{ coords = vector3(-471.95, 6031.64, 31.3), heading = 226.99, radius = 6.0 }
				},

			},
			{
				Spawner = vector3(473.3, -1018.8, 28.0),
				InsideShop = vector3(228.5, -993.5, -99.0),
				SpawnPoints = {
					{ coords = vector3(475.9, -1021.6, 28.0), heading = 276.1, radius = 6.0 },
					{ coords = vector3(484.1, -1023.1, 27.5), heading = 302.5, radius = 6.0 }
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(461.1, -981.5, 43.6),
				InsideShop = vector3(477.0, -1106.4, 43.0),
				SpawnPoints = {
					{ coords = vector3(477.0, -1106.4, 43.0), heading = 92.6, radius = 10.0 }
				}
			}
		},
		Helicopters = {
			{
				Spawner = vector3(458.97, -981.12, 43.69),
				InsideShop = vector3(481.36, -982.14, 41.01),
				SpawnPoints = {
					{ coords = vector3(449.57, -981.24, 43.69), heading = 92.6, radius = 10.0 }
				}
			}
		},
		BossActions = {
			vector3(448.4, -973.2, 30.6)
		}

	}

}

Config.AuthorizedWeapons = {
	recruit = {
		--{ weapon = 'WEAPON_APPISTOL', components = { 0, 0, 1000, 4000, nil }, price = 10000 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 1500 },
		{ weapon = 'WEAPON_PISTOL', price = 1500 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 80 }
	},

	officer = {
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0, 1000, 4000, nil }, price = 1000 },
		{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 0, 6000, 1000, 4000, 8000, nil }, price = 2000 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 500 },
		--{ weapon = 'WEAPON_BZGAS', price = 500 },
		{ weapon = 'WEAPON_SMG', price = 500 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }
	},

	sergeant = {
		--{ weapon = 'WEAPON_APPISTOL', components = { 0, 0, 1000, 4000, nil }, price = 1000 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 6000, 1000, 4000, 8000, nil }, price = 3000 },
		{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 2000, 6000, nil }, price = 2000 },
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0, 1000, 4000, nil }, price = 1000 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 500 },
		{ weapon = 'WEAPON_BZGAS', price = 500 },
		{ weapon = 'WEAPON_SMG', price = 500 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }
	},

	intendent = {
		{ weapon = 'WEAPON_SNIPERRIFLE', components = { 0, 0, 1000, 4000, nil }, price = 1000 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 6000, 1000, 4000, 8000, nil }, price = 3000 },
		{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 2000, 6000, nil }, price = 700 },
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0, 1000, 4000, nil }, price = 1000 },
	    { weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 500 },
		{ weapon = 'WEAPON_BZGAS', price = 500 },
		{ weapon = 'WEAPON_SMG', price = 500 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }

	},

	lieutenant = {
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0, 1000, 4000, nil }, price = 100 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 6000, 1000, 4000, 8000, nil }, price = 500 },
		{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 2000, 6000, nil }, price = 700 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_BZGAS', price = 500 },
		{ weapon = 'WEAPON_STUNGUN', price = 500 },
		{ weapon = 'WEAPON_SMG', price = 500 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }
	},

	chief = {
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0, 1000, 4000, nil }, price = 100 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 6000, 1000, 4000, 8000, nil }, price = 500 },
		{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 2000, 6000, nil }, price = 700 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 500 },
		{ weapon = 'WEAPON_SMG', price = 500 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }
	},

	boss = {
		{ weapon = 'WEAPON_SNIPERRIFLE', components = { 0, 0, 1000, 4000, nil }, price = 100 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 6000, 1000, 4000, 8000, nil }, price = 500 },
		{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 2000, 6000, nil }, price = 700 },
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0, 1000, 4000, nil }, price = 1000 },
	    { weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 500 },
		{ weapon = 'WEAPON_BZGAS', price = 500 },
		{ weapon = 'WEAPON_SMG', price = 500 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }
	}
}

Config.AuthorizedVehicles = {
	Shared = {
	        { model = 'rt1200', label = 'Moto 1', price = 100 },	
                { model = 'ypoli', label = 'Moto 2', price = 100 },
                { model = 'ghispo2', label = 'Maserati', price = 100 },
                { model = 'megan', label = 'Renault M', price = 100 },
                { model = 'skoda', label = 'Skoda', price = 100 },
                { model = 'sef_pfinder', label = 'Nissan P', price = 100 },
                { model = 'kuga', label = 'Ford K', price = 100 },
                { model = 'oastra', label = 'Opel A', price = 100 },
                { model = 'feverest', label = 'Ford F', price = 100 },
                { model = 'fdlctruck', label = 'Camión Anti-incendios', price = 100 },
                { model = 'mer02', label = 'Furgoneta Mercedes', price = 100 },
                { model = 'crafter', label = 'Furgoneta Wolkswagen', price = 100 },
                { model = 'c4mercury', label = 'Citroën', price = 100 },
                { model = 'bmwsla', label = 'BMW', price = 100 },
                { model = 'bmwtou', label = 'BMW', price = 100 },
                { model = 'polgtr', label = 'Secreta 1', price = 100 },
                { model = 'policer8', label = 'Secreta 2', price = 100 },
                { model = 'policesl', label = 'Secreta 3', price = 100 },
                { model = 'bestia', label = 'U.E.I.', price = 100 },
		{ model = 'police2', label = 'police', price = 100 },
		{ model = 'policegt350r', label = 'GT 350', price = 100 },
		{ model = '159atgc', label = 'Alfa Romeo', price = 100 },
		--{ model = 'asterope', label = 'Astra User', price = 100 },
		--{ model = 'sheriff', label = 'Policia Astra', price = 200 },
		--{ model = 'pbus', label = 'Police Prison Bus', price = 500 },
                --{ model = 'bmwtou', label = 'Bmw Guardia Civil', price = 500 },
		--{ model = 'policer8', label = 'AUDI R8', price = 20000 },
	},

	recruit = {

	},

	officer = {
		{ model = 'ghispo2', label = 'Maserati', price = 100 },
		{ model = 'sheriff2', label = 'Toyota LandCruiser', price = 100 },
	},

	sergeant = {
		{ model = 'ghispo2', label = 'Maserati', price = 100 },
		{ model = 'sheriff2', label = 'Toyota LandCruiser', price = 100 }
	},

	intendent = {

	},

	lieutenant = {
		{ model = 'ghispo2', label = 'Maserati', price = 100 },
		{ model = 'sheriff2', label = 'Toyota LandCruiser', price = 100 }
	},

	chief = {
		{ model = 'ghispo2', label = 'Maserati', price = 100 },
		{ model = 'sheriff2', label = 'Toyota LandCruiser', price = 100 }
	},

	boss = {
		{ model = 'ghispo2', label = 'Maserati', price = 100 },
		{ model = 'police2', label = 'Police', price = 100 },
		{ model = 'sheriff2', label = 'Toyota LandCruiser', price = 100 }
	}
}

Config.AuthorizedHelicopters = {
	recruit = {},

	officer = {},

	sergeant = {},

	intendent = {},

	lieutenant = {
		{ model = 'swift', label = 'Helicoptero 1', livery = 0, price = 1000 },
		{ model = 'supervolito', label = 'Helicoptero 2', livery = 0, price = 1000 }
	},

	chief = {
		{ model = 'swift', label = 'Helicoptero 1', livery = 0, price = 1000 },
		{ model = 'supervolito', label = 'Helicoptero 2', livery = 0, price = 1000 }
	},

	boss = {
		{ model = 'swift', label = 'Helicoptero 1', livery = 0, price = 1000 },
		{ model = 'supervolito', label = 'Helicoptero 2', livery = 0, price = 1000 }
	}
}

-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

Config.Uniforms = {
	recruit_wear = {
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 19,
			['pants_1'] = 35,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 46,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	officer_wear = {
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 19,
			['pants_1'] = 35,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 46,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	sergeant_wear = {
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 19,
			['pants_1'] = 35,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 46,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	intendent_wear = {
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 19,
			['pants_1'] = 35,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 46,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	lieutenant_wear = { -- currently the same as intendent_wear
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 19,
			['pants_1'] = 35,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 46,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	chef_wear = {
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 19,
			['pants_1'] = 35,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 46,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	boss_wear = { -- currently the same as chef_wear
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 19,
			['pants_1'] = 35,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 46,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	bullet_wear = {
		male = {
			['bproof_1'] = 11,  ['bproof_2'] = 1
		},
		female = {
			['bproof_1'] = 13,  ['bproof_2'] = 1
		}
	},
	gilet_wear = {
		male = {
			['tshirt_1'] = 59,  ['tshirt_2'] = 1
		},
		female = {
			['tshirt_1'] = 36,  ['tshirt_2'] = 1
		}
	}

}
