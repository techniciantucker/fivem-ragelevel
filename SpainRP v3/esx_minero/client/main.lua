local PlayerData                = {}
ESX                             = nil

local blip1 = {}
local blips = false
local blipActive = false
local mineActive = false
local washingActive = false
local remeltingActive = false
local firstspawn = false
local impacts = 0
local timer = 0
local isInService = false
local locations = {
    { ['x'] = -591.47,  ['y'] = 2076.52,  ['z'] = 131.37},
    { ['x'] = -590.35,  ['y'] = 2071.76,  ['z'] = 131.29},
    { ['x'] = -589.61,  ['y'] = 2069.3,  ['z'] = 131.19},
    { ['x'] = -588.6,  ['y'] = 2064.03,  ['z'] = 130.96},
}
local JobBlips                = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	blips()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
	deleteBlips()
	blips()
end)

RegisterNetEvent("esx_srpminero:washing")
AddEventHandler("esx_srpminero:washing", function()
    Washing()
end)

RegisterNetEvent("esx_srpminero:remelting")
AddEventHandler("esx_srpminero:remelting", function()
    Remelting()
end)

RegisterNetEvent('esx_srpminero:timer')
AddEventHandler('esx_srpminero:timer', function()
    local timer = 0
    local ped = PlayerPedId()
    
    Citizen.CreateThread(function()
		while timer > -1 do
			Citizen.Wait(150)

			if timer > -1 then
				timer = timer + 1
            end
            if timer == 100 then
                break
            end
		end
    end) 

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1)
            if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.WashingX, Config.WashingY, Config.WashingZ, true) < 5 then
                Draw3DText( Config.WashingX, Config.WashingY, Config.WashingZ+0.5 -1.400, ('Lavando piedras en progreso ' .. timer .. '%'), 4, 0.1, 0.1)
            end
            if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.RemeltingX, Config.RemeltingY, Config.RemeltingZ, true) < 5 then
                Draw3DText( Config.RemeltingX, Config.RemeltingY, Config.RemeltingZ+0.5 -1.400, ('Fundiendo piedras en progreso ' .. timer .. '%'), 4, 0.1, 0.1)
            end
            if timer == 100 then
                timer = 0
                break
            end
        end
    end)
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
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == Config.jobName then
       
        blip1 = AddBlipForCoord(-597.01, 2091.42, 131.41)
        SetBlipSprite(blip1, 486)
        SetBlipColour(blip1, 5)
        SetBlipAsShortRange(blip1, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Mina")
        EndTextCommandSetBlipName(blip1)
        table.insert(JobBlips, blip1)
  
        blip2 = AddBlipForCoord(Config.WashingX, Config.WashingY, Config.WashingZ)

        SetBlipSprite(blip2, 365)
        SetBlipColour(blip2, 5)
        SetBlipAsShortRange(blip2, true)
        SetBlipScale  (blip2, 1.1)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Lavado de piedras")
        EndTextCommandSetBlipName(blip2)
        table.insert(JobBlips, blip2)

        blip3 = AddBlipForCoord(Config.RemeltingX, Config.RemeltingY, Config.RemeltingZ)

        SetBlipSprite(blip3, 365)
        SetBlipColour(blip3, 5)
        SetBlipAsShortRange(blip3, true)
        SetBlipScale  (blip3, 1.1)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Fundición de piedras")
        EndTextCommandSetBlipName(blip3)
        table.insert(JobBlips, blip3)

        blip4 = AddBlipForCoord(Config.SellX, Config.SellY, Config.SellZ)

        SetBlipSprite(blip4, 272)
        SetBlipColour(blip4, 5)
        SetBlipAsShortRange(blip4, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Venta de piedras")
        EndTextCommandSetBlipName(blip4)
        table.insert(JobBlips, blip4)

        blip5 = AddBlipForCoord(Config.CloakroomX, Config.CloakroomY, Config.CloakroomZ)
        SetBlipSprite(blip5, 280)
        SetBlipColour(blip5, 5)
        SetBlipAsShortRange(blip5, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Caseta de minería")
        EndTextCommandSetBlipName(blip5)
        table.insert(JobBlips, blip5)

    end
end

Citizen.CreateThread(function()
    while true do
	local ped = PlayerPedId()
        Citizen.Wait(1)
            if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'miner' and not IsEntityDead( ped ) then
                if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.CloakroomX, Config.CloakroomY, Config.CloakroomZ, true) < 60 then
                    DrawMarker(1, Config.CloakroomX, Config.CloakroomY, Config.CloakroomZ, 0, 0, 0, 0, 0, 90.0, 1.5, 1.5, 1.5, 0, 155, 253, 155, 0, 0, 2, 0, 0, 0, 0)
                    DrawMarker(1, Config.deletevehicleX, Config.deletevehicleY, Config.deletevehicleZ, 0, 0, 0, 0, 0, 90.0, 1.5, 1.5, 1.5, 0, 155, 253, 155, 0, 0, 2, 0, 0, 0, 0)
                        if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.CloakroomX, Config.CloakroomY, Config.CloakroomZ, true) < 1.5 then
                            ESX.ShowHelpNotification('Presiona ~INPUT_CONTEXT~ para acceder al vestuario.')
                                if IsControlJustReleased(1, 51) then
                                    Cloakroom() 
                                end
                         end
                 end
            end
        end
end)


Citizen.CreateThread(function()
    while true do
	local ped = PlayerPedId()
        Citizen.Wait(1)
            if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'miner' and not IsEntityDead( ped ) then
                for k in pairs(Config.deleteVehicleZones) do
                    local ped = PlayerPedId()
                    local pedcoords = GetEntityCoords(ped, false)
                    local playerPed = GetPlayerPed(-1)
                    local vehicle = GetVehiclePedIsIn(playerPed, false)
                    local distance = Vdist(pedcoords.x, pedcoords.y, pedcoords.z, Config.deleteVehicleZones[k].x, Config.deleteVehicleZones[k].y, Config.deleteVehicleZones[k].z)
                        
                    if distance <= 1.40 then

                        
                        ESX.ShowHelpNotification("Presiona ~INPUT_CONTEXT~ para guardar el vehículo en el garaje")
        
                        if IsPedInAnyVehicle(playerPed,  false) and IsControlJustPressed(0, 38)then
                                deleteVehicle(vehicle)
                        else
                            ESX.ShowNotification("Debes estar dentro de un vehiculo")
                        end
        
                    end
                end
            end
        end
end)


function deleteVehicle(vehicle)

	ESX.Game.DeleteVehicle(vehicle)

end

Citizen.CreateThread(function()
    while true do
	local ped = PlayerPedId()
        Citizen.Wait(1)
        if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'miner' and not IsEntityDead( ped ) and isInService == true then

            for i=1, #locations, 1 do
            if GetDistanceBetweenCoords(GetEntityCoords(ped), locations[i].x, locations[i].y, locations[i].z, true) < 25 and mineActive == false then
                DrawMarker(20, locations[i].x, locations[i].y, locations[i].z, 0, 0, 0, 0, 180.0, 75.0, 1.0, 1.0, 1.0, 0, 155, 253, 155, 1, 0, 2, 0, 0, 0, 0)
                    if GetDistanceBetweenCoords(GetEntityCoords(ped), locations[i].x, locations[i].y, locations[i].z, true) < 1 then
                        ESX.ShowHelpNotification("Presiona ~INPUT_CONTEXT~ para empezar a picar.")
                            if IsControlJustReleased(1, 51) then
                                Animation()
                                mineActive = true
                            end
                    end
            end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
	local ped = PlayerPedId()
        Citizen.Wait(1)
        if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'miner' and not IsEntityDead( ped ) and isInService == true then
            if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.WashingX, Config.WashingY, Config.WashingZ, true) < 25 and washingActive == false then
                DrawMarker(1, Config.WashingX, Config.WashingY, Config.WashingZ, 0, 0, 0, 0, 0, 55.0, 1.5, 1.5, 1.5, 0, 155, 253, 155, 0, 0, 2, 0, 0, 0, 0)
                    if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.WashingX, Config.WashingY, Config.WashingZ, true) < 1.5 then
                        ESX.ShowHelpNotification("Presiona ~INPUT_CONTEXT~ para lavar las piedras.")
                            if IsControlJustReleased(1, 51) then
                                TriggerServerEvent("esx_srpminero:washing")
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
	local ped = PlayerPedId()
        Citizen.Wait(1)
        if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'miner' and not IsEntityDead( ped ) and isInService == true then

            if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.RemeltingX, Config.RemeltingY, Config.RemeltingZ, true) < 25 and remeltingActive == false then
                DrawMarker(1, Config.RemeltingX, Config.RemeltingY, Config.RemeltingZ, 0, 0, 0, 0, 0, 55.0, 1.5, 1.5, 1.5, 0, 155, 253, 155, 0, 0, 2, 0, 0, 0, 0)
                    if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.RemeltingX, Config.RemeltingY, Config.RemeltingZ, true) < 1.5 then
                        ESX.ShowHelpNotification("Presiona ~INPUT_CONTEXT~ para fundir piedras.")
                            if IsControlJustReleased(1, 51) then
                            TriggerServerEvent("esx_srpminero:remelting")  
                        end
                    end
                end
            end
        end
    end)

