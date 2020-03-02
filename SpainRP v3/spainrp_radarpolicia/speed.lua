--[[------------------------------------------------------------------------

	Radar/ALPR 
	Created by Brock =]
	Uses Numpad5 to turn on
    Uses Numpad8 to freeze	

------------------------------------------------------------------------]]--

local radar =
{
	shown = true,
	freeze = false,
	info = "~y~Inicializando RADAR...~w~321...~y~Cargando! ",
	info2 = "~y~Inicializando RADAR...~w~321...~y~Cargando! ",
	minSpeed = 5.0,
	maxSpeed = 75.0,
}
--local distanceToCheckFront = 50

function DrawAdvancedText(x,y ,w,h,sc, text, r,g,b,a,font,jus)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(sc, sc)
	N_0x4e096588b13ffeca(jus)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
	DrawText(x - 0.1+w, y - 0.02+h)
end

Citizen.CreateThread( function()
	
	while true do
		Wait(0)
		if IsControlJustPressed(1, 121) and IsPedInAnyPoliceVehicle(GetPlayerPed(-1)) then
			
			if radar.shown then 
				radar.shown = false 
				radar.info = string.format("~y~Inicializando ALPR...~w~321...~y~Cargando! ")
				radar.info2 = string.format("~y~Inicializando ALPR...~w~321...~y~Cargando! ")
			else 
				radar.shown = true 
			end		
                Wait(75)
			
		end
		if IsControlJustPressed(1, 178) and IsPedInAnyPoliceVehicle(GetPlayerPed(-1)) then
		
			if radar.freeze then radar.freeze = false else radar.freeze = true end
	
		end
		if radar.shown  then
			if radar.freeze == false then
					local veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
					local coordA = GetOffsetFromEntityInWorldCoords(veh, 0.0, 1.0, 1.0)
					local coordB = GetOffsetFromEntityInWorldCoords(veh, 0.0, 105.0, 0.0)
					local frontcar = StartShapeTestCapsule(coordA, coordB, 3.0, 10, veh, 7)
					local a, b, c, d, e = GetShapeTestResult(frontcar)
					
					if IsEntityAVehicle(e) then
						
						local fmodel = GetDisplayNameFromVehicleModel(GetEntityModel(e))
						local fvspeed = GetEntitySpeed(e)*3.609
						local fplate = GetVehicleNumberPlateText(e)
						radar.info = string.format("~y~Matricula: ~w~%s  ~y~Modelo: ~w~%s  ~y~Velocidad: ~w~%s Km/h", fplate, fmodel, math.ceil(fvspeed))
					end
					
					local bcoordB = GetOffsetFromEntityInWorldCoords(veh, 0.0, -105.0, 0.0)
					local rearcar = StartShapeTestCapsule(coordA, bcoordB, 3.0, 10, veh, 7)
					local f, g, h, i, j = GetShapeTestResult(rearcar)
					
					if IsEntityAVehicle(j) then
					
						local bmodel = GetDisplayNameFromVehicleModel(GetEntityModel(j))
						local bvspeed = GetEntitySpeed(j)*3.609
						local bplate = GetVehicleNumberPlateText(j)
						radar.info2 = string.format("~y~Matricula: ~w~%s  ~y~Modelo: ~w~%s  ~y~Velocidad: ~w~%s Km/h", bplate, bmodel, math.ceil(bvspeed))
					
					
					end
					
			end
			
			DrawAdvancedText(0.80, 0.87, 0.005, 0.0028, 0.45, "Radar frontal", 0, 191, 255, 255, 6, 1)
			DrawAdvancedText(0.80, 0.93, 0.005, 0.0028, 0.45, "Radar trasero", 0, 191, 255, 255, 6, 1)
			DrawAdvancedText(0.80, 0.90, 0.005, 0.0028, 0.4, radar.info, 255, 255, 255, 255, 6, 1)
			DrawAdvancedText(0.80, 0.96, 0.005, 0.0028, 0.4, radar.info2, 255, 255, 255, 255, 6, 1)

			
		end
		
		if(not IsPedInAnyVehicle(GetPlayerPed(-1))) then
			radar.shown = false
			radar.info = string.format("~y~Inicializando ALPR...~w~321...~y~Cargando! ")
			radar.info2 = string.format("~y~Inicializando ALPR...~w~321...~y~Cargando! ")
		end
					
	end
	
	
end)

