
local puntosahacer = 10
local eligoopos = 0
local cosechando = false
local isfinish = false
local isinroute = false
local puntos = 0    
local isOut = false
local recogiendo = false
local isMoney = false
local puedohacermarkers = false

----------------------FULLY CHANGEABLE--------------------------------
---------------------------------------------------------------------
local depositPos = {x = 761.98266601563, y = 6464.0229492188, z = 30.556999206543}
local JobPos =  {x = 749.72497558594, y = 6460.03515625, z = 30.245344161987}
local posiciones = {
	{x = 740.29943847656, y = 6457.205078125, z = 30.790899276733},
	{x = 719.41223144531, y = 6458.2724609375, z = 30.094020843506},
	{x = 695.17181396484, y = 6459.2158203125, z = 30.018301010132},
	{x = 668.16192626953, y = 6459.2607421875, z = 30.425884246826},
	{x = 630.72406005859, y = 6465.3481445313, z = 29.312149047852},
	{x = 645.64312744141, y = 6464.783203125, z = 29.795108795166},
	{x = 669.26666259766, y = 6464.2192382813, z = 29.964912414551},
	{x = 698.87780761719, y = 6463.7685546875, z = 29.721956253052},
	{x = 725.28771972656, y = 6463.9873046875, z = 29.99146270752},
	{x = 746.99688720703, y = 6468.771484375, z = 28.843770980835},
	{x = 653.24487304688, y = 6469.6748046875, z = 29.748556137085},
	{x = 627.4892578125, y = 6471.53515625, z = 29.339635848999},
	{x = 618.1513671875, y = 6479.3520507813, z = 29.374317169189},
	{x = 646.75671386719, y = 6491.4326171875, z = 28.674770355225},
	{x = 671.04071044922, y = 6491.0966796875, z = 28.439826965332},
	{x = 649.58898925781, y = 6495.3764648438, z = 28.450080871582},
	{x = 623.79107666016, y = 6499.837890625, z = 28.755884170532},
}
--------------------------------------------------------------------
---------------------------------------------------------------------


function drawTxt(text, font, centre, x, y, scale, r, g, b, a)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(centre)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

function deleteCar( entity )
    Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) )
end


function empiezoacosechar() 
	--puntosahacer = math.random(5,12)
	eligopos = math.random(1,17)
	puedohacermarkers = true
end

function spawntractor()

    Citizen.Wait(0)
    local player = PlayerId()
    local vehicle = GetHashKey('tractor2')
 
    RequestModel(vehicle)
 
    while not HasModelLoaded(vehicle) do
        Wait(1)
    end
 
	local plate = math.random(100, 900)
	local tractor = CreateVehicle(vehicle,745.29229736328,6464.9130859375,30.521860122681 , 180, true, false)
	SetVehicleOnGroundProperly(tractor)
	local plate = "CTZN"..math.random(100, 900)
    SetVehicleNumberPlateText(tractor, plate)
	SetPedIntoVehicle(GetPlayerPed(-1), tractor, - 1)
	SetModelAsNoLongerNeeded(vehicle)
	Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(tractor))
  TriggerEvent("advancedFuel:setEssence", 100, GetVehicleNumberPlateText(tractor), GetDisplayNameFromVehicleModel(GetEntityModel(tractor))) 
end 

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(0)
		if recogiendo then
			drawTxt('RECOGIENDO', 2, 1, 0.5, 0.02, 0.6, 255, 255, 255, 255)
		end
	end
