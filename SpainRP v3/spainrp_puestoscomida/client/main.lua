local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX								= nil
local cam						= -1

local CurrentStand = nil


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)


-- Function Commande HotDog
function CommandHotDog()
	ESX.ShowNotification(_U('command_in_progress'))
	TriggerServerEvent('esx_hotdog:buyItem', 	Config.Price)
	
end

Citizen.CreateThread(function() -- Détecte si il est près d'un stand
	while true do
		Citizen.Wait(1000)

			local PlayerPed = PlayerPedId()
			local PlayerCoords = GetEntityCoords(PlayerPed)

			for k,v in pairs(Config.Stand) do
				local ClosestStand = GetClosestObjectOfType(PlayerCoords, 1.5, GetHashKey(v), false, false)

				if ClosestStand ~= 0 and ClosestStand ~= nil then
					CurrentStand = ClosestStand
					break
				else
					CurrentStand = nil
				end
			end
	end
end)

Citizen.CreateThread(function() -- si il est près d'un stand alors on lui met la notif
	while true do
		Citizen.Wait(5)

		if CurrentStand ~= nil then
			
			local StandCoord = GetEntityCoords(CurrentStand)

			ESX.ShowHelpNotification(_U('hotdog_shop_prompt'))
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)

		if CurrentStand ~= nil and IsControlJustReleased(0, 38) then
			CommandHotDog()
			DrawMissionText(_U('command_in_progress'), 5000)

		end
	end
end)

-- Function Message en bas
function DrawMissionText(msg, time)
  	ClearPrints()
  	SetTextEntry_2('STRING')
  	AddTextComponentString(msg)
  	DrawSubtitleTimed(time, 1)
end
