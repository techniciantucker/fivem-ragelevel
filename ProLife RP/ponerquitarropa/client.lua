ESX = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getShtoniaredObjtoniect', function(obj) ESX = obj end)
    Citizen.Wait(10)
	end
end)

RegisterNetEvent('ropa:camisa')
AddEventHandler('ropa:camisa', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
		if(skin.sex == 0) then
		local clothesSkin = {
		['tshirt_1'] = 15, ['tshirt_2'] = 0,
		['torso_1'] = 15, ['torso_2'] = 0,
		['arms'] = 15, ['arms_2'] = 0
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
		else
		local clothesSkin = {
		['tshirt_1'] = 15, ['tshirt_2'] = 10,
		['torso_1'] = 18, ['torso_2'] = 9,
		['arms'] = 15, ['arms_2'] = 0
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
		end
	end)
end)

RegisterNetEvent('ropa:desnudo')
AddEventHandler('ropa:desnudo', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
		if(skin.sex == 0) then
		local clothesSkin = {
		['tshirt_1'] = 15, ['tshirt_2'] = 0,
		['torso_1'] = 15, ['torso_2'] = 0,
		['arms'] = 15, ['arms_2'] = 0
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
		else
		local clothesSkin = {
		['tshirt_1'] = 34, ['tshirt_2'] = 100,
		['torso_1'] = 82, ['torso_2'] = 0,
		['arms'] = 15, ['arms_2'] = 0
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
		end
	end)
end)

RegisterNetEvent('ropa:pantalones')
AddEventHandler('ropa:pantalones', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
		if(skin.sex == 0) then
		local clothesSkin = {
		['pants_1'] = 61, ['pants_2'] = 6
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
		else
		local clothesSkin = {
		['pants_1'] = 15, ['pants_2'] = 10
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
		print('oops')
		end
	end)
end)

RegisterNetEvent('ropa:zapatos')
AddEventHandler('ropa:zapatos', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
		if(skin.sex == 0) then
		local clothesSkin = {
		['shoes_1'] = 34, ['shoes_2'] = 0
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
		else
		local clothesSkin = {
		['shoes_1'] = 35, ['shoes_2'] = 0
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
		end
	end)
end)

RegisterNetEvent('ropa:mochila')
AddEventHandler('ropa:mochila', function()
	TriggerEvent('skinchanger:getSkin', function(skin)

		local clothesSkin = {
		['bags_1'] = 0, ['bags_2'] = 0
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	end)
end)

function OpenActionMenuInteraction(target)

	local elements = {}

	table.insert(elements, {label = ('Vestirse'), value = 'vestirse'})
	table.insert(elements, {label = ('Quitar camisa'), value = 'camisa'})
	table.insert(elements, {label = ('Quitar Pantalones'), value = 'pantalones'})
	table.insert(elements, {label = ('Quitar Zapatos'), value = 'zapatos'})
	table.insert(elements, {label = ('Quitar Mochila'), value = 'mochila'})
  		ESX.UI.Menu.CloseAll()


	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'action_menu',
		{
			title    = ('Ropa'),
			align    = 'top-left',
			elements = elements
		},

	function(data, menu)

		if data.current.value == 'vestirse' then
		ExecuteCommand("me se pone la ropa")
		ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		TriggerEvent('skinchanger:loadSkin', skin)
		end)
		ESX.UI.Menu.CloseAll()
		elseif data.current.value == 'camisa' then
		ExecuteCommand("me se quita la camiseta")
		TriggerEvent('ropa:camisa')
		ESX.UI.Menu.CloseAll()
	    elseif data.current.value == 'desnudo' then
	    ExecuteCommand("me se quita toda la ropa")
	    TriggerEvent('ropa:desnudo')
		ESX.UI.Menu.CloseAll()
		elseif data.current.value == 'pantalones' then
		ExecuteCommand("me se quita los pantalones")
		TriggerEvent('ropa:pantalones')
		ESX.UI.Menu.CloseAll()
		elseif data.current.value == 'zapatos' then
		ExecuteCommand("me se quita los zapatos")
		TriggerEvent('ropa:zapatos')
		ESX.UI.Menu.CloseAll()
		elseif data.current.value == 'mochila' then
		TriggerEvent('ropa:mochila')
		ESX.UI.Menu.CloseAll()
		end
	end)
end

Citizen.CreateThread(function()
	while true do
	Citizen.Wait(5)
		if IsControlJustReleased(0, 82) and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'action_menu') then
		OpenActionMenuInteraction()
		end
	end
end)