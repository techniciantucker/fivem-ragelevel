--VARIABLES DEL CLIENTE -------
trabajando = false
puntos = 0
sumapuntos = 0
isfinish = false
isintruck = false
isinroute = false
posmarker = { 
	{x = 95.92,z = 6364.92, y = 30.36},
}
local blips = {
    {title="Basurero", colour=18, id=106, x = 95.92,y = 6364.92, z = 30.36}
}
local job = nil
AddEventHandler('playerSpawned', function(spawn)
  TriggerServerEvent('pop_basura:getJob')
end)
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    TriggerServerEvent('pop_basura:getJob')
end)
TriggerServerEvent('pop_basura:getJob')
RegisterNetEvent('pop_basura:setJob')
AddEventHandler('pop_basura:setJob',function(jobu)
  job = jobu
end)
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

local destination = {
{ x = -129.04 , y = 6229.4, z = 31.36, money = 200},
{ x = -51.84 , y = 6355.88, z = 31.36, money = 200},
{ x = -19.04 , y = 6387.0, z = 31.32, money = 200},
{ x = 5.68 , y = 6411.28, z = 31.32, money = 200},
{ x = 145.68 , y = 6390.0, z = 31.32, money = 200},
{ x = 123.56  , y = 6652.36, z = 31.64, money = 200},
{ x = -82.12  , y = 6480.36, z = 31.48, money = 180},
{ x = -74.04  , y = 6502.32, z = 31.48, money = 180},
{ x = -68.48  , y = 6444.0, z = 31.48, money = 180},
{ x = -139.32  , y = 6343.6, z = 31.48, money = 180},
{ x = -154.32  , y = 6348.32, z = 31.6, money = 180},
{ x = -182.24  , y = 6319.12, z = 31.36, money = 180},
{ x = -255.84  , y = 6249, z = 31.48, money = 180},
{ x = -343.2  , y = 6068.8, z = 31.48, money = 180},
{ x = -122.72,  y=6211,96, z=30.92, money = 180},
{ x = -135.28, y=6267.48, z=31.32, money = 180},
{ x = -19.88, y=6389.48, z=31.4, money = 180}

}
------------------------------------------------
------FUNCIONES------------
-----------------------------------------------
function deleteCar( entity )
    Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) )
end

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

function activojob()
	trabajando = true
	TriggerEvent("mt:missiontext", "Conduce hasta tu ~g~destino~w~.", 10000)
	eligodest = math.random(1,14)
  blip = AddBlipForCoord(destination[eligodest].x,destination[eligodest].y,destination[eligodest].z)
  SetBlipRoute(blip, true)
end

function entregaexitosa()
    sumapuntos = sumapuntos + destination[eligodest].money
    if puntos == 2 then 
    RemoveBlip(blip)
    blip = AddBlipForCoord(95.92,6364.92,30.36)
    SetBlipRoute(blip, true)
		isfinish = true
    isinroute = false
    else
        RemoveBlip(blip)
        activojob()
        puntos = puntos + 1
    end
end
	

function creocamion()
	local myPed = GetPlayerPed(-1)
    if IsPedSittingInAnyVehicle(myPed) then
        if IsVehicleModel(GetVehiclePedIsIn(myPed, true), GetHashKey("trash")) then
            activojob()
            isintruck = true
        end
    else
    Citizen.Wait(0)
    local player = PlayerId()
    local vehicle = GetHashKey('trash')
 
    RequestModel(vehicle)
 
    while not HasModelLoaded(vehicle) do
        Wait(1)
    end
 
    local coords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, 5.0, 0)
    camioncoche = CreateVehicle(vehicle, 82.84,6374.84,31.24, 180, true, false)
    SetVehicleOnGroundProperly(camioncoche)
    local plate = "CTZN"..math.random(100, 900)
    SetVehicleNumberPlateText(camioncoche, plate)
    SetPedIntoVehicle(myPed, camioncoche, - 1)
    SetModelAsNoLongerNeeded(vehicle)
    Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(camioncoche))
    TriggerEvent("advancedFuel:setEssence", 100, GetVehicleNumberPlateText(camioncoche), GetDisplayNameFromVehicleModel(GetEntityModel(camioncoche)))
    end
