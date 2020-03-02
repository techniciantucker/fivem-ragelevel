local curGang = {}
local PlayerData = {}
local isInMarker = false
local curMarker = nil
local dragStatus = {}
local LastcurMarker                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}

ESX = nil

local prevMaleVariation = 0
local prevFemaleVariation = 0

-- Loading the hashes for female/male MP peds once.
local femaleHash = GetHashKey("mp_f_freemode_01")
local maleHash = GetHashKey("mp_m_freemode_01")

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	while ESX.GetPlayerData().job2 == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
	PlayerData.job2 = job2

	Citizen.Wait(5000)
end)

--  Blip
-- Citizen.CreateThread(function()
--     for k,v in pairs(Config.Gangs) do
--         local blip = AddBlipForCoord(v.Blip.coords)

--         SetBlipSprite (blip, v.Blip.sprite)
--         SetBlipScale  (blip, v.Blip.scale)
--         SetBlipColour (blip, v.Blip.color)
--         SetBlipAsShortRange(blip, true)

--         BeginTextCommandSetBlipName('STRING')
--         AddTextComponentString(v.Blip.name)
--         EndTextCommandSetBlipName(blip)
--     end
-- end)

RegisterNetEvent('esx_gangs:BossMenu')
AddEventHandler('esx_gangs:BossMenu', function(society)
    TriggerEvent('esx_society:openBossMenu', PlayerData.job2.name, function(data, menu)
        print(society)
        menu.close()

        CurrentAction     = 'menu_boss_actions'
        CurrentActionMsg  = 'boss'
        CurrentActionData = {}
    end, { wash = false })
end)

--Menus

function OpenBossMenu()
    TriggerServerEvent('esx_gangs:openBossMenu')
end