end)

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(0)
		if IsEntityDead(GetPlayerPed(-1)) then 
                        puntosahacer = 10
                        eligopos = 0
                        cosechando = false
                        isfinish = false
                        isinroute = false
                        puntos = 0
                        isOut = false
                        recogiendo = false
                        isMoney = false
                        puedohacermarkers = false
		end
		DrawMarker(1, JobPos.x,JobPos.y,JobPos.z, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 1.0001, 0, 155, 255, 200, 0, 0, 0, 0)
		if isfinish then
			TriggerEvent("mt:missiontext",_U('backwards'), 10000)
			if GetDistanceBetweenCoords(depositPos.x,depositPos.y,depositPos.z, GetEntityCoords(GetPlayerPed(-1))) < 5.0 then
				TriggerEvent("mt:missiontext",_U('unloading'), 5000)
				isfinish = false
				puedofinalizar = true
				recogiendo = true
           	    FreezeEntityPosition(vehicleu,true)
				Citizen.Wait(5000)
				FreezeEntityPosition(vehicleu,false)
				recogiendo = false
				isOut = false
				isMoney = true
				TriggerEvent("mt:missiontext",_U('returnToPay'),5000)
			end
		end

    	if isinroute then
      		drawTxt(_U('goHarvest'), 2, 1, 0.5, 0.02, 0.6, 255, 255, 255, 255)
    	end
		if GetDistanceBetweenCoords(JobPos.x,JobPos.y,JobPos.z, GetEntityCoords(GetPlayerPed(-1))) < 3.0 then
			if cosechando == false then
   				 drawTxt(_U('getTractor'), 2, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
    			if (IsControlJustReleased(1, 38)) then
            		if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
              			if IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), true), GetHashKey("trash"))  then
                			spawntractor()
               	 			isinroute = true
               	 			cosechando = true
               	 			empiezoacosechar()
               	 			SetNotificationTextEntry("STRING")
							AddTextComponentString(_U('tractorBy'))
							DrawNotification(false, true)
              			else
                			TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0},_U('getOutFromTractor'))
              			end
            		else
              			spawntractor()
              			empiezoacosechar()
              			isinroute = true
              			cosechando = true
              			SetNotificationTextEntry("STRING")
						AddTextComponentString(_U('tractorBy'))
						DrawNotification(false, true)
              		end
				end
   			else
   				if puedofinalizar then
   					drawTxt(_U('finishJob'), 2, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
                    if (IsControlJustReleased(1, 38)) then
                    	local randm = math.random(900,1200)
                    	preciofinal = puntosahacer * randm
	                    TriggerServerEvent('pop_cosecha:paga',randm)
                        puntosahacer = 10
                        eligopos = 0
                        cosechando = false
                        isfinish = false
                        isinroute = false
                        puntos = 0
                        isOut = false
                        recogiendo = false
                        isMoney = false
                        puedohacermarkers = false
                      	if IsPedSittingInAnyVehicle(ped) then
                          local vehicleu = GetVehiclePedIsIn(GetPlayerPed(-1), false)
                          SetEntityAsMissionEntity( vehicleu, true, true )
                          deleteCar( vehicleu )
                          TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0},_U('thanksForJob'))
                      	else
                      	  local vehicleu = GetVehiclePedIsIn(GetPlayerPed(-1), true)
                          SetEntityAsMissionEntity( vehicleu, true, true )
                          deleteCar( vehicleu )
                          TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0},_U('thanksForJob'))
                        end
                        puedofinalizar = false
                    end
   					 
                else 
                    drawTxt(_U('returnTractor'), 2, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
                    if (IsControlJustReleased(1, 74)) then
                        puntosahacer = 10
                        eligopos = 0
                        cosechando = false
                        isfinish = false
                        isinroute = false
                        puntos = 0
                        isOut = false
                        recogiendo = false
                        isMoney = false
                        puedohacermarkers = false
                        if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
                        	local tractor = GetVehiclePedIsIn(GetPlayerPed(-1),false)
                        	SetEntityAsMissionEntity( tractor, true, true )
                          	deleteCar(tractor)
                          	TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0},_U('tractorDeleted'))
                        else
                        	local tractor = GetVehiclePedIsIn(GetPlayerPed(-1),true)
                        	SetEntityAsMissionEntity( tractor, true, true )
                          	deleteCar(tractor)
                          	TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0},_U('tractorDeleted'))
                        end
                    end
                end
   			end
		end
		if isOut then
			drawTxt(_U('goDeposit'), 2, 1, 0.5, 0.02, 0.6, 255, 255, 255, 255)
			DrawMarker(1,depositPos.x,depositPos.y,depositPos.z, 0, 0, 0, 0, 0, 0, 3.0001, 3.0001, 1.0001, 255, 0, 0, 200, 0, 0, 0, 0)
		end
		if isMoney then
			drawTxt(_U('goForPay'), 2, 1, 0.5, 0.02, 0.6, 255, 255, 255, 255)
			
		end
		if puedohacermarkers then
			DrawMarker(1, posiciones[eligopos].x,posiciones[eligopos].y,posiciones[eligopos].z, 0, 0, 0, 0, 0, 0, 5.0001, 5.0001, 5.0001, 255, 0, 0, 200, 0, 0, 0, 0)
			if GetDistanceBetweenCoords(posiciones[eligopos].x,posiciones[eligopos].y,posiciones[eligopos].z, GetEntityCoords(GetPlayerPed(-1))) < 4.0 then
				puntos = puntos + 1
				if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
              		if IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), false), GetHashKey("tractor2"))  then

						if puntosahacer == puntos then
							isinroute = false
							puedohacermarkers = false
							isfinish = true
							SetNewWaypoint(761.98266601563,6464.0229492188)
							isOut = true
						else
							empiezoacosechar()
						end
			     	end
				end
			end
		end
	end
end)

local blips = {
    {title=_U('BlipName'), colour=2, id=89, x = JobPos.x, y = JobPos.y, z = JobPos.z},
}
 
Citizen.CreateThread(function()
	Citizen.Wait(0)
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

