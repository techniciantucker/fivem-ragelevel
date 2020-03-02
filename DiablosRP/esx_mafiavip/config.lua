Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 1.0 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }
Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- only turn this on if you are using esx_identity
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableSocietyOwnedVehicles = false
Config.EnableLicenses             = false
Config.MaxInService               = -1
Config.Locale = 'en'

Config.MafiaStations = {

  Mafia = {

    Blip = {
      Pos     = { x = 425.130, y = -979.558, z = 30.711 },
      Sprite  = 60,
      Display = 4,
      Scale   = 1.2,
      Colour  = 29,
    },

    AuthorizedWeapons = {
      { name = 'WEAPON_VINTAGEPISTOL',       price = 40000  },
      { name = 'WEAPON_ASSAULTRIFLE',        price = 90000  },
      { name = 'WEAPON_MICROSMG',            price = 75000  },
     ---VIP
       { name = 'WEAPON_COMBATPDW',          price = 75000 },
       { name = 'WEAPON_COMPACTRIFLE',       price = 60000 },
       { name = 'WEAPON_ASSAULTSMG',         price = 90000 },
    ---VIP
     -- { name = 'WEAPON_PUMPSHOTGUN',      price = 100000 },
     -- { name = 'WEAPON_STUNGUN',          price = 50000 },
     -- { name = 'WEAPON_FLASHLIGHT',       price = 800 },
     -- { name = 'WEAPON_FIREEXTINGUISHER', price = 1200 },
     -- { name = 'WEAPON_FLAREGUN',         price = 500 },
      { name = 'GADGET_PARACHUTE',       price = 3000 },
      { name = 'WEAPON_BAT'		,          price = 700 },
     -- { name = 'WEAPON_STICKYBOMB',       price = 200000 },
    --   { name = 'WEAPON_SNIPERRIFLE',      price = 2200000 },
     -- { name = 'WEAPON_FIREWORK',         price = 30000 },
     -- { name = 'WEAPON_GRENADE',          price = 180000 },
     -- { name = 'WEAPON_BZGAS',            price = 120000 },
    --  { name = 'WEAPON_SMOKEGRENADE',     price = 100000 },
      { name = 'WEAPON_MACHINEPISTOL',        price = 80000 },
   --   { name = 'WEAPON_CARBINERIFLE',     price = 180000 },
    --   { name = 'WEAPON_HEAVYSNIPER',      price = 2000000 },
    --  { name = 'WEAPON_MINIGUN',          price = 700000 },
     -- { name = 'WEAPON_RAILGUN',          price = 2500000 },
    },

	  AuthorizedVehicles = {
		  { name = 'RAPTOR150',  label = 'RAPTOR150' },
		  { name = 'zn20',      label = 'zn20' },
      { name = 'cognoscenti2',      label = 'Vehículo Blindado' },
       --dubsta_3
      { name = 'redbullx1',      label = 'Red Bull F1' },
	  },

    Cloakrooms = {
      { x = -2674.25, y = 1304.75, z = 151.015 },
    },

    Armories = {
      { x = -2679.40, y = 1333.12, z = 139.88 },
    },

    Vehicles = {
      {
        Spawner    = { x = -2676.69, y = 1307.78, z = 146.16 },
        SpawnPoint = { x = -2671.24, y = 1305.24, z = 146.12 },
        Heading    = 263.38
      }
    },

	Helicopters = {
      {
        Spawner    = { x = 20.312, y = 535.667, z = 873.627 },
        SpawnPoint = { x = 3.40, y = 525.56, z = 577.919 },
        Heading    = 0.0,
      }
    },

    VehicleDeleters = {
      { x = -2669.13, y = 1309.49, z = 146.127 },
     -- { x = 21.35, y = 543.3, z = 175.027 },
    },

    BossActions = {
      { x = -2679.17, y = 1336.86, z = 151.03 }
    },

  },

}
