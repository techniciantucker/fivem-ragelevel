ESX                           = nil
local iKnowPlant = true
local iKnowTheDouble = true
local areas = {
	{x = 2494.68, y = 4855.64, z = 32.56, radio = 20.5,label = "PH",id = 439,colour = 71},
	{x = 340.28, y = 6627.64, z = 28.88, radio = 28.5,label = "PH",id = 439,colour = 71},
	{x = 1955.84, y = 4796.2, z = 42.52, radio = 15.5,label = "PH",id = 439,colour = 71},
}
local locales = {
	success = 'Has plantado una semilla de ',
	errorarea = 'En este sitio no está permitido plantar',
	ready = "Listo para recoger",
	space = "Hay muy poco espacio entre una planta y otra",
	getmore = "La planta todavía no está madura",
	ph = "No hay suficiente sustancia para plantar en este terreno"
}
local plants = {
	{x = 0, y = 0, z = 0, percent = 0}
}

AddEventHandler('playerSpawned', function(spawn)
	TriggerServerEvent('tm1_farm:getSource')
end)
TriggerServerEvent('tm1_farm:getSource')

RegisterNetEvent('pop_university:setKown')
AddEventHandler('pop_university:setKown', function()
	iKnowPlant = true
end)

RegisterNetEvent('pop_university:setCatch')
AddEventHandler('pop_university:setCatch', function()
	iKnowTheDouble = true
end)

RegisterNetEvent('tm1_farm:setSource')
AddEventHandler('tm1_farm:setSource', function(sc)
	source = sc
end)

local source = nil
Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getShtoniaredObjtoniect', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

RegisterNetEvent('tm1_farm:plant')
AddEventHandler('tm1_farm:plant', function(seed)
	if iKnowPlant == true then
		local a = 0
		for i,v in pairs(areas) do
			if GetDistanceBetweenCoords(v.x, v.y, v.z, GetEntityCoords(GetPlayerPed(-1),true)) <= v.radio then
				local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
				local min = 1000
				for i,v in pairs(plants) do
					if GetDistanceBetweenCoords(v.x, v.y, v.z, GetEntityCoords(GetPlayerPed(-1),true)) < min then
						min = GetDistanceBetweenCoords(v.x, v.y, v.z, GetEntityCoords(GetPlayerPed(-1),true))
					end
				end
				if min >= 2 then
					TriggerServerEvent('tm1_farm:planted',seed,x, y, z)
					ESX.UI.Menu.CloseAll()
				else
					errorarea(locales.space,4000)
				end
				a = a + 1
			else
				--errorarea(locales.errorarea,4000)
			end
		end
		if a < 1 then
			errorarea(locales.errorarea,4000)
		end
	else
		TriggerEvent('exp:NotificateError',"No sabes plantar")
	end
end)

RegisterNetEvent('tm1_farm:plantsuccess')
AddEventHandler('tm1_farm:plantsuccess', function(label,object,x,y,z,sou)
	if source == sou then
		plantsuccess(label)
	end
	spawnObject(object,x,y,z)
end)

RegisterNetEvent('tm1_farm:plantupdate')
AddEventHandler('tm1_farm:plantupdate', function(Plants)
	plants = Plants
end)

RegisterNetEvent('tm1_farm:sendMSG')
AddEventHandler('tm1_farm:sendMSG', function(label)
	errorarea(label,2000)
end)

RegisterNetEvent('tm1_farm:removePlanted')
AddEventHandler('tm1_farm:removePlanted', function(x,y,z,obj)
	local entity = GetClosestObjectOfType(x,y,z, 100.0,  GetHashKey(obj), false, false, false) 
	DeleteObject(entity)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		for i,v in pairs(plants) do
		DrawMarker(1,v.x,v.y,v.z - 1, 0, 0, 0, 0, 0, 0, 0.21, 0.21, 0.4001,255,255,51, 200, 0, 0, 0, 0)
			if GetDistanceBetweenCoords(v.x, v.y, v.z, GetEntityCoords(GetPlayerPed(-1),true)) <= 1.0 then
				if v.percent < 100 then
					DrawText3D(v.x, v.y, v.z,"["..v.label.."] - "..v.percent.."%",0,255,0)
					if IsControlJustPressed(1,38) then
					    errorarea(locales.getmore,2000)
					end
				else
					DrawText3D(v.x, v.y, v.z,"["..v.label.."] - "..locales.ready,0,255,0)
					if IsControlJustPressed(1,38) then
						local finalplant = v.finalplant
						TriggerServerEvent('tm1_farm:removeplant',v.identifier,v.x, v.y, v.z,v.object)
						Citizen.Wait(100)
						deleteInTheClient( v.identifier )
						if iKnowTheDouble == true then
							TriggerServerEvent('tm1_farm:addPlant',finalplant)
							TriggerServerEvent('tm1_farm:addPlant',finalplant)
						else
							TriggerServerEvent('tm1_farm:addPlant',finalplant)
						end
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		for i,v in pairs(areas) do
			DrawMarker(1,v.x,v.y,v.z - 1, 0, 0, 0, 0, 0, 0, (v.radio * 2) + 0.01, (v.radio * 2) + 0.01, 0.1001,255,0,0, 200, 0, 0, 0, 0)
		end
	end
end)

Citizen.CreateThread(function()
    for _, info in pairs(areas) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.9)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.label)
      EndTextCommandSetBlipName(info.blip)
    end
end)

function errorarea(msg,temp)
	TriggerEvent("pNotify:SetQueueMax", "center", 2)
    TriggerEvent("pNotify:SendNotification", {
        text = msg,
        type = "error",
        timeout = temp,
        layout = "centerRight",
        queue = "center"
    })
end

function deleteInTheClient( identifier )
	local id = 0
	for i,v in pairs(plants) do
		if v.identifier == identifier then
			id = i
		end
	end
	table.remove( plants, id )
end

function round(num, numDecimalPlaces)
	local mult = 5^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

function plantsuccess(plant)

	TriggerEvent("pNotify:SetQueueMax", "center", 2)
    TriggerEvent("pNotify:SendNotification", {
        text = locales.success..plant,
        type = "success",
        timeout = 3000,
        layout = "centerRight",
        queue = "center"
    })
end

function spawnObject(object,x,y,z)
	ESX.Game.SpawnObject(object, {
      x = x,
      y = y,
      z = z
    }, function(obj)

      SetEntityHeading(obj, GetEntityHeading(playerPed))
      PlaceObjectOnGroundProperly(obj)
    end)
end

function DrawText3D(x,y,z, text, r,g,b) -- some useful function, use it if you want!
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(0)
        SetTextProportional(1)
        -- SetTextScale(0.0, 0.55)
        SetTextColour(r, g, b, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end
