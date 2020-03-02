local spawnedOpios = 0
local opioPlants = {}
local isPickingUp, isProcessing = false, false


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if GetDistanceBetweenCoords(coords, Config.CircleZones.OpioProcessing.coords, true) < 4 then
			if not isProcessing then
				ESX.ShowHelpNotification(_U('opio_processprompt'))
			end

			if IsControlJustReleased(0, 38) and not isProcessing then
					ProcessOpio()
			end
		else
			Citizen.Wait(500)
		end
	end
end)

function ProcessOpio()
	isProcessing = true

	ESX.ShowNotification(_U('opio_processingstarted'))
	TriggerServerEvent('esx_srpdrogas:processOpio')
	local timeLeft = Config.Delays.OpioProcessing / 1000
	local playerPed = PlayerPedId()

	while timeLeft > 0 do
		Citizen.Wait(1000)
		timeLeft = timeLeft - 1

		if GetDistanceBetweenCoords(GetEntityCoords(playerPed), Config.CircleZones.OpioProcessing.coords, false) > 6 then
			ESX.ShowNotification(_U('opio_processingtoofar'))
			TriggerServerEvent('esx_srpdrogas:cancelProcessing')
			break
		end
	end

	isProcessing = false
end


AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(opioPlants) do
			ESX.Game.DeleteObject(v)
		end
	end
end)


function GetCoordZ(x, y)
	local groundCheckHeights = { 40.0, 41.0, 42.0, 43.0, 44.0, 45.0, 46.0, 47.0, 48.0, 49.0, 50.0 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 43.0
end
