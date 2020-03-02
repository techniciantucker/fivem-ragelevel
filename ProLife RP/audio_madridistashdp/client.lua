

Citizen.CreateThread(function()
	while true do
		local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
		if IsControlJustPressed(1, 163) then -- 1
				if IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), true), GetHashKey("kaprixfiat"))  then
				TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "madridistashdp", 1)
				Citizen.Wait(5000) --espero a que pase el audio
			end
		end
		Citizen.Wait(0)
	end
end)
