local allApartments = {}
local myCharacterID = 0
local myApartment = {}

RegisterNetEvent('apartments:load')
AddEventHandler('apartments:load', function(apartments, myID, firstSpawn)
 allApartments = apartments
 myCharacterID = myID
 if firstSpawn then
  for id,v in pairs(allApartments) do
   if v.owned then
    if v.char_id == myCharacterID then 
     if v.spawnPoint == 1 then
      RequestIpl(v.ipl)
      DoScreenFadeOut(1)
      Teleport(v.exit.x, v.exit.y, v.exit.z)
      SetEntityHeading(GetPlayerPed(-1), 277.988)
      Wait(1000)
      DoScreenFadeIn(250)
      myApartment = v 
      myApartment.id = id
     end
    end
   end
  end 
 end
end)

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(5)
  if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1), true), -776.875, 318.948, 85.663, true) < 50 then
   DrawMarker(21, -776.875, 318.948, 85.690, 0, 0, 0, 0, 0, 0, 0.8,0.8,0.5, 255, 25, 25, 100, 1, 1, 2, 0, 0, 0, 0)
   if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1), true), -776.875, 318.948, 85.663, true) < 1.4 then
    drawTxt('~b~Press ~g~E~b~ To Access Apartments')
    if IsControlJustPressed(0, 38) then
     WarMenu.OpenMenu('allApartments')
    end
   end
  else 
   Citizen.Wait(2500)
  end
 end
end)

-- Entering // Buying Apartments
Citizen.CreateThread(function()
 WarMenu.CreateLongMenu('allApartments', 'Apartments')
 while true do
  Citizen.Wait(5)
  if WarMenu.IsMenuOpened('allApartments') then
   for id,v in pairs(allApartments) do
    if v.owned then
     if v.doorLocked then 
      if WarMenu.Button('Apartment '..id, '~r~Bloqueado') then
       if v.char_id == myCharacterID then 
        myApartment = v
        myApartment.id = id
        RequestIpl(v.ipl)
        DoScreenFadeOut(1)
        Teleport(v.exit.x, v.exit.y, v.exit.z)
        SetEntityHeading(GetPlayerPed(-1), 277.988)
        Wait(1000)
        DoScreenFadeIn(250)
        WarMenu.CloseMenu()
       end
      end
     else 
      if WarMenu.Button('Apartment '..id, '~g~Desbloqueado') then
       RequestIpl(v.ipl)
       myApartment = v
       myApartment.id = id
       DoScreenFadeOut(1)
       Teleport(v.exit.x, v.exit.y, v.exit.z)
       Wait(1000)
       DoScreenFadeIn(500)
       WarMenu.CloseMenu()
      end
     end
    else 
     if WarMenu.Button('Type: '..v.design, '~g~$2,000,000') then
      TriggerServerEvent('apartments:buy', id)
     end   
    end
   end
   WarMenu.Display()
  end
 end
end)

-- Exiting Apartments
Citizen.CreateThread(function()
 while true do
  Citizen.Wait(5)
  if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1), true), -827.534, 306.028, 110.395, false) < 1.5 then
   drawTxt('~b~Pulse ~g~E~b~ Dejar el apartamento \n ~b~Pulse ~g~F~b~ Para entrar en el garaje')
   if IsControlJustPressed(0, 38) then
    DoScreenFadeOut(1)
    RemoveIpl(GetInteriorFromEntity(GetPlayerPed(-1)))
    Teleport(-776.875, 318.948, 85.663)
    Wait(1000)
    DoScreenFadeIn(500)
   elseif IsControlJustPressed(0, 49) then 
    DoScreenFadeOut(1)
    RemoveIpl(GetInteriorFromEntity(GetPlayerPed(-1)))
    Teleport(-776.674, 334.589, 25.495)
    Wait(1000)
    DoScreenFadeIn(500)
    setupGarage()
   end
  else 
   Citizen.Wait(2500)
  end
 end
