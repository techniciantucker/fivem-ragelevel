local user_vehicles = {}                                                                                                             --
local user_garages = {}   
local insured_vehicles = {}
local slotprice = 500
local currentgaragecost = 0 
local coords = {}
local selectedgarage = {}
local garages = {
 [1] = {id = 1, name = "Central LS [1]", pos = {x = 215.842, y = -787.166, z = 30.829}, cost = 0, maxslots = 5, type = 'Public', showBlip = true},
 --[1] = {id = 1, name = "Central LS[12]", pos = {x = 238.086, y = -775.432, z = 30.701}, cost = 300000, maxslots = 32, type = 'Personal', showBlip = true},
 [2] = {id = 2, name = "North LS [2]", pos = {x = -443.004, y = 185.2983, z = 75.2037}, cost = 0, maxslots = 5, type = 'Public', showBlip = true},
 [3] = {id = 3, name = "Sandy [3]", pos = {x = 1232.479, y = 2708.325, z = 38.009}, cost = 0, maxslots = 5, type = 'Public', showBlip = true},
 [4] = {id = 4, name = "Paleto [4]", pos = {x = 117.9678, y = 6599.457, z = 32.0136}, cost = 0, maxslots = 5, type = 'Public', showBlip = true},
 [5] = {id = 5, name = "Industrial [5]", pos = {x = 947.136, y = -1697.978, z = 30.085}, cost = 15000, maxslots = 10, type = 'Personal', showBlip = true}, 
 [6] = {id = 6, name = "Apartment Complex [6]", pos = {x = 520.407, y = 168.996, z = 99.372}, cost = 6000, maxslots = 6, type = 'Personal', showBlip = true},
 [7] = {id = 7, name = "Hills [7]", pos = {x = -676.564, y = 904.18, z = 230.587}, cost = 18000, maxslots = 12, type = 'Personal', showBlip = true},
 [8] = {id = 8, name = "Autoshop Garage [8]", pos = {x = 258.6834, y = 2589.728, z = 44.95}, cost = 10000, maxslots = 8, type = 'Personal', showBlip = true},
 [9] = {id = 9, name = "Residential [9]", pos = {x = -226.092, y = 6436.400, z = 31.1973}, cost = 20000, maxslots = 4, type = 'Personal', showBlip = true},
 [10] = {id = 10, name = "Weazel [10]", pos = {x = -833.249, y = -392.953, z = 31.323}, cost = 18000, maxslots = 12, type = 'Personal', showBlip = true},
 [11] = {id = 11, name = "Small Garage [11]", pos = {x = -30.3036, y = 2.1268, z = 71.200}, cost = 40000, maxslots = 4, type = 'Personal', showBlip = true},
 [12] = {id = 12, name = "Maze Tower [12]", pos = {x = -84.0195, y = -820.996, z = 36.028}, cost = 300000, maxslots = 32, type = 'Personal', showBlip = true},
 [13] = {id = 13, name = "Catfish View [13]", pos = {x = 3802.055, y = 4463.333, z = 4.515}, cost = 0, maxslots = 1, type = 'Public', showBlip = true},
 [15] = {id = 15, name = "Garment [15]", pos = {x = 690.118, y = -984.674, z = 23.569}, cost = 25000, maxslots = 2, type = 'Personal', showBlip = true},
 [16] = {id = 16, name = "Golfing [16]", pos = {x = -941.218, y = 305.514, z = 71.047}, cost = 55000, maxslots = 10, type = 'Personal', showBlip = true},
 [17] = {id = 17, name = "Highway [17]", pos = {x = 2782.284, y = 3472.104, z = 55.323}, cost = 55000, maxslots = 5, type = 'Personal', showBlip = true},
 [19] = {id = 19, name = "Playboy [19]", pos = {x = -1527.789, y = 86.013, z = 56.609}, cost = 100000, maxslots = 5, type = 'Personal', showBlip = true},
 [20] = {id = 20, name = "Hawick Motel [20]", pos = {x = 327.673, y = -205.642, z = 54.086}, cost = 0, maxslots = 4, type = 'Public', showBlip = true},
 [21] = {id = 21, name = "Mission Row [21]", pos = {x = 324.202, y = -551.573, z = 28.744}, cost = 0, maxslots = 4, type = 'Public', showBlip = false},
 [22] = {id = 22, name = "Hospital [22]", pos = {x = 452.378, y = -997.000, z = 25.763}, cost = 0, maxslots = 4, type = 'Public', showBlip = false},
 [23] = {id = 23, name = "Lumberyard [23]", pos = {x = -573.251, y = 5243.776, z = 70.469}, cost = 0, maxslots = 1, type = 'Public', showBlip = true},
 [24] = {id = 24, name = "Trash Place [24]", pos = {x = -322.668, y = -1517.746, z = 27.545}, cost = 0, maxslots = 1, type = 'Public', showBlip = true},
 [25] = {id = 25, name = "El Burro [25]", pos = {x = 1374.563, y = -2219.366, z = 60.000}, cost = 15000, maxslots = 2, type = 'Personal', showBlip = false},
 [26] = {id = 26, name = "Bahama Mamas [26]", pos = {x = -1418.902, y = -648.044, z = 28.674}, cost = 45000, maxslots = 4, type = 'Personal', showBlip = false},
 [27] = {id = 27, name = "The Lost MC [27]", pos = {x = -817.770, y = -2919.662, z = 13.962}, cost = 25000, maxslots = 2, type = 'Personal', showBlip = false},
 [28] = {id = 28, name = "Anvil [28]", pos = {x = -817.770, y = -2919.662, z = 13.962}, cost = 25000, maxslots = 2, type = 'Personal', showBlip = false},
 [29] = {id = 29, name = "Biker [5]", pos = {x = 966.292, y = -120.444, z = 74.353}, cost = 15000, maxslots = 10, type = 'Personal', showBlip = true}, 
 [30] = {id = 30, name = "Sandy [5]", pos = {x = 1883.588, y = 3707.964, z = 33.157}, cost = 15000, maxslots = 10, type = 'Personal', showBlip = true},
 [31] = {id = 31, name = "Central LS [2]", pos = {x = 238.086, y = -775.432, z = 30.701}, cost = 15000, maxslots = 10, type = 'Personal', showBlip = true}, 
 [32] = {id = 32, name = "Barrio LS [2]", pos = {x = -53.546, y = -1836.981, z = 26.533}, cost = 15000, maxslots = 10, type = 'Personal', showBlip = true}, 
 [33] = {id = 33, name = "Taxi Garajes LS [2]", pos = {x = 902.831, y = -183.611, z = 73.912}, cost = 1500, maxslots = 10, type = 'Personal', showBlip = true},
 [34] = {id = 29, name = "Fuente Blanca", pos = {x = 1414.088, y = 1118.880, z = 114.838}, cost = 15000, maxslots = 10, type = 'Personal', showBlip = true}, 
}

