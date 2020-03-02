local ped = {name = "El vende palas", x=1543.88, y=6334.0, z= 23.08,rotation = 60.01,NetworkSync = false}
local heli = {x = 473.48,y = 6490.4,z = 29.72}
local car = {x = 2420.96,y = 4779.72,z = 34.48}
local entrega = {x = -700.6,y = 5775.64,z = 16.32}
local delivery = {x = 1435.8, y = 6348.36, z = 24.0}
local isDeliveried = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		--ACTIVAR MISION
		if GetDistanceBetweenCoords(ped.x,ped.y,ped.z,GetEntityCoords(GetPlayerPed(-1), true)) < 3 then
			DrawText3D(ped.x,ped.y,ped.z + 2, "Pulsa E para hablar con el señor", 255,255,255)
			if IsControlJustPressed(1,38) then
				OpenJobMenu()
			end
		end
	end
end)

------------------------------
------------CREAR NPC---------
------------------------------
Citizen.CreateThread(function()
    wanted_model= "G_M_Y_Lost_03"
    modelHash = GetHashKey(wanted_model)
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
       	Wait(1)
    end
    createNPC() 
end)

function createNPC()
    --PRIMER NPC
	created_ped = CreatePed(5, modelHash , ped.x,ped.y,ped.z, ped.rotation, ped.NetworkSync, ped.NetworkSync)
	FreezeEntityPosition(created_ped, true)
	SetEntityInvincible(created_ped, true)
	SetBlockingOfNonTemporaryEvents(created_ped, true)
	TaskStartScenarioInPlace(created_ped, "WORLD_HUMAN_DRINKING", 0, true)
end

function spawnHeli()
	Citizen.Wait(0)

	local myPed = GetPlayerPed(-1)
	local player = PlayerId()
	local vehicle = GetHashKey('cargobob')

	RequestModel(vehicle)

	while not HasModelLoaded(vehicle) do
		Wait(1)
	end

	local plate = math.random(100, 900)
	local spawned_car = CreateVehicle(vehicle, heli.x,heli.y,heli.z, 431.436, - 996.786, 25.1887, true, false)

	local plate = "CTZN"..math.random(100, 900)
    SetVehicleNumberPlateText(spawned_car, plate)
	SetVehicleOnGroundProperly(spawned_car)
	SetVehicleLivery(spawned_car, 2)
	SetModelAsNoLongerNeeded(vehicle)
	Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(spawned_car))
	TriggerEvent("advancedFuel:setEssence", 100, GetVehicleNumberPlateText(spawned_car), GetDisplayNameFromVehicleModel(GetEntityModel(spawned_car)))
end

function spawnCar()
	Citizen.Wait(0)

	local myPed = GetPlayerPed(-1)
	local player = PlayerId()
	local vehicle = GetHashKey('zentorno')

	RequestModel(vehicle)

	while not HasModelLoaded(vehicle) do
		Wait(1)
	end

	local plate = math.random(100, 900)
	local spawned_car = CreateVehicle(vehicle, car.x,car.y,car.z, 431.436, - 996.786, 25.1887, true, false)

	local plate = "CTZN"..math.random(100, 900)
    SetVehicleNumberPlateText(spawned_car, plate)
	SetVehicleOnGroundProperly(spawned_car)
	SetVehicleLivery(spawned_car, 2)
	SetModelAsNoLongerNeeded(vehicle)
	Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(spawned_car))
	TriggerEvent("advancedFuel:setEssence", 100, GetVehicleNumberPlateText(spawned_car), GetDisplayNameFromVehicleModel(GetEntityModel(spawned_car)))
end

