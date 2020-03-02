local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil
local PlayerData                = {}
local fishing = false
local lastInput = 0
local pause = false
local pausetimer = 0
local correct = 0
local bait = "none"

local JobBlips                = {}
local Blips                     = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
	blips()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
	deleteBlips()
	blips()
end)

function blips()

		if PlayerData.job ~= nil and PlayerData.job.name == 'fisherman' then

			local blip = AddBlipForCoord(Config.SellFish.x, Config.SellFish.y, Config.SellFish.z)

						SetBlipSprite (blip, 68)
						SetBlipDisplay(blip, 4)
						SetBlipScale  (blip, 1.1)
						SetBlipColour (blip, 17)
						SetBlipAsShortRange(blip, true)
						BeginTextCommandSetBlipName("STRING")
						AddTextComponentString("Venta de pescado")
						EndTextCommandSetBlipName(blip)
						table.insert(JobBlips, blip)

					
			local blip2 = AddBlipForCoord(Config.SellTurtle.x, Config.SellTurtle.y, Config.SellTurtle.z)

						SetBlipSprite (blip2, 68)
						SetBlipDisplay(blip2, 4)
						SetBlipScale  (blip2, 0.9)
						SetBlipColour (blip2, 49)
						SetBlipAsShortRange(blip2, true)
						BeginTextCommandSetBlipName("STRING")
						AddTextComponentString("Traficante de tortugas marinas")
						EndTextCommandSetBlipName(blip2)
						table.insert(JobBlips, blip2)
					
			local blip3 = AddBlipForCoord(Config.SellShark.x, Config.SellShark.y, Config.SellShark.z)

						SetBlipSprite (blip3, 68)
						SetBlipDisplay(blip3, 4)
						SetBlipScale  (blip3, 0.9)
						SetBlipColour (blip3, 49)
						SetBlipAsShortRange(blip3, true)
						BeginTextCommandSetBlipName("STRING")
						AddTextComponentString("Traficante de carne de tiburón")
						EndTextCommandSetBlipName(blip3)
						table.insert(JobBlips, blip3)
					
			local blip4 = AddBlipForCoord(Config.FishingZone.x, Config.FishingZone.y, Config.FishingZone.z)

						SetBlipSprite (blip4, 68)
						SetBlipDisplay(blip4, 4)
						SetBlipScale  (blip4, 0.9)
						SetBlipColour (blip4, 25)
						SetBlipAsShortRange(blip4, true)
						BeginTextCommandSetBlipName("STRING")
						AddTextComponentString("Zona de pesca")
						EndTextCommandSetBlipName(blip4)
						table.insert(JobBlips, blip4)

			local blip5 = AddBlipForCoord(Config.FishingZone2.x, Config.FishingZone2.y, Config.FishingZone2.z)

						SetBlipSprite (blip5, 68)
						SetBlipDisplay(blip5, 4)
						SetBlipScale  (blip5, 0.9)
						SetBlipColour (blip5, 25)
						SetBlipAsShortRange(blip5, true)
						BeginTextCommandSetBlipName("STRING")
						AddTextComponentString("Zona de pesca")
						EndTextCommandSetBlipName(blip5)
						table.insert(JobBlips, blip5)

			--[[ local blip6 = AddBlipForCoord(Config.FishingZone3.x, Config.FishingZone3.y, Config.FishingZone3.z)

						SetBlipSprite (blip6, 68)
						SetBlipDisplay(blip6, 4)
						SetBlipScale  (blip6, 0.9)
						SetBlipColour (blip6, 25)
						SetBlipAsShortRange(blip6, true)
						BeginTextCommandSetBlipName("STRING")
						AddTextComponentString("Zona de pesca")
						EndTextCommandSetBlipName(blip6)
						table.insert(JobBlips, blip6)	 ]]		
		
			for _, info in pairs(Config.MarkerZones) do
						info.blip = AddBlipForCoord(info.x, info.y, info.z)
						SetBlipSprite(info.blip, 455)
						SetBlipDisplay(info.blip, 4)
						SetBlipScale(info.blip, 1.0)
						SetBlipColour(info.blip, 29)
						SetBlipAsShortRange(info.blip, true)
						BeginTextCommandSetBlipName("STRING")
						AddTextComponentString("Alquiler de botes")
						EndTextCommandSetBlipName(info.blip)
						table.insert(JobBlips, info.blip)
			end

		end
		
end

function deleteBlips()
	if JobBlips[1] ~= nil then
		for i=1, #JobBlips, 1 do
		RemoveBlip(JobBlips[i])
		JobBlips[i] = nil
		end
	end
