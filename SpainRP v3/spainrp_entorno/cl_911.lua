ESX = nil
blip = nil
blips = {}

displayTime = 120

Citizen.CreateThread(function()
    while ESX == nil do
      TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
      Citizen.Wait(0)
    end
  
    while ESX.GetPlayerData().job == nil do
          Citizen.Wait(10)
      end
  
    PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)
        
Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/entorno', 'Envía una llamada al 911 a los Servicios de emergencia!', {
        { name="motivo", help="Introduce una descripcion del incidente aquí!" }
    })
end)

AddEventHandler('outlawNotify', function(alert)
    if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
        Notify(alert)
    end
end)

RegisterNetEvent('911:setBlip')
AddEventHandler('911:setBlip', function(name, x, y, z)
    if PlayerData.job ~= nil and PlayerData.job.name == 'police' then

        blip = AddBlipForCoord(x, y, z)
        SetBlipSprite(blip, 304)
        SetBlipScale(blip, 1.0)
        SetBlipColour(blip, 3)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Llamada al 911')
        EndTextCommandSetBlipName(blip)
        table.insert(blips, blip)
        Wait(displayTime * 1000)
        for i, blip in pairs(blips) do 
            RemoveBlip(blip)
        end

    end
end)
        
RegisterCommand('entorno', function(source, args)
    local name = GetPlayerName(PlayerId())
    local ped = GetPlayerPed(PlayerId())
    local x, y, z = table.unpack(GetEntityCoords(ped, true))
    local street = GetStreetNameAtCoord(x, y, z)
    local location = GetStreetNameFromHashKey(street)
    local msg = table.concat(args, ' ')
    if args[1] == nil then
        TriggerEvent('chatMessage', '^5Entorno', {255,255,255}, ' ^7Introduce el motivo de la llamada.')
    else
		TriggerServerEvent("esx:entorno",name, msg)
        TriggerEvent('chatMessage', '^5Entorno', {255,255,255}, ' ^7Tu llamada se ha realizado correctamente.')
        TriggerServerEvent('911', location, msg, x, y, z, name)
        TriggerServerEvent('esx_addons_gcphone:startCall', 'police', 'Alerta policial: ' .. msg .. ' ubicado en ' .. location)
    end
end)
        