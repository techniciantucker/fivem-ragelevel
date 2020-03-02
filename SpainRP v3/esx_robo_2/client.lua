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
local PlayerData              	= {}

onMission = false
local HuntCar = nil
misionCar = false

blips = {}
peds = {}
pickups = {}

lastDoor = 1
currentVan = nil

shouldDraw = false

missionVehicles = {
	"Rumpo2"
}

local Positions = {
	['SpawnATV'] = { ['x'] = 540.88, ['y'] = -1945.08, ['z'] = 24.98 }
}

local marker = {
	{ name="Hunting", blipName='Ortega', hint='Presiona ~INPUT_CONTEXT~ para hablar con Ortega', id=66, x=544.49, y= -1947.95, z=24.98},
}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	local hash = GetHashKey("ig_ortega")
	while not HasModelLoaded(hash) do
		RequestModel(hash)
		Wait(20)
	end
	ped = CreatePed("PED_TYPE_CIVMALE", hash, 543.15, -1948.83, 23.98, 306.53, false, true)

	SetBlockingOfNonTemporaryEvents(ped, true)
	FreezeEntityPosition(ped, true)
	SetEntityInvincible(ped,true)
	TaskStartScenarioInPlace(ped,'WORLD_HUMAN_SMOKING_POT', 8.0, -8.0, -1, 1, 0, false, false, false)

	ScriptLoaded()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

function ScriptLoaded()
	Citizen.Wait(1000)
	LoadMarkers()
end