function OpenArmoryMenu()
	local elements = {}
    table.insert(elements, {label = "Sacar Arma",     value = 'get_weapon'})
    table.insert(elements, {label = "Depositar Arma",     value = 'put_weapon'})
    table.insert(elements, {label = "Sacar Objeto",  value = 'get_stock'})
    table.insert(elements, {label = "Depositar Objeto", value = 'put_stock'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gang_' .. PlayerData.job2.name .. '_armory', {
		title    = "Armario",
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'get_weapon' then
			OpenGetWeaponMenu()
		elseif data.current.value == 'put_weapon' then
			OpenPutWeaponMenu()
		elseif data.current.value == 'put_stock' then
			OpenPutStocksMenu()
		elseif data.current.value == 'get_stock' then
			OpenGetStocksMenu()
		end

	end, function(data, menu)
        menu.close()

		CurrentAction     = 'menu_armory'
		CurrentActionMsg  = "gang_armory_open"
		CurrentActionData = {}
	end)
end

function OpenGetWeaponMenu()
	ESX.TriggerServerCallback('esx_gangs:getArmoryWeapons', function(weapons)
		local elements = {}

		for i=1, #weapons, 1 do
			if weapons[i].count > 0 then
				table.insert(elements, {
					label = 'x' .. weapons[i].count .. ' ' .. ESX.GetWeaponLabel(weapons[i].name),
					value = weapons[i].name
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gang_' .. PlayerData.job2.name .. '_armory_get_weapon', {
			title    = "Sacar Arma",
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			menu.close()

			ESX.TriggerServerCallback('esx_gangs:removeArmoryWeapon', function()
				OpenGetWeaponMenu()
			end, data.current.value)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function OpenPutWeaponMenu()
	local elements   = {}
	local playerPed  = PlayerPedId()
	local weaponList = ESX.GetWeaponList()

	for i=1, #weaponList, 1 do
		local weaponHash = GetHashKey(weaponList[i].name)

		if HasPedGotWeapon(playerPed, weaponHash, false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
			table.insert(elements, {
				label = weaponList[i].label,
				value = weaponList[i].name
			})
		end
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gang_' .. PlayerData.job2.name .. '_armory_put_weapon', {
		title    = "Depositar Arma",
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		menu.close()

		ESX.TriggerServerCallback('esx_gangs:addArmoryWeapon', function()
			OpenPutWeaponMenu()
		end, data.current.value, true)
	end, function(data, menu)
		menu.close()
	end)
end

function OpenGetStocksMenu()
	ESX.TriggerServerCallback('esx_gangs:getStockItems', function(items)
		local elements = {}

		for i=1, #items, 1 do
			table.insert(elements, {
				label = 'x' .. items[i].count .. ' ' .. items[i].label,
				value = items[i].name
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gang_' .. PlayerData.job2.name .. '_stocks_menu', {
			title    = "Inventario Banda/Mafia",
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'gang_' .. PlayerData.job2.name .. '_stocks_menu_get_item_count', {
				title = "Cantidad"
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification("Cantidad Invalida")
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('esx_gangs:getStockItem', itemName, count)

					Citizen.Wait(300)
					OpenGetStocksMenu()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function OpenPutStocksMenu()
	ESX.TriggerServerCallback('esx_gangs:getPlayerInventory', function(inventory)
		local elements = {}

		for i=1, #inventory.items, 1 do
			local item = inventory.items[i]

			if item.count > 0 then
				table.insert(elements, {
					label = item.label .. ' x' .. item.count,
					type = 'item_standard',
					value = item.name
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gang_' .. PlayerData.job2.name .. '_stocks_menu', {
			title    = "Inventario",
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'gang_' .. PlayerData.job2.name .. '_stocks_menu_put_item_count', {
				title = "Cantidad"
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification("Cantidad Invalida")
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('esx_gangs:putStockItems', itemName, count)

					Citizen.Wait(300)
					OpenPutStocksMenu()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function OpenMafiaActionsMenu()
	ESX.UI.Menu.CloseAll()

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gangs_actions',{

			title    = _U('citizen_interaction'),
			align    = 'bottom-right',
			elements = {
				-- {label = _U('id_card'), value = 'identity_card'},
				-- {label = _U('search'), value = 'body_search'},
				{label = _U('handcuff'), value = 'handcuff'},
				{label = ('Desesposar'), value = 'uncuff'},
				{label = _U('drag'), value = 'drag'},
				{label = _U('put_in_vehicle'), value = 'put_in_vehicle'},
				{label = _U('out_the_vehicle'), value = 'out_the_vehicle'},
			},
		  },

		function(data, menu)

			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			if closestPlayer ~= -1 and closestDistance <= 3.0 then
					local action = data.current.value

					if action == 'identity_card' then
						OpenIdentityCardMenu(closestPlayer)
					elseif action == 'body_search' then
						TriggerServerEvent('esx_srppolicia:message', GetPlayerServerId(closestPlayer), _U('being_searched'))
						OpenBodySearchMenu(closestPlayer)
					
					elseif action == 'handcuff' then
						local target, distance = ESX.Game.GetClosestPlayer()
						playerheading = GetEntityHeading(GetPlayerPed(-1))
						playerlocation = GetEntityForwardVector(PlayerPedId())
						playerCoords = GetEntityCoords(GetPlayerPed(-1))
						local target_id = GetPlayerServerId(target)
						if distance <= 2.0 then
							TriggerServerEvent('esx_gangs:requestarrest', target_id, playerheading, playerCoords, playerlocation)
						else
							ESX.ShowNotification('No hay nadie cerca')
						end
					
					elseif action == 'uncuff' then
						local target, distance = ESX.Game.GetClosestPlayer()
						playerheading = GetEntityHeading(GetPlayerPed(-1))
						playerlocation = GetEntityForwardVector(PlayerPedId())
						playerCoords = GetEntityCoords(GetPlayerPed(-1))
						local target_id = GetPlayerServerId(target)
						if distance <= 2.0 then
							TriggerServerEvent('esx_gangs:requestrelease', target_id, playerheading, playerCoords, playerlocation)
						else
							ESX.ShowNotification('No hay nadie cerca')
						end
				
					elseif action == 'drag' then
						TriggerServerEvent('esx_gangs:drag', GetPlayerServerId(closestPlayer))
					elseif action == 'put_in_vehicle' then
						TriggerServerEvent('esx_gangs:putInVehicle', GetPlayerServerId(closestPlayer))
					elseif action == 'out_the_vehicle' then
						TriggerServerEvent('esx_gangs:OutVehicle', GetPlayerServerId(closestPlayer))
					elseif action == 'fine' then
						OpenFineMenu(closestPlayer)
					elseif action == 'license' then
						ShowPlayerLicense(closestPlayer)
					elseif action == 'unpaid_bills' then
						OpenUnpaidBillsMenu(closestPlayer)
					end
			else
					ESX.ShowNotification(_U('no_players_nearby'))
			end
		end,
		function(data, menu)
		  menu.close()
		end
	)
end

function OpenIdentityCardMenu(player)
	ESX.TriggerServerCallback('esx_gangs:getOtherPlayerData', function(data)
		local elements = {}
		local nameLabel = _U('name', data.name)
		local jobLabel, sexLabel, dobLabel, heightLabel, idLabel

		if data.job.grade_label and  data.job.grade_label ~= '' then
			jobLabel = _U('job', data.job.label .. ' - ' .. data.job.grade_label)
		else
			jobLabel = _U('job', data.job.label)
		end

		if Config.EnableESXIdentity then
			nameLabel = _U('name', data.firstname .. ' ' .. data.lastname)

			if data.sex then
				if string.lower(data.sex) == 'm' then
					sexLabel = _U('sex', _U('male'))
				else
					sexLabel = _U('sex', _U('female'))
				end
			else
				sexLabel = _U('sex', _U('unknown'))
			end

			if data.dob then
				dobLabel = _U('dob', data.dob)
			else
				dobLabel = _U('dob', _U('unknown'))
			end

			if data.height then
				heightLabel = _U('height', data.height)
			else
				heightLabel = _U('height', _U('unknown'))
			end

			if data.name then
				idLabel = _U('id', data.name)
			else
				idLabel = _U('id', _U('unknown'))
			end
		end

		local elements = {
			{label = nameLabel},
			{label = jobLabel}
		}

		if Config.EnableESXIdentity then
			table.insert(elements, {label = sexLabel})
			table.insert(elements, {label = dobLabel})
			table.insert(elements, {label = heightLabel})
			table.insert(elements, {label = idLabel})
		end

		if data.drunk then
			table.insert(elements, {label = _U('bac', data.drunk)})
		end

		if data.licenses then
			table.insert(elements, {label = _U('license_label')})

			for i=1, #data.licenses, 1 do
				table.insert(elements, {label = data.licenses[i].label})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
			title    = _U('citizen_interaction'),
			align    = 'top-left',
			elements = elements
		}, nil, function(data, menu)
			menu.close()
		end)
	end, GetPlayerServerId(player))
end

function OpenBodySearchMenu(player)
	ESX.TriggerServerCallback('esx_gangs:getOtherPlayerData', function(data)
		local elements = {}

		for i=1, #data.accounts, 1 do
			if data.accounts[i].name == 'black_money' and data.accounts[i].money > 0 then
				table.insert(elements, {
					label    = _U('confiscate_dirty', ESX.Math.Round(data.accounts[i].money)),
					value    = 'black_money',
					itemType = 'item_account',
					amount   = data.accounts[i].money
				})

				break
			end
		end

		table.insert(elements, {label = _U('guns_label')})

		for i=1, #data.weapons, 1 do
			table.insert(elements, {
				label    = _U('confiscate_weapon', ESX.GetWeaponLabel(data.weapons[i].name), data.weapons[i].ammo),
				value    = data.weapons[i].name,
				itemType = 'item_weapon',
				amount   = data.weapons[i].ammo
			})
		end

		table.insert(elements, {label = _U('inventory_label')})

		for i=1, #data.inventory, 1 do
			if data.inventory[i].count > 0 then
				table.insert(elements, {
					label    = _U('confiscate_inv', data.inventory[i].count, data.inventory[i].label),
					value    = data.inventory[i].name,
					itemType = 'item_standard',
					amount   = data.inventory[i].count
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'body_search', {
			title    = _U('search'),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			if data.current.value then
				TriggerServerEvent('esx_gangs:confiscatePlayerItem', GetPlayerServerId(player), data.current.itemType, data.current.value, data.current.amount)
				OpenBodySearchMenu(player)
			end
		end, function(data, menu)
			menu.close()
		end)
	end, GetPlayerServerId(player))
end

function LookupVehicle()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'lookup_vehicle',
	{
		title = _U('search_database_title'),
	}, function(data, menu)
		local length = string.len(data.value)
		if data.value == nil or length < 2 or length > 13 then
			ESX.ShowNotification(_U('search_database_error_invalid'))
		else
			ESX.TriggerServerCallback('esx_srppolicia:getVehicleFromPlate', function(owner, found)
				if found then
					ESX.ShowNotification(_U('search_database_found', owner))
				else
					ESX.ShowNotification(_U('search_database_error_not_found'))
				end
			end, data.value)
			menu.close()
		end
	end, function(data, menu)
		menu.close()
	end)
end

RegisterNetEvent('esx_gangs:drag')
AddEventHandler('esx_gangs:drag', function(copId)
	if not isHandcuffed then
		return
	end

	if dragStatus.isDragged then
		ExecuteCommand("me deja de escoltar al sujeto")
	else
		ExecuteCommand("me agarra al sujeto del brazo")
	end

	dragStatus.isDragged = not dragStatus.isDragged
	dragStatus.CopId = copId

end)

Citizen.CreateThread(function()
	local playerPed
	local targetPed


	while true do
		Citizen.Wait(1)

		if isHandcuffed then
			playerPed = PlayerPedId()

			if dragStatus.isDragged then
				targetPed = GetPlayerPed(GetPlayerFromServerId(dragStatus.CopId))

				-- undrag if target is in an vehicle
				if not IsPedSittingInAnyVehicle(targetPed) then
					AttachEntityToEntity(playerPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
					
				else
					dragStatus.isDragged = false
					DetachEntity(playerPed, true, false)
				end

				if IsPedDeadOrDying(targetPed, true) then
					dragStatus.isDragged = false
					DetachEntity(playerPed, true, false)
				end

			else
				DetachEntity(playerPed, true, false)
			end
		else
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent('esx_gangs:putInVehicle')
AddEventHandler('esx_gangs:putInVehicle', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

	if not isHandcuffed then
		return
	end

	ExecuteCommand("me abre la puerta del vehiculo")
	ExecuteCommand("me mete al sujeto dentro del vehiculo, seguidamente, le pone el cinturón")
	ExecuteCommand("do ¿Estaria el cinturon abrochado?")


	if IsAnyVehicleNearPoint(coords, 5.0) then
		local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)

		if DoesEntityExist(vehicle) then
			local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

			for i=maxSeats - 1, 0, -1 do
				if IsVehicleSeatFree(vehicle, i) then
					freeSeat = i
					break
				end
			end

			if freeSeat then
				TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
				dragStatus.isDragged = false
			end
		end
	end
end)

RegisterNetEvent('esx_gangs:OutVehicle')
AddEventHandler('esx_gangs:OutVehicle', function()

	ExecuteCommand("me abre la puerta del vehiculo")
	ExecuteCommand("me le quita el cinturon y saca poco a poco al sujeto del vehiculo")

	local playerPed = PlayerPedId()

	if not IsPedSittingInAnyVehicle(playerPed) then
		return
	end

	local vehicle = GetVehiclePedIsIn(playerPed, false)
	TaskLeaveVehicle(playerPed, vehicle, 16)
end)


RegisterNetEvent('esx_gangs:getarrested')
AddEventHandler('esx_gangs:getarrested', function(playerheading, playercoords, playerlocation)
	
	playerPed = GetPlayerPed(-1)
	SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
	local x, y, z   = table.unpack(playercoords + playerlocation * 1.0)
	SetEntityCoords(GetPlayerPed(-1), x, y, z)
	SetEntityHeading(GetPlayerPed(-1), playerheading)
	Citizen.Wait(250)
	loadanimdict('mp_arrest_paired')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arrest_paired', 'crook_p2_back_right', 8.0, -8, 3750 , 2, 0, 0, 0, 0)
	Citizen.Wait(3760)
	isHandcuffed = true
	TriggerEvent('esx_gangs:handcuff')
	loadanimdict('mp_arresting')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
	ExecuteCommand("me saca del bolsillo/cinturon unas esposas y comezaria a esposar al sujeto.")
	

	if GetEntityModel(playerPed) == femaleHash then -- mp female
		prevFemaleVariation = GetPedDrawableVariation(ped, 7)
		SetPedComponentVariation(playerPed, 7, 25, 0, 0)
	
	-- If it's the male MP model, do the same thing as above, but for the Male ped instead.
	elseif GetEntityModel(playerPed) == maleHash then -- mp male
		prevMaleVariation = GetPedDrawableVariation(ped, 7)
		SetPedComponentVariation(playerPed, 7, 41, 0, 0)
	end

end)

RegisterNetEvent('esx_gangs:doarrested')
AddEventHandler('esx_gangs:doarrested', function()
	Citizen.Wait(250)
	loadanimdict('mp_arrest_paired')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arrest_paired', 'cop_p2_back_right', 8.0, -8,3750, 2, 0, 0, 0, 0)
	
	Citizen.Wait(3000)

end) 

RegisterNetEvent('esx_gangs:douncuffing')
AddEventHandler('esx_gangs:douncuffing', function()
	Citizen.Wait(250)
	loadanimdict('mp_arresting')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'a_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
	Citizen.Wait(5500)
	ClearPedTasks(GetPlayerPed(-1))
end)

RegisterNetEvent('esx_gangs:getuncuffed')
AddEventHandler('esx_gangs:getuncuffed', function(playerheading, playercoords, playerlocation)
	local x, y, z   = table.unpack(playercoords + playerlocation * 1.0)
	playerPed = GetPlayerPed(-1)

	SetEntityCoords(GetPlayerPed(-1), x, y, z)
	SetEntityHeading(GetPlayerPed(-1), playerheading)
	Citizen.Wait(250)
	loadanimdict('mp_arresting')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'b_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
	Citizen.Wait(5500)
	isHandcuffed = false
	TriggerEvent('esx_gangs:handcuff')
	ClearPedTasks(GetPlayerPed(-1))
	ExecuteCommand("me saca del bolsillo/cinturon una llave y comienza a desesposar al sujeto")
	if GetEntityModel(playerPed) == femaleHash then -- mp female
		SetPedComponentVariation(playerPed, 7, prevFemaleVariation, 0, 0)
	
	-- If it's not the MP female model, check for the MP male model instead.
	-- If that's the case, do the same thing but instead of resetting it to the
	-- female's previous style, set it to the male's previous style.
	elseif GetEntityModel(playerPed) == maleHash then -- mp male
		SetPedComponentVariation(playerPed, 7, prevMaleVariation, 0, 0)
	end

end)

-- Handcuff
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()

		if isHandcuffed then
			--DisableControlAction(0, 1, true) -- Disable pan
			DisableControlAction(0, 2, true) -- Disable tilt
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, 21, true) -- Shift

			
			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			

			DisableControlAction(0, 288,  true) -- Disable phone
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 167, true) -- Job

			DisableControlAction(0, 0, true) -- Disable changing view
			DisableControlAction(0, 26, true) -- Disable looking behind
			DisableControlAction(0, 73, true) -- Disable clearing animation
			DisableControlAction(2, 199, true) -- Disable pause screen

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(2, 36, true) -- Disable going stealth

			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle

			if IsEntityPlayingAnim(playerPed, 'mp_arresting', 'idle', 3) ~= 1 then
				ESX.Streaming.RequestAnimDict('mp_arresting', function()
					TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
				end)
			end
		else
			Citizen.Wait(500)
		end
	end
end)

function IsJobTrue()
    if PlayerData ~= nil then
		local IsJobTrue = false
		if PlayerData.job2 ~= nil then
            for k,v in pairs(Config.Gangs) do
				if PlayerData.job2.name == v.JobName then
					IsJobTrue = true
				end
			end
		end
        return IsJobTrue
    end
end

function IsGradeBoss()
    if PlayerData ~= nil then
        local IsGradeBoss = false
        if PlayerData.job2.grade_name == 'boss' then
            IsGradeBoss = true
		end
		return IsGradeBoss
    end
end

--Markers
--[ Absolute trash marker drawing and distance detection, I'm still learning :P (I know it's shit lmao)]
-- Citizen.CreateThread(function()
--     while true do
-- 	   Wait(0)
--         local markers = {}
--         if PlayerData.job2 ~= nil then
--             for k,v in pairs(Config.Gangs) do
--                 if PlayerData.job2.name == v.JobName then
-- 					markers = v.Markers
-- 				end

-- 				if IsControlJustReleased(0, 166) and not isDead and PlayerData.job2 and PlayerData.job2.name == v.JobName and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'gangs_actions') then
-- 					OpenMafiaActionsMenu()
-- 				end
-- 			end
-- 			for k,v in pairs(markers) do
-- 				local coords = GetEntityCoords(PlayerPedId())
-- 				local distance = GetDistanceBetweenCoords(coords, v.coords.x, v.coords.y, v.coords.z, true)
-- 				if(distance < Config.DrawDistance) then
-- 					DrawMarker(1, v.coords.x, v.coords.y, v.coords.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 0.5, 1.5, 0.5, 0, 100, false, true, 2, false, false, false, false)   

-- 					if distance < 1.5 then --[ TRASSSHHHHHH ]
-- 						curMarker = v.name
-- 					else
-- 						curMarker = nil
-- 					end
-- 				end
-- 			end
-- 			if IsControlJustReleased(1, 38) and IsJobTrue() then  
-- 				if curMarker == 'armory' then
-- 					OpenArmoryMenu()
-- 				end
-- 			end
-- 			if IsControlJustReleased(1, 38) and IsJobTrue() and IsGradeBoss() then
-- 				if curMarker == 'boss' then
-- 				  	OpenBossMenu()
-- 				end
-- 			end
--         end
--     end
-- end)

-- Menu F5
Citizen.CreateThread(function()
    while true do
	   Wait(0)
		if PlayerData.job2 ~= nil then
		end
        for k,v in pairs(Config.Gangs) do
			if IsControlJustReleased(0, 166) and not isDead and PlayerData.job2 and PlayerData.job2.name == v.JobName and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'gangs_actions') then
				OpenMafiaActionsMenu()
			end
		end
	end
end)

-- Markers
Citizen.CreateThread(function()
    while true do
	   Wait(0)
        local markers = {}
        if PlayerData.job2 ~= nil then
            for k,v in pairs(Config.Gangs) do
                if PlayerData.job2.name == v.JobName then
					markers = v.Markers
				end
			end
		end
		for k,v in pairs(markers) do
			local coords = GetEntityCoords(PlayerPedId())
			local distance = GetDistanceBetweenCoords(coords, v.coords.x, v.coords.y, v.coords.z, true)
				if(distance < Config.DrawDistance) then
					DrawMarker(1, v.coords.x, v.coords.y, v.coords.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 0.5, 1.5, 0.5, 0, 100, false, true, 2, false, false, false, false)   
			
				if distance < 1.5 then --[ TRASSSHHHHHH ]
					curMarker = v.name
				else
					curMarker = nil
				end
			end
		end
	end
end)

-- Acciones Entrar/Salir Punto
Citizen.CreateThread(function()
    	while true do
    		Wait(0)
			if PlayerData.job2 ~= nil then
				for k,v in pairs(Config.Gangs) do
					if PlayerData.job2.name == v.JobName then
					end

					local coordenadas      = GetEntityCoords(GetPlayerPed(-1))
					local isInMarker  = false
					local currentcurMarker = nil
					for k,v in pairs(Config.Gangs) do
						if PlayerData.job2.name == v.JobName then
							markers = v.Markers
						end
					end

					for k,v in pairs(markers) do
						if(GetDistanceBetweenCoords(coordenadas, v.coords.x, v.coords.y, v.coords.z, true) < 1.2) then
							isInMarker  = true
							currentcurMarker = k
						end
					end

					if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastcurMarker ~= currentcurMarker) then
						HasAlreadyEnteredMarker = true
						LastcurMarker                = currentcurMarker
						TriggerEvent('esx_mafias:hasEnteredMarker', currentcurMarker)
					end

					if not isInMarker and HasAlreadyEnteredMarker then
						HasAlreadyEnteredMarker = false
						TriggerEvent('esx_mafias:hasExitedMarker', LastcurMarker)
					end
				end
			end
		end
	end)

AddEventHandler('esx_mafias:hasEnteredMarker', function(curMarker)
	
	for k,v in pairs(Config.Gangs) do
	if PlayerData.job2.name == v.JobName then
	for k,v in pairs(markers) do

    if curMarker == 'boss' and IsGradeBoss() then
      CurrentAction     = 'boss'
      CurrentActionMsg  = ('Presiona E para abrir el menu de jefe')
      CurrentActionData = {}
    end

    if curMarker == 'armory' then
      CurrentAction     = 'armory'
      CurrentActionMsg  = ('Presiona E para abrir el armario')
      CurrentActionData = {}
	end
	end
	end
	end

end)

AddEventHandler('esx_mafias:hasExitedMarker', function(curMarker)

    CurrentAction = nil
    ESX.UI.Menu.CloseAll()

end)

-- Control de teclas
Citizen.CreateThread(function()
  while true do

    Citizen.Wait(0)

    if CurrentAction ~= nil then

      SetTextComponentFormat('STRING')
      AddTextComponentString(CurrentActionMsg)
      DisplayHelpTextFromStringLabel(0, 0, 1, -1)

      if IsControlJustReleased(0, 38) then

        if CurrentAction == 'armory' then
            OpenArmoryMenu()
        end

        if CurrentAction == 'boss' then
            OpenBossMenu()
        end
	end
end
  end
end)


function loadanimdict(dictname)
	if not HasAnimDictLoaded(dictname) then
		RequestAnimDict(dictname) 
		while not HasAnimDictLoaded(dictname) do 
			Citizen.Wait(1)
		end
	end
end