Citizen.CreateThread(function()
    while true do
	local ped = PlayerPedId()
        Citizen.Wait(1)
        if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'miner' and not IsEntityDead( ped ) and isInService == true then

                if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.SellX, Config.SellY, Config.SellZ, true) < 2 then
                    ESX.ShowHelpNotification("Presiona ~INPUT_CONTEXT~ para vender piedras.")
                        if IsControlJustReleased(1, 51) then
                            Jeweler()                          
                        end
                end
        end
    end
 end)
    

Citizen.CreateThread(function()
    local hash = GetHashKey("ig_natalia")

    if not HasModelLoaded(hash) then
        RequestModel(hash)
        Citizen.Wait(100)
    end

    while not HasModelLoaded(hash) do
        Citizen.Wait(0)
    end

    if firstspawn == false then
        local npc = CreatePed(6, hash, Config.SellX, Config.SellY, Config.SellZ, 129.0, false, false)
        SetEntityInvincible(npc, true)
        FreezeEntityPosition(npc, true)
        SetPedDiesWhenInjured(npc, false)
        SetPedCanRagdollFromPlayerImpact(npc, false)
        SetPedCanRagdoll(npc, false)
--[[         SetEntityAsMissionEntity(npc, true, true)
 ]]
        SetBlockingOfNonTemporaryEvents(npc, true)
    end
end)

