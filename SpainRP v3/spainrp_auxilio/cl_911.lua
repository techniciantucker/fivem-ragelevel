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
    TriggerEvent('chat:addSuggestion', '/auxilio', 'Envía una llamada a los medicos a los Servicios de emergencia!', {
        { name="motivo", help="Introduce una descripcion del incidente aquí!" }
    })
end)

AddEventHandler('outlawNotify', function(alert)
    if PlayerData.job ~= nil and PlayerData.job.name == 'ambulance' then
        Notify(alert)
    end
end)

RegisterNetEvent('auxilio:setBlip')
 AddEventHandler('auxilio:setBlip', function(name, x, y, z)
    if PlayerData.job ~= nil and PlayerData.job.name == 'ambulance' then
		local transT = 250
        blip = AddBlipForCoord(x, y, z)
		SetBlipSprite(blip,  10)
		SetBlipColour(blip,  5)
		SetBlipAlpha(blip,  transT)
        SetBlipAsShortRange(blip,  false)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Llamada de socorro')
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
        
RegisterCommand('auxilio', function(source, args)
    local name = GetPlayerName(PlayerId())
    local ped = GetPlayerPed(PlayerId())
    local x, y, z = table.unpack(GetEntityCoords(ped, true))
    local street = GetStreetNameAtCoord(x, y, z)
    local location = GetStreetNameFromHashKey(street)
    local msg = table.concat(args, ' ')
    if args[1] == nil then
        TriggerEvent('chatMessage', '^5Auxilio', {255,255,255}, ' ^7Introduce el motivo de la llamada.')
    else
		TriggerEvent("esx:auxilio",name, msg)
        TriggerEvent('chatMessage', '^5Auxilio', {255,255,255}, ' ^7Tu llamada se ha realizado correctamente.')
        TriggerServerEvent('auxilio', location, msg, x, y, z, name)
        TriggerServerEvent('esx_addons_gcphone:startCall', 'ambulance', 'Alerta medica: ' .. msg .. ' ubicado en ' .. location)
    end
end)
        