
------------------------------------------------------
---------------------- Rent a bike -------------------
------------------------------------------------------
local bikerental = {
 [1] = {x = -15.846, y = -1111.139, z = 25.682}, -- Car Dealer
 [2] = {x = -243.107, y = -948.406, z = 30.229}, -- Job Center
 [3] = {x = 220.311, y = -369.933, z = 43.259}, -- Court House
 [4] = {x = -512.300, y = 5256.594, z = 80.610}, -- Paleto Lumber Yard
 [5] = {x = -807.417, y = 5400.209, z = 33.728}, -- Paleto Hillclimb Race
 [6] = {x = -1379.713, y = -580.845, z = 30.129}, -- Bahamams
 [7] = {x = 764.773, y = -1222.154, z = 25.190}, -- BMX Park
 [8] = {x = -1106.857, y = -1690.943, z = 4.354}, --Beach Rental Hut
 [9] = {x = 3.818, y = -1831.969, z = 24.926}, --Beach Rental Hut
}

local bikes = {
 [1] = {name = 'BMX', model = 'bmx', price = 12}, 
 [2] = {name = 'Cruiser', model = 'cruiser', price = 18}, 
 [3] = {name = 'Scorcher', model = 'scorcher', price = 24}, 
 [4] = {name = 'Fixter', model = 'fixter', price = 26}
}

local boatrental = {
 [1] = {x = 3858.837, y = 4459.149, z = 1.834}, 
 [2] = {x = 1299.674, y = 4216.969, z = 33.908}, 
 [4] = {x = -1624.291, y = -1165.163, z = 2.269},
 [5] = {x = 2835.968, y = -666.832, z = 1.008}
}


local boats = {
 [1] = {name = 'Sea Shark', model = 'seashark', price = 1500}, 
 [2] = {name = 'Shitzu Jetmax', model = 'squalo', price = 3750},
 [3] = {name = 'Shitzu Suntrap', model = 'suntrap', price = 4500}, 
 [4] = {name = 'Shitzu Tropic', model = 'tropic', price = 5500},
 [5] = {name = 'Shitzu Squalo', model = 'squalo', price = 5750}
}

Citizen.CreateThread(function()
 WarMenu.CreateMenu('bike_rental', 'Rental')
 WarMenu.CreateMenu('boat_rental', 'Rental')
 while true do
  Citizen.Wait(5)

  -- Bike Rental
  for _,v in pairs(bikerental) do
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 50) and not IsPedOnAnyBike(GetPlayerPed(-1)) then
    DrawMarker(27, v.x, v.y, v.z, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 26,200,200, 200, 0, 0, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 1.2) then
     drawTxt('~b~Press ~g~E~b~ To Rent A Bike')
     if IsControlJustPressed(0, 38) then 
      WarMenu.OpenMenu('bike_rental')
     end
    end
   elseif(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 50) and IsPedOnAnyBike(GetPlayerPed(-1)) then
    DrawMarker(27, v.x, v.y, v.z, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 26,100,200, 200, 0, 0, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 1.2) then
     drawTxt('~b~Press ~g~E~b~ To Return Bike')
     if IsControlJustPressed(0, 38) then
      TriggerServerEvent('rental:return', source)
      ClearPedTasksImmediately(GetPlayerPed(-1))
      DeleteVehicle(GetVehiclePedIsIn(GetPlayerPed(-1), true))
     end
    end
   end
  end
  -- Menu
  if WarMenu.IsMenuOpened('bike_rental') then
   for _,v in pairs(bikes) do
    if WarMenu.Button(v.name, '~g~$'..v.price) then
     TriggerServerEvent('rental:bike', v.price, v.model)
    end
   end
   WarMenu.Display()
  elseif WarMenu.IsMenuOpened('boat_rental') then
   for _,v in pairs(boats) do
    if WarMenu.Button(v.name, '~g~$'..v.price) then
     TriggerServerEvent('rental:boat', v.price, v.model)
    end
   end
   WarMenu.Display()
  end
-- End Of Bike Rental 

-- Boat Rental
  for _,v in pairs(boatrental) do 
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 50) and not IsPedInAnyBoat(GetPlayerPed(-1)) then
    DrawMarker(27, v.x, v.y, v.z-0.95, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 26,200,200, 200, 0, 0, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 1.2) then
    drawTxt('~b~Press ~g~E~b~ To Rent A Boat')
     if IsControlJustPressed(0, 38) then 
      WarMenu.OpenMenu('boat_rental')
     end
    end
   end
  end
 end
end)

RegisterNetEvent('rental:spawnbike')
AddEventHandler('rental:spawnbike', function(bike)
  local coords    = GetEntityCoords(GetPlayerPed(-1))
  vehiclehash = GetHashKey(bike)
  RequestModel(vehiclehash)
    
  Citizen.CreateThread(function() 
  local waiting = 0
  while not HasModelLoaded(vehiclehash) do
    waiting = waiting + 100
    Citizen.Wait(100)
    if waiting > 5000 then
      break
    end
  end
    local vehicle = CreateVehicle(vehiclehash, coords.x, coords.y+1, coords.z, 90, 1, 0)
  TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
  SetVehicleNumberPlateText(vehicle, 'RENTAL')
  end)
end)

RegisterNetEvent('rental:spawnboat')
AddEventHandler('rental:spawnboat', function(bike)
  local coords    = GetEntityCoords(GetPlayerPed(-1))
  vehiclehash = GetHashKey(bike)
  RequestModel(vehiclehash)
    
  Citizen.CreateThread(function() 
  local waiting = 0
  while not HasModelLoaded(vehiclehash) do
    waiting = waiting + 100
    Citizen.Wait(100)
    if waiting > 5000 then
      break
    end
  end
    local vehicle = CreateVehicle(vehiclehash, coords.x, coords.y-10, coords.z, 90, 1, 0)
  TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
  SetVehicleNumberPlateText(vehicle, 'RENTAL')
  TriggerEvent("advancedFuel:setEssence", '100', 'RENTAL', bike)
  end)
end)


Citizen.CreateThread(function()
  for k,v in ipairs(bikerental)do
    local blip = AddBlipForCoord(v.x, v.y, v.z)
    SetBlipSprite (blip, 365)
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.6)
    SetBlipColour (blip, 4)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Bike Rental")
    EndTextCommandSetBlipName(blip)
  end
  for k,v in ipairs(boatrental)do
    local blip = AddBlipForCoord(v.x, v.y, v.z)
    SetBlipSprite (blip, 427)
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.6)
    SetBlipColour (blip, 4)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Boat Rental")
    EndTextCommandSetBlipName(blip)
  end
end)