function Cloakroom()
    local elements = {
        {label = 'Ropa de civil',   value = 'cloakroom1'},
        {label = 'Ropa de trabajo',      value = 'cloakroom2'},
        {label = 'Vehiculo de trabajo',       value = 'vehicle'},
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'miner_actions', {
        title    = 'Caseta del minero',
        align    = 'top-left',
        elements = elements
    }, function(data, menu)
        if data.current.value == 'cloakroom1' then
            menu.close()
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                TriggerEvent('skinchanger:loadSkin', skin)
            end)  
            blips = false
            blipActive = false
            isInService = false
        elseif data.current.value == 'cloakroom2' then
            menu.close()
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                if skin.sex == 0 then
                    TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
                else
                    TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
                end
                blips = true
                isInService = true
            end)
        elseif data.current.value == 'vehicle' then
            menu.close()
            RequestModel("rumpo3")
            Citizen.Wait(100)
            CreateVehicle("rumpo3", -283.82, 2546.95, 73.13, 0.0, true, true)
            ESX.ShowNotification("Has sacado el vehículo del garaje.")
        end
    end, function(data, menu)
        menu.close()
    end)
end

function Jeweler()
    local elements = {
        {label = 'Vender diamantes',   value = 'diamonds'},
        {label = 'Vender oro',      value = 'gold'},
        {label = 'Vender hierro',       value = 'iron'},
        {label = 'Vender cobre',       value = 'copper'},
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'jeweler_actions', {
        title    = 'Joyero - Venta de piedras',
        align    = 'top-left',
        elements = elements
    }, function(data, menu)
        if data.current.value == 'diamonds' then
            menu.close()
            TriggerServerEvent("esx_srpminero:selldiamond")
        elseif data.current.value == 'gold' then
            menu.close()
            TriggerServerEvent("esx_srpminero:sellgold")
        elseif data.current.value == 'iron' then
            menu.close()
            TriggerServerEvent("esx_srpminero:selliron")
        elseif data.current.value == 'copper' then
            menu.close()
            TriggerServerEvent("esx_srpminero:sellcopper")
        end
	end, function(data, menu)
        menu.close()
 
    end)