Citizen.CreateThread(function()
 addGarageBlips()
 WarMenu.CreateLongMenu('garage', 'Garage')
 WarMenu.CreateLongMenu('vehicle_list', 'Vehicles')
 WarMenu.CreateLongMenu('modify_garages', 'Garages')
 WarMenu.CreateLongMenu('modify_garages2', 'Garages')
 WarMenu.CreateLongMenu('modify_garages_veh', 'Garages')
 WarMenu.CreateLongMenu('give_vehicles_players', 'Garages')
 WarMenu.CreateLongMenu('impound_yard', 'Impound')
 WarMenu.CreateLongMenu('purchase_insurance', 'Insurance')
 local currentItemIndex = 1
 local PurchasedSlots = 1 
 while true do
  Citizen.Wait(5)
  if WarMenu.IsMenuOpened('garage') then
   local t = true
   for i = 1, #user_garages do
    if user_garages[i].id == currentgarage.id and t then
     currentgaragecost = currentgarage.cost/10
     t = false
    end
   end
   if t then 
    local slots = {}
    for i = 1, currentgarage.maxslots do
     table.insert(slots, ""..i)
    end
    if WarMenu.Button(currentgarage.name, '~g~$'..currentgaragecost) then
     TriggerServerEvent("garage:buy", currentgaragecost, currentgarage.id, PurchasedSlots)
    elseif WarMenu.ComboBox('Slots', slots, currentItemIndex, PurchasedSlots, function(currentIndex)
     currentItemIndex = currentIndex 
     PurchasedSlots = currentIndex
     currentgaragecost = math.floor(currentgarage.cost + slotprice * (PurchasedSlots - 1))
     end) then
    end
   else
    if WarMenu.Button('List Vehicles', getCarQ().."/"..getGarageQ()) then
      recoverVehicle = false
      WarMenu.OpenMenu('vehicle_list')
    elseif WarMenu.Button('Store Vehicle') then
     StoreVehicle()
    end
   end
   WarMenu.Display()
  elseif WarMenu.IsMenuOpened('vehicle_list') then
   for i = 1,#user_vehicles do
    if (user_vehicles[i] ~= nil) then
     if user_vehicles[i].garage == currentgarage.id then
      if user_vehicles[i].stored and not user_vehicles[i].impound then
       if WarMenu.Button(user_vehicles[i].model, '~g~Stored') then
        SpawnVehicle(user_vehicles[i])
        if insured_vehicles[user_vehicles[i].plate].insurance_due == '0' and insured_vehicles[user_vehicles[i].plate].insurance > 0 then 
         exports.pNotify:SendNotification({text = "You Owe $"..insured_vehicles[user_vehicles[i].plate].insurance_due.." In Insurance Payments"})
        elseif insured_vehicles[user_vehicles[i].plate].insurance == 0 then
         --exports.pNotify:SendNotification({text = "Your Vehicle Has No Insurance, Driving A Vehicle Without Insurance Is Illegal"})
		 exports['clrp_notify']:DoLongHudText ('inform', 'Su vehículo no tiene seguro, conducir un vehículo sin seguro es ilegal')
         TriggerEvent('dispatch:noInsurance')
        end
        WarMenu.CloseMenu()
       end
      elseif user_vehicles[i].impound then
       if WarMenu.Button(user_vehicles[i].model, '~r~Impound') then
       end
      else
       if WarMenu.Button(user_vehicles[i].model, '~r~Out') then
        if insured_vehicles[user_vehicles[i].plate].insurance_due == '0' and insured_vehicles[user_vehicles[i].plate].insurance > 0 then 
         --exports.pNotify:SendNotification({text = "Your Vehicle Is Already Out, Select This Option Again To Recover Your Vehicle For $5000"})
		 exports['clrp_notify']:DoLongHudText ('inform', 'Su vehículo ya está fuera, seleccione esta opción nuevamente para recuperar su vehículo por $5000')
         if recoverVehicle and not user_vehicles[i].impound then 
          SpawnVehicle(user_vehicles[i])
          TriggerServerEvent('garage:recoverFee', 5000)
         end
         recoverVehicle = true
        end
       end
      end
     end
    end
   end
   WarMenu.Display()
  elseif WarMenu.IsMenuOpened('modify_garages') then
   for i = 1,#user_garages do
    if WarMenu.Button(tostring(garages[user_garages[i].id].name), tostring(garages[user_garages[i].id].type)) then 
     selectedgarage = {}
     selectedgarage = user_garages[i]
     selectedgarage.id = i
     WarMenu.OpenMenu('modify_garages2')
    end
   end
   WarMenu.Display()
  elseif WarMenu.IsMenuOpened('modify_garages2') then
   local slots = {}
   for a = (selectedgarage.count + 1), (garages[selectedgarage.id].maxslots) do
    table.insert(slots, ""..a)
   end
   if WarMenu.Button('Transfer Vehicle') then
    WarMenu.OpenMenu('modify_garages_veh')
   end
   if selectedgarage.id > 4 then
    if WarMenu.Button('Sell Garage', '~g~$'..selectedgarage.cost) then
     TriggerServerEvent("garage:sellgarage", selectedgarage.id)
    end
   end
   if selectedgarage.count ~= garages[selectedgarage.id].maxslots then
    if WarMenu.ComboBox('Increase Slots To ', slots, currentItemIndex, PurchasedSlots, function(currentIndex)
     currentItemIndex = currentIndex 
     PurchasedSlots = currentIndex
     currentgaragecost = math.floor(slotprice * PurchasedSlots)
     end) then
    elseif WarMenu.Button('Buy Slots', '~g~$'..currentgaragecost) then
     TriggerServerEvent("garage:buyslots", currentgaragecost, selectedgarage.id, (PurchasedSlots + selectedgarage.count))
    end
   end
   WarMenu.Display()
  elseif WarMenu.IsMenuOpened('modify_garages_veh') then
   for i = 1, #user_vehicles do
    if WarMenu.Button(user_vehicles[i].model, user_vehicles[i].plate) then  
     local count = 0
     for a = 1,#user_vehicles do
      if user_vehicles[a].cg == selectedgarage.id then
       count = count + 1
      end
     end
     local actualslots = selectedgarage.count
     if count <= actualslots then 
      if user_vehicles[i].stored then
       TriggerServerEvent("garage:transfer", user_vehicles[i].plate, selectedgarage.id)
      else
       --exports.pNotify:SendNotification({text = "Vehículo debe ser almacenado"})
	   exports['clrp_notify']:DoLongHudText ('inform', 'Vehículo debe ser almacenado')
      end
     else
      --exports.pNotify:SendNotification({text = "Garage Full"})
	  exports['clrp_notify']:DoLongHudText ('error', 'Garaje lleno')
     end
    end
   end
   WarMenu.Display()
  elseif WarMenu.IsMenuOpened('impound_yard') then
   for i = 1, #user_vehicles do
    if (user_vehicles[i] ~= nil) then
     if user_vehicles[i].impound then
      if WarMenu.Button(user_vehicles[i].model, '~g~$'..(user_vehicles[i].price/2)) then
       TriggerServerEvent("garage:impound", user_vehicles[i], user_vehicles[i].price/2)
      end
     end
    end
   end
   WarMenu.Display()
  elseif WarMenu.IsMenuOpened('purchase_insurance') then
   for i = 1, #user_vehicles do
    if (user_vehicles[i] ~= nil) then
     if not user_vehicles[i].insured then
      if WarMenu.Button(user_vehicles[i].model, '~g~$'..math.floor(user_vehicles[i].price*0.10).." WKLY") then
       TriggerServerEvent("garage:insure", user_vehicles[i].plate, user_vehicles[i].price*0.10)
      end
     else
      if WarMenu.Button(user_vehicles[i].model, '~g~Insured') then
      end
     end
    end
   end
   WarMenu.Display()
  else 
   Citizen.Wait(250)
  end
 end
end)

