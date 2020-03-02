Citizen.CreateThread(function()

	while true do
		ped = PlayerPedId()
        Citizen.Wait(0)
        for k in pairs(Config.MarkerZones) do
			if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.MarkerZones[k].x, Config.MarkerZones[k].y, Config.MarkerZones[k].z, true) < 20 then
				DrawSub()
			end
		end
    end
end)

Citizen.CreateThread(function()
	ped = PlayerPedId()

	while true do
		ped = PlayerPedId()
        Citizen.Wait(5000)
        for k in pairs(Config.MarkerZones) do
			if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.MarkerZones[k].x, Config.MarkerZones[k].y, Config.MarkerZones[k].z, true) < 20 then
				TriggerServerEvent('srp_stresszones:removeStress')
			end
		end
    end
end)

function DrawSub()
	ClearPrints()
	BeginTextCommandPrint('STRING')
	AddTextComponentSubstringPlayerName('Estás en una zona de ~b~relax')
	EndTextCommandPrint(5000, 1)
end