ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function openMenu()
	ESX.UI.Menu.Open(
	  'default', GetCurrentResourceName(), 'id_card_menu',
	  {
		  title    = 'Menu Licencias',
		  align    = 'bottom-right',
		  elements = {
			  {label = 'Mirar tu DNI', value = 'checkID'},
			  {label = 'Mostrar tu DNI', value = 'showID'},
			  {label = 'Mirar tu licencia de conduccion', value = 'checkDriver'},
			  {label = 'Mostrar tu licencia de conduccion', value = 'showDriver'},
			  {label = 'Mirar tu licencia de armas', value = 'checkFirearms'},
			  {label = 'Mostrar tu licencia de armas', value = 'showFirearms'},
		  }
	  },
	  function(data, menu)
		  local val = data.current.value
		  
		  if val == 'checkID' then
			  TriggerServerEvent('spainrp_dni:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
			  ExecuteCommand("me saca su dni y comienza a observarlo")
		  elseif val == 'checkDriver' then
			  TriggerServerEvent('spainrp_dni:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')
		  elseif val == 'checkFirearms' then
			  TriggerServerEvent('spainrp_dni:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'weapon')
		  else
			  local player, distance = ESX.Game.GetClosestPlayer()
			  
			 	 if distance ~= -1 and distance <= 3.0 then
			  if val == 'showID' then
				  TriggerServerEvent('spainrp_dni:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player))
				  
			  elseif val == 'showDriver' then
				 	 TriggerServerEvent('spainrp_dni:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'driver')
			  elseif val == 'showFirearms' then
			 		 TriggerServerEvent('spainrp_dni:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'weapon')
				  end
			  else
				ESX.ShowNotification('No hay jugadores cerca')
			  end
		  end
	  end,
	  function(data, menu)
		  menu.close()
	  end
  )
  end

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if IsControlJustPressed(1, 182) and IsControlPressed(1, 21) then
			openMenu()
		end
	end
end)

  