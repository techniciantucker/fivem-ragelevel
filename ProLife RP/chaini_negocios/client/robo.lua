
local blip = nil
local robando = false
local tiempo = 0
local id = 0


function drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
	    SetTextOutline()
	end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

RegisterNetEvent('chaini_negocios:notificacion')
AddEventHandler('chaini_negocios:notificacion',function(title,subtitle,message)

    local mugshot, mugshotStr = ESX.Game.GetPedMugshot(PlayerPedId())
    ESX.ShowAdvancedNotification(title,subtitle,message,mugshotStr,1)
    UnregisterPedheadshot(mugshot)

end)

RegisterNetEvent('chaini_negocios:creoBlip')
AddEventHandler('chaini_negocios:creoBlip',function(pos)

    blip = AddBlipForCoord(pos.x, pos.y, pos.z)

	SetBlipSprite(blip, 161)
	SetBlipScale(blip, 2.0)
	SetBlipColour(blip, 3)

	PulseBlip(blip)


end)

RegisterNetEvent('chaini_negocios:borroBlip')
AddEventHandler('chaini_negocios:borroBlip', function()
	RemoveBlip(blip)
end)

RegisterNetEvent('chaini_negocios:empiezoRobo')
AddEventHandler('chaini_negocios:empiezoRobo', function(time,neg_id)

    --while not PrepareAlarm("JEWEL_STORE_HEIST_ALARMS") do
	--	Citizen.Wait(0)
	--end

   -- StartAlarm("JEWEL_STORE_HEIST_ALARMS", 1)
    local mugshot, mugshotStr = ESX.Game.GetPedMugshot(PlayerPedId())
    ESX.ShowAdvancedNotification("Joder","Tenemos un problema","Han llamado a la puta ~b~policía",mugshotStr,1)
    UnregisterPedheadshot(mugshot)

    robando = true
    tiempo = time
    id = neg_id

    Citizen.CreateThread(function()
        while robando == true do
            if(tiempo > 0)then
                tiempo = tiempo - 1
            else
                robando = false
            end
            Citizen.Wait(1000)
        end
    end)
        

end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local coords = GetEntityCoords(PlayerPedId())

        if robando then

            if GetDistanceBetweenCoords(coords,negocio[id].pos.x,negocio[id].pos.y,negocio[id].pos.z) > 15.0 then
                TriggerServerEvent('chaini_negocios:roboMuyLejos')
                local mugshot, mugshotStr = ESX.Game.GetPedMugshot(PlayerPedId())
                ESX.ShowAdvancedNotification("Joder","La hemos cagado","Te has alejado demasiado del negocio",mugshotStr,1)
                UnregisterPedheadshot(mugshot)
                tiempo = 0
                robando = false
                id = 0
            end

            drawTxt(0.66, 1.44, 1.0,1.0,0.4, '~r~Robo en progreso.~b~ ' .. tiempo.. ' ~w~segundos para finalizar', 255, 255, 255, 255)
        end
        for i=1, #negocio,1 do
            if GetDistanceBetweenCoords(coords,negocio[i].pos.x+1.5,negocio[i].pos.y+1.5,negocio[i].pos.z) < 1.5 and (negocio[i].tipo == 1 or negocio[i].tipo == 6) then
                DisplayHelpText("Presiona ~INPUT_ARREST~ para robar en la tienda: "..negocio[i].nombre)
                if IsControlJustReleased(1,75) then

                    if IsPedArmed(PlayerPedId(), 7) and IsPedArmed(PlayerPedId(),4) then

                        TriggerServerEvent('chaini_negocios:empiezoRobo', i)

                    else
 
                        local mugshot, mugshotStr = ESX.Game.GetPedMugshot(PlayerPedId())
                        ESX.ShowAdvancedNotification("Mierda","","Así no puedo ~r~intimidar~w~ al ~b~dependiente~w~...",mugshotStr,1)
                        UnregisterPedheadshot(mugshot)

                    end
                end
            end
            
        end
    
    end
end)
