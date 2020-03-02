-- Local
local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local CurrentAction = nil
local GUI                       = {}
GUI.Time                        = 0
local HasAlreadyEnteredMarker   = false
local LastZone                  = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}
local cont = true
local price = Config.Price
local this_Garage = {}
-- Fin Local

-- Init ESX
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getShtoniaredObjtoniect', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)
-- Fin init ESX

--- Gestion Des blips
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    --PlayerData = xPlayer
    --TriggerServerEvent('esx_jobs:giveBackCautionInCaseOfDrop')
	refreshBlips()
	DecorRegister("car_id",3)
end)

function refreshBlips()
	local zones = {}
	local blipInfo = {}	

	for zoneKey,zoneValues in pairs(Config.Garages)do

		local blip = AddBlipForCoord(zoneValues.Pos.x, zoneValues.Pos.y, zoneValues.Pos.z)
		SetBlipSprite (blip, Config.BlipInfos.Sprite)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 1.2)
		SetBlipColour (blip, Config.BlipInfos.Color)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(zoneValues.name)
		EndTextCommandSetBlipName(blip)
	end
end
refreshBlips()
-- Fin Gestion des Blips

--Fonction Menu
RegisterNetEvent('esx_eden_garage:activemenu')
AddEventHandler('esx_eden_garage:activemenu',function(opc,coords,coords1)
	OpenMenuGarage(opc,coords,coords1)
end)

function OpenMenuGarage(opc,coord,coord1)
	
	
	ESX.UI.Menu.CloseAll()

	

	if opc == nil then
		local elements = {
		{label = "Lista de vehículoss", value = 'list_vehicles'},
		{label = "Recuperar vehículo ("..Config.Price.."$)", value = 'return_vehicle'},
		}
		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'garage_menu',
			{
				title    = 'Garage',
				align    = 'bottom-right',
				elements = elements,
			},
			function(data, menu)

				menu.close()
				if(data.current.value == 'list_vehicles') then
					ListVehiclesMenu()
				end
				if(data.current.value == 'stock_vehicle') then
					StockVehicleMenu()
				end
				if(data.current.value == 'return_vehicle') then
					ReturnVehicleMenu()
				end

				local playerPed = GetPlayerPed(-1)
				SpawnVehicle(data.current.value)
				--local coords    = societyConfig.Zones.VehicleSpawnPoint.Pos

			end,
			function(data, menu)
				menu.close()
				--CurrentAction = 'open_garage_action'
			end)
	else
		local elements = {
		{label = "Lista de vehículoss", value = 'list_vehicles'},
		{label = "Recuperar vehículo ("..Config.Price.."$)", value = 'return_vehicle'},
		}
		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'garage_menu',
			{
				title    = 'Garage',
				align    = 'bottom-right',
				elements = elements,
			},
			function(data, menu)

				menu.close()
				if(data.current.value == 'list_vehicles') then
					ListVehiclesMenu(opc,coord)
				end
				if(data.current.value == 'return_vehicle') then
					ReturnVehicleMenu(opc,coord)
				end

				local playerPed = GetPlayerPed(-1)
				SpawnVehicle(data.current.value,opc,coord)
				--local coords    = societyConfig.Zones.VehicleSpawnPoint.Pos

			end,
			function(data, menu)
				menu.close()
				--CurrentAction = 'open_garage_action'
			end)
	end
end
-- Afficher les listes des vehicules
function ListVehiclesMenu(opc,coord)
	local elements = {}

	ESX.TriggerServerCallback('eden_garage:getVehicles', function(vehicles)

		local haveMoney = false

		ESX.TriggerServerCallback('eden_garage:getMoney', function(money)
			haveMoney = money
		end,price)

		for _,v in pairs(vehicles) do

			local hashVehicule = v.vehicle.model
    		local vehicleName = GetDisplayNameFromVehicleModel(hashVehicule)
			local labelvehicle
			local id = v.id

    		if(v.state)then
    		labelvehicle = vehicleName..': Dentro'
    		
    		else
    		labelvehicle = vehicleName..': Fuera'
    		end	
			table.insert(elements, {label =labelvehicle , value = v})
			
		end

		ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'spawn_vehicle',
		{
			title    = 'Garage',
			align    = 'bottom-right',
			elements = elements,
		},
		function(data, menu)
			if(data.current.value.state)then
				menu.close()
				if haveMoney == true then
					if opc == nil then
						SpawnVehicle(data.current.value.vehicle,id)
						TriggerServerEvent('eden_garage:pagodanospop',price)
					else
						SpawnVehicle(data.current.value.vehicle,opc,coord,id)
						TriggerServerEvent('eden_garage:pagodanospop',price)
					end
				else
					TriggerEvent('esx:showNotification', 'No tienes suficiente dinero')
				end
			else
				TriggerEvent('esx:showNotification', 'Su vehículo ya está fuera')
			end
		end,
		function(data, menu)
			menu.close()
			--CurrentAction = 'open_garage_action'
		end
	)	
	end)
