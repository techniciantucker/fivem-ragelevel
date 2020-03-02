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
local GUI      = {}
local PlayerData                = {}
local lastVehicle = nil
local lastOpen = false
GUI.Time                      = 0

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getShtoniaredObjtoniect', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  	PlayerData = xPlayer
end)

function VehicleInFront()
    local pos = GetEntityCoords(GetPlayerPed(-1))
    local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 4.0, 0.0)
    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
    local a, b, c, d, result = GetRaycastResult(rayHandle)
    return result
end
function GetPlayers()
    local players = {}

    for i = 0, 33 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end

function GetClosestPlayer()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)

    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = GetDistanceBetweenCoords(targetCoords['x'], targetCoords['y'], targetCoords['z'], plyCoords['x'], plyCoords['y'], plyCoords['z'], true)
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end

    return closestPlayer, closestDistance
end

-- Key controls
Citizen.CreateThread(function()
  while true do

    Wait(0)

		if IsControlPressed(0, Keys["L"]) and (GetGameTimer() - GUI.Time) > 150 then
			local player, distance = ESX.Game.GetClosestPlayer()
			if distance ~= -1 and distance <= 7.0 then
				TriggerServerEvent('esx_truck_inventory:closeMenu', GetPlayerServerId(player))
				ESX.ShowNotification('Hay jugadores cerca, no puedes abrir el inventario')
			else
				local vehFront = VehicleInFront()
				local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
				local closecar = GetClosestVehicle(x, y, z, 4.0, 0, 71)
				if vehFront > 0 and closecar ~= nil and GetPedInVehicleSeat(closecar, -1) ~= GetPlayerPed(-1) then
							lastVehicle = vehFront
							local model = GetDisplayNameFromVehicleModel(GetEntityModel(closecar))
							local locked = GetVehicleDoorLockStatus(closecar)
							local class = GetVehicleClass(vehFront)
							print(locked)
							ESX.UI.Menu.CloseAll()
							if ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'inventory') then
								SetVehicleDoorShut(vehFront, 5, false)
							else
								if locked == 1 or class == 15 or class == 16 or class == 14 then
									SetVehicleDoorOpen(vehFront, 5, false, false)
									ESX.UI.Menu.CloseAll()

									TriggerServerEvent("esx_truck_inventory:getInventory", GetVehicleNumberPlateText(vehFront))
								else
									ESX.ShowNotification('El cofre esta cerrado')
								end
							end
					else
						ESX.ShowNotification('No hay coches cerca')
					end
				lastOpen = true
				GUI.Time  = GetGameTimer()
			end
		elseif lastOpen and IsControlPressed(0, Keys["BACKSPACE"]) and (GetGameTimer() - GUI.Time) > 150 then
				lastOpen = false
				ESX.UI.Menu.CloseAll()
				if lastVehicle > 0 then
					SetVehicleDoorShut(lastVehicle, 5, false)
					lastVehicle = 0
				end
				GUI.Time  = GetGameTimer()		
		end
			
  end
end)

function isIntegrer(number)
	if number % 1 == 0 then
		return true
	end
	return false
end