end


-------------------------------------
--CITIZEN--------
-------------------------------------
Citizen.CreateThread(function()
    while true do
		Citizen.Wait(0)
		if IsEntityDead(GetPlayerPed(-1)) then 
			trabajando = false
      isfinish = false
      RemoveBlip(blip)
		end
		DrawMarker(1, 95.92,6364.92,30.36, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 1.0001, 0, 155, 255, 200, 0, 0, 0, 0)
		if isfinish then
			drawTxt('VUELVE A LA CENTRAL PARA COBRAR', 2, 1, 0.5, 0.02, 0.6, 255, 255, 255, 255)
		end
    if isinroute then
      drawTxt('VE A RECOGER LA BASURA', 2, 1, 0.5, 0.02, 0.6, 255, 255, 255, 255)
      DrawMarker(1, destination[eligodest].x,destination[eligodest].y,destination[eligodest].z - 1, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 1.0001, 0, 155, 255, 200, 0, 0, 0, 0)
    end
		if GetDistanceBetweenCoords(95.92,6364.92,30.36, GetEntityCoords(GetPlayerPed(-1))) < 4.0 then
			if trabajando == false then
   				 drawTxt('Presiona ~g~E~s~ para conseguir un~b~ camion', 2, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
    			if (IsControlJustReleased(1, 38)) and job == "trash" then
            if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
              if IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), true), GetHashKey("trash"))  then
                creocamion()
                isinroute = true
                if isintruck then

                else
                  activojob()
                end
              else
                TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0},"Tienes que bajarte del vehiculo.")
              end
            else
              creocamion()
              isinroute = true
              activojob()

            end
       		elseif (IsControlJustReleased(1, 38)) and not(job == "trash") then
            TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0},"No eres basurero.")
   				end
   			else
   				    if puntos == 2 then
   					    drawTxt('Presiona ~g~E~s~ para conseguir el~b~ dinero', 2, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
                    --Si tiene 7  y le da la suma del dinero de todos los puntos.
                    if (IsControlJustReleased(1, 38)) then
                      local price = math.random(500,800)
	                    TriggerServerEvent('pop_basura:paga',price)
                      TriggerServerEvent('exp:addExperience',55)
	                    puntos = 0
	                    isfinish = false
                      isinroute = false
                      trabajando = false
                      RemoveBlip(blip)
                      sumapuntos = 0
                      if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
                          local vehicleu = GetVehiclePedIsIn(GetPlayerPed(-1), false)
                          SetEntityAsMissionEntity( vehicleu, true, true )
                          deleteCar( vehicleu )
                          TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0},"El vehiculo ha sido recogido.")
                      end
	                end                
                else 
                    drawTxt('Presiona ~g~H~s~ para devolver el~b~ camion, no cobraras nada.', 2, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
                    if (IsControlJustReleased(1, 74)) then
                        trabajando = false
                        isinroute = false
                        RemoveBlip(blip)
                        SetWaypointOff()
                        puntos = 0
                        if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
                          local vehicleu = GetVehiclePedIsIn(GetPlayerPed(-1), false)
                          SetEntityAsMissionEntity( vehicleu, true, true )
                          deleteCar( vehicleu )
                          TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0},"El vehiculo ha sido recogido.")
                        end
                    end
                end
   			end
		end
		if isinroute == true then
			if GetDistanceBetweenCoords(destination[eligodest].x,destination[eligodest].y,destination[eligodest].z, GetEntityCoords(GetPlayerPed(-1))) < 4.0 then
	            drawTxt('Presiona ~g~E~s~ para recoger la ~b~ basura', 2, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
              if (IsControlJustReleased(1, 38)) then
                if IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), true), GetHashKey("trash"))  then
  	              entregaexitosa()
                else
                  TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0},"No estas en un camion de basura.")
                end
				      end 
			end
		end
	end
end)
