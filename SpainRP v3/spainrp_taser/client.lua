local tiempo = 8000 -- in miliseconds >> 1000 ms = 1s

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsPedBeingStunned(GetPlayerPed(-1)) then
		SetPedMinGroundTimeForStungun(GetPlayerPed(-1), tiempo)
		StartScreenEffect("DrugsDrivingOut",1000,false)
		Citizen.Wait(1000)
		ResetPedMovementClipset(GetPlayerPed(-1))
		ResetPedWeaponMovementClipset(GetPlayerPed(-1))
		ResetPedStrafeClipset(GetPlayerPed(-1))
		end
	end
end)