function msg(msg)
TriggerEvent("pNotify:SetQueueMax", "center", 2)
TriggerEvent("pNotify:SendNotification", {
    text = msg,
    type = "error",
    timeout = 3000,
    layout = "centerRight",
    queue = "center"
})
end
RegisterNetEvent('esx_truck_inventory:getInventoryLoaded')
AddEventHandler('esx_truck_inventory:getInventoryLoaded', function(inventory)
	local elements = {}
	local vehFrontBack = VehicleInFront()


	table.insert(elements, {
      label     = 'Depositar',
      count     = 0,
      value     = 'deposit',
    })

	if inventory ~= nil and #inventory > 0 then
		for i=1, #inventory, 1 do
		  if inventory[i].count > 0 then
		    table.insert(elements, {
		      label     = inventory[i].label .. ' x' .. inventory[i].count,
		      count     = inventory[i].count,
		      value     = inventory[i].name,
		    })
		  end
		
		end
	end 

	ESX.UI.Menu.Open(
	  'default', GetCurrentResourceName(), 'inventory_deposit',
	  {
	    title    = 'Contenido del maletero',
			align    = 'bottom-right',
	    elements = elements,
	  },
	  function(data, menu) 
	  	if data.current.value == 'deposit' then
	  		local elem = {}
	  		PlayerData = ESX.GetPlayerData()
			for i=1, #PlayerData.inventory, 1 do
				if PlayerData.inventory[i].count > 0 then
				    table.insert(elem, {
				      label     = PlayerData.inventory[i].label .. ' x' .. PlayerData.inventory[i].count,
				      count     = PlayerData.inventory[i].count,
				      value     = PlayerData.inventory[i].name,
				      name     = PlayerData.inventory[i].label,
				    })
				end
			end
			ESX.UI.Menu.Open(
			  'default', GetCurrentResourceName(), 'inventory_player',
			  {
			    title    = 'Contenido del inventario',
			    align    = 'bottom-right',
			    elements = elem,
			  },function(data3, menu3)
				ESX.UI.Menu.Open(
				  'dialog', GetCurrentResourceName(), 'inventory_item_count_give',
				  {
				    title = 'Cantidad'
				  },
				  function(data4, menu4)
				
				    local quantity = tonumber(data4.value)
				    vehFront = VehicleInFront()

				    if quantity > 0 and quantity <= tonumber(data3.current.count) and vehFront > 0 then
				    	if isIntegrer(quantity) == true then
					    	local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
					    	local closecar = GetClosestVehicle(x, y, z, 4.0, 0, 71)
					        TriggerServerEvent('esx_truck_inventory:addInventoryItem', GetVehicleClass(closecar), GetDisplayNameFromVehicleModel(GetEntityModel(closecar)), GetVehicleNumberPlateText(vehFront), data3.current.value, quantity, data3.current.name)
				   		else
				   			msg("Cantidad invalida")
				   			ESX.UI.Menu.CloseAll()
				   		end
				    else
			      		ESX.ShowNotification('~rCantidad invalida')
				    end
				
				    ESX.UI.Menu.CloseAll()

		        	local vehFront = VehicleInFront()
		          	if vehFront > 0 then
		              TriggerServerEvent("esx_truck_inventory:getInventory", GetVehicleNumberPlateText(vehFront))
		            else
		              SetVehicleDoorShut(vehFrontBack, 5, false)
		            end
				  end,
				  function(data4, menu4)
		            SetVehicleDoorShut(vehFrontBack, 5, false)
				    ESX.UI.Menu.CloseAll()
				  end
				)
			end)
	  	else
			ESX.UI.Menu.Open(
			  'dialog', GetCurrentResourceName(), 'inventory_item_count_give',
			  {
			    title = 'Cantidad'
			  },
			  function(data2, menu2)
			
			    local quantity = tonumber(data2.value)
			    vehFront = VehicleInFront()

			    if quantity > 0 and quantity <= tonumber(data.current.count) and vehFront > 0 then
			    	if isIntegrer(quantity) == true then
			      		TriggerServerEvent('esx_truck_inventory:removeInventoryItem', GetVehicleNumberPlateText(vehFront), data.current.value, quantity)
			   		else
			   			msg("Cantidad invalida")
			   			ESX.UI.Menu.CloseAll()
			   		end
			    else
			      ESX.ShowNotification('~rCantidad invalida')
			    end
			
			    ESX.UI.Menu.CloseAll()

	        	local vehFront = VehicleInFront()
	          	if vehFront > 0 then
	          		ESX.SetTimeout(1500, function()
	              		TriggerServerEvent("esx_truck_inventory:getInventory", GetVehicleNumberPlateText(vehFront))
	          		end)
	            else
	              SetVehicleDoorShut(vehFrontBack, 5, false)
	            end
			  end,
			  function(data2, menu2)
	            SetVehicleDoorShut(vehFrontBack, 5, false)
			    ESX.UI.Menu.CloseAll()
			  end
			)
	  	end
	  end)
end)

RegisterNetEvent('esx_truck_inventory:closedMenu')
AddEventHandler('esx_truck_inventory:closedMenu', function()
	ESX.UI.Menu.CloseAll()
	lastOpen = false
  if lastVehicle > 0 then
  	SetVehicleDoorShut(lastVehicle, 5, false)
  	lastVehicle = 0
  end
  GUI.Time  = GetGameTimer()
end)
