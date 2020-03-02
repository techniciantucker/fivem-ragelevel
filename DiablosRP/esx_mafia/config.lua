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
      { name = 'WEAPON_COMBATPISTOL',     price = 4000 },
      { name = 'WEAPON_ASSAULTSMG',       price = 15000 },
      { name = 'WEAPON_ASSAULTRIFLE',     price = 25000 },
      { name = 'WEAPON_ASSAULTSHOTGUN',      price = 9000 },
      { name = 'WEAPON_FLAREGUN',         price = 3000 },
      { name = 'GADGET_PARACHUTE',        price = 2000 },
      { name = 'WEAPON_SNIPERRIFLE',      price = 50000 },
      { name = 'WEAPON_FIREWORK',         price = 5000 },
      { name = 'WEAPON_SMOKEGRENADE',     price = 8000 },
      { name = 'WEAPON_HEAVYSNIPER',      price = 100000 },
      { name = 'WEAPON_STICKYBOMB',            price = 8000 },
	  { name = 'WEAPON_REVOLVER',         price = 6000 },
	 -- { name = 'WEAPON_POOLCUE',          price = 100 },
	  
    },

	  AuthorizedVehicles = {
		  { name = 'titan60',  label = 'Moto' },
		  { name = 'one77',      label = 'one77' },
		  { name = 'denalihd',      label = 'GMC Denali' },
		  { name = 'gmcyd',      label = 'GMC Yukon' },
		  { name = 'x6m',   label = 'BMW X6' },
	  },

    Cloakrooms = {
      { x = 9.283, y = 528.914, z = 169.635 },
    },

    Armories = {
      { x = 1.550, y = 527.397, z = 169.617 },
    },

    Vehicles = {
      {
        Spawner    = { x = 13.40, y = 549.1, z = 175.187 },
        SpawnPoint = { x = 8.237, y = 556.963, z = 175.266 },
        Heading    = 90.0,
      }
    },
	
	Helicopters = {
      {
        Spawner    = { x = 0.82, y = 533.68, z = 180.79 },
        SpawnPoint = { x = 3.40, y = 525.56, z = 177.919 },
        Heading    = 0.0,
      }
    },

    VehicleDeleters = {
      { x = 22.74, y = 545.9, z = 175.027 },
      { x = 21.35, y = 543.3, z = 175.027 },
    },

    BossActions = {
      { x = 4.113, y = 526.897, z = 173.628 }
    },

  },

}
