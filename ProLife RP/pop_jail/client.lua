local isActivated = false
local carcel = {
		[1] = {x = 1694.32,y = 2504.88,z = -77.04},
		[2] = {x = 1697.2,y = 2503.8,z = -77.04},
		[3] = {x = 1694.12,y = 2492.88,z = -77.04},
		[4] = {x = 1702.64,y = 2492.4,z = -77.04}
}
local interior = {x=1722.96,y=2493.08,z=-77.04}
local exterior = {x=1690.88,y=2592.28,z=45.76}
local polijail = {x=1704.44,y=2498.84,z=-79.01}
local poliout = {x=1707.04,y=2498.8,z=-79.01}
local plaza = {x = -388.76, y = 6128.08, z = 31.48}
local segundos = 0
local PlayerData = {}
local msg = ""
ESX                           = nil


Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getShtoniaredObjtoniect', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
  Citizen.Trace(tostring(PlayerData.job.name))
end)

RegisterNetEvent('popjail:sendtojail')
AddEventHandler('popjail:sendtojail',function(tiempo,mensaje)
	Citizen.CreateThread(function()
		local playerPed = GetPlayerPed(-1)
		segundos = tiempo
		local puerta = math.random(1,4)
		
		SetEntityCoords(GetPlayerPed(-1), carcel[puerta].x, carcel[puerta].y, carcel[puerta].z)
		isActivated = true
		msg = mensaje
		descontador()
		ClearPedSecondaryTask(GetPlayerPed(-1))
        SetEnableHandcuffs(GetPlayerPed(-1), false)
        SetPedCanPlayGestureAnims(GetPlayerPed(-1),  true)
        FreezeEntityPosition(GetPlayerPed(-1), false)
		SetEntityInvincible(GetPlayerPed(-1),true)
		Citizen.CreateThread(function()
			while segundos > 0 do
				local coords = GetEntityCoords(GetPlayerPed(-1))
				if GetDistanceBetweenCoords(coords.x,coords.y,coords.z,carcel[puerta].x, carcel[puerta].y, carcel[puerta].z) > 15 then
					SetEntityCoords(GetPlayerPed(-1),carcel[puerta].x, carcel[puerta].y, carcel[puerta].z)
				end
				Citizen.Wait(0)
			end
		
		end)
		while segundos > 0 do
			Citizen.Wait(1000)
			segundos = segundos - 1
			SetEntityHealth(GetPlayerPed(-1), 200)
		end
		SetEntityInvincible(GetPlayerPed(-1),false)
		SetEntityCoords(GetPlayerPed(-1), plaza.x, plaza.y, plaza.z)
		isActivated = false
	end)
end)
function descontador()
	Citizen.CreateThread(function()
		while isActivated == true do
			Citizen.Wait(0)
			drawTxt(math.tointeger(segundos).." SEGUNDOS RESTANTES",2, 1, 0.5, 0.1, 0.70,51,255,255,255)
			drawTxt(msg,2, 1, 0.5, 0.13, 0.70,51,255,255,255)
		end
	end)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
		if GetDistanceBetweenCoords(exterior.x,exterior.y,exterior.z,x,y,z) < 40 then
			DrawMarker(1,exterior.x,exterior.y,exterior.z-1, 0, 0, 0, 0, 0, 0, 2.5001, 2.5001, 1.6001,98,192,249, 200, 0, 0, 0, 0)
			if GetDistanceBetweenCoords(exterior.x,exterior.y,exterior.z, x,y,z) < 1.5 then
				DisplayHelpText("Pulsa ~INPUT_CONTEXT~ para entrar")
				if IsControlJustPressed(1,38) then
					SetEntityCoords(GetPlayerPed(-1), interior.x,interior.y,interior.z)
				end
			end
		elseif GetDistanceBetweenCoords(interior.x,interior.y,interior.z,x,y,z) < 15 then
			DrawMarker(1,interior.x,interior.y,interior.z-1, 0, 0, 0, 0, 0, 0, 2.5001, 2.0001, 1.6001,98,192,249, 200, 0, 0, 0, 0)
			if GetDistanceBetweenCoords(interior.x,interior.y,interior.z, x,y,z) < 1.5 then
				DisplayHelpText("Pulsa ~INPUT_CONTEXT~ para salir")
				if IsControlJustPressed(1,38) then
					SetEntityCoords(GetPlayerPed(-1), exterior.x,exterior.y,exterior.z)
				end
			end
		end

		if PlayerData.job ~= nil and PlayerData.job.name == 'police' or 'police1' then
			if GetDistanceBetweenCoords(poliout.x,poliout.y,poliout.z,x,y,z) < 15 then
				DrawMarker(1,poliout.x,poliout.y,poliout.z, 0, 0, 0, 0, 0, 0, 2.0001, 2.0001, 1.6001,98,192,249, 200, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(poliout.x,poliout.y,poliout.z, x,y,z) < 1.5 then
					DisplayHelpText("Pulsa ~INPUT_CONTEXT~ para entrar a las celdas")
					if IsControlJustPressed(1,38) then
						SetEntityCoords(GetPlayerPed(-1), polijail.x,polijail.y,polijail.z)
					end
				end
			end
			if GetDistanceBetweenCoords(polijail.x,polijail.y,polijail.z,x,y,z) < 15 then
				DrawMarker(1,polijail.x,polijail.y,polijail.z, 0, 0, 0, 0, 0, 0, 2.5001, 2.5001, 1.6001,98,192,249, 200, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(polijail.x,polijail.y,polijail.z, x,y,z) < 1.5 then
					DisplayHelpText("Pulsa ~INPUT_CONTEXT~ para salir de las celdas")
					if IsControlJustPressed(1,38) then
						SetEntityCoords(GetPlayerPed(-1), poliout.x,poliout.y,poliout.z)
					end
				end
			end
		end
	end
end)

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