Citizen.CreateThread(function()
 while true do
  coords = GetEntityCoords(GetPlayerPed(-1), true)  
  Wait(5)
  for k,v in pairs(garages) do
   local pos = v.pos
   if(GetDistanceBetweenCoords(coords, pos.x, pos.y, pos.z, true) < 50) and not IsPedInAnyVehicle(GetPlayerPed(-1)) then
    DrawMarker(27, pos.x, pos.y, pos.z-0.95, 0, 0, 0, 0, 0, 0, 1.2,1.2,0.5, 0, 82, 165, 240, 0, 0, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(coords, pos.x, pos.y, pos.z, true) < 5.0) then
     drawTxt('~b~Press ~g~E~b~ To Access Garage')
     if IsControlPressed(0, 38) then
      WarMenu.OpenMenu('garage')
      currentgarage = garages[k]
     end
    end
   elseif(GetDistanceBetweenCoords(coords, pos.x, pos.y, pos.z, true) < 50) and IsPedInAnyVehicle(GetPlayerPed(-1)) then
    DrawMarker(27, pos.x, pos.y, pos.z-0.95, 0, 0, 0, 0, 0, 0, 3.0,3.0,0.5, 0, 128, 255, 240, 0, 0, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(coords, pos.x, pos.y, pos.z, true) < 5.0) then
     drawTxt('~b~Press ~g~ENTER~b~ To Store Your Vehicle')
     if IsControlJustPressed(0, 176) then
      currentgarage = garages[k]
      SetVehicleForwardSpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
      StoreVehicle()
     end
    end
   elseif(GetDistanceBetweenCoords(coords, -56.352, -1089.531, 26.422, true) < 25) then
    DrawMarker(27, -56.352, -1089.531, 25.425, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 100, 128, 255, 140, 0, 0, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(coords, -56.352, -1089.531, 26.422, true) < 1.75) then
     drawTxt('~b~Press ~g~E~b~ To Modify Garages')
     if IsControlJustPressed(0, 38) then
      WarMenu.OpenMenu('modify_garages')
     end
    end
   elseif(GetDistanceBetweenCoords(coords, 413.791, -1617.023, 28.341, true) < 25) then
    DrawMarker(27, 413.791, -1617.023, 28.341, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 100, 128, 255, 140, 0, 0, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(coords, 413.791, -1617.023, 28.341, true) < 1.35) then
     drawTxt('~b~Press ~g~E~b~ To Access Impound')
     if IsControlJustPressed(0, 38) then
      currentgarage = {x=395.98846435547, y=-1644.5775146484, z = 29.291948318481}
      currentgarage.id = k
      WarMenu.OpenMenu('impound_yard')
     end
    end
   elseif(GetDistanceBetweenCoords(coords, -32.958, -1111.619, 25.472, true) < 25) then
    DrawMarker(27, -32.958, -1111.619, 25.472, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 100, 128, 255, 140, 0, 0, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(coords, -32.958, -1111.619, 25.472, true) < 1.35) then
     drawTxt('~b~Press ~g~E~b~ To Buy Insurance')
     if IsControlJustPressed(0, 38) then
      WarMenu.OpenMenu('purchase_insurance')
     end
    end
   end
  end
 end
end)

