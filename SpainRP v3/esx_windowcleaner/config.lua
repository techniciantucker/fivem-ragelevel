Config                            = {}
Config.DrawDistance               = 100.0
Config.nameJob                    = "windowcleaner"
Config.nameJobLabel               = "LimpiaCristales"
Config.platePrefix                = "LC"
Config.Locale                     = 'en'

Config.Blip = {
    Sprite = 384,
    Color = 1
}

Config.Vehicles = {
	Truck = {
		Spawner = 1,
		Label = 'Vehiculo de trabajo',
		Hash = "Speedo",
		Livery = 0,
		Trailer = "none",
	},
}

Config.Zones = {

  Cloakroom = {
    Pos     = {x = -239.12, y = -1397.83, z = 30.38},
    Size    = {x = 1.5, y = 1.5, z = 0.6},
    Color   = {r = 255, g = 5, b = 5},
    Type    = 1,
	BlipSprite = 72,
	BlipColor = 1,
	BlipName = Config.nameJobLabel..": Vestuario",
	hint = 'Presiona ~INPUT_CONTEXT~ para acceder al vestuario',
  },

  VehicleSpawner = {
	Pos   = {x = -235.45, y = -1381.88, z = 30.35},
	Size  = {x = 3.0, y = 3.0, z = 0.9},
	Color = {r = 255, g = 5, b = 5},
	Type  = 1,
	BlipSprite = 72,
	BlipColor = 1,
	BlipName = Config.nameJobLabel..": Garaje",
	hint = 'Presiona ~INPUT_CONTEXT~ para acceder al garaje',
  },

  VehicleSpawnPoint = {
	Pos   = {x = -235.09, y = -1391.78, z = 30.29},
	Size  = {x = 3.0, y = 3.0, z = 1.0},
	Type  = -1,
	Heading = 191.17,
  },

  VehicleDeleter = {
	Pos   = {x = -218.02, y = -1378.89, z = 30.26},
	Size  = {x = 3.0, y = 3.0, z = 0.9},
	Color = {r = 255, g = 5, b = 5},
	Type  = 1,
	BlipSprite = 72,
	BlipColor = 1,
	BlipName = Config.nameJobLabel..": Guardar vehiculo",
	hint = 'Presiona ~INPUT_CONTEXT~ para guardar el vehiuculo',
  },
  
  Vente = {
	Pos   = {x = -229.74, y = -1377.07, z = 30.26},
	Size  = {x = 3.0, y = 3.0, z = 0.8},
	Color = {r = 255, g = 5, b = 5},
	Type  = 1,
	BlipSprite = 72,
	BlipColor = 1,
	BlipName = Config.nameJobLabel..": Facturacion",

	ItemTime = 600,
	ItemDb_name = "receipt",
	ItemName = "W.C receipt",
	ItemMax = 100,
	ItemAdd = 1,
	ItemRemove = 1,
	ItemRequires = "receipt",
	ItemRequires_name = "Factura de limpiacristales",
	ItemDrop = 100,
	ItemPrice  = 220,
	hint = 'Presiona ~INPUT_CONTEXT~ para cobrar por los servicios',
  },
  
}