end

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(0)
		
		if PlayerData.job ~= nil and PlayerData.job.name == "fisherman" then

			for k in pairs(Config.MarkerZones) do
				DrawMarker(1, Config.MarkerZones[k].x, Config.MarkerZones[k].y, Config.MarkerZones[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.0, 3.0, 1.0, 0, 150, 150, 100, 0, 0, 0, 0)	
			end

			for k in pairs(Config.deleteVehicleZones) do
				DrawMarker(1, Config.deleteVehicleZones[k].x, Config.deleteVehicleZones[k].y, Config.deleteVehicleZones[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 5.0, 5.0, 2.0, 255, 50, 50, 200, 0, 0, 0, 0)	
			end
		end
    end
end)
			
function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
Citizen.CreateThread(function()
while true do
	Wait(600)
		if pause and fishing then
			pausetimer = pausetimer + 1
		end
end
end)
Citizen.CreateThread(function()
	while true do
		Wait(5)
		if fishing then
			if IsControlJustReleased(0, Keys['1']) then
				 input = 1
			end
			if IsControlJustReleased(0, Keys['2']) then
				input = 2
			end
			if IsControlJustReleased(0, Keys['3']) then
				input = 3
			end
			if IsControlJustReleased(0, Keys['4']) then
				input = 4
			end
			if IsControlJustReleased(0, Keys['5']) then
				input = 5
			end
			if IsControlJustReleased(0, Keys['6']) then
				input = 6
			end
			if IsControlJustReleased(0, Keys['7']) then
				input = 7
			end
			if IsControlJustReleased(0, Keys['8']) then
				input = 8
			end
			
			
			if IsControlJustReleased(0, Keys['X']) then
				fishing = false
				ESX.ShowNotification("~r~Dejaste de pescar")
			end
			if fishing then
			
				playerPed = GetPlayerPed(-1)
				local pos = GetEntityCoords(GetPlayerPed(-1))
				if pos.y >= 7700 or pos.y <= -4000 or pos.x <= -3700 or pos.x >= 4300 or IsPedInAnyVehicle(GetPlayerPed(-1)) then
					
				else
					fishing = false
					ESX.ShowNotification("~r~Dejaste de pescar")
				end
				if IsEntityDead(playerPed) or IsEntityInWater(playerPed) then
					ESX.ShowNotification("~r~Dejaste de pescar")
				end
			end
			
			if pausetimer > 3 then
				input = 99
			end
			
			if pause and input ~= 0 then
				pause = false
				if input == correct then
					TriggerServerEvent('fishing:catch', bait)
					TriggerServerEvent('esx_pescador:addStress')
				else
					ESX.ShowNotification("~r~El pescado se escapo")
				end
			end
		end

		if PlayerData.job ~= nil and PlayerData.job.name == "fisherman" then
		
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Config.SellFish.x, Config.SellFish.y, Config.SellFish.z, true) <= 3 then
				TriggerServerEvent('fishing:startSelling', "fish")
				Citizen.Wait(4000)
			end
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Config.SellShark.x, Config.SellShark.y, Config.SellShark.z, true) <= 3 then
				TriggerServerEvent('fishing:startSelling', "shark")
				Citizen.Wait(4000)
			end
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Config.SellTurtle.x, Config.SellTurtle.y, Config.SellTurtle.z, true) <= 3 then
				TriggerServerEvent('fishing:startSelling', "turtle")
				Citizen.Wait(4000)
			end
			
		end

	end
end)

function deleteVehicle(vehicle)

	ESX.Game.DeleteVehicle(vehicle)

end
				
Citizen.CreateThread(function()
	while true do
		Wait(1)

		if PlayerData.job ~= nil and PlayerData.job.name == "fisherman" then
			DrawMarker(1, Config.SellFish.x, Config.SellFish.y, Config.SellFish.z , 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.0, 3.0, 2.0, 0, 70, 250, 30, false, true, 2, false, false, false, false)
			DrawMarker(1, Config.SellTurtle.x, Config.SellTurtle.y, Config.SellTurtle.z , 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.0, 3.0, 2.0, 0, 70, 250, 30, false, true, 2, false, false, false, false)
			DrawMarker(1, Config.SellShark.x, Config.SellShark.y, Config.SellShark.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.0, 3.0, 2.0, 0, 70, 250, 30, false, true, 2, false, false, false, false)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		local wait = math.random(Config.FishTime.a , Config.FishTime.b)
		Wait(wait)
			if fishing then
				pause = true
				correct = math.random(1,8)
				ESX.ShowNotification("~g~El pescado está mordiendo el anzuelo \n ~h~Presiona " .. correct .. " para atraparlo")
				input = 0
				pausetimer = 0
			end
			
	end
end)

