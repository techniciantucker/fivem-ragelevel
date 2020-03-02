ESX              = nil
local lSpeed	 = 1.49
local weight = 0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getShtoniaredObjtoniect', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  TriggerServerEvent('esx_advanced_inventory:loaded')
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  if Config.userSpeed == true then
  	TriggerServerEvent("esx_advanced_inventory:initSpeed")
  end
end)

RegisterNetEvent("esx_advanced_inventory:speed")
AddEventHandler("esx_advanced_inventory:speed", function(speed)
  if Config.userSpeed == true then
  	lSpeed = speed
  end
end)

RegisterNetEvent("esx_advanced_inventory:updateWeight")
AddEventHandler("esx_advanced_inventory:updateWeight", function(weight1)
	weight = weight1
end)

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



--Citizen.CreateThread(function()
	--while true do
	--	Citizen.Wait(0)
	--	SetEntityMaxSpeed(GetPlayerPed(-1), speed)
	--end
--end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
			local p = weight / 1000
			local limit = Config.Limit / 1000
			drawTxt(p.."kg / "..limit.."kg",1, 1, 0.205, 0.880, 0.50,255,255,255,255)
	end
end)
