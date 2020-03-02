Config                            = {}

Config.DrawDistance               = 100.0
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 0.5 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }

Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- enable if you're using esx_identity
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableLicenses             = true -- enable if you're using esx_license

Config.EnableHandcuffTimer        = true -- enable handcuff timer? will unrestrain player after the time ends
Config.HandcuffTimer              = 10 * 60000 -- 10 mins

Config.EnableJobBlip              = true -- enable blips for colleagues, requires esx_society

Config.MaxInService               = -1
Config.Locale                     = 'en'

Config.PoliceStations = {

	LSPD = {

		Blip = {
			Coords  = vector3(425.1, -979.5, 30.7),
			Sprite  = 60,
			Display = 4,
			Scale   = 1.2,
			Colour  = 29
		},

		Cloakrooms = {
			vector3(452.6, -992.8, 30.6)
		},

		Armories = {
			vector3(451.7, -980.1, 30.6)
		},

		Vehicles = {
			{
				Spawner = vector3(454.6, -1017.4, 28.4),
				InsideShop = vector3(228.5, -993.5, -99.5),
				SpawnPoints = {
					{ coords = vector3(438.4, -1018.3, 27.7), heading = 90.0, radius = 6.0 },
					{ coords = vector3(441.0, -1024.2, 28.3), heading = 90.0, radius = 6.0 },
					{ coords = vector3(453.5, -1022.2, 28.0), heading = 90.0, radius = 6.0 },
					{ coords = vector3(450.9, -1016.5, 28.1), heading = 90.0, radius = 6.0 }
				}
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
					{ coords = vector3(449.5, -981.2, 43.6), heading = 92.6, radius = 10.0 }
				}
			}
		},

		BossActions = {
			vector3(448.4, -973.2, 30.6)
		}

	},

	Norte = {

		Blip = {
			Coords  = vector3(1851.59, 3690.69, 33.27),
			Sprite  = 60,
			Display = 4,
			Scale   = 1.2,
			Colour  = 29
		},

		Cloakrooms = {
			vector3(1857.05, 3689.69, 33.27)
		},

		Armories = {
			vector3(1851.12, 3683.51, 33.27)
		},

		Vehicles = {
			{
				Spawner = vector3(1862.20, 3682.69, 32.78),
				InsideShop = vector3(228.5, -993.5, -99.5),
				SpawnPoints = {
					{ coords = vector3(1865.26, 3671.64, 32.85), heading = 116.32, radius = 6.0 },
					{ coords = vector3(1858.81, 3667.52, 33.0), heading = 122.84, radius = 6.0 }
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(1845.39, 3706.66, 32.63),
				InsideShop = vector3(477.0, -1106.4, 43.0),
				SpawnPoints = {
					{ coords = vector3(1841.15, 3714.78, 32.16), heading = 290.6, radius = 10.0 }
				}
			}
		},

		BossActions = {
			vector3(1851.59, 3690.69, 194.12)
		}

	}

}

