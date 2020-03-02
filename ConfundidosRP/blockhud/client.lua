Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
	end
end)

Citizen.CreateThread(function()
    while true do
	Citizen.Wait(10)
		HideHudComponentThisFrame(3)
		HideHudComponentThisFrame(4)
		HideHudComponentThisFrame(13)
    end
end)