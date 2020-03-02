
	local blips = {
		-- Airports 
		{title="Aeropuerto", colour=3, id=90, x=1721.0, y=3255.07, z=41.148},
		{title="Aeropuerto", colour=3, id=90, x=2149.59, y=4817.6, z=41.268},
		{title="Aeropuerto", colour=3, id=90, x=-1045.49, y=-2751.304, z=21.363},
		-- Police Departments
		{title="Estación de policía", colour=29, id=60, x=-445.202, y=6014.36, z=31.7164},
		{title="Estación de policía", colour=29, id=60, x=1854.21, y=3685.51, z=34.2671},
		{title="Estación de policía", colour=29, id=60, x=642.001, y=0.638351, z=82.7869},
		{title="Estación de policía", colour=29, id=60, x=-1198.25, y=-845.297, z=19.317},
		{title="Estación de policía", colour=29, id=60, x=360.624, y=-1584.47, z=29.2919},
		{title="Estación de policía", colour=29, id=60, x=825.987, y=-1290.03, z=28.2407},
		-- Fire Departments
		{title="Estación de bomberos", colour=1, id=60, x=215.786, y=-1642.49, z=29.7138},
		{title="Estación de bomberos", colour=1, id=60, x=1202.38, y=-1460.13, z=34.7642},
		{title="Estación de bomberos", colour=1, id=60, x=-1087.93, y=-2374.1, z=13.9451},
		{title="Estación de bomberos", colour=1, id=60, x=-379.942, y=6118.73, z=31.8456},
		{title="Estación de bomberos", colour=1, id=60, x=-635.992, y=-121.635, z=39.0138},
		{title="Estación de bomberos", colour=1, id=60, x=1697.26, y=3585.46, z=35.5443},
		{title="Estación de bomberos", colour=1, id=60, x=-2113.74, y=2831.58, z=32.8093},
		-- Hostipals
		{title="Ambulatorios", colour=74, id=61, x=337.238, y=-1396.28, z=32.5092},
		{title="Ambulatorios", colour=74, id=61, x=-450.586, y=-340.387, z=34.5014},
		{title="Ambulatorios", colour=74, id=61, x=1839.74, y=3672.0, z=34.2767},
		{title="Ambulatorios", colour=74, id=61, x=360.222, y=-582.222, z=28.8212},
		{title="Ambulatorios", colour=74, id=61, x=-243.463, y=6327.87, z=32.4262},
		{title="Ambulatorios", colour=74, id=61, x=-677.003, y=310.929, z=83.0841},
		{title="Ambulatorios", colour=74, id=61, x=1151.31, y=-1529.95, z=34.9904},
		{title="Ambulatorios", colour=74, id=61, x=-874.614, y=-308.375, z=39.5448},
		--[[-- Mechanic
		{title="Mecánico de vehículos", colour=31, id=446, x=-356.146, y=-134.69, z=39.0097},
		{title="Mecánico de vehículos", colour=31, id=446, x=723.013, y=-1088.92, z=22.1829},
		{title="Mecánico de vehículos", colour=31, id=446, x=-1145.67, y=-1991.17, z=13.162},
		{title="Mecánico de vehículos", colour=31, id=446, x=1174.76, y=2645.46, z=37.7545},
		{title="Mecánico de vehículos", colour=31, id=446, x=112.275, y=6619.83, z=31.8154},
		{title="Mecánico de vehículos", colour=31, id=446, x=-207.978, y=-1309.64, z=-31.2939},
		--]]
		-- A few ATM's within the city.
		{title="Cajero", colour=2, id=108, x=89.9733, y=2.18227, z=68.2283},
		{title="Cajero", colour=2, id=108, x=711.389, y=-820.833, z=23.6155},
		{title="Cajero", colour=2, id=108, x=-526.065, y=-1221.99, z=18.4549},
		{title="Cajero", colour=2, id=108, x=711.389, y=-820.833, z=23.6155},
		{title="Cajero", colour=2, id=108, x=-2073.44, y=-317.245, z=13.316},
		{title="Cajero", colour=2, id=108, x=-821.17, y=-1083.29, z=11.1324},
		{title="Cajero", colour=2, id=108, x=1686.4, y=4816.36, z=42.0092},
		-- Banks
		{title="Banco", colour=2, id=431, x=-2964.76, y=482.658, z=15.7068},
		{title="Banco", colour=2, id=431, x=260.232, y=205.886, z=106.284},
		{title="Banco", colour=2, id=431, x=150.061, y=-1039.99, z=29.3778},
		{title="Banco", colour=2, id=431, x=-1213.57, y=-328.829, z=37.7908},
		{title="Banco", colour=2, id=431, x=-109.453, y=6464.05, z=31.6267},
		--Race Track
		{title="Pista de Carreras", colour=6, id=147, x=1131.91, y=101.72, z=83.023},
		-- Caceria
		{title="Caza de animales", colour=81, id=141, x=-768.98, y=5593.86, z=114.97},
		{title="Carniceria", colour=81, id=141, x=960.196105957031, y=-2105.53198242188, z=31.9526977539063},
		-- Asesinato
		{title="Misión de asesinato", colour=1, id=84, x=-1152.8, y=-1517.2, z=13.71},
		{title="Comprador de organos", colour=1, id=303, x=-2255.2, y=320.35, z=184.6},
		-- Mechanic
		--{title="Taller de Mecanicos", colour=1, id=446, x=940.84, y=-1455.09, z=31.21},
	
	
		}

Citizen.CreateThread(function()

    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.9)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)


