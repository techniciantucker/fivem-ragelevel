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

ESX                             = nil
local PlayerData                = {}
local GUI                       = {}
GUI.Time                        = 0
local HasAlreadyEnteredMarker   = false
local LastZone                  = nil
local CurrentAction             = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}
local onDuty                    = false
local BlipCloakRoom             = nil
local BlipVehicle               = nil
local BlipVehicleDeleter		= nil
local Blips                     = {}
local OnJob                     = false
local Done 						= false
local JobBlips                = {}
local NPCLastCancel = GetGameTimer() - 5 * 60000

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
	onDuty = false
	blips()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
	onDuty = false
	deleteBlips()
	blips()
end)

-- NPC MISSIONS

function SelectPool()
    local index = GetRandomIntInRange(1,  #Config.Pool)

    for k,v in pairs(Config.Zones) do
      if v.Pos.x == Config.Pool[index].x and v.Pos.y == Config.Pool[index].y and v.Pos.z == Config.Pool[index].z then
        return k
      end
    end
end

function StartNPCJob()
    NPCTargetPool     = SelectPool()
	local zone            = Config.Zones[NPCTargetPool]

	TriggerServerEvent('esx_srptrabajopubli:askStress')
		Wait(500)
		if stressValue < 750000 then
			Blips['NPCTargetPool'] = AddBlipForCoord(zone.Pos.x,  zone.Pos.y,  zone.Pos.z)
			SetBlipRoute(Blips['NPCTargetPool'], true)
			ESX.ShowNotification(_U('GPS_info'))
			Done = true
			TriggerServerEvent('esx_srptrabajopubli:addStress')
		else
			ESX.ShowNotification('Estas demasiado cansado, devuelve el vehículo a la central y tomate un descanso')
		
			if Blips['NPCTargetPool'] ~= nil then
				RemoveBlip(Blips['NPCTargetPool'])
				Blips['NPCTargetPool'] = nil
			end
		  
			OnJob = false
			ESX.ShowNotification(_U('cancel_mission'))
		end
end

function StopNPCJob(cancel)

    if Blips['NPCTargetPool'] ~= nil then
      RemoveBlip(Blips['NPCTargetPool'])
      Blips['NPCTargetPool'] = nil
	end

	OnJob = false

    if cancel then
	  ESX.ShowNotification(_U('cancel_mission'))
	else
		TriggerServerEvent('esx_srptrabajopubli:GiveItem')
		StartNPCJob()
		Done = true
	end
end

--[[ ************** STRESS GET AND SET ************** ]]

RegisterNetEvent('esx_srptrabajopubli:returnStress')
AddEventHandler('esx_srptrabajopubli:returnStress', function(stress)
	stressValue = stress
end)

function deleteBlips()
	if JobBlips[1] ~= nil then
		for i=1, #JobBlips, 1 do
		RemoveBlip(JobBlips[i])
		JobBlips[i] = nil
		end
	end
end

function blips()
	if PlayerData.job ~= nil and PlayerData.job.name == 'works' then
	
		local blip = AddBlipForCoord(Config.Zones.Cloakroom.Pos.x, Config.Zones.Cloakroom.Pos.y, Config.Zones.Cloakroom.Pos.z)
		SetBlipSprite (blip, 280)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip7, 0.9)
		SetBlipColour (blip, 5)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Vestuario")
		EndTextCommandSetBlipName(blip)
		table.insert(JobBlips, blip)
	end
	
	if PlayerData.job ~= nil and PlayerData.job.name == 'works' then
		local blip2 = AddBlipForCoord(Config.Zones.VehicleSpawner.Pos.x, Config.Zones.VehicleSpawner.Pos.y, Config.Zones.VehicleSpawner.Pos.z)
		SetBlipSprite (blip2, 441)
		SetBlipDisplay(blip2, 4)
		SetBlipScale  (blip2, 0.9)
		SetBlipColour (blip2, 5)
		SetBlipAsShortRange(blip2, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Sacar vehículo del garaje")
		EndTextCommandSetBlipName(blip2)
		table.insert(JobBlips, blip2)
	end

	if PlayerData.job ~= nil and PlayerData.job.name == 'works' then
		local blip3 = AddBlipForCoord(Config.Zones.Vente.Pos.x, Config.Zones.Vente.Pos.y, Config.Zones.Vente.Pos.z)
		SetBlipSprite (blip3, 354)
		SetBlipDisplay(blip3, 4)
		SetBlipScale  (blip3, 1.2)
		SetBlipColour (blip3, 5)
		SetBlipAsShortRange(blip3, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Canjear facturas")
		EndTextCommandSetBlipName(blip3)
		table.insert(JobBlips, blip3)
	end

	if PlayerData.job ~= nil and PlayerData.job.name == 'works' then
		local blip4 = AddBlipForCoord(Config.Zones.VehicleSpawnPoint.Pos.x, Config.Zones.VehicleSpawnPoint.Pos.y, Config.Zones.VehicleSpawnPoint.Pos.z)
		SetBlipSprite (blip4, 357)
		SetBlipDisplay(blip4, 4)
		SetBlipScale  (blip4, 0.9)
		SetBlipColour (blip4, 5)
		SetBlipAsShortRange(blip4, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Almacenar vehículo")
		EndTextCommandSetBlipName(blip4)
		table.insert(JobBlips, blip4)
	end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)

        if NPCTargetPool ~= nil then

            local coords = GetEntityCoords(GetPlayerPed(-1))
            local zone   = Config.Zones[NPCTargetPool]
			local playerPed = GetPlayerPed(-1)
			

           	if GetDistanceBetweenCoords(coords, zone.Pos.x, zone.Pos.y, zone.Pos.z, true) < 3 then
				if IsPedInAnyVehicle(playerPed, 0) then

					ESX.ShowHelpNotification('No puede realizar el trabajo desde tu vehiculo...')
					
				else
					HelpPromt(_U('pickup'))

					if IsControlJustReleased(1, Keys["E"]) and PlayerData.job ~= nil then
						TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_CLIPBOARD", 0, true)
						Wait(10000)
						TaskStartScenarioInPlace(playerPed, "CODE_HUMAN_POLICE_INVESTIGATE", 0, true)
						Wait(12000)
						TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_WELDING", 0, true)
						Wait(17000)
						StopNPCJob()
						Wait(3000)
						ClearPedTasksImmediately(playerPed)
						Done = false
					end
				end
            end
        end
    end
end)

-- Funcion servicio
function CloakRoomMenu()

	local elements = {}

	if onDuty then
		table.insert(elements, {label = _U('end_service'), value = 'citizen_wear'})
	else
		table.insert(elements, {label = _U('take_service'), value = 'job_wear'})
	end

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'cloakroom',
        {
            title = 'Caseta de trabajo',
			align    = 'right',
            elements = elements
        },
        function(data, menu)

            if data.current.value == 'citizen_wear' then
				onDuty = false
				--[[ CreateBlip() ]]
				menu.close()
                ESX.ShowNotification(_U('end_service_notif'))
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
	    			TriggerEvent('skinchanger:loadSkin', skin)
				end)
            end

            if data.current.value == 'job_wear' then
				onDuty = true
				--[[ CreateBlip() ]]
                menu.close()
				ESX.ShowNotification(_U('take_service_notif'))
				ESX.ShowNotification(_U('start_job'))
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
	    			if skin.sex == 0 then
	    				TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
					else
	    				TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
					end
				end)
            end

            CurrentAction     = 'cloakroom_menu'
            CurrentActionMsg  = Config.Zones.Cloakroom.hint
            CurrentActionData = {}
        end,
        function(data, menu)

            menu.close()

			CurrentAction     = 'cloakroom_menu'
			CurrentActionMsg  = Config.Zones.Cloakroom.hint
            CurrentActionData = {}
        end
    )

