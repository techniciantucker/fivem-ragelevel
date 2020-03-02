Config = {}
Config.Locale = 'en'

Config.DoorList = {

	--
	-- Mission Row First Floor
	--

	-- Entrance Doors
	{
		textCoords = vector3(434.7, -982.0, 31.5),
		authorizedJobs = { 'police' },
		locked = false,
		distance = 2.5,
		doors = {
			{
				objName = 'v_ilev_ph_door01',
				objYaw = -90.0,
				objCoords = vector3(434.7, -980.6, 30.8)
			},

			{
				objName = 'v_ilev_ph_door002',
				objYaw = -90.0,
				objCoords = vector3(434.7, -983.2, 30.8)
			}
		}
	},

	-- Back Doors
	{
		textCoords = vector3(445.97, -999.39, 31.15),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 2.5,
		doors = {
			{
				objName = 'v_ilev_gtdoor',
				objYaw = 0.0,
				objCoords = vector3(444.53, -999.4, 30.72)
			},

			{
				objName = 'v_ilev_gtdoor',
				objYaw = 180.0,
				objCoords = vector3(447.27, -999.7, 30.72)
			}
		}
	},


	-- To locker room & roof
	{
		objName = 'v_ilev_ph_gendoor004',
		objYaw = 90.0,
		objCoords  = vector3(449.6, -986.4, 30.6),
		textCoords = vector3(450.1, -986.3, 31.7),
		authorizedJobs = { 'police' },
		locked = true
	},

	-- Rooftop
	{
		objName = 'v_ilev_gtdoor02',
		objYaw = 90.0,
		objCoords  = vector3(464.3, -984.6, 43.8),
		textCoords = vector3(464.3, -984.0, 44.8),
		authorizedJobs = { 'police' },
		locked = true
	},

	-- Hallway to roof
	{
		objName = 'v_ilev_arm_secdoor',
		objYaw = 90.0,
		objCoords  = vector3(461.2, -985.3, 30.8),
		textCoords = vector3(461.5, -986.0, 31.5),
		authorizedJobs = { 'police' },
		locked = true
	},

	{
		objName = 'prop_facgate_07b',
		objYaw = 0.0,
		objCoords  = vector3(-180.1072, -1293.118, 30.31945),
		textCoords = vector3(-191.27, -1298.49, 31.3),
		authorizedJobs = { 'mechanic' },
		locked = true,
		distance = 12,
		size = 2
	},

	-- Armory
	{
		objName = 'v_ilev_arm_secdoor',
		objYaw = -90.0,
		objCoords  = vector3(452.6, -982.7, 30.6),
		textCoords = vector3(453.0, -982.6, 31.7),
		authorizedJobs = { 'police' },
		locked = true
	},

	-- Captain Office
	{
		objName = 'v_ilev_ph_gendoor002',
		objYaw = -180.0,
		objCoords  = vector3(447.2, -980.6, 30.6),
		textCoords = vector3(447.2, -980.0, 31.7),
		authorizedJobs = { 'police' },
		locked = true
	},

	-- To downstairs (double doors)
	{
		textCoords = vector3(444.6, -989.4, 31.7),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 4,
		doors = {
			{
				objName = 'v_ilev_ph_gendoor005',
				objYaw = 180.0,
				objCoords = vector3(443.9, -989.0, 30.6)
			},

			{
				objName = 'v_ilev_ph_gendoor005',
				objYaw = 0.0,
				objCoords = vector3(445.3, -988.7, 30.6)
			}
		}
	},

	--
	-- Mission Row Cells
	--

	-- Main Cells
	{
		objName = 'v_ilev_ph_cellgate',
		objYaw = 0.0,
		objCoords  = vector3(463.8, -992.6, 24.9),
		textCoords = vector3(463.3, -992.6, 25.1),
		authorizedJobs = { 'police' },
		locked = true
	},

	-- Cell 1
	{
		objName = 'v_ilev_ph_cellgate',
		objYaw = -90.0,
		objCoords  = vector3(462.3, -993.6, 24.9),
		textCoords = vector3(461.8, -993.3, 25.0),
		authorizedJobs = { 'police' },
		locked = true
	},

	-- Cell 2
	{
		objName = 'v_ilev_ph_cellgate',
		objYaw = 90.0,
		objCoords  = vector3(462.3, -998.1, 24.9),
		textCoords = vector3(461.8, -998.8, 25.0),
		authorizedJobs = { 'police' },
		locked = true
	},

	-- Cell 3
	{
		objName = 'v_ilev_ph_cellgate',
		objYaw = 90.0,
		objCoords  = vector3(462.7, -1001.9, 24.9),
		textCoords = vector3(461.8, -1002.4, 25.0),
		authorizedJobs = { 'police' },
		locked = true
	},

	-- To Back
	{
		objName = 'v_ilev_gtdoor',
		objYaw = 0.0,
		objCoords  = vector3(463.4, -1003.5, 25.0),
		textCoords = vector3(464.0, -1003.5, 25.5),
		authorizedJobs = { 'police' },
		locked = true
	},

	--
	-- Mission Row Back
	--

	-- Back (double doors)
	{
		textCoords = vector3(468.6, -1014.4, 27.1),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 4,
		doors = {
			{
				objName = 'v_ilev_rc_door2',
				objYaw = 0.0,
				objCoords  = vector3(467.3, -1014.4, 26.5)
			},

			{
				objName = 'v_ilev_rc_door2',
				objYaw = 180.0,
				objCoords  = vector3(469.9, -1014.4, 26.5)
			}
		}
	},

	-- Back Gate
	{
		objName = 'hei_prop_station_gate',
		objYaw = 90.0,
		objCoords  = vector3(488.8, -1017.2, 27.1),
		textCoords = vector3(488.8, -1020.2, 30.0),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 14,
		size = 2
	},

	--
	-- Sandy Shores
	--

	-- Entrance
	{
		objName = 'v_ilev_shrfdoor',
		objYaw = 30.0,
		objCoords  = vector3(1855.1, 3683.5, 34.2),
		textCoords = vector3(1855.1, 3683.5, 35.0),
		authorizedJobs = { 'police' },
		locked = false
	},

	--
	-- Paleto Bay
	--

	-- Entrance (double doors)
	{
		textCoords = vector3(-443.5, 6016.3, 32.0),
		authorizedJobs = { 'police' },
		locked = false,
		distance = 2.5,
		doors = {
			{
				objName = 'v_ilev_shrf2door',
				objYaw = -45.0,
				objCoords  = vector3(-443.1, 6015.6, 31.7),
			},

			{
				objName = 'v_ilev_shrf2door',
				objYaw = 135.0,
				objCoords  = vector3(-443.9, 6016.6, 31.7)
			}
		}
	},

	--
	-- Bolingbroke Penitentiary
	--

	-- Entrance (Two big gates)
	{
		objName = 'prop_gate_prison_01',
		objCoords  = vector3(1844.9, 2604.8, 44.6),
		textCoords = vector3(1844.9, 2608.5, 48.0),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 12,
		size = 2
	},

	{
		objName = 'prop_gate_prison_01',
		objCoords  = vector3(1818.5, 2604.8, 44.6),
		textCoords = vector3(1818.5, 2608.4, 48.0),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 12,
		size = 2
	},
    
{
		textCoords = vector3(-1388.5, -586.75, 30.49563),
		authorizedJobs = { 'bahamas' },
		locked = true,
		distance = 2.5,
		doors = {
			{
				objName = 'v_ilev_ph_gendoor006',
				objYaw = -327.0,
				objCoords = vector3(-1387.026, -586.6138, 30.49563),
			},

			{
				objName = 'v_ilev_ph_gendoor006',
				objYaw = 213.0,
				objCoords = vector3(-1389.212, -588.0406, 30.49132),
			}
		}
	},
    
    {
		objName = 'v_ilev_fa_frontdoor',
		objCoords  = vector3(-14.0, -1441.0, 31.0 ),
		textCoords = vector3(-14.0, -1441.0, 31.0 ),
		authorizedJobs = { 'grove' },
		locked = false,
		distance = 1,
        objYaw = 180.0,
		size = 1
	},
    

    {
		objName = 'prop_gate_cult_01_l',
		objCoords  = vector3(-1041.23, 4906.10, 209.20 ),
		textCoords = vector3(-1043.11, 4910.96, 212.04 ),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 10,
        objYaw = 111.0,
		size = 4
	},
    
        {
		objName = 'prop_gate_cult_01_r',
		objCoords  = vector3(-1044.75, 4914.97, 209.19 ),
		textCoords = vector3(-1043.11, 4910.96, 212.04 ),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 10,
        objYaw = 112.0,
		size = 4
	},
    
    --[[ JAULA UFC ]]
    {
		objName = 'prop_fnclink_09gate1',
        objYaw = 215.0,
		objCoords  = vector3(-518.3, -1712.34, 19.6 ),
		textCoords = vector3(-518.3, -1712.34, 19.6 ),
		authorizedJobs = {'unemployed'},
		locked = true,
		distance = 5,
	},
    
    
    {
		objName = 'v_ilev_roc_door4',
        objYaw = -5.0,
		objCoords  = vector3(-564.50, 276.97, 83.30 ),
		textCoords = vector3(-564.50, 276.97, 83.30 ),
		authorizedJobs = { 'tequila' },
		locked = false,
		distance = 2,

	},

	{
		objName = 'v_ilev_roc_door2',
        objYaw = 265.0,
		objCoords  = vector3(-559.85, 292.35, 82.06 ),
		textCoords = vector3(-559.85, 292.35, 82.06 ),
		authorizedJobs = { 'tequila' },
		locked = false,
		distance = 2,

	},
    
    {
		objName = 'v_ilev_roc_door4',
        objYaw = 175.0,
		objCoords  = vector3(-561.91, 293.91, 88.0 ),
		textCoords = vector3(-561.91, 293.91, 88.0 ),
		authorizedJobs = { 'tequila' },
		locked = true,
		distance = 2,
	},
    
        {
		objName = 'prop_strip_door_01',
        objYaw = 30.0,
		objCoords  = vector3(128.72, -1298.64, 29.23 ),
		textCoords = vector3(128.72, -1298.64, 29.23 ),
		authorizedJobs = { 'vanilla' },
		locked = false,
		distance = 2,
	},
    
    {
		objName = 'prop_magenta_door',
        objYaw = 210.0,
		objCoords  = vector3(95.32, -1284.91, 29.43878 ),
		textCoords = vector3(95.32, -1284.91, 29.43878 ),
		authorizedJobs = { 'vanilla' },
		locked = true,
		distance = 2,
	},
    
    {
		objName = 'prop_bh1_03_gate_r',
        objYaw = 90.0,
		objCoords  = vector3(1316.42, 1106.31, 105.85 ),
		textCoords = vector3(1316.42, 1106.31, 105.85 ),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 2,
	},
	
		-- Puerta garaje - Los hijos de Agapito
	{
		objName = 'prop_com_ls_door_01',
        objYaw = 136.0,
		objCoords  = vector3(-1145.90, -1991.14, 14.18),
		textCoords = vector3(-1145.898, -1991.144, 14.18357 ),
		authorizedJobs = { 'lhda' },
		locked = false,
		distance = 20,
	},


	-- {
	-- 	objName = 'prop_gate_military_01',
    --     objYaw = -30.0,
	-- 	objCoords  = vector3(956.7736, -138.77, 73.48),
	-- 	textCoords = vector3(956.7736, -138.77, 73.48 ),
	-- 	authorizedJobs = { 'berserkers' },
	-- 	locked = true,
	-- 	distance = 20,
	-- },

	-- {
	-- 	objName = 'v_ilev_lostdoor',
    --     objYaw = 43.0,
	-- 	objCoords  = vector3(981.65, -102.77, 74.85),
	-- 	textCoords = vector3(981.65, -102.77, 74.85),
	-- 	authorizedJobs = { 'berserkers' },
	-- 	locked = true,
	-- 	distance = 20,
	-- },

	{
		objName = 'prop_lrggate_02_ld',
        objYaw = 90.0,
		objCoords  = vector3(-844.051, 155.9619, 66.03),
		textCoords = vector3(-844.051, 155.9619, 66.03),
		authorizedJobs = { 'zeltasis' },
		locked = true,
		distance = 15,
	},

	{
		objName = 'prop_bh1_48_gate_1',
        objYaw = -95.0,
		objCoords  = vector3(-848.93, 179.30, 70.02),
		textCoords = vector3(-848.93, 179.30, 70.02),
		authorizedJobs = { 'zeltasis' },
		locked = true,
		distance = 5,
	},

	{
		objName = 'v_ilev_mm_door',
        objYaw = -160.0,
		objCoords  = vector3(-806.2817, 186.0246, 72.62),
		textCoords = vector3(-806.2817, 186.0246, 72.62),
		authorizedJobs = { 'zeltasis' },
		locked = true,
		distance = 7,
	},

	{
		textCoords = vector3(-816.10, 177.51, 72.82738),
		authorizedJobs = { 'zeltasis' },
		locked = true,
		distance = 3,
		doors = {
			{
				objName = 'v_ilev_mm_doorm_r',
				objYaw = -70.0,
				objCoords = vector3(-816.10, 177.51, 72.82738)
			},

			{
				objName = 'v_ilev_mm_doorm_l',
				objYaw = -70.0,
				objCoords = vector3(-816.716, 179.098, 72.82)
			}
		}
	},

	
	
	{
		textCoords = vector3(-795.64, 177.97, 72.83),
		authorizedJobs = { 'zeltasis' },
		locked = true,
		distance = 3,
		doors = {
			{
				objName = 'prop_bh1_48_backdoor_l',
				objYaw = 21.0,
				objCoords = vector3(-796.56, 177.22, 73.040)
			},

			{
				objName = 'prop_bh1_48_backdoor_r',
				objYaw = 21.0,
				objCoords = vector3(-794.50, 178.0124, 73.04)
			}
		}
	},

	{
		textCoords = vector3(-793.95, 181.25, 72.83),
		authorizedJobs = { 'zeltasis' },
		locked = true,
		distance = 3,
		doors = {
			{
				objName = 'prop_bh1_48_backdoor_r',
				objYaw = 110.0,
				objCoords = vector3(-794.185, 182.568, 73.040)
			},

			{
				objName = 'prop_bh1_48_backdoor_l',
				objYaw = 110.0,
				objCoords = vector3(-793.3943, 180.5075, 73.04)
			}
		}
	},


    --
	-- Addons
	--

	--[[
	-- Entrance Gate (Mission Row mod) https://www.gta5-mods.com/maps/mission-row-pd-ymap-fivem-v1
	{
		objName = 'prop_gate_airport_01',
		objCoords  = vector3(420.1, -1017.3, 28.0),
		textCoords = vector3(420.1, -1021.0, 32.0),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 14,
		size = 2
	}
	--]]
}