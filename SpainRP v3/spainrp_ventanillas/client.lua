Citizen.CreateThread(function()
    while true
    	do
		local playerPed = GetPlayerPed(-1)
		local playerVeh = GetVehiclePedIsIn(playerPed, false)
			if IsControlJustReleased(0, 173) then
				RollDownWindows(playerVeh)
			end
			if IsControlJustReleased(0, 172) then
				RollUpWindow(playerVeh, 0)
				RollUpWindow(playerVeh, 1)
				RollUpWindow(playerVeh, 2)
				RollUpWindow(playerVeh, 3)
			end
		Citizen.Wait(1)
	end
end)