Config = {}
Config.Blip			= {sprite= 357, color = 30}
Config.BoatBlip		= {sprite= 356, color = 30}
Config.AirplaneBlip	= {sprite= 359, color = 30}
Config.MecanoBlip	= {sprite= 357, color = 26}
Config.Price		= 500 -- pound price to get vehicle back
Config.SwitchGaragePrice		= 2000 -- price to pay to switch vehicles in garage
Config.StoreOnServerStart = true -- Store all vehicles in garage on server start?

Config.Garages = {
	Central = {
		Pos = {x=215.800, y=-810.057, z=30.727},
		Marker = { w= 1.5, h= 1.0,r = 204, g = 204, b = 0},
		Name = 'Garaje Central',
		HelpPrompt = "Presiona ~INPUT_PICKUP~ para recuperar tu vehiclo",
		SpawnPoint = {
			Pos = {x=229.700, y= -800.1149, z= 30.5722},
			Heading = 160.0,
			Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
			HelpPrompt = "Presiona ~INPUT_PICKUP~ para sacar tu vehiculo"
		},
		DeletePoint = {
			Pos = {x=215.124, y=-791.377, z=30.946},
			Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
			HelpPrompt = "Presiona ~INPUT_PICKUP~ para guardar tu vehiclo"
		}, 	
	},
	Central2 = {
		Pos = {x = -1523.191,y = -451.017,z = 35.596},
		Marker = { w= 1.5, h= 1.0,r = 204, g = 204, b = 0},
		Name = 'Garaje Centra 2',
		HelpPrompt = "Presiona ~INPUT_PICKUP~ para recuperar tu vehiclo",
		SpawnPoint = {
			Pos = {x = -1519.22,y = -434.582,z = 35.442},
			Heading = 160.0,
			Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
			HelpPrompt = "Presiona ~INPUT_PICKUP~ para sacar tu vehiculo"
		},
		DeletePoint = {
			Pos = {x = -1528.022,y = -443.280,z = 35.442},
			Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
			HelpPrompt = "Presiona ~INPUT_PICKUP~ para guardar tu vehiclo"
		}, 	
	},
	Paleto = {
		Pos = {x=105.359, y=6613.586, z=32.3973},
		Marker = { w= 1.5, h= 1.0,r = 204, g = 204, b = 0},
		Name = 'Garaje Paleto',
		HelpPrompt = "Presiona ~INPUT_PICKUP~ para recuperar tu vehiclo",
		SpawnPoint = {
			Pos = {x=128.7822, y= 6622.9965, z= 31.7828},
			Heading = 160.0,
			Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
			HelpPrompt = "Presiona ~INPUT_PICKUP~ para sacar tu vehiculo"
		},
		DeletePoint = {
			Pos = {x=126.3572, y=6608.4150, z=31.8565},
			Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
			HelpPrompt = "Presiona ~INPUT_PICKUP~ para guardar tu vehiclo"
		}, 	
	},
	SandyShore = {
		Pos = {x=1694.571, y=3610.924, z=35.319},
		Marker = { w= 1.5, h= 1.0,r = 204, g = 204, b = 0},
		Name = 'Garaje SandyShore',
		HelpPrompt = "Presiona ~INPUT_PICKUP~ para recuperar tu vehiclo",
		SpawnPoint = {
			Pos = {x=1713.492, y= 3598.938, z= 35.338},
			Heading = 160.0,
			Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
			HelpPrompt = "Presiona ~INPUT_PICKUP~ para sacar tu vehiculo"
		},
		DeletePoint = {
			Pos = {x = 1695.156,y = 3601.061,z = 35.530},
			Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
			HelpPrompt = "Presiona ~INPUT_PICKUP~ para guardar tu vehiclo"
		}, 	
	},
	Ocean1 = {
		Pos = {x = -3140.323,y = 1124.463,z = 20.706},
		Marker = { w= 1.5, h= 1.0,r = 204, g = 204, b = 0},
		Name = 'Garaje Ocean 1',
		HelpPrompt = "Presiona ~INPUT_PICKUP~ para recuperar tu vehiclo",
		SpawnPoint = {
			Pos = {x = -3132.638,y = 1126.662,z = 20.667},
			Heading = 160.0,
			Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
			HelpPrompt = "Presiona ~INPUT_PICKUP~ para sacar tu vehiculo"
		},
		DeletePoint = {
			Pos = {x = -3136.902,y = 1102.685,z = 20.654},
			Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
			HelpPrompt = "Presiona ~INPUT_PICKUP~ para guardar tu vehiclo"
		}, 	
	},
	Ocean2 = {
		Pos = {x = -2982.561,y = 327.506,z = 14.935},
		Marker = { w= 1.5, h= 1.0,r = 204, g = 204, b = 0},
		Name = 'Garaje Ocean2',
		HelpPrompt = "Presiona ~INPUT_PICKUP~ para recuperar tu vehiclo",
		SpawnPoint = {
			Pos = {x = -2977.238,y = 337.777,z = 14.768},
			Heading = 160.0,
			Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
			HelpPrompt = "Presiona ~INPUT_PICKUP~ para sacar tu vehiculo"
		},
		DeletePoint = {
			Pos = {x = -2971.814,y = 355.331,z = 14.771},
			Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
			HelpPrompt = "Presiona ~INPUT_PICKUP~ para guardar tu vehiclo"
		}, 	
	},
	Sud = {
		Pos = {x = 443.6696,y = -1969.4372,z = 24.401},
		Marker = { w= 1.5, h= 1.0,r = 204, g = 204, b = 0},
		Name = 'Garaje Sud',
		HelpPrompt = "Presiona ~INPUT_PICKUP~ para recuperar tu vehiclo",
		SpawnPoint = {
			Pos = {x = 437.8140,y = -1958.572,z = 22.957},
			Heading = 182.0,
			Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
			HelpPrompt = "Presiona ~INPUT_PICKUP~ para sacar tu vehiculo"
		},
		DeletePoint = {
			Pos = {x = 457.91,y = -1971.343,z = 22.553},
			Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
			HelpPrompt = "Presiona ~INPUT_PICKUP~ para guardar tu vehiclo"
		}, 	
	},
	Lake = {
		Pos = {x = -73.165504455566,y = 908.08734130859,z = 235.62712097168 },
		Marker = { w= 1.0, h= 1.0,r = 204, g = 204, b = 0},
		Name = 'Garaje Lake',
		HelpPrompt = "Presiona ~INPUT_PICKUP~ para recuperar tu vehiclo",
		SpawnPoint = {
			Pos = {x = -72.099822998047,y = 902.85479736328,z = 235.63186645508 },
			Heading = 134.409,
			Marker = { w= 1.0, h= 1.0,r=0,g=255,b=0},
			HelpPrompt = "Presiona ~INPUT_PICKUP~ para sacar tu vehiculo"
		},
		DeletePoint = {
			Pos = {x = -66.987632751465,y = 891.65881347656,z = 235.55270385742 },
			Marker = { w= 1.0, h= 1.0,r=255,g=0,b=0},
			HelpPrompt = "Presiona ~INPUT_PICKUP~ para guardar tu vehiclo"
		}, 	
	},
	Occaz = {
		Pos = {x = 1136.3771972656,y = 2666.6303710938,z = 38.013275146484 },
		Marker = { w= 1.5, h= 1.0,r = 204, g = 204, b = 0},
		Name = 'Garaje Occaz',
		HelpPrompt = "Presiona ~INPUT_PICKUP~ para recuperar tu vehiclo",
		SpawnPoint = {
			Pos = {x = 1120.9813232422,y = 2668.8684082031,z = 38.048095703125 },
			Heading = 179.84,
			Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
			HelpPrompt = "Presiona ~INPUT_PICKUP~ para sacar tu vehiculo"
		},
		DeletePoint = {
			Pos = {x = 1121.9963378906,y = 2660.1179199219,z = 37.996875762939 },
			Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
			HelpPrompt = "Presiona ~INPUT_PICKUP~ para guardar tu vehiclo"
		}, 	
	},
	Groove = {
		Pos = {x = -69.514305114746,y = -1822.9477539063,z = 26.941974639893 },
		Marker = { w= 1.5, h= 1.0,r = 204, g = 204, b = 0},
		Name = 'Garaje Groove',
		HelpPrompt = "Presiona ~INPUT_PICKUP~ para recuperar tu vehiclo",
		SpawnPoint = {
			Pos = {x = -67.72095489502,y = -1835.7784423828,z = 26.883722305298 },
			Heading = 225.887,
			Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
			HelpPrompt = "Presiona ~INPUT_PICKUP~ para sacar tu vehiculo"
		},
		DeletePoint = {
			Pos = {x = -60.4020652771,y = -1829.5288085938,z = 26.836933135986 },
			Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
			HelpPrompt = "Presiona ~INPUT_PICKUP~ para guardar tu vehiclo"
		}, 	
	},
	Venise = {
		Pos = {x = -1081.974609375,y = -1254.1881103516,z = 5.4244246482849 },
		Marker = { w= 1.5, h= 1.0,r = 204, g = 204, b = 0},
		Name = 'Garaje Venise',
		HelpPrompt = "Presiona ~INPUT_PICKUP~ para recuperar tu vehiculo",
		SpawnPoint = {
			Pos = {x = -1077.2590332031,y = -1239.3200683594,z = 5.161093711853 },
			Heading = 144.887,
			Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
			HelpPrompt = "Presiona ~INPUT_PICKUP~ para sacar tu vehiculo"
		},
		DeletePoint = {
			Pos = {x = -1097.2971191406,y = -1253.8725585938,z = 5.2441983222961 },
			Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
			HelpPrompt = "Presiona ~INPUT_PICKUP~ para guardar tu vehiculo"
		}, 	
	},
	Tequila = {
		Pos = {x = -575.66357421875,y = 318.41366577148,z = 84.614906311035 },
		Marker = { w= 1.5, h= 1.0,r = 204, g = 204, b = 0},
		Name = 'Garaje Tequila',
		HelpPrompt = "Presiona ~INPUT_PICKUP~ para recuperar tu vehiculo",
		SpawnPoint = {
			Pos = {x = -569.47564697266,y = 323.53549194336,z = 84.474433898926 },
			Heading = 22.52,
			Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
			HelpPrompt = "Presiona ~INPUT_PICKUP~ para guardar tu vehiculo"
		},
		DeletePoint = {
			Pos = {x = -560.84375,y = 322.41586303711,z = 84.402587890625 },
			Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
			HelpPrompt = "Presiona ~INPUT_PICKUP~ para recuperar tu vehiculo"
		}, 	
	},
	Mirrorpark = {
		Pos = {x = 1033.9229736328,y = -767.10662841797,z = 58.003326416016 },
		Marker = { w= 1.5, h= 1.0,r = 204, g = 204, b = 0},
		Name = 'Garaje Mirrorpark',
		HelpPrompt = "Presiona ~INPUT_PICKUP~ para recuperar tu vehiculo",
		SpawnPoint = {
			Pos = {x = 1040.6834716797,y = -778.18170166016,z = 58.022853851318 },
			Heading = 359.92,
			Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
			HelpPrompt = "Presiona ~INPUT_PICKUP~ para sacar tu vehiculo"
		},
		DeletePoint = {
			Pos = {x = 1022.7816772461,y = -763.78955078125,z = 57.961227416992 },
			Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
			HelpPrompt = "Presiona ~INPUT_PICKUP~ para guardar tu vehiculo"
		}, 	
	},
	Garaje_LosHijosdeAgapito = {
		Pos = {x = -1157.17,y = -2009.06,z = 12.17 },
		Marker = { w= 1.5, h= 1.0,r = 204, g = 204, b = 0},
		Name = 'Los Hijos De Agapito',
		HelpPrompt = "Presiona ~INPUT_PICKUP~ para recuperar tu vehiclo",
		Functionmenu = OpenMenuGarage,
		SpawnPoint = {
			Pos = {x = -1130.44,y = -2000.59,z = 12.17 },
			Heading = 264.63,
			Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
			HelpPrompt = "Presiona ~INPUT_PICKUP~ para sacar tu vehiculo",
			Functionmenu = ListVehiclesMenu,
		},
		DeletePoint = {
			Pos = {x = -1118.09,y = -2013.16,z = 12.19 },
			Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
			HelpPrompt = "Presiona ~INPUT_PICKUP~ para guardar tu vehiculo",
			Functionmenu = StockVehicleMenu,
		}, 	
	},
	-- Garage_YouTool = {
		-- Pos = {x = 2709.8679199219,y = 3455.1743164063,z = 56.317573547363 },
		-- Marker = { w= 1.5, h= 1.0,r = 204, g = 204, b = 0},
		-- Name = 'Garage',
		-- HelpPrompt = "Appuyer sur ~INPUT_PICKUP~ pour ouvrir le garage",
		-- Functionmenu = OpenMenuGarage,
		-- SpawnPoint = {
			-- Pos = {x = 2691.1271972656,y = 3454.1496582031,z = 55.785736083984 },
			-- Heading = 239.90,
			-- Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
			-- HelpPrompt = "Appuyer sur ~INPUT_PICKUP~ pour sortir votre véhicule",
			-- Functionmenu = ListVehiclesMenu,
		-- },
		-- DeletePoint = {
			-- Pos = {x = 2702.1945800781,y = 3454.7746582031,z = 55.667736053467 },
			-- Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
			-- HelpPrompt = "Appuyer sur ~INPUT_PICKUP~ pour rentrer votre véhicule",
			-- Functionmenu = StockVehicleMenu,
		-- }, 	
	-- },
}

