X.OpenGetMenu = function(id)
	local elements = {}

	ESX.TriggerServerCallback('tm1_stores:getWarehouse', function(warehouse)
		X.LastShop = warehouse
	    table.insert(elements, {value = "wood" , valueLabel = Local.wood ,  material = X.LastShop.materials.wood, maxMaterial =  X.LastShop.maxMaterials.wood, label = "<span style='color: orange;'>Madera</span><b> : "..X.LastShop.materials.wood.."/"..X.LastShop.maxMaterials.wood.."</b>"})
	    table.insert(elements, {value = "food" , valueLabel = Local.food ,  material = X.LastShop.materials.food, maxMaterial =  X.LastShop.maxMaterials.food, label = "<span style='color: green;'>Comida</span><b> : "..X.LastShop.materials.food.."/"..X.LastShop.maxMaterials.food.."</b>"})
	    table.insert(elements, {value = "mine" , valueLabel = Local.mine ,  material = X.LastShop.materials.mine, maxMaterial =  X.LastShop.maxMaterials.mine, label = "<span style='color: yellow;'>Minerales</span><b> : "..X.LastShop.materials.mine.."/"..X.LastShop.maxMaterials.mine.."</b>"})
	    table.insert(elements, {value = "water", valueLabel = Local.water,  material = X.LastShop.materials.water, maxMaterial = X.LastShop.maxMaterials.water, label = "<span style='color: cyan;'>Agua</span><b> : "..X.LastShop.materials.water.."/"..X.LastShop.maxMaterials.water.."</b>"})
	    table.insert(elements, {value = "infoTrucks", label = Local.infoTrucks})
	    table.insert(elements, {value = "infoVans", label = Local.infoVans})

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'warehouse', {
			title    = Local.warehouse,
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			if data.current.value == "infoTrucks" then
				ESX.ShowNotification(Local.haveToBuy)
				local msg = "Camiones: "
				for k,v in pairs(Config.AvaliableTrucks) do
					if k % 2 == 0 then
						msg = msg.."~g~"..v.." "
					else
						msg = msg.."~o~"..v.." "
					end
				end
				ESX.ShowNotification(msg)
			elseif data.current.value == "infoVans" then
				ESX.ShowNotification(Local.haveToBuy)
				local msg = "Furgonetas: "
				for k,v in pairs(Config.AvaliableVans) do
					if k % 2 == 0 then
						msg = msg.."~g~"..v.." "
					else
						msg = msg.."~o~"..v.." "
					end
				end
				ESX.ShowNotification(msg)
			elseif data.current.value then
				X.Material = data.current.value
				X.ActualWarehouse = X.LastShop.storeName
				X.OpenOptionMenu()
			end
		end,
		function(data, menu)
			isMenuOpened = false
			menu.close()
		end
		)
    end, id)
end

X.OpenGetCharge = function()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'warehouse_charge',
	{
		title = Local.load..X.Material.." ("..Local.maxCharge..Config.MaxWeight[X.Option].." "..Local.tons..")",
	}, function(data, menu)
		local parameter = data.value
		local tons = tonumber(parameter)
		if X.Option == 'truck' then
			if X.IsAValidTruck() then						
				ESX.TriggerServerCallback('tm1_stores:getWarehouse', function(warehouse)
					if tons > 0 and tons < Config.MaxWeight[X.Option] then
						if warehouse.materials[X.Material] >= tons then
							ESX.Game.SpawnVehicle(Config.TrailersModels[X.Material].go, X.LastShop.spawnCharge, X.LastShop.spawnCharge.h, function(vehicle)
								local plate = X.GenerateUniquePlate()
								SetVehicleNumberPlateText(vehicle, plate)			
								TriggerServerEvent('tm1_stores:addTrailer', X.Trim(GetVehicleNumberPlateText(vehicle)), tons)
								TriggerServerEvent('tm1_stores:removeMaterial', X.LastShop.storeName, X.Material, tons)
								X.GoToNextStep()
							end)
						else
							ESX.ShowNotification(Local.notenough)
						end
					else
						ESX.ShowNotification(Local.invalidAumont)
					end
				end, X.ActualWarehouse)
			else
				ESX.ShowNotification(Local.notTruckAllowed)
			end
		elseif X.Option == 'van' then
			if X.IsAValidVan() then						
				ESX.TriggerServerCallback('tm1_stores:getWarehouse', function(warehouse)
					if tons > 0 and tons <= Config.MaxWeight[X.Option] then
						if warehouse.materials[X.Material] >= tons then
							X.Tons = tons
							TriggerServerEvent('tm1_stores:removeMaterial', X.LastShop.storeName, X.Material, X.Tons)
							ESX.ShowNotification(Local.goToCharge)
							X.GoToNextStep()
						else
							ESX.ShowNotification(Local.notenough)
						end
					else
						ESX.ShowNotification(Local.invalidAumont)
					end
				end, X.ActualWarehouse)
			else
				ESX.ShowNotification(Local.notTruckAllowed)
			end
		end
		menu.close()
	end, function(data, menu)
		menu.close()
	end)
end

X.OpenOptionMenu = function()
	local elements = {}
    table.insert(elements, {value = "truck", label = Local.loadTruck})
    table.insert(elements, {value = "van", label = Local.loadVan})
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'warehouse_load', {
		title    = Local.warehouse,
		align    = 'top-left',
		elements = elements
	}, function(data2, menu2)

		if data2.current.value then
			X.IsSelecting = true
			X.Option = data2.current.value
			ESX.ShowNotification(Local.youSelect..Local[X.Material].."~w~ "..Local.inLabel.." ~o~"..X.ActualWarehouse.."~w~. "..Local.youNeed.." ~y~"..Local[X.Option])
			ESX.UI.Menu.CloseAll()
		end
	end,
	function(data2, menu2)
		menu2.close()
	end
	)
end

X.CancelCharging = function()
	X.Material = nil
	X.ActualWarehouse = nil
	X.Option = nil
	X.IsSelecting = false
end

X.ExistsPlate = function(trailers, plate)
	for k,v in pairs(trailers) do
		if v.plate == plate then
			return true
		end
	end

	return false
end

X.GoToNextStep = function()
	if X.Option == 'truck' then
		X.IsSelecting = false
		X.IsCarrying = true
	elseif X.Option == 'van' then
		X.IsSelecting = false
		X.IsChargingBox = true
	end
end

X.GenerateUniquePlate = function()
	local plate = nil
	ESX.TriggerServerCallback('tm1_stores:getTrailers', function(trailers)
		local intentOfPlate = "TRC "..math.random(100, 999)
		while X.ExistsPlate(trailers, intentOfPlate) == true do
			intentOfPlate = "TRC "..math.random(100, 999)
		end
		plate = intentOfPlate
	end)
	while plate == nil do
		Wait(0)
	end

	return plate
end