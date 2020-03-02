-- CONFIG --

-- AFK Kick Time Limit (in seconds)
secondsUntilKick = 7*60

-- Warn players if 3/4 of the Time Limit ran up
kickWarning = true
afkP = false
afkS = false
-- CODE --

Citizen.CreateThread(function()
	while true do
		Wait(1000)

		playerPed = GetPlayerPed(-1)
		if playerPed then
			currentPos = GetEntityCoords(playerPed, true)

			if currentPos == prevPos then
				if time > 0 then
					if kickWarning and time == math.ceil(secondsUntilKick / 4) then
						TriggerEvent("chatMessage", "ATTENTION", {255, 0, 0}, "^1Te van a echar en " .. time .. " segundos por estar AFK!")

					end

					time = time - 1
				else
					if afkP == true then

					else
						if afkS == true then

						else
							TriggerServerEvent("kickForBeingAnAFKDouchebag")
						end
					end
				end
			else
				time = secondsUntilKick
			end

			prevPos = currentPos
		end
	end
end)

RegisterNetEvent('afk:changerP')
AddEventHandler('afk:changerP',function()
	afkP = not afkP
end)

RegisterNetEvent('afk:changerS')
AddEventHandler('afk:changerS',function()
	afkS = not afkS
end)