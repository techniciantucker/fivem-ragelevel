local isActivated = false

RegisterNetEvent('popllamada:mensaje')
AddEventHandler('popllamada:mensaje',function(mensaje)
	Citizen.CreateThread(function()
		isActivated = true
		anuncio(mensaje)
		Citizen.Wait(15000)
		isActivated = false
	end)
end)

function anuncio(mensaje)
	Citizen.CreateThread(function()
		while isActivated == true do
			Citizen.Wait(0)
			drawTxt(mensaje,2, 1, 0.5, 0.1, 0.70,255,255,255,255)
		end
	end)
end

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(255, 255, 255, 255,255)
    SetTextEdge(1, 255, 255, 255, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(centre)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x , y)
end

Citizen.CreateThread(function()
	Citizen.Wait(20000)
	while true do
		Citizen.Wait(0)
		actdonador()
		if IsControlJustPressed(1,73) then
			break
		end
	end
end)
AddEventHandler('playerSpawned', function(spawn)
  TriggerServerEvent('pop_llamada:getJob')
end)
TriggerServerEvent('pop_llamada:getJob')

RegisterNetEvent('pop_llamada:setJob')
AddEventHandler('pop_llamada:setJob', function (cu)
  donator = cu
end)