end

--Funcion vehiculo
function VehicleMenu()

    local elements = {
        {label = Config.Vehicles.Truck.Label, value = Config.Vehicles.Truck}
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'spawn_vehicle',
        {
            title    = _U('Vehicle_Menu_Title'),
            elements = elements
        },
        function(data, menu)
            for i=1, #elements, 1 do
				menu.close()
				local playerPed = GetPlayerPed(-1)
				local coords    = Config.Zones.VehicleSpawnPoint.Pos
				local Heading    = Config.Zones.VehicleSpawnPoint.Heading
				local platenum = math.random(1000, 9999)
				local platePrefix = Config.platePrefix
				ESX.Game.SpawnVehicle(data.current.value.Hash, coords, Heading, function(vehicle)
					TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
					SetVehicleNumberPlateText(vehicle, platePrefix .. platenum)
					plate = GetVehicleNumberPlateText(vehicle)
					plate = string.gsub(plate, " ", "")
					name = 'Véhicule de '..platePrefix
					TriggerServerEvent('esx_vehiclelock:registerkeyjob', name, plate, 'no')
				end)
				break
            end
            menu.close()

    end,
function(data, menu)
    menu.close()
    CurrentAction     = 'vehiclespawn_menu'
    CurrentActionMsg  = Config.Zones.VehicleSpawner.hint
    CurrentActionData = {}
end
)
end

