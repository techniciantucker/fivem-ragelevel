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

ESX = nil
local HasAlreadyEnteredMarker = false
local LastZone = nil
local CurrentAction = nil
local CurrentActionMsg = ''
local CurrentActionData = {}
local ShopOpen = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	ESX.TriggerServerCallback('esx_blackmarket:getShop', function(shopItems)
		for k,v in pairs(shopItems) do
			Config.Zones[k].Items = v
		end
	end)

	ESX.TriggerServerCallback('esx_blackmarket:requestDBItems', function(ShopItems)
		for k,v in pairs(ShopItems) do
			Config.Zones[k].Items2 = v
		end
	end)

	local hash = GetHashKey("u_m_o_taphillbilly")

	while not HasModelLoaded(hash) do
		RequestModel(hash)
		Wait(20)
	end

	ped = CreatePed("PED_TYPE_CIVMALE", hash, 1253.02, -2971.44, 10.97, 10.97, false, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
	FreezeEntityPosition(ped, true)
	SetEntityInvincible(ped,true)

end)

RegisterNetEvent('esx_blackmarket:sendShop')
AddEventHandler('esx_blackmarket:sendShop', function(shopItems)
	for k,v in pairs(shopItems) do
		Config.Zones[k].Items = v
	end
end)

function OpenShopMenu(zone)
	
	ESX.UI.Menu.CloseAll()
	PlaySoundFrontend(-1, 'BACK', 'HUD_AMMO_SHOP_SOUNDSET', false)
	
	-- START MENU

	ESX.UI.Menu.Open( 
    'default', GetCurrentResourceName(), 'blackmarket',
    {
        title    = ('Mercado negro'),
        align = 'bottom-right',
        elements = {
            {label = ('Armas'),     value = 'weapons'},
            {label = ('Objetos'),      value = 'items'}
        }
    },
    function(data, menu)
        
        if data.current.value == 'weapons' then
		
			local elements = {}

			for i=1, #Config.Zones[zone].Items, 1 do
				local item = Config.Zones[zone].Items[i]
		
				table.insert(elements, {
					label = ('%s - <span style="color: red;">%s</span>'):format(item.label, _U('shop_menu_item', ESX.Math.GroupDigits(item.price))),
					price = item.price,
					weaponName = item.item
				})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'weapons',
			{
				title    = ('Armas / Mercado negro'),
       			align = 'bottom-right',
				elements = elements
			},
			
				function(data, menu)
					ESX.TriggerServerCallback('esx_blackmarket:buyWeapon', function(bought)
						if bought then
							DisplayBoughtScaleform(data.current.weaponName, data.current.price)
						else
							PlaySoundFrontend(-1, 'ERROR', 'HUD_AMMO_SHOP_SOUNDSET', false)
						end
					end, data.current.weaponName, zone)
				end, function(data, menu)
					PlaySoundFrontend(-1, 'BACK', 'HUD_AMMO_SHOP_SOUNDSET', false)
					ShopOpen = false
					menu.close()
			
					CurrentAction     = 'shop_menu'
					CurrentActionMsg  = _U('shop_menu_prompt')
					CurrentActionData = { zone = zone }
				end, function(data, menu)
					PlaySoundFrontend(-1, 'NAV', 'HUD_AMMO_SHOP_SOUNDSET', false)
			end)
		
	
	
		elseif data.current.value == 'items' then
		
			local elements = {}

			for i=1, #Config.Zones[zone].Items2, 1 do
				local item = Config.Zones[zone].Items2[i]
		
				table.insert(elements, {
					label      = ('%s - <span style="color:red;">%s</span>'):format(item.label, ESX.Math.GroupDigits(item.price)),
					itemLabel  = item.label,
					item       = item.item,
					price      = item.price,
		
					value      = 1,
					type       = 'slider',
					min        = 1,
					max        = 100
				})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'items', {
				title    = ('Items / Mercado negro'),
				align    = 'bottom-right',
				elements = elements
			}, function(data, menu)
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm', {
					title    = '¿Confirmar compra?', data.current.value, data.current.itemLabel, ESX.Math.GroupDigits(data.current.price * data.current.value),
					align    = 'bottom-right',
					elements = {
						{label = 'Si',  value = 'si'},
						{label = 'No', value = 'no'}
				}}, function(data2, menu2)
					if data2.current.value == 'si' then
						TriggerServerEvent('esx_blackmarket:buyItem2', data.current.item, data.current.value, zone)
					end
		
					menu2.close()
				end, function(data2, menu2)
					menu2.close()
				end)
			end, function(data, menu)
				menu.close()
		
				currentAction     = 'shop_menu'
				currentActionMsg  = 'press_menu'
				currentActionData = {zone = zone}
			end)

        end 
        
	end,
	
    function(data, menu) -- Cette partie contient le code qui s'exécute lorsque l'on presse retour
        menu.close()
	end)
	
	-- END MENU	
end

function DisplayBoughtScaleform(weaponName, price)
	local scaleform = ESX.Scaleform.Utils.RequestScaleformMovie('MP_BIG_MESSAGE_FREEMODE')
	local sec = 4

	BeginScaleformMovieMethod(scaleform, 'SHOW_WEAPON_PURCHASED')

	PushScaleformMovieMethodParameterString(_U('weapon_bought', ESX.Math.GroupDigits(price)))
	PushScaleformMovieMethodParameterString(ESX.GetWeaponLabel(weaponName))
	PushScaleformMovieMethodParameterInt(GetHashKey(weaponName))
	PushScaleformMovieMethodParameterString('')
	PushScaleformMovieMethodParameterInt(100)

	EndScaleformMovieMethod()

	PlaySoundFrontend(-1, 'WEAPON_PURCHASE', 'HUD_AMMO_SHOP_SOUNDSET', false)

	Citizen.CreateThread(function()
		while sec > 0 do
			Citizen.Wait(0)
			sec = sec - 0.01
	
			DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
		end
	end)
end

AddEventHandler('esx_blackmarket:hasEnteredMarker', function(zone)
	if zone == 'blackmarket' then
		CurrentAction     = 'shop_menu'
		CurrentActionMsg  = _U('shop_menu_prompt')
		CurrentActionData = { zone = zone }
	end
end)

AddEventHandler('esx_blackmarket:hasExitedMarker', function(zone)
	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		if ShopOpen then
			ESX.UI.Menu.CloseAll()
		end
	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local coords = GetEntityCoords(PlayerPedId())
		local isInMarker, currentZone = false, nil

		for k,v in pairs(Config.Zones) do
			for i=1, #v.Locations, 1 do
				if GetDistanceBetweenCoords(coords, v.Locations[i], true) < Config.Size.x then
					isInMarker, ShopItems, currentZone, LastZone = true, v.Items, k, k
				end
			end
		end
		if isInMarker and not HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = true
			TriggerEvent('esx_blackmarket:hasEnteredMarker', currentZone)
		end
		
		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_blackmarket:hasExitedMarker', LastZone)
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction ~= nil then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, Keys['E']) then

				if CurrentAction == 'shop_menu' then
					if Config.LicenseEnable and Config.Zones[CurrentActionData.zone].Legal then
						ESX.TriggerServerCallback('esx_license:checkLicense', function(hasWeaponLicense)
							if hasWeaponLicense then
								OpenShopMenu(CurrentActionData.zone)
							else
								OpenBuyLicenseMenu(CurrentActionData.zone)
							end
						end, GetPlayerServerId(PlayerId()), 'weapon')
					else
						OpenShopMenu(CurrentActionData.zone)
					end
				end

				CurrentAction = nil
			end
		end
	end
end)

loadDict = function(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
end