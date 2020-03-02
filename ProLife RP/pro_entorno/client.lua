-------------------------------------------------------------------------------------------
-- ESTA TOTALMENTE PROHIBIDA LA VENTA/DISTRIBUICIÓN DE ESTE SCRIPT (CREATED: Kaprix.) --
-------------------------------------------------------------------------------------------

--// Variables //--

local blip = nil
local blips = {}
local blipPos = nil
local PlayerData = {}
local entorno_llamada = false 

--// Hilos //--

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getShtoniaredObjtoniect', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
end)

Citizen.CreateThread(function()
	while true do 
		if blipPos ~= nil then 
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), blipPos, true) < 100 then 
				local prx 
				
				if PlayerData.job.name == 'police' then 
					prx = '[^2Entorno^0]'
				elseif  PlayerData.job.name == 'ambulance' then 
					prx = '[^1Auxilio^0]'
				end 
				
				Citizen.Wait(250)
				
				TriggerEvent('chatMessage', prx, {255,255,255}, "^0Has llegado a la ^3zona^0, busca donde se origino la llamada!^0")
				blipPos = nil
				RemoveBlip(blip)
			end 
		end 
		Citizen.Wait(250)
	end 
end)

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/entorno', 'Indica el delito que esta en progreso!', {{ name="Motivo de la llamada", help="Indica el entorno que deseas!" }})
end)

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/auxilio', 'Indica el motivo de la emergencia!', {{ name="Motivo de la llamada", help="Indica el entorno que deseas!" }})
end)

--// Refrescar Trabajos //--

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

--// Registros y Eventos //--


RegisterNetEvent('llamada_entorno:sendAlert')
AddEventHandler('llamada_entorno:sendAlert', function(name, x, y, z)
	if PlayerData.job.name == 'police' then
		entorno_llamada = true 
		Citizen.CreateThread(function()
			while entorno_llamada do 
				ESX.ShowHelpNotification("Pulsa Musculo ~INPUT_PICKUP~ para atender la llamada o Pulsa musculo ~INPUT_COVER~ para rechazarla")
				if IsControlJustReleased(1, 38) then 
					entorno_llamada = false 
					TriggerEvent('chatMessage','^0[^2Entorno^0]', {255,255,255}, "^0La llamada fue ^2Aceptada^0")
					
					if blipPos ~= nil then 
						TriggerEvent('chatMessage','^0[^1Entorno^0]', {255,255,255}, "^0La llamada que tenias activa fue ^1cancelada^0 por atender esta")
						blipPos = nil 
						RemoveBlip(blip)
					end 

					Citizen.Wait(500)

					blipPos = vector3(x, y, z)
					blip = AddBlipForCoord(x, y, z)
					SetBlipSprite(blip, 9)
					SetBlipScale(blip, 0.5)
					SetBlipColour(blip, 1)
					table.insert(blips, blip)
				elseif IsControlJustReleased(1, 44) then 
					entorno_llamada = false 
					TriggerEvent('chatMessage','^0[^1Entorno^0]', {255,255,255}, "^1La llamada fue rechazada^0")
				end 
				Citizen.Wait(0)
			end 
		end)
	end 
end)

RegisterNetEvent('llamada_auxilio:sendAlert')
AddEventHandler('llamada_auxilio:sendAlert', function(name, x, y, z)
	if PlayerData.job.name == 'ambulance' then
		auxilio_llamada = true 
		Citizen.CreateThread(function()
			while auxilio_llamada do 
				ESX.ShowHelpNotification("Pulsa Musculo ~INPUT_PICKUP~ para atender la llamada o Pulsa musculo ~INPUT_COVER~ para rechazarla")
				if IsControlJustReleased(1, 38) then 
					auxilio_llamada = false 
					TriggerEvent('chatMessage','^0[^2auxilio^0]', {255,255,255}, "^0La llamada fue ^2Aceptada^0")
					
					if blipPos ~= nil then 
						TriggerEvent('chatMessage','^0[^1auxilio^0]', {255,255,255}, "^0La llamada que tenias activa fue ^1cancelada^0 por atender esta")
						blipPos = nil 
						RemoveBlip(blip)
					end 

					Citizen.Wait(500)

					blipPos = vector3(x, y, z)
					blip = AddBlipForCoord(x, y, z)
					SetBlipSprite(blip, 9)
					SetBlipScale(blip, 0.5)
					SetBlipColour(blip, 1)
					table.insert(blips, blip)
				elseif IsControlJustReleased(1, 44) then 
					auxilio_llamada = false 
					TriggerEvent('chatMessage','^0[^1auxilio^0]', {255,255,255}, "^1La llamada fue rechazada^0")
				end 
				Citizen.Wait(0)
			end 
		end)
	end 
end)

--== Enviar mensaje ==-- 

RegisterNetEvent('llamada_entorno:setMensaje')
AddEventHandler('llamada_entorno:setMensaje', function(msg)
	if PlayerData.job.name == 'police' then
		TriggerEvent('chatMessage','', {255,255,255}, msg)
	end
end)

RegisterNetEvent('llamada_auxilio:setMensaje')
AddEventHandler('llamada_auxilio:setMensaje', function(msg)
	if PlayerData.job.name == 'ambulance' then
		TriggerEvent('chatMessage','', {255,255,255}, msg)
	end
end)

--// Comandos //--

RegisterCommand('entorno', function(source, args)
    local name = GetPlayerName(PlayerId())
    local ped = GetPlayerPed(PlayerId())
    local x, y, z = table.unpack(GetEntityCoords(ped, true))
    local street = GetStreetNameAtCoord(x, y, z)
    local location = GetStreetNameFromHashKey(street)
    local msg = table.concat(args, ' ')
    if args[1] == nil then
        TriggerEvent('chatMessage', '^[^1Entorno error^0]', {255,255,255}, ' ^7Por favor indica el ^1entorno.')
	else	
		TriggerServerEvent('llamada:entorno', location, msg, x, y, z, name)
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
        TriggerEvent('chatMessage', '^[^1Auxilio error^0]', {255,255,255}, ' ^7Por favor indica el ^1Auxilio.')
	else	
		TriggerServerEvent('llamada:auxilio', location, msg, x, y, z, name)
    end
end)