-- Entra al marcador
AddEventHandler('esx_srptrabajopubli:hasEnteredMarker', function(zone)

    if zone == 'Cloakroom' then
        CurrentAction        = 'cloakroom_menu'
        CurrentActionMsg     = Config.Zones.Cloakroom.hint
        CurrentActionData    = {}
    end

    if zone == 'VehicleSpawner' then
        CurrentAction        = 'vehiclespawn_menu'
        CurrentActionMsg     = Config.Zones.VehicleSpawner.hint
        CurrentActionData    = {}
    end

    if zone == 'VehicleDeleter' then
        local playerPed = GetPlayerPed(-1)
        if IsPedInAnyVehicle(playerPed,  false) then
          CurrentAction        = 'delete_vehicle'
          CurrentActionMsg     = Config.Zones.VehicleDeleter.hint
          CurrentActionData    = {}
        end
    end

    if zone == 'Vente' then
        CurrentAction        = 'vente'
        CurrentActionMsg     = Config.Zones.Vente.hint
        CurrentActionData    = {}
    end
end)

-- Abandona la zona
AddEventHandler('esx_srptrabajopubli:hasExitedMarker', function(zone)

	if zone == 'Vente' then
		TriggerServerEvent('esx_srptrabajopubli:stopVente')
	end
    CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)

