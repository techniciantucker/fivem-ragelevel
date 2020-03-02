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

Config.CartelStations = {

  Cartel = {

    Blip = {
--      Pos     = { x = 425.130, y = -979.558, z = 30.711 },
      Sprite  = 60,
      Display = 4,
      Scale   = 1.2,
      Colour  = 29,
    },

    AuthorizedWeapons = {
    --  { name = 'WEAPON_SAWNOFFSHOTGUN',       price = 9000 },
      { name = 'WEAPON_PISTOL50',     price = 30000 },
      { name = 'WEAPON_BULLPUPSHOTGUN',       price = 50000 },
      { name = 'WEAPON_COMPACTRIFLE',     price = 65000 },
     -- { name = 'WEAPON_PUMPSHOTGUN',      price = 600000 },
     -- { name = 'WEAPON_STUNGUN',          price = 50000 },
     -- { name = 'WEAPON_FLASHLIGHT',       price = 800 },
     -- { name = 'WEAPON_FIREEXTINGUISHER', price = 1200 },
     -- { name = 'WEAPON_FLAREGUN',         price = 6000 },
     -- { name = 'GADGET_PARACHUTE',        price = 3000 },
	   { name = 'WEAPON_BAT'		,        price = 3000 },
     -- { name = 'WEAPON_STICKYBOMB',       price = 200000 },
   --   { name = 'WEAPON_SNIPERRIFLE',      price = 2200000 },
     -- { name = 'WEAPON_FIREWORK',         price = 30000 },
     -- { name = 'WEAPON_GRENADE',          price = 180000 },
     -- { name = 'WEAPON_BZGAS',            price = 120000 },
    --  { name = 'WEAPON_SMOKEGRENADE',     price = 100000 },
      --{ name = 'WEAPON_APPISTOL',         price = 70000 },
      --{ name = 'WEAPON_CARBINERIFLE',     price = 1100000 },
   --   { name = 'WEAPON_HEAVYSNIPER',      price = 2000000 },
    --  { name = 'WEAPON_MINIGUN',          price = 700000 },
     -- { name = 'WEAPON_RAILGUN',          price = 2500000 },
    },

	  AuthorizedVehicles = {
		  { name = 'cognoscenti2',  label = 'Vehículo Blindado' },
		  { name = 'xt66',    label = 'Moto' },
		  { name = '18f350',   label = 'Ford 4X4' },
                  { name = 'rmodamgc63',   label = 'coche Jefe' },
                  { name = 'panamera',   label = 'panamera' },
		  { name = 'camry55',      label = 'Vehículo Civil' },
	  },

    Cloakrooms = {
      { x = 1397.46, y = 1164.63, z = 113.33},
    },

    Armories = {
      { x = 1402.22, y = 1132.18, z = 113.33},
    },

    Vehicles = {
      {
        Spawner    = { x =1413.80, y = 1115.58, z = 113.84 },
        SpawnPoint = { x = 1405.73, y = 1117.43, z = 114.84 },
        Heading    = 56.19,
      }
    },

    Helicopters = {
      {
        Spawner    = { x = 113.30500793457, y = -3109.3337402344, z = 6.0060696601868 },
        SpawnPoint = { x = 112.94457244873, y = -3102.5942382813, z = 6.0050659179688 },
        Heading    = 0.0,
      }
    },

    VehicleDeleters = {
      { x = 1374.46, y = 1124.31, z = 113.19 },
      { x = 1401.4, y = 1116.21, z = 113.84 },
      
    },

    BossActions = {
      { x = 1398.50, y =1157.04 , z = 113.33 },
    },

  },

}