Config.AuthorizedWeapons = {
	recruit = {
		{ weapon = 'WEAPON_PISTOL',  price = 100 },
		{ weapon = 'WEAPON_COMBATPISTOL',  price = 100 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }
	},

	officer = {
		{ weapon = 'WEAPON_PISTOL',  price = 100 },
		{ weapon = 'WEAPON_COMBATPISTOL',  price = 100 },
		{ weapon = 'WEAPON_PUMPSHOTGUN',  price = 100 },
		{ weapon = 'WEAPON_SMG',  price = 5000 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_BZGAS', price = 0 },
	},

	sergeant = {
		{ weapon = 'WEAPON_PISTOL',  price = 100 },
		{ weapon = 'WEAPON_COMBATPISTOL',  price = 100 },
		{ weapon = 'WEAPON_PUMPSHOTGUN',  price = 100 },
		{ weapon = 'WEAPON_SMG',  price = 5000 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_BZGAS', price = 0 },
	},

	lieutenant = {
		{ weapon = 'WEAPON_PISTOL',  price = 100 },
		{ weapon = 'WEAPON_COMBATPISTOL',  price = 100 },
		{ weapon = 'WEAPON_PUMPSHOTGUN',  price = 100 },
		{ weapon = 'WEAPON_SMG',  price = 5000 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_BZGAS', price = 0 },
	},

	lieutenantBoss = {
		{ weapon = 'WEAPON_PISTOL',  price = 100 },
		{ weapon = 'WEAPON_COMBATPISTOL',  price = 100 },
		{ weapon = 'WEAPON_PUMPSHOTGUN',  price = 100 },
		{ weapon = 'WEAPON_SMG',  price = 5000 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_BZGAS', price = 0 },
		{ weapon = 'WEAPON_MACHINEPISTOL', price = 0 },
	},

	subBoss = {
		{ weapon = 'WEAPON_PISTOL',  price = 100 },
		{ weapon = 'WEAPON_COMBATPISTOL',  price = 100 },
		{ weapon = 'WEAPON_PUMPSHOTGUN',  price = 100 },
		{ weapon = 'WEAPON_SMG',  price = 1000 },
		{ weapon = 'WEAPON_CARBINERIFLE',  price = 5000 },
		{ weapon = 'WEAPON_SNIPERRIFLE',  price = 5000 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_BZGAS', price = 0 },
		{ weapon = 'WEAPON_MACHINEPISTOL', price = 0 },
	},

	boss = {
		{ weapon = 'WEAPON_PISTOL',  price = 100 },
		{ weapon = 'WEAPON_COMBATPISTOL',  price = 100 },
		{ weapon = 'WEAPON_PUMPSHOTGUN',  price = 100 },
		{ weapon = 'WEAPON_SMG',  price = 1000 },
		{ weapon = 'WEAPON_CARBINERIFLE',  price = 1000 },
		{ weapon = 'WEAPON_SNIPERRIFLE',  price = 5000 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_BZGAS', price = 0 },
		{ weapon = 'WEAPON_MACHINEPISTOL', price = 0 },
	},
}

Config.AuthorizedVehicles = {
	Shared = {
		{ model = 'bf400c', label = 'Policia Nacional - Moto de campo', price = 10000 },
		{ model = 'pbus', label = 'Policia Nacional - Bus', price = 5000 },
		{ model = '18charger', label = 'Policia Nacional - Coche patrulla', price = 10000 },
		{ model = '18stealth', label = 'Policia Nacional - Coche secreta', price = 10000 },
		{ model = 'hellcat', label = 'Policia Nacional - Coche patrulla', price = 10000 },
		{ model = 'hellcat2', label = 'Policia Nacional - Coche secreta', price = 10000 }
	},

	recruit = {

	},

	officer = {
	},

	sergeant = {
	},

	lieutenantBoss = {

	},

	lieutenant = {
	},

	subBoss = {

	},

	boss = {

	}
}

Config.AuthorizedHelicopters = {
	recruit = {},

	officer = {
		{ model = 'polmav', label = 'Police Maverick', livery = 0, price = 100000 }
	},

	sergeant = {
		{ model = 'polmav', label = 'Police Maverick', livery = 0, price = 100000 }
	},

	lieutenant = {
		{ model = 'polmav', label = 'Police Maverick', livery = 0, price = 100000 }
	},

	lieutenantBoss = {
		{ model = 'polmav', label = 'Police Maverick', livery = 0, price = 100000 }
	},

	subBoss = {
		{ model = 'polmav', label = 'Police Maverick', livery = 0, price = 100000 }
	},

	boss = {
		{ model = 'polmav', label = 'Police Maverick', livery = 0, price = 100000 }
	}
}

-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

Config.Uniforms = {
	recruit_wear = {
		male = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 3,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['bproof_1'] = 24,  ['bproof_2'] = 9
		},
		female = {
			['tshirt_1'] = 36,  ['tshirt_2'] = 1,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = 45,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	officer_wear = {
		male = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 3,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['bproof_1'] = 24,  ['bproof_2'] = 9
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	sergeant_wear = {
		male = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 3,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['bproof_1'] = 24,  ['bproof_2'] = 9
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 1,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	intendent_wear = {
		male = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 3,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['bproof_1'] = 24,  ['bproof_2'] = 9
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 2,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	lieutenant_wear = { -- currently the same as intendent_wear
		male = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 3,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['bproof_1'] = 24,  ['bproof_2'] = 9,
			['ears_1'] = 0,     ['ears_2'] = 0,

		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 2,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	chef_wear = {
		male = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 3,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['bproof_1'] = 24,  ['bproof_2'] = 9,
			['ears_1'] = 0,     ['ears_2'] = 0,

		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 3,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	
	boss_wear = { -- currently the same as chef_wear
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 3,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 4,
			['pants_1'] = 10,   ['pants_2'] = 2,
			['shoes_1'] = 10,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['bproof_1'] = 24,  ['bproof_2'] = 9,
			['chain_1'] = 6,    ['chain_2'] = 1,
			['mask_1'] = 0,     ['mask_2'] = 0,
			['glasses_1'] = 0,  ['glasses_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,

		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 3,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['bproof_1'] = 24,  ['bproof_2'] = 9
		}
	},

	boss_wear_bullet_wear = { -- currently the same as chef_wear
		male = {
			['tshirt_1'] = 41,  ['tshirt_2'] = 0,
			['torso_1'] = 3,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 4,
			['pants_1'] = 10,   ['pants_2'] = 2,
			['shoes_1'] = 10,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['bproof_1'] = 24,  ['bproof_2'] = 9,
			['chain_1'] = 6,    ['chain_2'] = 1,
			['mask_1'] = 0,     ['mask_2'] = 0,
			['glasses_1'] = 0,  ['glasses_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,

		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 3,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['bproof_1'] = 24,  ['bproof_2'] = 9,
		}
	},

	bullet_wear = {
		male = {
			
		},
		female = {
			
		}
	},
	geos = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 49,   ['torso_2'] = 2,
			['decals_1'] = 3,   ['decals_2'] = 0,
			['arms'] = 17,
			['pants_1'] = 31,   ['pants_2'] = 2,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 75,  ['helmet_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['mask_1'] = 56,     ['mask_2'] = 1,
			['bproof_1'] = 16,  ['bproof_2'] = 0,
			['glasses_1'] = 24,  ['glasses_2'] = 2,
			['ears_1'] = -1,     ['ears_2'] = 0,

		},
		female = {
			['tshirt_1'] = 14,  ['tshirt_2'] = 0,
			['torso_1'] = 42,   ['torso_2'] = 2,
			['decals_1'] = 3,   ['decals_2'] = 0,
			['arms'] = 18,
			['pants_1'] = 30,   ['pants_2'] = 2,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 74,  ['helmet_2'] = 0,
			['chain_1'] = 81,    ['chain_2'] = 0,
			['mask_1'] = 52,     ['mask_2'] = 0,
			['bproof_1'] = 18,  ['bproof_2'] = 0,
			['glasses_1'] = 27,  ['glasses_2'] = 1,
			['ears_1'] = -1,     ['ears_2'] = 0,
			}
	},
	
	centauro = {
		male = {
			['tshirt_1'] = 53,  ['tshirt_2'] = 0,
			['torso_1'] = 93,   ['torso_2'] = 0,
			['arms'] = 30,
			['pants_1'] = 31,   ['pants_2'] = 2,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 16,  ['helmet_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['bproof_1'] = 12,  ['bproof_2'] = 3,
			['glasses_1'] = 0,  ['glasses_2'] = 0,
			['mask_1'] = 0,     ['mask_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
		},
		female = {
			['tshirt_1'] = 33,  ['tshirt_2'] = 0,
			['torso_1'] = 84,   ['torso_2'] = 0,
			['arms'] = 33,
			['pants_1'] = 61,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 16,  ['helmet_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['bproof_1'] = 7,  ['bproof_2'] = 0,
			['glasses_1'] = 5,  ['glasses_2'] = 0,
			['mask_1'] = 0,     ['mask_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
		}
	},
	
	uip = {
		male = {
			['tshirt_1'] = 53,  ['tshirt_2'] = 0,
			['torso_1'] = 49,   ['torso_2'] = 2,
			['arms'] = 17,
			['pants_1'] = 31,   ['pants_2'] = 2,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 125,  ['helmet_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['bproof_1'] = 12,  ['bproof_2'] = 3,
			['glasses_1'] = 0,  ['glasses_2'] = 0,
			['mask_1'] = 56,     ['mask_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
		},
		female = {
			['tshirt_1'] = 51,  ['tshirt_2'] = 0,
			['torso_1'] = 42,   ['torso_2'] = 2,
			['arms'] = 20,
			['pants_1'] = 30,   ['pants_2'] = 2,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 124,  ['helmet_2'] = 0,
			['chain_1'] = 81,    ['chain_2'] = 0,
			['bproof_1'] = 18,  ['bproof_2'] = 0,
			['glasses_1'] = 5,  ['glasses_2'] = 0,
			['mask_1'] = 52,     ['mask_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
		}
	},
	
	normal = {
		male = {
			['tshirt_1'] = 53,  ['tshirt_2'] = 0,
			['torso_1'] = 93,   ['torso_2'] = 0,
			['arms'] = 30,
			['pants_1'] = 59,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['bproof_1'] = 13,  ['bproof_2'] = 0,
			['glasses_1'] = 0,  ['glasses_2'] = 0,
			['mask_1'] = 0,     ['mask_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
		},
		female = {
			['tshirt_1'] = 51,  ['tshirt_2'] = 0,
			['torso_1'] = 84,   ['torso_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 61,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['bproof_1'] = 14,  ['bproof_2'] = 0,
			['glasses_1'] = 5,  ['glasses_2'] = 0,
			['mask_1'] = 0,     ['mask_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,		
		}
	},
	
	normal_wear_bullet_wear = {
			male = {
				['tshirt_1'] = 53,  ['tshirt_2'] = 0,
				['torso_1'] = 93,   ['torso_2'] = 0,
				['arms'] = 30,
				['pants_1'] = 59,   ['pants_2'] = 0,
				['shoes_1'] = 25,   ['shoes_2'] = 0,
				['helmet_1'] = -1,  ['helmet_2'] = 0,
				['chain_1'] = 1,    ['chain_2'] = 0,
				['bproof_1'] = 12,  ['bproof_2'] = 3,
				['glasses_1'] = 0,  ['glasses_2'] = 0,
				['mask_1'] = 0,     ['mask_2'] = 0,
				['decals_1'] = 0,   ['decals_2'] = 0,
				['ears_1'] = -1,     ['ears_2'] = 0,
			},
			female = {
				['tshirt_1'] = 51,  ['tshirt_2'] = 0,
				['torso_1'] = 84,   ['torso_2'] = 0,
				['arms'] = 44,
				['pants_1'] = 61,   ['pants_2'] = 0,
				['shoes_1'] = 25,   ['shoes_2'] = 0,
				['helmet_1'] = -1,  ['helmet_2'] = 0,
				['chain_1'] = 0,    ['chain_2'] = 0,
				['bproof_1'] = 7,  ['bproof_2'] = 0,
				['glasses_1'] = 5,  ['glasses_2'] = 0,
				['mask_1'] = 0,     ['mask_2'] = 0,
				['decals_1'] = 0,   ['decals_2'] = 0,
				['ears_1'] = -1,     ['ears_2'] = 0,	
			}
	},
	
	piloto = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 228,   ['torso_2'] = 19,
			['arms'] = 20,
			['pants_1'] = 92,   ['pants_2'] = 4,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 79,  ['helmet_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['glasses_1'] = 0,  ['glasses_2'] = 0,
			['mask_1'] = 0,     ['mask_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
		},
		female = {
			['tshirt_1'] = 2,  ['tshirt_2'] = 0,
			['torso_1'] = 238,   ['torso_2'] = 19,
			['arms'] = 20,
			['pants_1'] = 42,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 78,  ['helmet_2'] = 0,
			['chain_1'] = 29,    ['chain_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['glasses_1'] = 5,  ['glasses_2'] = 0,
			['mask_1'] = 0,     ['mask_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
		}
	},
	secreta = {
		male = {
			['tshirt_1'] = 116,  ['tshirt_2'] = 1,
			['torso_1'] = 208,   ['torso_2'] = 15,
			['arms'] = 19,
			['pants_1'] = 1,   ['pants_2'] = 5,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['bproof_1'] = 7,  ['bproof_2'] = 0,
			['glasses_1'] = 0,  ['glasses_2'] = 0,
			['mask_1'] = 121,     ['mask_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
		},
		female = {
			['tshirt_1'] = 67,  ['tshirt_2'] = 3,
			['torso_1'] = 107,   ['torso_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 0,   ['pants_2'] = 1,
			['shoes_1'] = 7,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 88,    ['chain_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['glasses_1'] = 5,  ['glasses_2'] = 0,
			['mask_1'] = 0,     ['mask_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
		}
	}
}
