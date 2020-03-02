local isActivated = false

RegisterNetEvent('popllamada:mensaje')
AddEventHandler('popllamada:mensaje',function(mensaje)
	Citizen.CreateThread(function()
		isActivated = true
		anuncio(mensaje)
		Citizen.Wait(10000)
		isActivated = false
	end)
end)

function anuncio(mensaje)
	Citizen.CreateThread(function()
		while isActivated == true do
			Citizen.Wait(0)
			drawTxt(mensaje,2, 1, 0.5, 0.1, 0.70,51,255,255,255)
		end
	end)
end

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(centre)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x , y)
end

function actdonador()
	while true do
		Citizen.Wait(0)
		drawTxt("RECUERDA QUE PUEDES DONAR PARA MANTENER EL SERVIDOR",2, 1, 0.12, 0.05, 0.40,247, 220, 111,255)
		drawTxt("TENDRAS ACCESO A MUCHISIMOS BENEFICIONES DE VIP",2, 1, 0.12, 0.07, 0.40,162, 217, 206,255)
		drawTxt("SI QUIERES DONAR PUEDES HACERLO A TRAVES DEL FORO",2, 1, 0.12, 0.09, 0.40,169, 204, 227,255)
		drawTxt("O PIDIENDO AYUDA EN EL TEAMSPEAK 3 O DISCORD",2, 1, 0.12, 0.11, 0.40,215, 189, 226,255)
		drawTxt("PULSA X PARA CERRAR",2, 1, 0.12, 0.13, 0.40,230, 176, 170,255)
		if IsControlJustPressed(1,73) then
			break
		end
	end
end
local donator = nil

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