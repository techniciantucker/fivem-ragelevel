ESX                           = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getShtoniaredObjtoniect', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local isPolice = nil

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  if xPlayer.job.name == 'police' then
	isPolice = 1
  else
	isPolice = 0
  end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    if job.name == 'police' then
		isPolice = 1
	  else
		isPolice = 0
	  end
end)

RegisterNetEvent('pop_spawnheli:comprobadopol')
AddEventHandler('pop_spawnheli:comprobadopol',function(rol)
	if rol == "police" then
		isPolice = 1
	else
		isPolice = 0
	end
	--TriggerEvent('chatMessage', "Miguel Reyes ", {0, 0, 255}, isPolice)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
		if isPolice == 1 then
			DrawMarker(1,-474.68,5992.36,30.32, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.9001,120,0,120, 255, 0, 0, 0, 0)
			if get3DDistance(-474.68,5992.36,30.32, x,y,z) < 1.5 then
				DisplayHelpText("Pulsa E para sacar un helicóptero")
				if IsControlJustPressed(1,38) then
					OpenMenuA()
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
		if isPolice == 1 then
			DrawMarker(1,1863.64,3658.08,33.05, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.9001,120,0,120, 255, 0, 0, 0, 0)
			if get3DDistance(1863.64,3658.08,33.92, x,y,z) < 1.5 then
				DisplayHelpText("Pulsa E para sacar un helicóptero")
				if IsControlJustPressed(1,38) then
					OpenMenuB()
				end
			end
		end
	end
end)

function OpenMenuA()
	local elements = {
		{label = "EC-135" ,value = "supervolito"},
		{label = "H-40" ,value = "swift"},
		{label = "Little Bird" ,value = "as350"}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'dammit',
		{
			title  = "Menu",
			align    = 'bottom-right',
			elements = elements
		},
		function(data, menu)
			if data.current.value == "supervolito" then
				spawn_vehicle('supervolito',-480.02, 5983.786, 31.1887)
			elseif data.current.value == "swift" then
				spawn_vehicle('swift',-480.02, 5983.786, 31.1887)
			elseif data.current.value == "as350" then
				spawn_vehicle('as350',-480.02, 5983.786, 31.1887)
			end
		end,
		function(data, menu)
			menu.close()
		end
	)
end

function OpenMenuB()
	local elements = {
		{label = "EC-135" ,value = "supervolito"},
		{label = "H-40" ,value = "swift"},
		{label = "Little Bird" ,value = "as350"}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'dammit',
		{
			title  = "Menu",
			elements = elements
		},
		function(data, menu)
			if data.current.value == "supervolito" then
				spawn_vehicle('supervolito',1866.96, 3647.84, 35.84)
			elseif data.current.value == "swift" then
				spawn_vehicle('swift',1866.96, 3647.84, 35.84)
			elseif data.current.value == "as350" then
				spawn_vehicle('as350',1866.96, 3647.84, 35.84)
			end
		end,
		function(data, menu)
			menu.close()
		end
	)
end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function get3DDistance(x1, y1, z1, x2, y2, z2)
	local a = (x1 - x2) * (x1 - x2)
	local b = (y1 - y2) * (y1 - y2)
	local c = (z1 - z2) * (z1 - z2)
    return math.sqrt(a + b + c)
end

function spawn_vehicle(veh,spawnx,spawny,spawnz)
	Citizen.Wait(0)
	local myPed = GetPlayerPed(-1)
	local vehicle = GetHashKey(veh)
	RequestModel(vehicle)
	while not HasModelLoaded(vehicle) do
		Wait(1)
	end
	SetVehicleModKit(vehicle, 0)
	SetVehicleLivery(vehicle, 1)
	local plate = "CTZN"..6969
	local spawned_car = CreateVehicle(vehicle, spawnx,spawny,spawnz, -480.02, 5983.786, 31.1887, true, false)
	SetVehicleNumberPlateText(spawned_car, plate)
	SetVehicleOnGroundProperly(spawned_car)
	SetModelAsNoLongerNeeded(vehicle)
	Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(spawned_car))
	TriggerEvent("advancedFuel:setEssence", 100, GetVehicleNumberPlateText(spawned_car), GetDisplayNameFromVehicleModel(GetEntityModel(spawned_car)))
end