Config.GaragesMecano = {
	Policia = {
		Name = 'Imputar Vehiculo',
		SpawnPoint = {
			Pos = {x = 449.253,y = -1024.322,z = 28.57},
			Heading = 100.0,
			Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
			HelpPrompt = "Presiona ~INPUT_PICKUP~ para meter el vehiculo en el deposito"
		},
		DeletePoint = {
			Pos = {x = 452.305,y = -996.752,z = 25.776},
			Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
			HelpPrompt = "Presiona ~INPUT_PICKUP~ para sacar el vehiculo del deposito"
		}, 	
	},
	-- Bennys2 = {
		-- Marker = 1,
		-- SpawnPoint = {
			-- Pos = {x=-190.455, y= -1290.654, z= 30.295},
			-- Color = {r=0,g=255,b=0},
			-- Size  = {x = 3.0, y = 3.0, z = 1.0},
			-- Marker = 1
		-- },
		-- DeletePoint = {
			-- Pos = {x=-190.379, y=-1284.667, z=30.233},
			-- Color = {r=255,g=0,b=0},
			-- Size  = {x = 3.0, y = 3.0, z = 1.0},
			-- Marker = 1
		-- }, 	
	-- },
}

Config.BoatGarages = {
	BoatGarage_Centre = {
		Pos = {x = -742.47064208984,y = -1332.4702148438,z = 1.59 },
		Marker = { w= 1.5, h= 2.0,r = 204, g = 204, b = 0},
		Name = 'Garaje Barcos',
		HelpPrompt = "Presiona ~INPUT_PICKUP~ para abrir el menu de barcos",
		SpawnPoint = {
			Pos = {x = -736.47064208984,y = -1342.4702148438,z = 0.40 },
			Heading = 230.0,
			Marker = { w= 1.5, h= 2.0,r=0,g=255,b=0},
			HelpPrompt = "Presiona ~INPUT_PICKUP~ para sacar tu barco"
		},
		DeletePoint = {
			Pos = {x = -740.06408691406,y = -1361.8474121094,z = 0.40 },
			Marker = { w= 3.5, h= 2.0,r=255,g=0,b=0},
			HelpPrompt = "Presiona ~INPUT_PICKUP~ para guardar el barco"
		}, 	
	},
}