end
-- Fin Afficher les listes des vehicules

-- Fonction qui permet de rentrer un vehicule
function StockVehicleMenu(opc,coord1)
	if opc == nil then
		local playerPed  = GetPlayerPed(-1)
		if IsAnyVehicleNearPoint(this_Garage.DeletePoint.Pos.x,  this_Garage.DeletePoint.Pos.y,  this_Garage.DeletePoint.Pos.z,  3.5) then

			local vehicle       = GetClosestVehicle(this_Garage.DeletePoint.Pos.x, this_Garage.DeletePoint.Pos.y, this_Garage.DeletePoint.Pos.z, this_Garage.DeletePoint.Size.x, 0, 70)
			local vehicleProps  = ESX.Game.GetVehicleProperties(vehicle)
			local current 	    = GetPlayersLastVehicle(GetPlayerPed(-1), true)
			local engineHealth  = GetVehicleEngineHealth(current)
			local id = DecorGetInt(vehicle,"car_id")

			ESX.TriggerServerCallback('eden_garage:stockv',function(valid)

				if (valid) then
					TriggerServerEvent('eden_garage:debug', vehicle)
					TriggerServerEvent('eden_garage:modifystate', true, vehicleProps.plate)
					deleteCar(vehicle)
					TriggerServerEvent('eden_garage:logging', "engineHealth \t" .. engineHealth.. "\n")

					-------------------------------------------------------
					TriggerEvent('esx:showNotification', 'Su vehículo está en el garaje')
				else
					TriggerEvent('esx:showNotification', 'No puede almacenar este vehículo')
				end
			end,vehicleProps,id)
		else
			TriggerEvent('esx:showNotification', 'No hay vehículo para meter')
		end
	else
		local playerPed  = GetPlayerPed(-1)
		if IsAnyVehicleNearPoint(coord1.x, coord1.y, coord1.z,  6.5) then
			local vehicle       = GetClosestVehicle(coord1.x, coord1.y, coord1.z, 6.5, 0, 70)
			local vehicleProps  = ESX.Game.GetVehicleProperties(vehicle)
			local current 	    = GetPlayersLastVehicle(GetPlayerPed(-1), true)
			local engineHealth  = GetVehicleEngineHealth(current)
			local id = DecorGetInt(vehicle,"car_id")

			ESX.TriggerServerCallback('eden_garage:stockv',function(valid)

				if (valid) then
					TriggerServerEvent('eden_garage:debug', vehicle)
					deleteCar(vehicle)
					TriggerEvent('esx:showNotification', 'He borrado')
					TriggerServerEvent('eden_garage:modifystate', true,vehicleProps.plate)

					TriggerServerEvent('eden_garage:logging', "engineHealth \t" .. engineHealth.. "\n")

					TriggerEvent('esx:showNotification', 'Su vehículo está en el garaje')
				else
					TriggerEvent('esx:showNotification', 'No puede almacenar este vehículo')
				end
			end,vehicleProps,id)
		else
			TriggerEvent('esx:showNotification', 'No hay vehículo para meter')
		end
	end
end
-- Fin fonction qui permet de rentrer un vehicule 
--Fin fonction Menu

function deleteCar( entity )
    Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) )
end


--Fonction pour spawn vehicule
function SpawnVehicle(vehicle,opc,coord,id)

		if opc == nil then
			local car = GetClosestVehicle(this_Garage.SpawnPoint.Pos.x ,this_Garage.SpawnPoint.Pos.y,this_Garage.SpawnPoint.Pos.z + 1,  3.0,  0,  71)
			if not DoesEntityExist(car) then
				local id = nil
				ESX.Game.SpawnVehicle(vehicle.model, {
					x = this_Garage.SpawnPoint.Pos.x ,
					y = this_Garage.SpawnPoint.Pos.y,
					z = this_Garage.SpawnPoint.Pos.z + 1											
					},120, function(callback_vehicle)
					ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
					TriggerEvent("advancedFuel:setEssence", 100, GetVehicleNumberPlateText(callback_vehicle), GetDisplayNameFromVehicleModel(GetEntityModel(callback_vehicle)))
					TriggerServerEvent('llaves:addarrayllaves',GetVehicleNumberPlateText(callback_vehicle),vehicle)
					TriggerServerEvent('eden_garage:modifystate', false, GetVehicleNumberPlateText(callback_vehicle))
				end)

				
			else
				ESX.ShowNotification('Ya hay un vehículo en el punto de spawn')
			end
		else
			local car = GetClosestVehicle(coord.x ,coord.y,coord.z + 1,  3.0,  0,  71)
			 if not DoesEntityExist(car) then
				local id
				ESX.Game.SpawnVehicle(vehicle.model, {
					x = coord.x ,
					y = coord.y,
					z = coord.z + 1											
					},120, function(callback_vehicle)
					ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
					TriggerEvent("advancedFuel:setEssence", 100, GetVehicleNumberPlateText(callback_vehicle), GetDisplayNameFromVehicleModel(GetEntityModel(callback_vehicle)))
					TriggerServerEvent('llaves:addarrayllaves',GetVehicleNumberPlateText(callback_vehicle),vehicle) 
					TriggerServerEvent('eden_garage:modifystate', false, GetVehicleNumberPlateText(callback_vehicle))
					end)
			else
				ESX.ShowNotification('Ya hay un vehículo en el punto de spawn')
			end
		end