function getCarQ()
    local count = 0
    for i=1,#user_vehicles do
        if user_vehicles[i].garage == currentgarage.id then
            count = count + 1
        end
    end
    return count
end

function getGarageQ()
    for i=1,#user_garages do
        if user_garages[i].id == currentgarage.id then
            return user_garages[i].count
        end
    end
end

RegisterNetEvent("garage:refresh")
AddEventHandler("garage:refresh", function(data, gdata, idata)
 user_vehicles = data
 user_garages = gdata
 insured_vehicles = idata
 TriggerEvent('phone:myVehicles', user_vehicles, garages, insured_vehicles)
end)

function StoreVehicle()
 local vehicle = nil
 if IsPedInAnyVehicle(GetPlayerPed(-1), false) then vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false) else vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71) end      
 local components = GetVehProps(vehicle)
 local fuel = DecorGetInt(vehicle, "_Fuel_Level")
 for i = 1, #user_vehicles do
  if tostring(components.plate) == tostring(user_vehicles[i].plate) then
   local count = 0
   for a = 1,#user_vehicles do
    if user_vehicles[a].garage == currentgarage.id then
     count = count + 1
    end
   end
   local actualslots
   for b = 1,#user_garages do
    if user_garages[b].id == currentgarage.id then
     actualslots = user_garages[b].count
    end
   end
   if count <= actualslots then
    TriggerServerEvent("garage:store", components, currentgarage.id, fuel)
    SetEntityAsMissionEntity(vehicle, true, true)
    Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle))
    SetEntityAsNoLongerNeeded(vehicle)
    SetModelAsNoLongerNeeded(GetEntityModel(vehicle))
    --exports.pNotify:SendNotification({text = "Vehicle Stored"})
	exports['clrp_notify']:DoLongHudText ('success', 'Vehículo almacenado')
   else
    --exports.pNotify:SendNotification({text = "Garage Full"})
	exports['clrp_notify']:DoLongHudText ('error', 'Garaje lleno')
   end
  end
 end
