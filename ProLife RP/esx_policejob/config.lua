Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 1.0 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }
Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = false
Config.EnableESXIdentity          = true -- only turn this on if you are using esx_identity
Config.EnableNonFreemodePeds      = true -- turn this on if you want custom peds
Config.EnableSocietyOwnedVehicles = false
Config.EnableLicenses             = true
Config.MaxInService               = 20
Config.Locale                     = 'es'

Config.PoliceStations = {

  Paleto = {

    Blip = {
      Pos     = {x = -449.16, y = 6012.32, z = 30.72},
      Sprite  = 60,
      Display = 4,
      Scale   = 1.2,
      Color   = 29,
    },

    AuthorizedWeapons = {
      { name = 'WEAPON_NIGHTSTICK',       price = 200 },
      { name = 'WEAPON_PISTOL',     price = 300 },
      { name = 'WEAPON_HEAVYPISTOL',     price = 300 },
      { name = 'WEAPON_COMBATPISTOL',     price = 300},
      { name = 'WEAPON_ASSAULTSMG',       price = 1250 },
      { name = 'WEAPON_SPECIALCARBINE',     price = 1500 },
      { name = 'WEAPON_COMBATPDW',          price = 1000},
      { name = 'WEAPON_STUNGUN',          price = 500 },
      { name = 'WEAPON_HEAVYSNIPER',     price = 1200},
      { name = 'WEAPON_FLASHLIGHT',       price = 80 },
      { name = 'GADGET_PARACHUTE',        price = 300 },
      { name = 'WEAPON_SMOKEGRENADE',        price = 300 },
    },

    AuthorizedVehicles = {
      { name = '',  label = '-> RECLUTA A AGENTE <-' },
      { name = 'feverest', label = '4X4 Ford' },
      { name = 'lrover', label = 'Range Rover 4x4' },
      { name = 'sef_pfinder', label = 'Nissan Pathfinder' },
      { name = 'kuga', label = 'Kuga' },
      { name = '',  label = '-> AGENTE 2ª A AGENTE 1ª <-' },
      { name = 'bmwtou', label = 'BMW Guardia Civil' },
      { name = 'skoda', label = 'Skoda Guardia Civil' },
      { name = 'mer02', label = 'Mercedes Vito' },
      { name = 'oastra', label = 'Opel Astra' },
      { name = 'megan', label = 'Megane' },
      { name = 'skoda', label = 'Skoda Guardia Civil' },
      { name = 'c414', label = 'Citroën C4' },
      { name = '',  label = '-> CABO A CABO 1ª <-' },
      { name = 'c4picasso', label = 'Citroën C4 Picasso 2009' },
      { name = '',  label = '-> CABO MAYOR A SARGENTO <-' },
      { name = 'c4mercury', label = 'Citroën C4 Picasso 2014' },
      { name = '',  label = '' },
      { name = '',  label = '-= ESPECIALIDADES =-' },
      { name = '',  label = '=> UNIDAD CENTRAL OPERATIVA <=' },
      { name = 'polgtr', label = 'GTR'},
      { name = 'policesl', label = 'BMW X5'},
      { name = 'policer8', label = 'Mustang'},
	  { name = 'supra_secreta', label = 'Supra'},
      { name = '',  label = '=> AGRUPACIÓN DE TRAFICO <=' },
      { name = 'rt1200', label = 'Moto BMW RT1200 Tráfico' },
      { name = 'sheriff',  label = 'Mercedes G' },
      { name = 'police2',  label = 'Mercedes CLA' },
      { name = '159atgc',  label = 'Alfa Romeo' },
      { name = 'mer03', label = 'Furgon Tráfico'},
      { name = 'sef_pfinder_atgc', label = '4x4 Tráfico'},
      { name = 'bmwsla', label = 'BMW trafico' },
      { name = '',  label = '=> GRUPO DE RESERVA Y SEGURIDAD <=' },
      { name = 'crafter', label = 'Volkswagen Crafter' },
      { name = 'fdlctruck', label = 'Bomba GRS' },
      { name = 'jumpy', label = 'Citroën Jumpy' },
      { name = '',  label = '=> UNIDAD ESPECIAL DE INTERVENCIÓN <=' },
      { name = 'elsantos', label = 'El Santos'},
      { name = 'bestia', label = 'Bestia U.E.I.'},
	  { name = '',  label = '=> JEFATURA <=' },
	  { name = 'ghispo2', label = 'Maseratti'}
    },

    Cloakrooms = {
      { x = -454.74, y = 6016.02, z = 30.54 },
    },

    Armories = {
      { x = -435.76, y = 5999.25, z = 30.68 },
    },

    Vehicles = {
      {
        Spawner    = { x = -474.4, y = 6037.68, z = 30.36 },
        SpawnPoint = { x = -474.36, y = 6023.8, z = 30.36 },
        Heading    = 90.0,
      }
    },

    Helicopters = {
      {
        Spawner    = { x = -470.6, y = 5988.6, z = 30.32 },
        SpawnPoint = { x = -479.96, y = 5983.96, z =31.08 },
        Heading    = 0.0,
      }
    },

    VehicleDeleters = {
      { x = -459.28, y = 6042.2, z = 30.36 },
      { x = 462.40, y = -1019.7, z = 27.104 },
    },

    BossActions = {
      { x = -449.16, y = 6012.32, z = 30.72 }
		}
	},
}