Config.Windows = {

{ [ 'x' ] = -60.15, [ 'y' ] =  -1099.29, [ 'z' ] = 26.43 }, 
{ [ 'x' ] = 151.61, [ 'y' ] = -1037.49, [ 'z' ] = 29.34},
{ [ 'x' ] = 434.37, [ 'y' ] = -984.01, [ 'z' ] = 30.71},
{ [ 'x' ] = 418.08, [ 'y' ] = -807.11, [ 'z' ] = 29.41},
{ [ 'x' ] = 299.79, [ 'y' ] = -583.31, [ 'z' ] = 43.26},
{ [ 'x' ] = 355.84, [ 'y' ] = -594.73, [ 'z' ] = 28.78},
{ [ 'x' ] = 1141.54, [ 'y' ] = -980.99, [ 'z' ] = 46.41},
{ [ 'x' ] = -21.69, [ 'y' ] = -106.83, [ 'z' ] = 57.06},
{ [ 'x' ] = -58.03, [ 'y' ] = -91.51, [ 'z' ] = 57.76},
{ [ 'x' ] = 81.81, [ 'y' ] = 274.74, [ 'z' ] = 110.21},
{ [ 'x' ] = 150.38, [ 'y' ] = 237.95, [ 'z' ] = 106.91},
{ [ 'x' ] = 174.88, [ 'y' ] = 181.92, [ 'z' ] =	105.65},
{ [ 'x' ] = 374.11, [ 'y' ] = 323.33, [ 'z' ] = 103.48},
{ [ 'x' ] = 638.56, [ 'y' ] = 2.07, [ 'z' ] = 81.79},
{ [ 'x' ] = 930.63, [ 'y' ] = 42.89, [ 'z' ] = 81.1},
{ [ 'x' ] = 201.03, [ 'y' ] = 2438.24, [ 'z' ] = 60.44},
{ [ 'x' ] = 591.43, [ 'y' ] = 2744.83, [ 'z' ] = 42.04},
{ [ 'x' ] = 547.42, [ 'y' ] = 2673.52, [ 'z' ] = 42.18},
{ [ 'x' ] = 732.47, [ 'y' ] = 2523.81, [ 'z' ] = 73.37},
{ [ 'x' ] = 1166.37, [ 'y' ] = 2703.3, [ 'z' ] = 38.18},
{ [ 'x' ] = 1175.24, [ 'y' ] = 2703.21, [ 'z' ] = 38.17},
{ [ 'x' ] = 1197.82, [ 'y' ] = 2702.69, [ 'z' ] = 38.16},
{ [ 'x' ] = 1228.92, [ 'y' ] = 2727.53, [ 'z' ] = 38.0},
{ [ 'x' ] = 1855.33, [ 'y' ] = 3683.07, [ 'z' ] = 34.27},
{ [ 'x' ] = 1903.41, [ 'y' ] = 3708.34, [ 'z' ] = 32.73},
{ [ 'x' ] = 1965.59, [ 'y' ] = 3740.39, [ 'z' ] = 32.33},
{ [ 'x' ] = -443.13, [ 'y' ] = 6016.38, [ 'z' ] = 31.71},
{ [ 'x' ] = -111.16, [ 'y' ] = 6462.81, [ 'z' ] = 31.64},
--{ [ 'x' ] = 000.000, [ 'y' ] = 000.000, [ 'z' ] = 000.000	}, to add more use this template REMEMBER EACH ONE NEED TO HAVE A COMMA  even the last one  
}

for i=1, #Config.Windows, 1 do

    Config.Zones['Window' .. i] = {
        Pos   = Config.Windows[i],
        Size  = {x = 1.5, y = 1.5, z = 1.0},
        Color = {r = 204, g = 204, b = 0},
        Type  = -1
    }

end

Config.Uniforms = {

  job_wear = {
    male = {
        ['tshirt_1'] = 15, ['tshirt_2'] = 0,
		['torso_1'] = 146, ['torso_2'] = 1,
		['decals_1'] = 0, ['decals_2'] = 0,
		['arms'] = 63,
		['pants_1'] = 47, ['pants_2'] = 0,
		['shoes_1'] = 73, ['shoes_2'] = 4,
		['helmet_1'] = -1, ['helmet_2'] = 0,
		['chain_1'] = 0, ['chain_2'] = 0,
		['ears_1'] = -1, ['ears_2'] = 0,
		['mask_1'] = -1, ['mask_2'] = 0,
		['ears_1'] = -1, ['ears_2'] = 0,
		['bproof_1'] = 0, ['bproof_2'] = 0,
    },
    female = {
        ['tshirt_1'] = 15, ['tshirt_2'] = 0,
		['torso_1'] = 49, ['torso_2'] = 0,
		['decals_1'] = 0, ['decals_2'] = 0,
		['arms'] = 14,
		['pants_1'] = 11, ['pants_2'] = 0,
		['shoes_1'] = 73, ['shoes_2'] = 4,
		['helmet_1'] = -1, ['helmet_2'] = 0,
		['chain_1'] = 0, ['chain_2'] = 0,
		['ears_1'] = -1, ['ears_2'] = 0,
		['mask_1'] = -1, ['mask_2'] = 0,
		['ears_1'] = -1, ['ears_2'] = 0,
		['bproof_1'] = 0, ['bproof_2'] = 0,

    }
  },
}