end

function Animation()
    Citizen.CreateThread(function()
        while impacts < 5 do
            Citizen.Wait(1)
		local ped = PlayerPedId()	
                RequestAnimDict("melee@large_wpn@streamed_core")
                Citizen.Wait(100)
                TaskPlayAnim((ped), 'melee@large_wpn@streamed_core', 'ground_attack_on_spot', 8.0, 8.0, -1, 80, 0, 0, 0, 0)
                SetEntityHeading(ped, 270.0)
                TriggerServerEvent('InteractSound_SV:PlayOnSource', 'pickaxe', 0.5)
                if impacts == 0 then
                    pickaxe = CreateObject(GetHashKey("prop_tool_pickaxe"), 0, 0, 0, true, true, true) 
                    AttachEntityToEntity(pickaxe, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.18, -0.02, -0.02, 350.0, 100.00, 140.0, true, true, false, true, 1, true)
                end  
                Citizen.Wait(2500)
                ClearPedTasks(ped)
                impacts = impacts+1
                if impacts == 5 then
                    DetachEntity(pickaxe, 1, true)
                    DeleteEntity(pickaxe)
                    DeleteObject(pickaxe)
                    mineActive = false
                    impacts = 0
                    TriggerServerEvent("esx_srpminero:givestone")
                    break
                end        
        end
    end)
end

function Washing()
    local ped = PlayerPedId()
    RequestAnimDict("amb@prop_human_bum_bin@idle_a")
    washingActive = true
    Citizen.Wait(100)
    FreezeEntityPosition(ped, true)
    TaskPlayAnim((ped), 'amb@prop_human_bum_bin@idle_a', 'idle_a', 8.0, 8.0, -1, 81, 0, 0, 0, 0)
    TriggerEvent("esx_srpminero:timer")
    Citizen.Wait(15900)
    ClearPedTasks(ped)
    FreezeEntityPosition(ped, false)
    washingActive = false
end

function Remelting()
    local ped = PlayerPedId()
    RequestAnimDict("amb@prop_human_bum_bin@idle_a")
    remeltingActive = true
    Citizen.Wait(100)
    FreezeEntityPosition(ped, true)
    TaskPlayAnim((ped), 'amb@prop_human_bum_bin@idle_a', 'idle_a', 8.0, 8.0, -1, 81, 0, 0, 0, 0)
    TriggerEvent("esx_srpminero:timer")
    Citizen.Wait(15900)
    ClearPedTasks(ped)
    FreezeEntityPosition(ped, false)
    remeltingActive = false
end

function Draw3DText(x,y,z,textInput,fontId,scaleX,scaleY)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)    
    local scale = (1/dist)*20
    local fov = (1/GetGameplayCamFov())*100 
    SetTextScale(0.35, 0.35)
    SetTextFont(fontId)
    SetTextProportional(0)
    SetTextColour(255, 255, 255, 215)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x,y,z+2, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()   
end