Config.AirplaneGarages = {
	AirplaneGarage_Centre = {
		Pos = {x = -1264.6,y = -3387.03,z = 13.940155029297 },
		Marker = { w= 1.5, h= 1.5,r = 204, g = 204, b = 0},
		Name = 'Garaje Aviones/Helicoteros',
		HelpPrompt = "Presiona ~INPUT_PICKUP~ para recuperar tu avion/helicoptero",
		SpawnPoint = {
			Pos = {x = -1280.1153564453,y = -3378.1647949219,z = 13.940155029297 },
			Heading = 160.0,
			Marker = { w= 1.5, h= 1.5,r=0,g=204,b=0},
			HelpPrompt = "Presiona ~INPUT_PICKUP~ para sacar tu avion/helicoptero"
		},
		DeletePoint = {
			Pos = {x = -1287.5788574219,y = -3390.4025878906,z = 13.940155029297 },
			Marker = { w= 1.5, h= 1.5,r=204,g=0,b=0},
			HelpPrompt = "Presiona ~INPUT_PICKUP~ para guardar el avion/helicoptero"
		}, 	
	},
	AirplaneGarage_Shandy = {
		Pos = {x = 1766.62,y = 3254.56,z = 41.72 },
		Marker = { w= 1.5, h= 1.5,r = 204, g = 204, b = 0},
		Name = 'Garaje Aviones/Helicoteros',
		HelpPrompt = "Presiona ~INPUT_PICKUP~ para recuperar tu avion/helicoptero",
		SpawnPoint = {
			Pos = {x = 1770.13,y = 3239.83,z = 42.12 },
			Heading = 160.0,
			Marker = { w= 1.5, h= 1.5,r=0,g=204,b=0},
			HelpPrompt = "Presiona ~INPUT_PICKUP~ para sacar tu avion/helicoptero"
		},
		DeletePoint = {
			Pos = {x = 1755.31,y = 3247.75,z = 41.06 },
			Marker = { w= 1.5, h= 1.5,r=204,g=0,b=0},
			HelpPrompt = "Presiona ~INPUT_PICKUP~ para guardar el avion/helicoptero"
		}, 	
	},
}