end)

-- Exiting Garage
Citizen.CreateThread(function()
 while true do
  Citizen.Wait(5)
  if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1), true), -776.674, 334.589, 25.495, true) < 20 then
   DrawMarker(21, -776.674, 334.589, 26.495, 0, 0, 0, 0, 0, 0, 0.8,0.8,0.5, 255, 25, 25, 100, 1, 1, 2, 0, 0, 0, 0)
   if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1), true), -776.674, 334.589, 25.495, true) < 1.4 then
    drawTxt('~b~Pulse ~g~E~b~ Para acceder a los apartamentos')
    if IsControlJustPressed(0, 38) then
     killGarage()  
     WarMenu.OpenMenu('allApartments')
    end
   end
  else 
   Citizen.Wait(2500)
  end
 end
end)


-- Managing Apartments
Citizen.CreateThread(function()
 WarMenu.CreateLongMenu('manageApartment', 'Apartments')
 while true do
  Citizen.Wait(5)
  if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1), true), -839.294, 312.995, 111.595, false) < 1.3 then
   drawTxt('~b~Pulse ~g~E~b~ Para gestionar apartamento')
   if IsControlJustPressed(0, 38) then
    if myApartment.char_id == myCharacterID then 
     WarMenu.OpenMenu('manageApartment')
    end
   end
  else 
   Citizen.Wait(2500)
  end
  if WarMenu.IsMenuOpened('manageApartment') then
   if WarMenu.Button('Toggle Locks') then
    allApartments[myApartment.id].doorLocked = not allApartments[myApartment.id].doorLocked 
    if not allApartments[myApartment.id].doorLocked then TriggerEvent('chatMessage', '^2Doors Unlocked') else TriggerEvent('chatMessage', '^1Doors Locked') end
    TriggerServerEvent('apartments:updateLocks', myApartment.id, allApartments[myApartment.id].doorLocked)
   elseif WarMenu.Button('Upgrade Storage', '~g~$200,000') then
    TriggerServerEvent('apartments:upgradeStorage', myApartment.id)
   end
   WarMenu.Display()
  end
 end
end)

-- Apartment Storage 
RegisterCommand('storeitem', function(source, args, rawCommand)
 if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1), true), -835.455, 316.694, 111.595, false) < 4.0 then
  if args[1] and args[2] then 
   TriggerServerEvent('apartments:storeItems', myApartment.id, args[1], args[2])
  end
 end
end)

RegisterCommand('takeitem', function(source, args, rawCommand)
 if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1), true), -835.455, 316.694, 111.595, false) < 4.0 then
  if args[1] and args[2] then 
   TriggerServerEvent('apartments:takeItems', myApartment.id, args[1], args[2])
  end
 end
end)

RegisterCommand('inv', function(source, args, rawCommand)
 if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1), true), -835.455, 316.694, 111.595, false) < 4.0 then
  TriggerServerEvent('apartments:listItems', myApartment.id)
 end
end)

RegisterCommand('storeweapon', function(source, args, rawCommand)
 if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1), true), -835.455, 316.694, 111.595, false) < 4.0 then
  if args[1] then 
   TriggerServerEvent('apartments:storeWeapon', myApartment.id, args[1])
  end
 end
end)

RegisterCommand('takeweapon', function(source, args, rawCommand)
 if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1), true), -835.455, 316.694, 111.595, false) < 4.0 then
  if args[1] then 
   TriggerServerEvent('apartments:takeWeapon', myApartment.id, args[1])
  end
 end
end)

RegisterCommand('setSpawnPoint', function(source, args, rawCommand)
 if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1), true), -835.455, 316.694, 111.595, false) < 25.0 then 
  TriggerServerEvent('apartments:setSpawn', myApartment.id)
 end
end)







