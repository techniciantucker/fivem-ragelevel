ESX                           = nil
local CurrentAction           = nil
local HasAlreadyEnteredMarker = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}

	local arma = {{label = "Cargador Pistola .50", name = "WEAPON_PISTOL50", price = 300},
						{label = "Cargador Pistola MK2", name = "WEAPON_PISTOL_MK2", price = 300},
						{label = "Cargador Pistola SNS", name = "WEAPON_SNSPISTOL", price = 300},
						{label = "Cargador Revólver", name = "WEAPON_REVOLVER", price = 300},
						{label = "Cargador Pistola Vintage", name = "WEAPON_VINTAGEPISTOL", price = 300},
						{label = "Cargador Pistola Pesada", name = "WEAPON_HEAVYPISTOL", price = 300},
						{label = "Cargador francotirador", name = "WEAPON_SNIPERRIFLE", price = 300},
						{label = "Cargador subfusil", name = "WEAPON_SMG", price = 300},
						{label = "Cargador rifle de asalto", name = "WEAPON_ASSAULTRIFLE", price = 300},
						{label = "Cargador fusil avanzado", name = "WEAPON_ADVANCEDRIFLE", price = 300},
						{label = "Cargador Pistola de combate", name = "WEAPON_COMBATPISTOL", price = 300},
						{label = "Cargador Pistola Vintage", name = "WEAPON_VINTAGEPISTOL", price = 300},
						{label = "Cargador Tec-9", name = "WEAPON_MACHINEPISTOL", price = 300}
					}
	local pos = {
				{x =  -331.24, y =	6082.32,z = 30.44}, -- paleto bay
				{x = 1692.72, y = 3757.84, z = 33.72}, --cerca casa trevor
    			{x = 2569.96, y = 294.96, z = 107.72}, -- nº3
    			{x = -1118.64, y = 2696.56, z = 17.56}, -- nº4
    			{x = -1115.44, y = 4936.24, z = 217.36}, -- mafia campamento altruista
    			{x = 51.2, y = 3702.6, z = 38.76}, -- mafia stab city
    			{x = 2223.12, y = 5607.16, z = 53.64}, -- mafia monte chilliad
    			{x = 3316.64, y = 5175.56, z = 17.42} -- mafia monte gordo
    		}
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getShtoniaredObjtoniect', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)



function OpenShopMenu(zone)

	local elements = {}

	for i=1,#arma, 1 do

		table.insert(elements, {
			label     = arma[i].label .. ' - <span style="color:green;">$' .. arma[i].price .. ' </span>',
			realLabel = arma[i].label,
			value     = arma[i].label,
			price     = arma[i].price
		})
	end


	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'cargadores',
		{
			title  = 'Cargadores',
			align    = 'bottom-right',
			elements = elements
		},
		function(data, menu)				
			TriggerServerEvent('carg:buyItem', data.current.value, data.current.price, zone, data.current.label)
		end,
		function(data, menu)
			
			menu.close()
			
			CurrentAction     = 'shop_menu'
			CurrentActionMsg  = _U('shop_menu')
			CurrentActionData = {zone = zone}
		end
	)
end
RegisterNetEvent('carg:hasEnteredMarker')
AddEventHandler('carg:hasEnteredMarker', function(zone)
	
	CurrentAction     = 'shop_menu'
	CurrentActionMsg  = _U('shop_menu')
	CurrentActionData = {zone = zone}

end)
RegisterNetEvent('carg:hasExitedMarker')
AddEventHandler('carg:hasExitedMarker', function(zone)

	CurrentAction = nil
	ESX.UI.Menu.CloseAll()

end)

RegisterNetEvent('carg:doyarma')
AddEventHandler('carg:doyarma',function(item,price)
	Citizen.Trace(item)
	local si = nil
	for i=1,#arma,1 do
		if arma[i].label == item then
			if HasPedGotWeapon(GetPlayerPed(-1),arma[i].name,false) then
					Citizen.Trace(arma[i].name)
					AddAmmoToPed(GetPlayerPed(-1), arma[i].name, 30)
					TriggerServerEvent('carg:pipa',item,price)
					si = 1
					break
			end
		end
	end
	if si == nil or si == 0 then
		SetTextComponentFormat('STRING')
      	AddTextComponentString("No tienes ese arma")
      	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
	else
		si = nil
	end


end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local coords      = GetEntityCoords(GetPlayerPed(-1))
		local isInMarker  = false
		local currentZone = nil

			for i = 1, #pos, 1 do
				if(GetDistanceBetweenCoords(coords, pos[i].x,pos[i].y,pos[i].z) < 1) then
					isInMarker  = true
					ShopItems   = items
					currentZone = 1
					LastZone    = i
				end
			end
		if isInMarker and not HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = true
			TriggerEvent('carg:hasEnteredMarker', currentZone)
		end
		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('carg:hasExitedMarker', LastZone)
		end

		for i = 1, #pos, 1 do
       		if(GetDistanceBetweenCoords(coords, pos[i].x,pos[i].y,pos[i].z) < 25) then
        		DrawMarker(1,pos[i].x,pos[i].y,pos[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5,1.5,1.5, 255,255,12, 100, false, true, 2, false, false, false, false)
        	end
    	end

    	if CurrentAction ~= nil then
	      SetTextComponentFormat('STRING')
	      AddTextComponentString(CurrentActionMsg)
	      DisplayHelpTextFromStringLabel(0, 0, 1, -1)
	      if IsControlJustReleased(0, 38) then          
	        if CurrentAction == 'shop_menu' then
	          OpenShopMenu(CurrentActionData.zone)
	        end    
	        CurrentAction = nil            
	      end
	    end
	end
end)
