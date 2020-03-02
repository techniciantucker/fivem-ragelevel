local input = {["E"] = 38,["DOWN"] = 173,["TOP"] = 27,["NENTER"] =  201}
ESX                           = nil
local PlayerData                = {}



Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getShtoniaredObjtoniect', function(obj) ESX = obj end)
    Citizen.Wait(1)
  end
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
SetNuiFocus(false, false)
end)


RegisterNetEvent('errormessage2')
AddEventHandler('errormessage2', function()
PlaySound(GetPlayerServerId(GetPlayerPed(-1)), "CHECKPOINT_MISSED", "HUD_MINI_GAME_SOUNDSET", 0, 0, 1)
end)


RegisterNetEvent('spinit2')
AddEventHandler('spinit2', function()
	PlaySound(GetPlayerServerId(GetPlayerPed(-1)), "Apt_Style_Purchase", "DLC_APT_Apartment_SoundSet", 0, 0, 1)

	SendNUIMessage({
			canspin = true
		})
	Citizen.Wait(100)

		SendNUIMessage({
			canspin = false
		})

end)


RegisterNUICallback('close', function(data, cb)

	SetNuiFocus(false, false)
	SendNUIMessage({
		show = false
	})
	cb("ok")
	PlaySound(GetPlayerServerId(GetPlayerPed(-1)), "Apt_Style_Purchase", "DLC_APT_Apartment_SoundSet", 0, 0, 1)

end)




RegisterNUICallback('payforplayer', function(winnings, cb)
	PlaySound(GetPlayerServerId(GetPlayerPed(-1)), "ROBBERY_MONEY_TOTAL", "HUD_FRONTEND_CUSTOM_SOUNDSET", 0, 0, 1)
	TriggerServerEvent('payforplayer2',winnings)
end)


RegisterNUICallback('playerpays', function(bet, cb)
	TriggerServerEvent('playerpays2',bet)
end)