end

function SpawnVehicle(data)
 RequestModel(data.components.model)
 while not HasModelLoaded(data.components.model) do
  Citizen.Wait(0)
 end
 vehicle = CreateVehicle(data.components.model, currentgarage.pos.x, currentgarage.pos.y, currentgarage.pos.z, GetEntityHeading(PlayerPedId()), true, false)
 if data.components.maxFuelLevel ~= nil then 
  DecorSetInt(vehicle, "_Max_Fuel_Level", data.components.maxFuelLevel)
 else 
  DecorSetInt(vehicle, "_Max_Fuel_Level", 100000)
 end
 if tonumber(data.fuel) < 10000 then 
  DecorSetInt(vehicle, "_Fuel_Level", 25000)
 else 
  DecorSetInt(vehicle, "_Fuel_Level", tonumber(data.fuel))
 end 
 SetVehicleProperties(vehicle, data.components)
 TriggerServerEvent("garage:out", data)
 TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
 SetVehicleEngineOn(vehicle, true)
 SetVehicleHasBeenOwnedByPlayer(vehicle, true)
 SetEntityAsMissionEntity(vehicle, true, true)
end

RegisterNetEvent("garage:spawn")
AddEventHandler("garage:spawn", function(data)
 SpawnVehicle(data)
end)

RegisterNetEvent("garage:store")
AddEventHandler("garage:store", function(data)
 StoreVehicle()
end)


RegisterCommand('giftcaradmin', function(source, args, rawCommand)
 local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
 local plate = GetVehicleNumberPlateText(vehicle)
 TriggerServerEvent('garage:transfervehicle', args[1], plate)
end)

-- Vehicle Locking
AddEventHandler('garage:togglelocks', function()
 local ped = GetPlayerPed(-1)
 local coords = GetEntityCoords(ped)
 local vehicle = nil
 if IsPedInAnyVehicle(ped, false) then vehicle = GetVehiclePedIsIn(ped, false) else vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 16.0, 0, 71) end
 Citizen.CreateThread(function()
  if HasKey(GetVehicleNumberPlateText(vehicle)) or hasVehicleKey(GetVehicleNumberPlateText(vehicle)) or DecorGetBool(ped, "isOfficer") or DecorGetBool(ped, "isParamedic") then
   playLockAnimation()
   TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 8, "lock", 0.1)
   SetVehicleEngineOn(vehicle, true, true, true)
   SetVehicleLights(vehicle, 2) Wait(200) SetVehicleLights(vehicle, 1) Wait(200) SetVehicleLights(vehicle, 2) Wait(200) SetVehicleLights(vehicle, 1)
   SetVehicleEngineOn(vehicle, false, false, false)
   SetVehicleLights(vehicle, 0)
   if GetVehicleDoorLockStatus(vehicle) == 1 then 
    SetVehicleDoorsLocked(vehicle, 2)  
    exports.pNotify:SendNotification({text = "<font color='#fc5044'>Vehicle Locked"})
   elseif GetVehicleDoorLockStatus(vehicle) == 2 then
    SetVehicleDoorsLocked(vehicle, 1)
    exports.pNotify:SendNotification({text = "<font color='lightgreen'>Vehicle Unlocked"})
   end
  end
 end)
end)

function playLockAnimation()
 if not IsPedInAnyVehicle(GetPlayerPed(-1), false) then 
  RequestAnimDict('anim@mp_player_intmenu@key_fob@')
  while not HasAnimDictLoaded('anim@mp_player_intmenu@key_fob@') do
   Citizen.Wait(1)
  end
  TaskPlayAnim(PlayerPedId(), "anim@mp_player_intmenu@key_fob@", "fob_click", 24.0, 16.0, 1000, 50, 0, false, false, false)
 end
end

-- Locked Vehicles
Citizen.CreateThread(function()
 while true do
  local ped = GetPlayerPed(-1)
  Citizen.Wait(5)
  if IsPedInAnyVehicle(ped, false) then 
   if GetVehicleDoorLockStatus(GetVehiclePedIsIn(ped, false)) == 2 then
    DisableControlAction(0, 75)
   end
  else 
   Wait(1000)
  end
 end
end)

function HasKey(plate)
 for i=1,#user_vehicles do
  if plate == user_vehicles[i].plate then
   return true 
  end
 end
 return false 