function LoadMarkers()
	Citizen.CreateThread(function()
		for _, item in pairs(marker) do
			item.blip = AddBlipForCoord(item.x, item.y, item.z)
			SetBlipSprite(item.blip, item.id)
			SetBlipColour(item.blip, 1)
			SetBlipAsShortRange(item.blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(item.blipName)
			EndTextCommandSetBlipName(item.blip)
		end
	end)

	LoadModel('Rumpo2')

	Citizen.CreateThread(function()
		while true do
			local sleep = 500
			
			local plyCoords = GetEntityCoords(PlayerPedId())

			for _, item in pairs(marker) do
				if item.hint ~= nil then

					local distance = GetDistanceBetweenCoords(plyCoords, item.x, item.y, item.z, true)

					if distance < 5.0 then
						sleep = 5
						DrawM(item.hint, 1, item.x, item.y, item.z - 0.945, 255, 255, 255, 1.5, 15)
						ESX.ShowHelpNotification(item.hint)

						if distance < 1.0 then
							if IsControlJustReleased(0, Keys['E']) then
								if item.name == 'Hunting' then
									SpawnCar()
								end
							end
						end
					end

				end
				
			end
			Citizen.Wait(sleep)
		end
	end)
end

RegisterNetEvent('esx_carthief:returnStress')
AddEventHandler('esx_carthief:returnStress', function(stress)
	stressValue = stress
end)

function SpawnCar()
		local time = TimeToSeconds(GetClockTime())
		
		TriggerServerEvent('esx_carthief:askStress')
		Wait(500)
		if stressValue < 750000 then
			
		TriggerServerEvent('esx_carthief:addStress')
		-- check time
			if time >= 0 and time <= TimeToSeconds(5, 30, 0) then
				
				if misionCar == false then
					HuntCar = CreateVehicle(GetHashKey('Rumpo2'), Positions['SpawnATV'].x, Positions['SpawnATV'].y, Positions['SpawnATV'].z, 298.61, true, false)
					ESX.ShowAdvancedNotification('Ortega', ' ', 'Subete en el vehículo y pulsa ~g~[E]~w~ para empezar con el trabajo.', 'CHAR_ORTEGA', 1)
					misionCar = true
				else
					ESX.ShowNotification('Ya tienes un vehículo fuera')
				end
			else
				ESX.ShowNotification('No quiero verte por aqui. Vuelve cuando sean las 00:00h...')
			end
		else
			ESX.ShowNotification('Estas demasiado cansado y no estas preparado para este trabajo')
		end
end

CreateThread(function()
	if not HasStreamedTextureDictLoaded('timerbars') then
		RequestStreamedTextureDict('timerbars')
		while not HasStreamedTextureDictLoaded('timerbars') do
			Wait(0)
		end
	end
	
	-- load ipls
	RequestIpl("hei_hw1_blimp_interior_v_studio_lo_milo_")
	RequestIpl("hei_hw1_blimp_interior_v_apart_midspaz_milo_")

	while true do
		Wait(0)

		local time = TimeToSeconds(GetClockTime())

		if time > TimeToSeconds(5, 31, 0) then
			misionCar = false
		end
		
		-- if pressed E in a vehicle and not onMission
		if IsControlJustPressed(0, 51) and not onMission and IsPedInAnyVehicle(PlayerPedId()) then
			local veh = GetVehiclePedIsIn(PlayerPedId(), false)
			
			if IsMissionVehicle(GetEntityModel(veh)) then
				
				if time >= 0 and time <= TimeToSeconds(5, 30, 0) then
					onMission = true
					
					-- spawn blips
					for _,door in pairs(doors) do
						local blip = AddBlipForCoord(door.coords.x, door.coords.y, door.coords.z)
						SetBlipSprite(blip, 40)
						SetBlipColour(blip, 1)
						SetBlipAsShortRange(blip, true)
						
						BeginTextCommandSetBlipName("STRING")
						AddTextComponentString("Casas para robar")
						EndTextCommandSetBlipName(blip)
						
						table.insert(blips, blip)
					end
					
					currentVan = VehToNet(veh)
					SetEntityAsMissionEntity(veh, false, false)
					
					ShowMPMessage("Robo a casas", "Encuentra una ~r~casa ~s~para robar.", 3500)
					--ShowSubtitle("Find a ~r~house ~s~ to rob")
				else
					DisplayHelpText("Las misiones de robo en casas solo pueden realizarse entre las 0:00 - 5:30 AM.")
				end
			end
		end
		
	end
end)

CreateThread(function()
	while true do
		Wait(0)
		
		if onMission then
			-- maths to calculate time until daylight
			local hours, minutes, seconds = GetClockTime()
			local left = TimeToSeconds(5, 30, 0) - TimeToSeconds(hours, minutes, seconds)
			local time = SecondsToTime(left)
			
			-- draw info
			DrawTimerBar("Objetos", #stolenItems, 2)
			DrawTimerBar("Tiempo restante", AddLeadingZero(time.hours) .. ":" .. AddLeadingZero(time.minutes), 1)
		end
	end
end)

CreateThread(function()
	while true do
		Wait(0)
		local coords = GetEntityCoords(PlayerPedId())
		
		if onMission then		
			for k,door in pairs(doors) do
				-- draw marker
				if Vdist(coords, door.coords.x, door.coords.y, door.coords.z) < 100 then
					DrawMarker(0, door.coords.x, door.coords.y, door.coords.z + 0.2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 204, 255, 0, 50, true, true, 2, nil, nil, false)
				end
				
				-- can enter
				if Vdist(coords, door.coords.x, door.coords.y, door.coords.z) < 2 then
					DisplayHelpText("Presiona ~INPUT_CONTEXT~ para entrar a esta casa.")
					
					if IsControlJustPressed(0, 51) then
						local house = houses[door.house]
						
						SetEntityCoords(PlayerPedId(), house.coords.x, house.coords.y, house.coords.z)
						SetEntityHeading(PlayerPedId(), house.coords.heading)
						
						lastDoor = k
						shouldDraw = true
						
						SpawnResidents(door.house)
						
						SpawnPickups(door.house, k)
						
						ShowSubtitle("Ahora estás en la casa, ten cuidado de no hacer demasiado ruido.")
					end
				end
			end
		end
		
		-- check inside
		for _,house in pairs(houses) do
			--DrawBox(house.area[1], house.area[2], 255, 255, 255, 50)
			if IsEntityInArea(PlayerPedId(), house.area[1], house.area[2], 0, 0, 0) and shouldDraw then
				if onMission then
					DrawNoiseBar(GetPlayerCurrentStealthNoise(PlayerId()), 3)
				end
				
				-- draw exit doors in houses (even if not in mission)
				DrawMarker(0, house.door, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 204, 255, 0, 50, true, true, 2, nil, nil, false)
				
				if Vdist(coords, house.door) < 1 then
					local door = doors[lastDoor]
				
					SetEntityCoords(PlayerPedId(), door.coords.x, door.coords.y, door.coords.z)
					RemoveResidents()
					RemovePickups()
					
					shouldDraw = false
					
					-- play holding anim if holding something after teleported outside
					if isHolding then
						TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "walk", 1.0, 1.0, -1, 1 | 16 | 32, 0.0, 0, 0, 0)
					end
				end
			end
		end
	end
end)

function SpawnPickups(house, door)
	for k,pickup in pairs(houses[house].pickups) do
		if not IsAlreadyStolen(door, k) then
			-- spawn prop
			RequestModel(pickup.model)
			
			while not HasModelLoaded(pickup.model) do
				Wait(0)
			end
			
			local prop = CreateObject(GetHashKey(pickup.model), pickup.coord, false, false, false)
			SetEntityHeading(prop, pickup.rotation)
			
			-- create blip
			local blip = AddBlipForCoord(pickup.coord)
			SetBlipColour(blip, 2)
			SetBlipScale(blip, 0.7)
			
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(pickup.model)
			EndTextCommandSetBlipName(blip)
			
			table.insert(pickups, {
				blip = blip,
				prop = prop,
				item = { house = house, id = k, door = door }
			})
		end
	end
end

function RemovePickups()
	for k,pickup in pairs(pickups) do
		RemoveBlip(pickup.blip)
		
		SetObjectAsNoLongerNeeded(pickup.prop)
		DeleteObject(pickup.prop)
	end
	
	pickups = {}
end

function SpawnResidents(house)
	for _,resident in pairs(residents) do
		if resident.house == house then
			RequestModel(resident.model)
		
			while not HasModelLoaded(resident.model) do 
				Wait(0)
			end
			
			local ped = CreatePed(4, resident.model, resident.coord, resident.rotation, false, false)
			table.insert(peds, ped)
			
			-- animation
			RequestAnimDict(resident.animation.dict)
	
			while not HasAnimDictLoaded(resident.animation.dict) do 
				Wait(0) 
			end
			
			if resident.aggressive then
				GiveWeaponToPed(ped, GetHashKey("WEAPON_PISTOL"), 255, true, false)
			end
			
			TaskPlayAnimAdvanced(ped, resident.animation.dict, resident.animation.anim, resident.coord, 0.0, 0.0, resident.rotation, 8.0, 1.0, -1, 1, 1.0, true, true)
			SetFacialIdleAnimOverride(ped, "mood_sleeping_1", 0)
			
			SetPedHearingRange(ped, 3.0)
			SetPedSeeingRange(ped, 0.0)
			SetPedAlertness(ped, 0)
		end
	end
end

function RemoveResidents()
	for k,ped in pairs(peds) do
		SetPedAsNoLongerNeeded(ped)
		DeletePed(ped)
	end
	
	peds = {}
end

function IsAlreadyStolen(door, id)
	for _,v in pairs(stolenItems) do
		if v.door == door and v.id == id then
			return true
		end
	end
	
	return false
end

function GetCurrentHouse()
	for index,house in pairs(houses) do
		if IsEntityInArea(PlayerPedId(), house.area[1], house.area[2], 0, 0, 0) then
			return true, index
		end
	end
	
	return false, index
end

function RemoveBlips()
	for _,blip in pairs(blips) do
		RemoveBlip(blip)
	end
	
	blips = {}
end

function IsMissionVehicle(model)
	for _,v in pairs(missionVehicles) do
		if model == GetHashKey(v) then
			return true
		end
	end
	
	return false
end

function DrawM(hint, type, x, y, z)
	DrawMarker(type, x, y, z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.2, 1.2, 1.2, 255, 50, 50, 255, false, true, 2, false, false, false, false)
end

loadDict = function(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
end

function LoadModel(model)
    while not HasModelLoaded(model) do
          RequestModel(model)
          Citizen.Wait(10)
    end
end