end
--Fin fonction pour spawn vehicule

--Action das les markers
AddEventHandler('eden_garage:hasEnteredMarker', function(zone)
	if zone == 'garage' then
		CurrentAction     = 'garage_action_menu'
		CurrentActionMsg  = ""
		CurrentActionData = {}
	end
end)

AddEventHandler('eden_garage:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)
--Fin Action das les markers

function ReturnVehicleMenu(opc,coord)
		ESX.TriggerServerCallback('eden_garage:getOutVehicles', function(vehicles)

			local elements = {}

			for _,v in pairs(vehicles) do

				local hashVehicule = v.model
	    		local vehicleName = GetDisplayNameFromVehicleModel(hashVehicule)
	    		local labelvehicle

	    		labelvehicle = vehicleName..': Sortie'
	    	
				table.insert(elements, {label =labelvehicle , value = v})
				
			end
			if opc == nil then

				ESX.UI.Menu.Open(
				'default', GetCurrentResourceName(), 'return_vehicle',
				{
					title    = 'Garage',
					align    = 'bottom-right',
					elements = elements,
				},
				function(data, menu)

					ESX.TriggerServerCallback('eden_garage:checkMoney', function(hasEnoughMoney)
						if hasEnoughMoney then
							if cont then
								contador()
								local car = GetClosestVehicle(this_Garage.SpawnPoint.Pos.x ,this_Garage.SpawnPoint.Pos.y,this_Garage.SpawnPoint.Pos.z + 1,  3.0,  0,  71)
								if not DoesEntityExist(car) then
									TriggerServerEvent('eden_garage:pagoPop')
									SpawnVehicle(data.current.value)
								else
									ESX.ShowNotification('Ya hay un coche en el punto de spawn')
								end
							else
								ESX.ShowNotification('Tienes que esperar un rato para volver a sacar el vehículo')			
							end
						else
							ESX.ShowNotification('No tienes suficiente dinero')						
						end
					end)
				end,
				function(data, menu)
					menu.close()
					--CurrentAction = 'open_garage_action'
				end
				)
			else
				ESX.UI.Menu.Open(
				'default', GetCurrentResourceName(), 'return_vehicle',
				{
					title    = 'Garage',
					align    = 'bottom-right',
					elements = elements,
				},
				function(data, menu)

					ESX.TriggerServerCallback('eden_garage:checkMoney', function(hasEnoughMoney)
						if hasEnoughMoney then
							if cont then
								contador()
								local car = GetClosestVehicle(this_Garage.SpawnPoint.Pos.x ,this_Garage.SpawnPoint.Pos.y,this_Garage.SpawnPoint.Pos.z + 1,  3.0,  0,  71)
								if not DoesEntityExist(car) then
									TriggerServerEvent('eden_garage:pay')
									SpawnVehicle(data.current.value,opc,coord)
								else
									ESX.ShowNotification('Ya hay un coche en el punto de spawn')	
								end
							else
								ESX.ShowNotification('Tienes que esperar un rato para volver a sacar el vehículo')			
							end
						else
							ESX.ShowNotification('No tienes suficiente dinero')						
						end
					end)
				end,
				function(data, menu)
					menu.close()
					--CurrentAction = 'open_garage_action'
				end
				)
			end
		end)
end

function contador()
	Citizen.CreateThread(function()
		cont = false
		Citizen.Wait(1000*60*30)
		cont = true
	end)
end

-- Affichage markers
Citizen.CreateThread(function()
	while true do
		Wait(0)		
		local coords = GetEntityCoords(GetPlayerPed(-1))			

		for k,v in pairs(Config.Garages) do
			if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then		
				DrawMarker(v.Marker, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
				DrawMarker(v.SpawnPoint.Marker, v.SpawnPoint.Pos.x, v.SpawnPoint.Pos.y, v.SpawnPoint.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.SpawnPoint.Size.x, v.SpawnPoint.Size.y, v.SpawnPoint.Size.z, v.SpawnPoint.Color.r, v.SpawnPoint.Color.g, v.SpawnPoint.Color.b, 100, false, true, 2, false, false, false, false)	
				DrawMarker(v.DeletePoint.Marker, v.DeletePoint.Pos.x, v.DeletePoint.Pos.y, v.DeletePoint.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.DeletePoint.Size.x, v.DeletePoint.Size.y, v.DeletePoint.Size.z, v.DeletePoint.Color.r, v.DeletePoint.Color.g, v.DeletePoint.Color.b, 100, false, true, 2, false, false, false, false)	
			end		
		end
		for k,v in pairs(Config.Garages) do
			if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.DeletePoint.Pos.x, v.DeletePoint.Pos.y, v.DeletePoint.Pos.z, true) <= 3) then		
				DrawText3D(v.DeletePoint.Pos.x, v.DeletePoint.Pos.y, v.DeletePoint.Pos.z + 1, "Pulsa E para meter el vehículo", 255,0,0)
				if IsControlJustReleased(0, 38) then
					if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
						StockVehicleMenua()
					else
						TriggerEvent('esx:showNotification', "No hay ningun coche para meter")
					end
				end
			end		
		end	
	end
end)