--[[ function CreateBlip()
    if PlayerData.job ~= nil and PlayerData.job.name == Config.nameJob then

		if BlipCloakRoom == nil then
			BlipCloakRoom = AddBlipForCoord(Config.Zones.Cloakroom.Pos.x, Config.Zones.Cloakroom.Pos.y, Config.Zones.Cloakroom.Pos.z)
			SetBlipSprite(BlipCloakRoom, Config.Zones.Cloakroom.BlipSprite)
			SetBlipColour(BlipCloakRoom, Config.Zones.Cloakroom.BlipColor)
			SetBlipAsShortRange(BlipCloakRoom, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(Config.Zones.Cloakroom.BlipName)
			EndTextCommandSetBlipName(BlipCloakRoom)
		end
	else

        if BlipCloakRoom ~= nil then
            RemoveBlip(BlipCloakRoom)
            BlipCloakRoom = nil
        end
	end

	if PlayerData.job ~= nil and PlayerData.job.name == Config.nameJob and onDuty then

        BlipVehicle = AddBlipForCoord(Config.Zones.VehicleSpawner.Pos.x, Config.Zones.VehicleSpawner.Pos.y, Config.Zones.VehicleSpawner.Pos.z)
        SetBlipSprite(BlipVehicle, Config.Zones.VehicleSpawner.BlipSprite)
        SetBlipColour(BlipVehicle, Config.Zones.VehicleSpawner.BlipColor)
        SetBlipAsShortRange(BlipVehicle, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.Zones.VehicleSpawner.BlipName)
        EndTextCommandSetBlipName(BlipVehicle)

        BlipVente = AddBlipForCoord(Config.Zones.Vente.Pos.x, Config.Zones.Vente.Pos.y, Config.Zones.Vente.Pos.z)
        SetBlipSprite(BlipVente, Config.Zones.Vente.BlipSprite)
        SetBlipColour(BlipVente, Config.Zones.Vente.BlipColor)
        SetBlipAsShortRange(BlipVente, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.Zones.Vente.BlipName)
        EndTextCommandSetBlipName(BlipVente)

        BlipVehicleDeleter = AddBlipForCoord(Config.Zones.VehicleDeleter.Pos.x, Config.Zones.VehicleDeleter.Pos.y, Config.Zones.VehicleDeleter.Pos.z)
        SetBlipSprite(BlipVehicleDeleter, Config.Zones.VehicleDeleter.BlipSprite)
        SetBlipColour(BlipVehicleDeleter, Config.Zones.VehicleDeleter.BlipColor)
        SetBlipAsShortRange(BlipVehicleDeleter, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.Zones.VehicleDeleter.BlipName)
        EndTextCommandSetBlipName(BlipVehicleDeleter)
    else

        if BlipVehicle ~= nil then
            RemoveBlip(BlipVehicle)
            BlipVehicle = nil
        end

        if BlipVente ~= nil then
            RemoveBlip(BlipVente)
            BlipVente = nil
        end

        if BlipVehicleDeleter ~= nil then
            RemoveBlip(BlipVehicleDeleter)
            BlipVehicleDeleter = nil
        end
    end
end
 ]]
-- Activation du marker au sol
Citizen.CreateThread(function()
	while true do
		Wait(0)
		if PlayerData.job ~= nil then
			local coords = GetEntityCoords(GetPlayerPed(-1))

			if PlayerData.job.name == Config.nameJob then
				if onDuty then

					for k,v in pairs(Config.Zones) do
						if v ~= Config.Zones.Cloakroom then
							if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
								DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
							end
						end
					end

				end

				local Cloakroom = Config.Zones.Cloakroom
				if(Cloakroom.Type ~= -1 and GetDistanceBetweenCoords(coords, Cloakroom.Pos.x, Cloakroom.Pos.y, Cloakroom.Pos.z, true) < Config.DrawDistance) then
					DrawMarker(Cloakroom.Type, Cloakroom.Pos.x, Cloakroom.Pos.y, Cloakroom.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Cloakroom.Size.x, Cloakroom.Size.y, Cloakroom.Size.z, Cloakroom.Color.r, Cloakroom.Color.g, Cloakroom.Color.b, 100, false, true, 2, false, false, false, false)
				end
			end
		end
	end
end)

-- Detección del entrante / salida de la zona del trabajo

Citizen.CreateThread(function()
	while true do
		Wait(1)
		if PlayerData.job ~= nil then
			local coords      = GetEntityCoords(GetPlayerPed(-1))
			local isInMarker  = false
			local currentZone = nil

			if PlayerData.job.name == Config.nameJob then
				if onDuty then
					for k,v in pairs(Config.Zones) do
						if v ~= Config.Zones.Cloakroom then
							if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) <= v.Size.x) then
								isInMarker  = true
								currentZone = k
							end
						end
					end
				end

				local Cloakroom = Config.Zones.Cloakroom
				if(GetDistanceBetweenCoords(coords, Cloakroom.Pos.x, Cloakroom.Pos.y, Cloakroom.Pos.z, true) <= Cloakroom.Size.x) then
					isInMarker  = true
					currentZone = "Cloakroom"
				end
			end

			if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
				HasAlreadyEnteredMarker = true
				LastZone                = currentZone
				TriggerEvent('esx_srptrabajopubli:hasEnteredMarker', currentZone)
			end
			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('esx_srptrabajopubli:hasExitedMarker', LastZone)
			end
		end
	end
