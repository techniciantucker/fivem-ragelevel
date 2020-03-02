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

ESX                           = nil
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getShtoniaredObjtoniect', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	Citizen.Wait(4000)
	ESX.TriggerServerCallback('esx_shops:requestDBItems', function(ShopItems)
		for k,v in pairs(ShopItems) do
			Config.Zones[k].Items = v
		end
	end)

end)

AddEventHandler('onClientMapStart', function()

	ESX.TriggerServerCallback('esx_shops:requestDBItems', function(ShopItems)
		for k,v in pairs(ShopItems) do
			Config.Zones[k].Items = v
		end
	end)

end)


function OpenShopMenu(zone,i)
	local elements = {}


	for i=1, #Config.Zones[zone].Items, 1 do
	
		local item = Config.Zones[zone].Items[i]
		--[[table.insert(elements, {
			label     = item.label .. ' - <span style="color: green;">' .. item.price .. ' EUR</span>',
			realLabel = item.label,
			value     = item.name,
			price     = item.price
		})]]

    	local options          = {}

	    table.insert(elements, {
		  name    = item.name,
		  label   = item.label .. ' - <span style="color: green;">' .. item.price .. ' EUR</span>',
		  value   = 0,
		  price     = item.price,
		  type    = 'slider',
		  max     = 69
		})

	end

	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'shop',
		{
			title    = _U('shop'),
			align    = 'bottom-right',
			elements = elements
		},
		function(data, menu)
         	ESX.UI.Menu.Open(
              	'default', GetCurrentResourceName(), 'accept_shops',
              	{
                  	title    = 'Seguro que deseas comprarlo por '..data.current.price*data.current.value..'$?' ,
                  	align	 = 'bottom-right',
                  	elements = {
                      	{label = 'Sí', value = 'yes'},
                      	{label = 'No', value = 'no'}
                  	}
              	},
          		function(data2, menu2)

            if data2.current.value == 'yes' then

				TriggerServerEvent('esx_shops:buyItem', data.current.name, data.current.value, data.current.price * data.current.value,i)

          	else
          		menu2.close()
			  end        
			  
			  ESX.UI.Menu.CloseAll()

          	end,
          	function(data2, menu2)
          		menu2.close()
    		end
          	)                 

		end,
		function(data, menu)
			menu.close()
			CurrentAction     = 'shop_menu'
			CurrentActionMsg  = _U('press_menu')
			CurrentActionData = {zone = zone}
		end
	)
end

RegisterNetEvent('esx_shops:openMenu')
AddEventHandler('esx_shops:openMenu',function(i)

	OpenShopMenu("TwentyFourSeven",i)

end)

function sendNotification(message, messageType, messageTimeout)
	TriggerEvent("pNotify:SendNotification", {
		text = message,
		type = messageType,
		queue = "qalle",
		timeout = messageTimeout,
		layout = "bottomCenter"
	})
end