function toHeli()
	blip = AddBlipForCoord(heli.x,heli.y,heli.z)
	SetBlipRoute(blip, true)
	TriggerEvent('esx:showNotification', 'Ve a la posición indicada para coger el cargobob.')
	Citizen.CreateThread(function ()
		while true do
			Citizen.Wait(0)

			if GetDistanceBetweenCoords(heli.x,heli.y,heli.z,GetEntityCoords(GetPlayerPed(-1), true)) < 70 then
				spawnHeli()
				TriggerEvent('esx:showNotification', 'Le hemos traido ya el cargobob.')
				Citizen.Wait(5000)
				TriggerEvent('esx:showNotification', 'Cuando se monte en el cargobob, espera a ordenes.')
				break
			end
		end
		while true do
			Citizen.Wait(0)
			if IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), true), GetHashKey("cargobob")) then
				RemoveBlip(blip)
				TriggerEvent('esx:showNotification', 'Ve a la posición indicada.')
				break
			end
		end
		RemoveBlip(blip)
		blip = AddBlipForCoord(car.x,car.y,car.z)
		SetBlipRoute(blip, true)
		while true do
			Citizen.Wait(0)
			if GetDistanceBetweenCoords(car.x,car.y,car.z,GetEntityCoords(GetPlayerPed(-1), true)) < 60 then
				TriggerEvent('esx:showNotification', 'Recoja el coche.')
				spawnCar()
				break
			end
		end
		while true do
			Citizen.Wait(0)
			if GetDistanceBetweenCoords(car.x,car.y,car.z,GetEntityCoords(GetPlayerPed(-1), true)) < 10 then
				TriggerEvent('esx:showNotification', 'LLevelo al punto de entrega.')
				RemoveBlip(blip)
				Citizen.Wait(5000)
				TriggerServerEvent('tm1_mafias:policeAvise')
				TriggerEvent('esx:showNotification', 'Mierda, tendrás que lidiar con la policía en el punto.')
				blip = AddBlipForCoord(entrega.x,entrega.y,entrega.z)
				SetBlipRoute(blip, true)
				break
			end
		end
		while true do
			Citizen.Wait(0)
			DrawMarker(1, entrega.x, entrega.y, entrega.z, 0, 0, 0, 0, 0, 0, 3.5001, 3.5001, 0.8001,252,0,0, 200, 0, 0, 0, 0)
			local vehicle = GetClosestVehicle(entrega.x, entrega.y, entrega.z, 3.5, 0, 70)
			if IsVehicleModel(vehicle, GetHashKey("zentorno")) then
				TriggerEvent('esx:showNotification', 'Entrega realizada.')
				RemoveBlip(blip)
				blip = AddBlipForCoord(delivery.x,delivery.y,delivery.z)
				SetBlipRoute(blip, true)
				TriggerEvent('esx:showNotification', 'Ve a dejar el cargobob aquí.')
				SetEntityAsMissionEntity( vehicle, true, true )
				Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( vehicle ) )
				isDeliveried = true
				break
			end
		end
		while true do
			Citizen.Wait(0)
			DrawMarker(1, delivery.x, delivery.y, delivery.z, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,252,255,0, 200, 0, 0, 0, 0)
			if GetDistanceBetweenCoords(delivery.x, delivery.y, delivery.z,GetEntityCoords(GetPlayerPed(-1), true)) < 5 then
				DrawText3D(delivery.x, delivery.y, delivery.z, "Pulsa E para dejar el cargobob", 255,255,255)
				if IsControlJustPressed(1,38) then
					if IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), true), GetHashKey("cargobob")) then
						RemoveBlip(blip)
						TriggerEvent('esx:showNotification', 'Bien hecho.')
						local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), true)
						SetEntityAsMissionEntity( vehicle, true, true )
						Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( vehicle ) )
						TriggerServerEvent('tm1_mafias:addMoney',4000)
						break
					end
				end
			end
		end
	end)
end

function OpenJobMenu()

	local elements = {
		{label = "Si",value = "yes"},
		{label = "No",value = "no"}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'get_job',
		{
			title  = '¿Quieres hacer el trabajo?',
			align    = 'bottom-right',
			elements = elements
		},
		function(data, menu)	
			if data.current.value == 'yes' then
				toHeli()
				Citizen.CreateThread(function ()
					TaskStartScenarioInPlace(created_ped, "WORLD_HUMAN_CLIPBOARD", 0, true)
					Citizen.Wait(3000)
					TaskStartScenarioInPlace(created_ped, "WORLD_HUMAN_DRINKING", 0, true)
				end)
			end
			menu.close()
		end,
		function(data, menu)
			menu.close()
		end
	)
end

RegisterNetEvent('tm1_mafias:addObj')
AddEventHandler('tm1_mafias:addObj', function()
	RemoveBlip(blip)
	blip = AddBlipForCoord(entrega.x,entrega.y,entrega.z)
	TriggerEvent('esx:showNotification', 'Van a entregar aquí un coche ilegal, intervenir.')
	while true do
		Citizen.Wait(0)
		if GetDistanceBetweenCoords(entrega.x,entrega.y,entrega.z,GetEntityCoords(GetPlayerPed(-1), true)) < 5 then
			RemoveBlip(blip)
			break
		end
	end
end)