--------------------------------------------------------------
------------------- APARTMENT GARAGES ------------------------
--------------------------------------------------------------
local myVehicles = {}
local vehicleLocations = {
 [1] = {x = -797.164, y = 317.779, z = 26.050, h = 313.843},
 [2] = {x = -794.302, y = 327.035, z = 26.052, h = 229.691}, 
 [3] = {x = -791.443, y = 317.359, z = 26.050, h = 309.884},
 [4] = {x = -788.929, y = 326.875, z = 26.050, h = 219.597},
 [5] = {x = -781.949, y = 327.228, z = 26.050, h = 233.810},
 [6] = {x = -782.234, y = 316.999, z = 26.050, h = 306.238}, 
}

function setupGarage()
 myVehicles = {}
 local myGarage = json.decode(myApartment.garage)
 if #myGarage > 0 and myGarage ~= nil then
  for i=1, #myGarage do 
   RequestModel(myGarage[i].model)
   while not HasModelLoaded(myGarage[i].model) do
    Citizen.Wait(0)
   end
   local pos = vehicleLocations[i]
   myVehicles[i] = CreateVehicle(myGarage[i].model, pos.x, pos.y, pos.z, pos.h, false, false)
   SetVehicleProperties(myVehicles[i], myGarage[i].components)
   SetVehicleOnGroundProperly(myVehicles[i])
  end
 end
end

function killGarage()
 for i=1, #myVehicles do 
  SetEntityAsMissionEntity(myVehicles[i], true, true)
  Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(myVehicles[i]))
  DeleteVehicle(myVehicles[i])
 end
end

function StoreVehicle()
 local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
 local components = GetVehProps(vehicle)
 local fuel = DecorGetInt(vehicle, "_Fuel_Level")
 local myGarage = json.decode(myApartment.garage)
 if #myGarage <= 6 then
  TriggerServerEvent("apartments:storeVehicle", components, myApartment.id, fuel)
  SetEntityAsMissionEntity(vehicle, false, false)
  Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle))
  --exports.pNotify:SendNotification({text = "Vehicle Stored"})
  exports['clrp_notify']:DoLongHudText('success', 'Vehículo almacenado')
  DoScreenFadeOut(1)
  Teleport(-776.674, 334.589, 25.495)
  Wait(1000)
  setupGarage()
  DoScreenFadeIn(500)
 else 
  --exports.pNotify:SendNotification({text = "Garaje lleno"})
  exports['clrp_notify']:DoLongHudText('error', 'Garaje lleno')
 end
end

RegisterCommand('store', function(source, args, rawCommand)
 if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1), true), -791.725, 333.007, 85.286, true) < 10.0 then
  if myApartment.id ~= nil then 
   StoreVehicle()
  else 
   for id,v in pairs(allApartments) do
    if v.owned then
     if v.char_id == myCharacterID then 
      myApartment = v 
      myApartment.id = id
      StoreVehicle()
     end
    end 
   end
  end
 end
end)

RegisterCommand('drive', function(source, args, rawCommand)
 if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1), true), -797.164, 317.779, 26.050, true) < 40.0 and IsPedInAnyVehicle(PlayerPedId(), false) then
  DoScreenFadeOut(10)
  local fakeVeh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
  local components = GetVehProps(fakeVeh)
  DeleteVehicle(fakeVeh)
  killGarage()
  vehicle = CreateVehicle(components.model, -800.632, 332.205, 85.701, 179.703, true, false)
  DecorSetInt(vehicle, "_Max_Fuel_Level", 100000)
  DecorSetInt(vehicle, "_Fuel_Level", 100000)
  SetVehicleProperties(vehicle, components)
  TriggerServerEvent("apartments:removeVehicle", myApartment.id, components.plate)
  TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
  SetVehicleEngineOn(vehicle, true)
  SetVehicleHasBeenOwnedByPlayer(vehicle, true)
  SetEntityAsMissionEntity(vehicle, true, true)
  Wait(1000)
  DoScreenFadeIn(10)
 end
end)

