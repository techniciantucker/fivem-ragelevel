local input = {["E"] = 38,["DOWN"] = 173,["TOP"] = 27,["NENTER"] =  201}
ESX                           = nil
local PlayerData                = {}



Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
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
	{ ['x'] = 1135.56, ['y'] = 257.22, ['z'] = -51.04 },
	{ ['x'] = 1134.67, ['y'] = 255.2, ['z'] =  -51.04 },
	{ ['x'] = 1133.19, ['y'] = 256.11, ['z'] = -51.04 },
	{ ['x'] = 1133.47, ['y'] = 257.65, ['z'] = -51.04 },
	{ ['x'] = 1129.53, ['y'] = 251.83, ['z'] = -51.04 },
	{ ['x'] = 1130.74, ['y'] = 251.72, ['z'] = -51.04 },
	{ ['x'] = 1131.76, ['y'] = 251.31, ['z'] = -51.04 },
	{ ['x'] = 1132.65, ['y'] = 250.58, ['z'] = -51.04 },
	{ ['x'] = 1133.27, ['y'] = 249.78, ['z'] = -51.04 },
	{ ['x'] = 1133.72, ['y'] = 248.61, ['z'] = -51.04 },
	{ ['x'] = 1133.89, ['y'] = 247.59, ['z'] = -51.04 },
	{ ['x'] = 1136.77, ['y'] = 253.36, ['z'] = -51.04 },
	{ ['x'] = 1139.07, ['y'] = 254.42, ['z'] = -51.04 },
	{ ['x'] = 1140.74, ['y'] = 252.77, ['z'] = -51.04 },
	{ ['x'] = 1139.61, ['y'] = 250.49, ['z'] = -51.04 },
	{ ['x'] = 1137.17, ['y'] = 250.94, ['z'] = -51.04 },
	{ ['x'] = 1106.43, ['y'] = 228.36, ['z'] = -49.84 },
	{ ['x'] = 1103.73, ['y'] = 228.22, ['z'] = -49.84 },
	{ ['x'] = 1107.15, ['y'] = 230.62, ['z'] = -49.84 },
	{ ['x'] = 1104.89, ['y'] = 232.33, ['z'] = -49.84 },
	{ ['x'] = 1102.91, ['y'] = 230.67, ['z'] = -49.84 },
	{ ['x'] = 1101.57, ['y'] = 229.43, ['z'] = -49.84 },
	{ ['x'] = 1101.57, ['y'] = 229.43, ['z'] = -49.84 },
	{ ['x'] = 1102.59, ['y'] = 233.52, ['z'] = -49.84 },
	{ ['x'] = 1102.70, ['y'] = 232.49, ['z'] = -49.84 },
	{ ['x'] = 1120.49, ['y'] = 233.77, ['z'] = -49.84 },
	{ ['x'] = 1120.25, ['y'] = 231.99, ['z'] = -49.84 },
	{ ['x'] = 1119.80, ['y'] = 230.840, ['z'] = -49.84 },
	{ ['x'] = 1120.32, ['y'] = 229.90, ['z'] = -49.84 },
	{ ['x'] = 1121.48, ['y'] = 229.50, ['z'] = -49.84 },
	{ ['x'] = 1118.52, ['y'] = 227.77, ['z'] = -49.84 },
	{ ['x'] = 1115.77, ['y'] = 227.75, ['z'] = -49.84 },
	{ ['x'] = 1114.72, ['y'] = 230.18, ['z'] = -49.84 },
	{ ['x'] = 1117.14, ['y'] = 231.77, ['z'] = -49.84 },
	{ ['x'] = 1115.32, ['y'] = 232.53, ['z'] = -49.84 },
	{ ['x'] = 1116.14, ['y'] = 234.99, ['z'] = -49.84 },
	{ ['x'] = 1116.14, ['y'] = 234.99, ['z'] = -49.84 },
	{ ['x'] = 1114.05, ['y'] = 236.47, ['z'] = -49.84 },
	{ ['x'] = 1112.03, ['y'] = 234.94, ['z'] = -49.84 },
	{ ['x'] = 1112.79, ['y'] = 232.47, ['z'] = -49.84 },
	{ ['x'] = 1113.16, ['y'] = 237.75, ['z'] = -49.84 },
	{ ['x'] = 1112.19, ['y'] = 237.27, ['z'] = -49.84 },
	{ ['x'] = 1110.97, ['y'] = 237.22, ['z'] = -49.84 },
	{ ['x'] = 1109.87, ['y'] = 237.42, ['z'] = -49.84 },
	{ ['x'] = 1108.88, ['y'] = 237.75, ['z'] = -49.84 },
	{ ['x'] = 1107.88, ['y'] = 238.37, ['z'] = -49.84 },
	{ ['x'] = 1110.53, ['y'] = 235.18, ['z'] = -49.84 },
	{ ['x'] = 1107.27, ['y'] = 232.7, ['z'] = -49.84 },
	{ ['x'] = 1109.90, ['y'] = 232.8, ['z'] = -49.84 },
	{ ['x'] = 1114.13, ['y'] = 238.55, ['z'] = -49.84 },

	--penthouse
	{ ['x'] = 944.73, ['y'] = 20.86, ['z'] = 116.16 },
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
						DisplayHelpText("Presiona ~INPUT_CONTEXT~ ~y~para jugar a las tragaperras")
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