function StockVehicleMenua()
		local playerPed  = GetPlayerPed(-1)
		if IsPedSittingInAnyVehicle(playerPed) then
			local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
			SetEntityAsMissionEntity( vehicle, true, true )
			local vehicleProps  = ESX.Game.GetVehicleProperties(vehicle)
			local current 	    = GetPlayersLastVehicle(GetPlayerPed(-1), true)
			local engineHealth  = GetVehicleEngineHealth(current)
			local id = DecorGetInt(vehicle,"car_id")

			ESX.TriggerServerCallback('eden_garage:stockv',function(valid)

			if (valid) then
				TriggerServerEvent('eden_garage:debug', vehicle)
				deleteCar( vehicle )
				TriggerServerEvent('llaves:removearrayllaves',GetVehicleNumberPlateText(vehicle))
				TriggerServerEvent('eden_garage:modifystate', true,vehicleProps.plate)
					------------------------------------------------------- sauvegarde de l'etat du vehicule
				TriggerServerEvent('eden_garage:logging', "engineHealth \t" .. engineHealth.. "\n")
				TriggerEvent('esx:showNotification', 'Su vehículo está en el garaje')
			else
				TriggerEvent('esx:showNotification', 'No puede almacenar este vehículo')
			end
			end,vehicleProps,id)
		else
			TriggerEvent('esx:showNotification', 'No hay vehículo para meter')
		end
end
-- Fin affichage markers
function DrawText3D(x,y,z, text, r,g,b) -- some useful function, use it if you want!
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(0)
        SetTextProportional(1)
        -- SetTextScale(0.0, 0.55)
        SetTextColour(r, g, b, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end
-- Activer le menu quand player dedans
Citizen.CreateThread(function()
	local currentZone = 'garage'
	while true do

		Wait(0)

		local coords      = GetEntityCoords(GetPlayerPed(-1))
		local isInMarker  = false

		for _,v in pairs(Config.Garages) do
			if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
				isInMarker  = true
				this_Garage = v
			end
		end

		if isInMarker and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
			LastZone                = currentZone
			TriggerEvent('eden_garage:hasEnteredMarker', currentZone)
		end

		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('eden_garage:hasExitedMarker', LastZone)
		end

	end
end)

function deleteCarX(x,y,z)
	Citizen.CreateThread(function ()
		Citizen.Wait(500)
		local vehicleu = GetClosestVehicle(x,y,z, 6.5, 0, 70)
		SetEntityAsMissionEntity( vehicleu, true, true )
		Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( vehicleu ) )
	end)
	
end

-- Fin activer le menu quand player dedans

-- Controle touche
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(0)

		if CurrentAction ~= nil then

			SetTextComponentFormat('STRING')
			AddTextComponentString(CurrentActionMsg)
			DisplayHelpTextFromStringLabel(0, 0, 1, -1)

			if IsControlPressed(0,  Keys['E']) and (GetGameTimer() - GUI.Time) > 150 then

				if CurrentAction == 'garage_action_menu' then
					OpenMenuGarage()
				end

				CurrentAction = nil
				GUI.Time      = GetGameTimer()

			end
		end
	end
end)
-- Fin controle touche
