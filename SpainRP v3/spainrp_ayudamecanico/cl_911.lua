ESX = nil
blip = nil
blips = {}
local blipTime = 120

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
    TriggerEvent('chat:addSuggestion', '/ayudamecanico', 'Envía una llamada a los mecanicos de la ciudad!', {
        { name="motivo", help="Introduce una descripcion del incidente aquí!" }
    })
end)

AddEventHandler('outlawNotify', function(alert)
    if PlayerData.job ~= nil and PlayerData.job.name == 'mechanic' or PlayerData.job.name == 'mecaniconorte' then
        Notify(alert)
    end
end)

RegisterNetEvent('mecanico:setBlip')
 AddEventHandler('mecanico:setBlip', function(name, x, y, z)
    if PlayerData.job ~= nil and PlayerData.job.name == 'mechanic' or PlayerData.job.name == 'mecaniconorte' then
		local transT = 250
        blip = AddBlipForCoord(x, y, z)
		SetBlipSprite(blip,  10)
		SetBlipColour(blip,  5)
		SetBlipAlpha(blip,  transT)
        SetBlipAsShortRange(blip,  false)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Llamada de emergencia')
        EndTextCommandSetBlipName(blip)
		while transT ~= 0 do
			Wait(blipTime * 4)
			transT = transT - 1
			SetBlipAlpha(blip,  transT)
			if transT == 0 then
				SetBlipSprite(blip,  2)
				return
			end
		end
	end
end)
        
RegisterCommand('ayudamecanico', function(source, args)
    local name = GetPlayerName(PlayerId())
    local ped = GetPlayerPed(PlayerId())
    local x, y, z = table.unpack(GetEntityCoords(ped, true))
    local street = GetStreetNameAtCoord(x, y, z)
    local location = GetStreetNameFromHashKey(street)
    local msg = table.concat(args, ' ')
    if args[1] == nil then
        TriggerEvent('chatMessage', '^5Mecanico', {255,255,255}, ' ^7Introduce el motivo de la llamada.')
    else
		TriggerEvent("esx:auxilio",name, msg)
        TriggerEvent('chatMessage', '^5Mecanico', {255,255,255}, ' ^7Tu llamada se ha realizado correctamente.')
        TriggerServerEvent('mecanico', location, msg, x, y, z, name)
        TriggerServerEvent('esx_addons_gcphone:startCall', 'mechanic', 'Alerta: ' .. msg .. ' ubicado en ' .. location)
        TriggerServerEvent('esx_addons_gcphone:startCall', 'mecaniconorte', 'Alerta:  ' .. msg .. ' ubicado en ' .. location)
    end
end)
        