end)

-- Action après la demande d'accés
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if CurrentAction ~= nil then
            SetTextComponentFormat('STRING')
            AddTextComponentString(CurrentActionMsg)
            DisplayHelpTextFromStringLabel(0, 0, 1, -1)
            if (IsControlJustReleased(1, Keys["E"]) or IsControlJustReleased(2, Keys["RIGHT"])) and PlayerData.job ~= nil then
				local playerPed = GetPlayerPed(-1)
				if PlayerData.job.name == Config.nameJob then
					if CurrentAction == 'cloakroom_menu' then
						if IsPedInAnyVehicle(playerPed, 0) then
							ESX.ShowNotification(_U('in_vehicle'))
						else
							CloakRoomMenu()
						end
					end
					if CurrentAction == 'vehiclespawn_menu' then
						if IsPedInAnyVehicle(playerPed, 0) then
							ESX.ShowNotification(_U('in_vehicle'))
						else
							VehicleMenu()
						end
					end
					if CurrentAction == 'vente' then
						TriggerServerEvent('esx_srptrabajopubli:startVente')
						TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_CLIPBOARD", 0, 1)
					end
					if CurrentAction == 'delete_vehicle' then
					  local playerPed = GetPlayerPed(-1)
					  local vehicle   = GetVehiclePedIsIn(playerPed,  false)
					  local hash      = GetEntityModel(vehicle)
					  local plate = GetVehicleNumberPlateText(vehicle)
					  local plate = string.gsub(plate, " ", "")
					  local platePrefix = Config.platePrefix
					
					  ESX.Game.DeleteVehicle(vehicle)

--[[ 					  if string.find (plate, platePrefix) then
						local truck = Config.Vehicles.Truck

						if hash == GetHashKey(truck.Hash) then
						end
					  else
						ESX.ShowNotification(_U('bad_vehicle'))
					  end ]]

					end
               	    CurrentAction = nil
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if IsControlJustReleased(1, Keys["DELETE"]) and PlayerData.job ~= nil and PlayerData.job.name == Config.nameJob then

			if Onjob then
				if GetGameTimer() - NPCLastCancel > 1 * 60000 then
				StopNPCJob(true)
				RemoveBlip(Blips['NPCTargetPool'])
				Onjob = false
				NPCLastCancel = GetGameTimer()
            	else
              	ESX.ShowNotification(_U('wait_five'))
                end
			else
				local playerPed = GetPlayerPed(-1)

				if IsPedInAnyVehicle(playerPed,  false) and IsVehicleModel(GetVehiclePedIsIn(playerPed,  false), GetHashKey("bison2")) then
					StartNPCJob()
					Onjob = true
				else
					ESX.ShowNotification(_U('not_good_veh'))
				end
			end
		end
	end
end)

function setUniform(job, playerPed)
  TriggerEvent('skinchanger:getSkin', function(skin)

    if skin.sex == 0 then
      if Config.Uniforms[job].male ~= nil then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].male)
      else
        ESX.ShowNotification(_U('no_outfit'))
      end
    else
      if Config.Uniforms[job].female ~= nil then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].female)
      else
        ESX.ShowNotification(_U('no_outfit'))
      end
    end

  end)
end

function HelpPromt(text)
	Citizen.CreateThread(function()
		SetTextComponentFormat("STRING")
		AddTextComponentString(text)
		DisplayHelpTextFromStringLabel(0, state, 0, -1)
	end)
end