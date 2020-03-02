

Citizen.CreateThread(function()
	while true do
		local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
		if IsControlJustPressed(1, 157) then -- 1
			if IsPedInAnyPoliceVehicle(GetPlayerPed(-1)) then
				TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 50, "sirenapoli", 1.0)
				Citizen.Wait(5000) --espero a que pase el audio
			end
		end
		Citizen.Wait(0)
	end
end)
