local esPolicia = nil
local esPolicia1 = nil
local isActive = false
local isWhile = false
local isActiveW = nil
local soyyo = false

AddEventHandler('playerSpawned', function(spawn)
	TriggerServerEvent('popre:isPolice')
end)
TriggerServerEvent('popre:isPolice')

RegisterNetEvent('popre:comprobadopol')
AddEventHandler('popre:comprobadopol',function(rol)
	if rol == "police" then
		esPolicia = true
	else
		esPolicia = false
	end

	if rol == "police1" then
		esPolicia1 = true
	else
		esPolicia1 = false
	end
end)

RegisterNetEvent('popre:cordsent')
AddEventHandler('popre:cordsent',function(x,y,z,tipo)
	if tipo == "normal" then
		DisplayHelpText("Aviso a todas las patrullas en el punto indicado en el mapa.")
		SetNewWaypoint(x,y)
	else
		SetNewWaypoint(x,y)
	end
end)

RegisterNetEvent('popre:comp')
AddEventHandler('popre:comp',function(forma)
	isActiveW = forma
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
		if IsControlJustPressed(1,20) then
			if esPolicia then
				if isWhile == true then
					soyyo = false
					isWhile = false
					TriggerServerEvent('popre:isautomatic',isWhile)
				elseif isWhile == false then
					soyyo = true
					isWhile = true
					TriggerServerEvent('popre:isautomatic',isWhile)	
				end
			end
		end
		if isActiveW == true and soyyo == false then
			drawTxt("ALGUIEN HA ACTIVADO LOS REFUERZOS AUTOMATICOS",4, 1, 0.5, 0.835, 0.85,51,255,51,255)
		end
		if isWhile == true then
			drawTxt("REFUERZOS AUTOMATICA ACTIVADO",4, 1, 0.5, 0.835, 0.85,51,255,51,255)
		end
		if IsControlJustPressed(1,29) then
			envaviso(x,y,z)
		end
		if isActive == true then
			drawTxt("REFUERZOS PEDIDOS",4, 1, 0.5, 0.835, 0.85,51,255,255,255)
		end

		if IsControlJustPressed(1,20) then
			if esPolicia1 then
				if isWhile == true then
					soyyo = false
					isWhile = false
					TriggerServerEvent('popre:isautomatic',isWhile)
				elseif isWhile == false then
					soyyo = true
					isWhile = true
					TriggerServerEvent('popre:isautomatic',isWhile)	
				end
			end
		end
		if isActiveW == true and soyyo == false then
			drawTxt("ALGUIEN HA ACTIVADO LOS REFUERZOS AUTOMATICOS",4, 1, 0.5, 0.835, 0.85,51,255,51,255)
		end
		if isWhile == true then
			drawTxt("REFUERZOS AUTOMATICA ACTIVADO",4, 1, 0.5, 0.835, 0.85,51,255,51,255)
		end
		if IsControlJustPressed(1,29) then
			envaviso(x,y,z)
		end
		if isActive == true then
			drawTxt("REFUERZOS PEDIDOS",4, 1, 0.5, 0.835, 0.85,51,255,255,255)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if isWhile == true then
			local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
			envavisow(x,y,z)
			Citizen.Wait(200)
		end
	end
end)

function envaviso(x,y,z)
	Citizen.CreateThread(function()
		if esPolicia then
			local tipo = "normal"
			TriggerServerEvent('popre:sendemergency',x,y,z,tipo)
			isActive = true
			Citizen.Wait(2000)
			isActive = false
		end

		if esPolicia1 then
			local tipo = "normal"
			TriggerServerEvent('popre:sendemergency',x,y,z,tipo)
			isActive = true
			Citizen.Wait(2000)
			isActive = false
		end
	end)
end

function envavisow(x,y,z)
	Citizen.CreateThread(function()
		if esPolicia then
			local tipo = "automatico"
			TriggerServerEvent('popre:sendemergency',x,y,z,tipo)
		end

		if esPolicia1 then
			local tipo = "automatico"
			TriggerServerEvent('popre:sendemergency',x,y,z,tipo)
		end
	end)
end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
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