local moneymachine_slot = {
	{ ['x'] = 1006.74, ['y'] = 53.2, ['z'] = 72.60 },
	{ ['x'] = 1007.27, ['y'] = 54.33, ['z'] = 72.60 },
	{ ['x'] = 1007.42, ['y'] = 55.39, ['z'] = 72.60 },
	{ ['x'] = 1007.31, ['y'] = 56.57, ['z'] = 72.60 },
	{ ['x'] = 1006.93, ['y'] = 57.52, ['z'] = 72.60 },
	{ ['x'] = 1006.35, ['y'] = 58.45, ['z'] = 72.60 },
	{ ['x'] = 1005.49, ['y'] = 59.14, ['z'] = 72.60 },
	{ ['x'] = 1010.02, ['y'] = 60.17, ['z'] = 72.60 },
	{ ['x'] = 1011.85, ['y'] = 58.58, ['z'] = 72.60 },
	{ ['x'] = 1013.98, ['y'] = 59.75, ['z'] = 72.60 },
	{ ['x'] = 1013.38, ['y'] = 62.18, ['z'] = 72.60 },
	{ ['x'] = 1010.98, ['y'] = 62.53, ['z'] = 72.60 },
    { ['x'] = 1012.32, ['y'] = 56.62, ['z'] = 72.60 },
	{ ['x'] = 1011.35, ['y'] = 54.33, ['z'] = 72.60 },
	{ ['x'] = 1013.21, ['y'] = 52.62, ['z'] = 72.60 },
	{ ['x'] = 1015.29, ['y'] = 53.99, ['z'] = 72.60 },
	{ ['x'] = 1014.71, ['y'] = 56.4, ['z'] = 72.60 },
	{ ['x'] = 969.66, ['y'] = 55.04, ['z'] = 73.80 },
	{ ['x'] = 970.76, ['y'] = 55.46, ['z'] = 73.80 },
	{ ['x'] = 971.56, ['y'] = 56.07, ['z'] = 73.80 },
	{ ['x'] = 972.32, ['y'] = 57.0, ['z'] = 73.80 },
	{ ['x'] = 972.81, ['y'] = 57.96, ['z'] = 73.80 },
	{ ['x'] = 974.15, ['y'] = 55.62, ['z'] = 73.80 },
	{ ['x'] = 975.12, ['y'] = 53.19, ['z'] = 73.80 },
	{ ['x'] = 973.19, ['y'] = 51.56, ['z'] = 73.80 },
	{ ['x'] = 970.96, ['y'] = 52.83, ['z'] = 73.80 },
	{ ['x'] = 971.64, ['y'] = 55.41, ['z'] = 73.80 },
	{ ['x'] = 976.89, ['y'] = 57.37, ['z'] = 73.80 },
	{ ['x'] = 976.3, ['y'] = 54.89, ['z'] = 73.80 },
	{ ['x'] = 978.51, ['y'] = 53.55, ['z'] = 73.80 },
	{ ['x'] = 980.42, ['y'] = 55.18, ['z'] = 73.80 },
	{ ['x'] = 979.46, ['y'] = 57.55, ['z'] = 73.80 },
	{ ['x'] = 979.95, ['y'] = 59.29, ['z'] = 73.80 },
	{ ['x'] = 980.4, ['y'] = 58.27, ['z'] = 73.80 },
	{ ['x'] = 981.02, ['y'] = 57.38, ['z'] = 73.80 },
	{ ['x'] = 981.84, ['y'] = 56.65, ['z'] = 73.80 },
	{ ['x'] = 982.87, ['y'] = 56.17, ['z'] = 73.80 },
	{ ['x'] = 983.98, ['y'] = 56.04, ['z'] = 73.80 },
	{ ['x'] = 985.07, ['y'] = 56.14, ['z'] = 73.80 },
	{ ['x'] = 987.1, ['y'] = 48.97, ['z'] = 73.80 },
	{ ['x'] = 986.45, ['y'] = 48.13, ['z'] = 73.80 },
	{ ['x'] = 986.0, ['y'] = 47.13, ['z'] = 73.80 },
	{ ['x'] = 985.79, ['y'] = 46.05, ['z'] = 73.80 },
	{ ['x'] = 985.6, ['y'] = 44.8, ['z'] = 73.80 },
	{ ['x'] = 985.15, ['y'] = 46.26, ['z'] = 73.80 },
	{ ['x'] = 984.14, ['y'] = 48.78, ['z'] = 73.80 },
	{ ['x'] = 981.6, ['y'] = 48.49, ['z'] = 73.80 },
	{ ['x'] = 980.91, ['y'] = 46.01, ['z'] = 73.80 },
	{ ['x'] = 983.15, ['y'] = 44.7, ['z'] = 73.80 },
	{ ['x'] = 983.06, ['y'] = 50.36, ['z'] = 73.80 },
	{ ['x'] = 985.08, ['y'] = 52.0, ['z'] = 73.80 },
	{ ['x'] = 984.08, ['y'] = 54.37, ['z'] = 73.80 },
	{ ['x'] = 981.55, ['y'] = 54.15, ['z'] = 73.80 },
	{ ['x'] = 980.93, ['y'] = 51.69, ['z'] = 73.80 },
	{ ['x'] = 1130.19, ['y'] = 251.7, ['z'] = -51.04 },
	{ ['x'] = 1131.22, ['y'] = 251.43, ['z'] = -51.04 },
	{ ['x'] = 1132.15, ['y'] = 250.89, ['z'] = -51.04 },
	{ ['x'] = 1132.92, ['y'] = 250.14, ['z'] = -51.04 },
	{ ['x'] = 1133.44, ['y'] = 249.18, ['z'] = -51.04 },
	{ ['x'] = 1133.74, ['y'] = 248.14, ['z'] = -51.04 },

	--penthouse
	{ ['x'] = 941.25, ['y'] = 8.86, ['z'] = 116.16 },
	{ ['x'] = 943.2, ['y'] = 7.67, ['z'] = 116.16 },
	{ ['x'] = 942.07, ['y'] = 5.96, ['z'] = 116.16 },
	{ ['x'] = 940.18, ['y'] = 7.06, ['z'] = 116.16 },
}



Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local pos = GetEntityCoords(GetPlayerPed(-1), false)
		for k,v in ipairs(moneymachine_slot) do
			if(Vdist(v.x, v.y, v.z, pos.x, pos.y, pos.z) < 20.0)then
				DrawMarker(29, v.x, v.y, v.z + 0.2, 0, 0, 0, 0, 0, 0, 0.6001, 1.0001, 0.6, 0, 255, 5, 90, 1,0, 0,1)
				if(Vdist(v.x, v.y, v.z, pos.x, pos.y, pos.z) < 1.0)then
						DisplayHelpText("Pulsa ~INPUT_CONTEXT~ ~y~para jugar en esta maquina.")
					if IsControlJustPressed(1,input["E"]) then
						SendNUIMessage({
							show = true
							
						})
						SetNuiFocus(true,true)
						PlaySound(GetPlayerServerId(GetPlayerPed(-1)), "Apt_Style_Purchase", "DLC_APT_Apartment_SoundSet", 0, 0, 1)
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

