Config                            = {}

Config.DrawDistance               = 100.0
Config.MarkerColor                = { r = 102, g = 0, b = 102 }
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 1.0 }
Config.ReviveReward               = 1000  -- revive reward, set to 0 if you don't want it enabled
Config.AntiCombatLog              = true -- enable anti-combat logging?
Config.LoadIpl                    = true -- disable if you're using fivem-ipl or other IPL loaders
Config.Locale = 'es'

local second = 1000
local minute = 60 * second

-- How much time before auto respawn at hospital
Config.RespawnDelayAfterRPDeath   = 5 * minute

-- How much time before a menu opens to ask the player if he wants to respawn at hospital now
-- The player is not obliged to select YES, but he will be auto respawn
-- at the end of RespawnDelayAfterRPDeath just above.
Config.RespawnToHospitalMenuTimer   = true
Config.MenuRespawnToHospitalDelay   = 5 * minute

Config.EnablePlayerManagement       = true
Config.EnableSocietyOwnedVehicles   = false

Config.RemoveWeaponsAfterRPDeath    = true
Config.RemoveCashAfterRPDeath       = true
Config.RemoveItemsAfterRPDeath      = true

-- Will display a timer that shows RespawnDelayAfterRPDeath time remaining
Config.ShowDeathTimer               = true

-- Will allow to respawn at any time, don't use with RespawnToHospitalMenuTimer enabled!
Config.EarlyRespawn                 = false
-- The player can have a fine (on bank account)
Config.RespawnFine                  = false
Config.RespawnFineAmount            = 150

Config.Blip = {
	Pos     = { x = -385.8792, y = 6124.595, z = 30.6475 },
	Sprite  = 61,
	Display = 4,
	Scale   = 1.2,
	Colour  = 2,
}

Config.HelicopterSpawner = {
	SpawnPoint = { x = -359.54, y = 6117.72, z = 37.8 }, 
	Heading    = 0.0
}

-- https://wiki.fivem.net/wiki/Vehicles
Config.AuthorizedVehicles = {

	{
		model = 'sprinter1',
		label = 'Ambulancia Cruz Roja [Enfermero]'
	},
	    {
		model = 'ambulance22',
		label = 'Ambulancia [Enfermero]'
	},  
	    {
		model = 'inem_vwcrafter',
		label = 'Volswagen [Técnico]'
	}, 
	    {
		model = 'fk22',
		label = 'Peugeot [Técnico]'  
	},
        {
		model = 'mini',
		label = 'Smart [Técnico]'
	}, 
	    {
		model = 'ems_gs1200',
		label = 'Moto BMW [Técnico]'
	}, 
	    {
		model = 'anpc_l200',
		label = 'Mitsubishi [Técnico]'  
	},	
	{
		model = 'sheriffx6',
		label = 'BMW X6 [Técnico]'  
	},	
        {
		model = 'polmp4',
		label = 'McLaren [Médico]'  
	},
	    {
		model = 'pol718',
		label = 'Porsche [Médico]'  
	},
	    {
		model = 'hcampana',
		label = 'Campaña de sangre [Doctor]'  
	},
	    {
		model = 'polaventa',
		label = 'Lamborghini [Subjefe]'  
	},
    	{
		model = 'f150',
		label = 'Ford Raptor [Forense]'
	}, 
	
    	


}

Config.Zones = {

	HospitalInteriorEntering1 = { -- Main entrance
		Pos	= { x = -381.5482, y = 6120.42, z = 30.05895 },
		Type = 1
	},

	HospitalInteriorInside1 = {
		Pos	= { x = 272.8, y = -1358.8, z = 23.5 },
		Type = -1
	},

	HospitalInteriorOutside1 = {
		Pos	= { x = -385.8792, y = 6124.595, z = 30.6475 },
		Type = -1
	},

	HospitalInteriorExit1 = {
		Pos	= { x = 275.7, y = -1361.5, z = 23.5 },
		Type = 1
	},

	HospitalInteriorEntering2 = { -- Lift go to the roof
		Pos	= { x = 247.1, y = -1371.4, z = 23.5 },
		Type = 1
	},

	HospitalInteriorInside2 = { -- Roof outlet
		Pos	= { x = 333.1,	y = -1434.9, z = 45.5 },
		Type = -1
	},

	HospitalInteriorOutside2 = { -- Lift back from roof
		Pos	= { x = 249.1,	y = -1369.6, z = 23.5 },
		Type = -1
	},

	HospitalInteriorExit2 = { -- Roof entrance
		Pos	= { x = 335.5, y = -1432.0, z = 45.5 },
		Type = 1
	},

	AmbulanceActions = { -- Cloakroom
		Pos	= { x = 268.4, y = -1363.330, z = 23.5 },
		Type = 1
	},

	VehicleSpawner = {
		Pos	= { x = -372.8583, y = 6084.431, z = 30.6221 },
		Type = 1
	},

	VehicleSpawnPoint = {
		Pos	= { x = -368.4586, y = 6090.578, z = 30.68146 },
		Type = -1
	},

	VehicleDeleter = {
		Pos	= { x = -379.0638, y = 6095.116, z = 30.68146 },
		Type = 1
	},

	Pharmacy = {
		Pos	= { x = 269.7, y = -1360.44, z = 23.6 },
		Type = 1
	},

	ParkingDoorGoOutInside = {
		Pos	= { x = 234.56, y = -1373.77, z = 20.97 },
		Type = 1
	},

	ParkingDoorGoOutOutside = {
		Pos	= { x = 320.98, y = -1478.62, z = 28.81 },
		Type = -1
	},

	ParkingDoorGoInInside = {
		Pos	= { x = 238.64, y = -1368.48, z = 23.53 },
		Type = -1
	},

	ParkingDoorGoInOutside = {
		Pos	= { x = 317.97, y = -1476.13, z = 28.97 },
		Type = 1
	},

	StairsGoTopTop = {
		Pos	= { x = 251.91, y = -1363.3, z = 38.53 },
		Type = -1
	},

	StairsGoTopBottom = {
		Pos	= { x = 237.45, y = -1373.89, z = 26.30 },
		Type = -1
	},

	StairsGoBottomTop = {
		Pos	= { x = 256.58, y = -1357.7, z = 37.30 },
		Type = -1
	},

	StairsGoBottomBottom = {
		Pos	= { x = 235.45, y = -1372.89, z = 26.30 },
		Type = -1
	}

}