RegisterNetEvent('fishing:message')
AddEventHandler('fishing:message', function(message)
	ESX.ShowNotification(message)
end)
RegisterNetEvent('fishing:break')
AddEventHandler('fishing:break', function()
	fishing = false
	ClearPedTasks(GetPlayerPed(-1))
end)

RegisterNetEvent('fishing:spawnPed')
AddEventHandler('fishing:spawnPed', function()
	
	RequestModel( GetHashKey( "A_C_SharkTiger" ) )
		while ( not HasModelLoaded( GetHashKey( "A_C_SharkTiger" ) ) ) do
			Citizen.Wait( 1 )
		end
	local pos = GetEntityCoords(GetPlayerPed(-1))
	
	local ped = CreatePed(29, 0x06C3F072, pos.x, pos.y, pos.z, 90.0, true, false)
	SetEntityHealth(ped, 0)
end)

RegisterNetEvent('fishing:setbait')
AddEventHandler('fishing:setbait', function(bool)
	bait = bool
	print(bait)
end)

RegisterNetEvent('fishing:fishstart')
AddEventHandler('fishing:fishstart', function()
	
	playerPed = GetPlayerPed(-1)
	local pos = GetEntityCoords(GetPlayerPed(-1))
	if IsPedInAnyVehicle(playerPed) then
		ESX.ShowNotification("~y~No puedes pescar desde un vehículo")
	else
		if pos.y >= 7700 or pos.y <= -4000 or pos.x <= -3700 or pos.x >= 4300 then
			ESX.ShowNotification("~g~Has empezado a pescar")
			TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_STAND_FISHING", 0, true)
			fishing = true
		else
			ESX.ShowNotification("~y~Necesitas ir más lejos de la orilla")
		end
	end
	
end, false)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
	
        for k in pairs(Config.MarkerZones) do
        	local ped = PlayerPedId()
            local pedcoords = GetEntityCoords(ped, false)
            local distance = Vdist(pedcoords.x, pedcoords.y, pedcoords.z, Config.MarkerZones[k].x, Config.MarkerZones[k].y, Config.MarkerZones[k].z)
            if distance <= 1.40 then

					ESX.ShowHelpNotification('Presiona ~INPUT_CONTEXT~ para alquilar un bote')
					
					if IsControlJustPressed(0, Keys['E']) and IsPedOnFoot(ped) then
						OpenBoatsMenu(Config.MarkerZones[k].xs, Config.MarkerZones[k].ys, Config.MarkerZones[k].zs)
					end 
			elseif distance < 1.45 then
				ESX.UI.Menu.CloseAll()
            end
		end
		
		for k in pairs(Config.deleteVehicleZones) do
        	local ped = PlayerPedId()
            local pedcoords = GetEntityCoords(ped, false)
            local playerPed = GetPlayerPed(-1)
			local vehicle = GetVehiclePedIsIn(playerPed, false)
            local distance = Vdist(pedcoords.x, pedcoords.y, pedcoords.z, Config.deleteVehicleZones[k].x, Config.deleteVehicleZones[k].y, Config.deleteVehicleZones[k].z)
				
			if distance <= 1.40 then
				
				ESX.ShowHelpNotification("Presiona ~INPUT_CONTEXT~ para borrar el vehículo")

				if IsPedInAnyVehicle(playerPed,  false) and IsControlJustPressed(0, Keys['E'])then
						deleteVehicle(vehicle)
				else
					ESX.ShowNotification("No estas dentro de ningun vehiculo")
				end

			end
		end

    end
end)

function OpenBoatsMenu(x, y , z)
	local ped = PlayerPedId()
	PlayerData = ESX.GetPlayerData()
	local elements = {}
	
		table.insert(elements, {label = '<span style="color:green;">Tug boat</span>', value = 'boat'})
		
	--If user has police job they will be able to get free Police Predator boat
	if PlayerData.job.name == "police" then
		table.insert(elements, {label = '<span style="color:green;">Police Predator</span>', value = 'police'})
	end
	
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'client',
    {
		title    = 'Alquila un bote',
		align    = 'bottom-right',
		elements = elements,
    },
	
	function(data, menu)

	if data.current.value == 'boat' then
		ESX.UI.Menu.CloseAll()
		SetPedCoordsKeepVehicle(ped, x, y, z)
		TriggerEvent('esx:spawnVehicle', "tug")
	end
	
	if data.current.value == 'police' then
		ESX.UI.Menu.CloseAll()

		TriggerEvent("chatMessage", 'Has sacado un bote')
		SetPedCoordsKeepVehicle(ped, x, y , z)
		TriggerEvent('esx:spawnVehicle', "predator")
	end
	ESX.UI.Menu.CloseAll()
	

    end,
	function(data, menu)
		menu.close()
		end
	)
end