end

-- Blips
function addGarageBlips()
 for k,v in ipairs(garages)do
  if v.showBlip then
   local blip = AddBlipForCoord(v.pos.x, v.pos.y, v.pos.z)
   SetBlipSprite(blip, 357)
   SetBlipDisplay(blip, 4)
   SetBlipScale(blip, 0.6) 
   if v.type == 'Public' then SetBlipColour(blip, 1) else SetBlipColour(blip, 3) end 
   SetBlipAsShortRange(blip, true)
   BeginTextCommandSetBlipName("STRING")
   AddTextComponentString(v.name)
   if v.type == 'Public' then AddTextComponentString('Public Garage') else AddTextComponentString('Private Garage') end 
   EndTextCommandSetBlipName(blip)
  end
 end
-- Impound Yard
 local blip = AddBlipForCoord(401.239, -1632.444, 29.291)
 SetBlipSprite(blip, 68)
 SetBlipDisplay(blip, 4)
 SetBlipScale(blip, 0.6)
 SetBlipColour(blip, 2)
 SetBlipAsShortRange(blip, true)
 BeginTextCommandSetBlipName("STRING")
 AddTextComponentString('Impound Yard')
 EndTextCommandSetBlipName(blip)
end

-- Giving Vehicle Keys
local vehicleKeys = {} 
local myCharacterID = 0

RegisterNetEvent("garage:updateKeys")
AddEventHandler("garage:updateKeys", function(data, char_id)
 vehicleKeys = data
 myCharacterID = char_id
end)

function hasVehicleKey(plate)
 if vehicleKeys[plate] ~= nil then 
  for id,v in pairs(vehicleKeys[plate]) do 
   if v.id == myCharacterID then 
    return true
   end
  end
  return false
 else 
  return false
 end
end

-- LS Air Tours Spawning

RegisterCommand('lsat', function(source, args, rawCommand)
 if DecorGetInt(GetPlayerPed(-1), 'Job') == 17 then
  local pos = GetEntityCoords(GetPlayerPed(-1))
  if tonumber(args[1]) == 1 then 
   RequestModel(GetHashKey("luxor"))
   while not HasModelLoaded(GetHashKey("luxor")) do
    Citizen.Wait(0)
   end
   vehicle = CreateVehicle(GetHashKey("luxor"), pos.x, pos.y, pos.z, GetEntityHeading(PlayerPedId()), true, false)
   local id = NetworkGetNetworkIdFromEntity(vehicle)
   SetNetworkIdCanMigrate(id, true)
   SetNetworkIdExistsOnAllMachines(id, true)
   SetVehicleDirtLevel(vehicle, 0)
   TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
   SetVehicleHasBeenOwnedByPlayer(vehicle, true)
   SetEntityAsMissionEntity(vehicle, true, true)
   SetVehicleEngineOn(vehicle, true)
   DecorSetInt(vehicle, "_Max_Fuel_Level", 150000)
   DecorSetInt(vehicle, "_Fuel_Level", 150000)
  elseif tonumber(args[1]) == 2 then
   RequestModel(GetHashKey("frogger"))
   while not HasModelLoaded(GetHashKey("frogger")) do
    Citizen.Wait(0)
   end
   vehicle = CreateVehicle(GetHashKey("frogger"), pos.x, pos.y, pos.z, GetEntityHeading(PlayerPedId()), true, false)
   local id = NetworkGetNetworkIdFromEntity(vehicle)
   SetNetworkIdCanMigrate(id, true)
   SetNetworkIdExistsOnAllMachines(id, true)
   SetVehicleDirtLevel(vehicle, 0)
   TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
   SetVehicleHasBeenOwnedByPlayer(vehicle, true)
   SetEntityAsMissionEntity(vehicle, true, true)
   SetVehicleEngineOn(vehicle, true)
   DecorSetInt(vehicle, "_Max_Fuel_Level", 150000)
   DecorSetInt(vehicle, "_Fuel_Level", 150000)
  elseif tonumber(args[1]) == 3 then
   RequestModel(GetHashKey("maverick"))
   while not HasModelLoaded(GetHashKey("maverick")) do
    Citizen.Wait(0)
   end
   vehicle = CreateVehicle(GetHashKey("maverick"), pos.x, pos.y, pos.z, GetEntityHeading(PlayerPedId()), true, false)
   local id = NetworkGetNetworkIdFromEntity(vehicle)
   SetNetworkIdCanMigrate(id, true)
   SetNetworkIdExistsOnAllMachines(id, true)
   SetVehicleDirtLevel(vehicle, 0)
   TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
   SetVehicleHasBeenOwnedByPlayer(vehicle, true)
   SetEntityAsMissionEntity(vehicle, true, true)
   SetVehicleEngineOn(vehicle, true)
   DecorSetInt(vehicle, "_Max_Fuel_Level", 150000)
   DecorSetInt(vehicle, "_Fuel_Level", 150000)
  elseif tonumber(args[1]) == 4 then
   RequestModel(GetHashKey("supervolito2"))
   while not HasModelLoaded(GetHashKey("supervolito2")) do
    Citizen.Wait(0)
   end
   vehicle = CreateVehicle(GetHashKey("supervolito2"), pos.x, pos.y, pos.z, GetEntityHeading(PlayerPedId()), true, false)
   local id = NetworkGetNetworkIdFromEntity(vehicle)
   SetNetworkIdCanMigrate(id, true)
   SetNetworkIdExistsOnAllMachines(id, true)
   SetVehicleDirtLevel(vehicle, 0)
   TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
   SetVehicleHasBeenOwnedByPlayer(vehicle, true)
   SetEntityAsMissionEntity(vehicle, true, true)
   SetVehicleEngineOn(vehicle, true)
   DecorSetInt(vehicle, "_Max_Fuel_Level", 150000)
   DecorSetInt(vehicle, "_Fuel_Level", 150000)
  elseif tonumber(args[1]) == 5 then
   RequestModel(GetHashKey("swift2"))
   while not HasModelLoaded(GetHashKey("swift2")) do
    Citizen.Wait(0)
   end
   vehicle = CreateVehicle(GetHashKey("swift2"), pos.x, pos.y, pos.z, GetEntityHeading(PlayerPedId()), true, false)
   local id = NetworkGetNetworkIdFromEntity(vehicle)
   SetNetworkIdCanMigrate(id, true)
   SetNetworkIdExistsOnAllMachines(id, true)
   SetVehicleDirtLevel(vehicle, 0)
   TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
   SetVehicleHasBeenOwnedByPlayer(vehicle, true)
   SetEntityAsMissionEntity(vehicle, true, true)
   SetVehicleEngineOn(vehicle, true)
   DecorSetInt(vehicle, "_Max_Fuel_Level", 150000)
   DecorSetInt(vehicle, "_Fuel_Level", 150000)
  elseif tonumber(args[1]) == 6 then
   RequestModel(GetHashKey("volatus"))
   while not HasModelLoaded(GetHashKey("volatus")) do
    Citizen.Wait(0)
   end
   vehicle = CreateVehicle(GetHashKey("volatus"), pos.x, pos.y, pos.z, GetEntityHeading(PlayerPedId()), true, false)
   local id = NetworkGetNetworkIdFromEntity(vehicle)
   SetNetworkIdCanMigrate(id, true)
   SetNetworkIdExistsOnAllMachines(id, true)
   SetVehicleDirtLevel(vehicle, 0)
   TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
   SetVehicleHasBeenOwnedByPlayer(vehicle, true)
   SetEntityAsMissionEntity(vehicle, true, true)
   SetVehicleEngineOn(vehicle, true)
   DecorSetInt(vehicle, "_Max_Fuel_Level", 150000)
   DecorSetInt(vehicle, "_Fuel_Level", 150000)
  elseif tonumber(args[1]) == 7 then
   RequestModel(GetHashKey("luxor2"))
   while not HasModelLoaded(GetHashKey("luxor2")) do
    Citizen.Wait(0)
   end
   vehicle = CreateVehicle(GetHashKey("luxor2"), pos.x, pos.y, pos.z, GetEntityHeading(PlayerPedId()), true, false)
   local id = NetworkGetNetworkIdFromEntity(vehicle)
   SetNetworkIdCanMigrate(id, true)
   SetNetworkIdExistsOnAllMachines(id, true)
   SetVehicleDirtLevel(vehicle, 0)
   TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
   SetVehicleHasBeenOwnedByPlayer(vehicle, true)
   SetEntityAsMissionEntity(vehicle, true, true)
   SetVehicleEngineOn(vehicle, true)
   DecorSetInt(vehicle, "_Max_Fuel_Level", 150000)
   DecorSetInt(vehicle, "_Fuel_Level", 150000)
  elseif tonumber(args[1]) == 8 then
   RequestModel(GetHashKey("velum"))
   while not HasModelLoaded(GetHashKey("velum")) do
    Citizen.Wait(0)
   end
   vehicle = CreateVehicle(GetHashKey("velum"), pos.x, pos.y, pos.z, GetEntityHeading(PlayerPedId()), true, false)
   local id = NetworkGetNetworkIdFromEntity(vehicle)
   SetNetworkIdCanMigrate(id, true)
   SetNetworkIdExistsOnAllMachines(id, true)
   SetVehicleDirtLevel(vehicle, 0)
   TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
   SetVehicleHasBeenOwnedByPlayer(vehicle, true)
   SetEntityAsMissionEntity(vehicle, true, true)
   SetVehicleEngineOn(vehicle, true)
   DecorSetInt(vehicle, "_Max_Fuel_Level", 150000)
   DecorSetInt(vehicle, "_Fuel_Level", 150000)
  elseif tonumber(args[1]) == 9 then
   RequestModel(GetHashKey("velum2"))
   while not HasModelLoaded(GetHashKey("velum2")) do
    Citizen.Wait(0)
   end
   vehicle = CreateVehicle(GetHashKey("velum2"), pos.x, pos.y, pos.z, GetEntityHeading(PlayerPedId()), true, false)
   local id = NetworkGetNetworkIdFromEntity(vehicle)
   SetNetworkIdCanMigrate(id, true)
   SetNetworkIdExistsOnAllMachines(id, true)
   SetVehicleDirtLevel(vehicle, 0)
   TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
   SetVehicleHasBeenOwnedByPlayer(vehicle, true)
   SetEntityAsMissionEntity(vehicle, true, true)
   SetVehicleEngineOn(vehicle, true)
   DecorSetInt(vehicle, "_Max_Fuel_Level", 150000)
   DecorSetInt(vehicle, "_Fuel_Level", 150000)
  elseif tonumber(args[1]) == 10 then
   RequestModel(GetHashKey("dodo"))
   while not HasModelLoaded(GetHashKey("dodo")) do
    Citizen.Wait(0)
   end
   vehicle = CreateVehicle(GetHashKey("dodo"), pos.x, pos.y, pos.z, GetEntityHeading(PlayerPedId()), true, false)
   local id = NetworkGetNetworkIdFromEntity(vehicle)
   SetNetworkIdCanMigrate(id, true)
   SetNetworkIdExistsOnAllMachines(id, true)
   SetVehicleDirtLevel(vehicle, 0)
   TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
   SetVehicleHasBeenOwnedByPlayer(vehicle, true)
   SetEntityAsMissionEntity(vehicle, true, true)
   SetVehicleEngineOn(vehicle, true)
   DecorSetInt(vehicle, "_Max_Fuel_Level", 150000)
   DecorSetInt(vehicle, "_Fuel_Level", 150000)
  elseif tonumber(args[1]) == 11 then
   RequestModel(GetHashKey("nimbus"))
   while not HasModelLoaded(GetHashKey("nimbus")) do
    Citizen.Wait(0)
   end
   vehicle = CreateVehicle(GetHashKey("nimbus"), pos.x, pos.y, pos.z, GetEntityHeading(PlayerPedId()), true, false)
   local id = NetworkGetNetworkIdFromEntity(vehicle)
   SetNetworkIdCanMigrate(id, true)
   SetNetworkIdExistsOnAllMachines(id, true)
   SetVehicleDirtLevel(vehicle, 0)
   TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
   SetVehicleHasBeenOwnedByPlayer(vehicle, true)
   SetEntityAsMissionEntity(vehicle, true, true)
   SetVehicleEngineOn(vehicle, true)
   DecorSetInt(vehicle, "_Max_Fuel_Level", 150000)
   DecorSetInt(vehicle, "_Fuel_Level", 150000)
  elseif tonumber(args[1]) == 12 then
   RequestModel(GetHashKey("mammatus"))
   while not HasModelLoaded(GetHashKey("mammatus")) do
    Citizen.Wait(0)
   end
   vehicle = CreateVehicle(GetHashKey("mammatus"), pos.x, pos.y, pos.z, GetEntityHeading(PlayerPedId()), true, false)
   local id = NetworkGetNetworkIdFromEntity(vehicle)
   SetNetworkIdCanMigrate(id, true)
   SetNetworkIdExistsOnAllMachines(id, true)
   SetVehicleDirtLevel(vehicle, 0)
   TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
   SetVehicleHasBeenOwnedByPlayer(vehicle, true)
   SetEntityAsMissionEntity(vehicle, true, true)
   SetVehicleEngineOn(vehicle, true)
   DecorSetInt(vehicle, "_Max_Fuel_Level", 150000)
   DecorSetInt(vehicle, "_Fuel_Level", 150000)
  elseif tonumber(args[1]) == 13 then
   RequestModel(GetHashKey("stretch"))
   while not HasModelLoaded(GetHashKey("stretch")) do
    Citizen.Wait(0)
   end
   vehicle = CreateVehicle(GetHashKey("stretch"), pos.x, pos.y, pos.z, GetEntityHeading(PlayerPedId()), true, false)
   local id = NetworkGetNetworkIdFromEntity(vehicle)
   SetNetworkIdCanMigrate(id, true)
   SetNetworkIdExistsOnAllMachines(id, true)
   SetVehicleDirtLevel(vehicle, 0)
   TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
   SetVehicleHasBeenOwnedByPlayer(vehicle, true)
   SetEntityAsMissionEntity(vehicle, true, true)
   SetVehicleEngineOn(vehicle, true)
   DecorSetInt(vehicle, "_Max_Fuel_Level", 150000)
   DecorSetInt(vehicle, "_Fuel_Level", 150000)
  end
 end
end)