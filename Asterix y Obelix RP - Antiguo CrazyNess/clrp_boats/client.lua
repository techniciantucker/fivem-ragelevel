local fake = {}
local ownedboats = {}
local boat_stores = {
  {name="Boat Store", x=-753.36, y=-1511.15, z=4.11},
}

local boats = {
 [1] = {name = "Toro", price = 1450000, model = "toro"},
 [2] = {name = "Toro Deluxe", price = 1450000, model = "toro2"},
 [3] = {name = "Dinghy", price = 1375000, model = "dinghy"},
 [4] = {name = "Dinghy Deluxe", price = 1400000, model = "dinghy4"},
 [5] = {name = "Tropic", price = 1250000, model = "tropic"},
 [6] = {name = "Tropic Deluxe", price = 1275000, model = "tropic2"},
 [7] = {name = "Speeder", price = 1375000, model = "speeder"},
 [8] = {name = "Speeder Deluxe", price = 1400000, model = "speeder2"},
 [9] = {name = "Squalo", price = 1250000, model = "squalo"},
 [10] = {name = "Tug", price = 1475000, model = "tug"},
 [11] = {name = "Yaht", price = 1600000, model = "marquis"},
 [12] = {name = "Jetmax", price = 1275000, model = "jetmax"},
 [13] = {name = "Suntrap", price = 1200000, model = "suntrap"},
 [14] = {name = "Seashark", price = 525000, model = "seashark"},
 [15] = {name = "Seashark Deluxe", price = 675000, model = "seashark3"}
}

Citizen.CreateThread(function()
 while true do
  Wait(5)
  local coords = GetEntityCoords(GetPlayerPed(-1))
  for k,v in pairs(boat_stores) do
   if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 50 then
    DrawMarker(27, v.x, v.y, v.z, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 91, 144, 252, 150, 0, 0, 2, 0, 0, 0, 0)
    if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.2 then
     drawTxt('~b~Press ~g~E~b~ To Access Boat Store')
     if IsControlJustPressed(0, 38) then
      WarMenu.OpenMenu('boat')
     end
    end
   end
  end
 end
end)

Citizen.CreateThread(function()
 for k,v in ipairs(boat_stores)do
  local blip = AddBlipForCoord(v.x, v.y, v.z)
  SetBlipSprite(blip, 427)
  SetBlipDisplay(blip, 4)
  SetBlipScale(blip, 0.5)
  SetBlipColour(blip, 74)
  SetBlipAsShortRange(blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString(v.name)
  EndTextCommandSetBlipName(blip)
 end

 local blip = AddBlipForCoord(-840.28, -1380.60, 0.60)
 SetBlipSprite(blip, 427)
 SetBlipDisplay(blip, 4)
 SetBlipScale(blip, 0.5)
 SetBlipColour(blip, 74)
 SetBlipAsShortRange(blip, true)
 BeginTextCommandSetBlipName("STRING")
 AddTextComponentString('Boat Garage')
 EndTextCommandSetBlipName(blip)
end)

Citizen.CreateThread(function()
 WarMenu.CreateMenu('boat', 'Boat Store')
 WarMenu.CreateMenu('purchaseboat', 'Boat Store')
 while true do
  Citizen.Wait(5)
  if WarMenu.IsMenuOpened('boat') then
   DisableControlAction(0, 177, true)
   for ind, v in pairs(boats) do
    if WarMenu.Button(v.name, "~g~$"..v.price/2) then
      SpawnFakeBoat(v.model, v.price/2)
      WarMenu.OpenMenu('purchaseboat')
    end
   end
   if WarMenu.Button('Exit') then 
    DeleteVehicle(fake.boat)
    SetEntityCoords(GetPlayerPed(-1), -753.36, -1511.15, 4.11)
    WarMenu.CloseMenu('boat')
   end
   WarMenu.Display()
  elseif WarMenu.IsMenuOpened('purchaseboat') then
   DisableControlAction(0, 177, true)
   local price = math.floor(fake.price)
   if WarMenu.Button('Purchase', "~g~$"..price) then
    local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
    local model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
    local plate = GetVehicleNumberPlateText(vehicle)
    TriggerServerEvent('boatstore:purchase', model, plate, fake.price)
    DeleteVehicle(fake.boat)
    fake.boat = nil 
    fake.price = 0
    SetEntityCoords(GetPlayerPed(-1), -753.36, -1511.15, 4.11)
   elseif WarMenu.Button('Back') then 
    DeleteVehicle(fake.boat)
    fake.boat = nil 
    fake.price = 0
    SetEntityCoords(GetPlayerPed(-1), -753.36, -1511.15, 4.11)
    WarMenu.OpenMenu('boat')
   end
   WarMenu.Display()
  end
 end
end)

function SpawnFakeBoat(vehicle, price)
  local car = GetHashKey(vehicle)    
  if DoesEntityExist(fake.boat) then
   Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fake.boat))
  end

  RequestModel(car)
  while not HasModelLoaded(car) do
      Citizen.Wait(0)
  end

  local veh = CreateVehicle(car, -813.561, -1509.591, 0.00, 175.394, true, false)
  fake.boat = veh
  fake.price = price
  SetVehicleOnGroundProperly(veh)
  TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
  SetEntityAsMissionEntity(veh, true, true)
  FreezeEntityPosition(veh,true)
  SetEntityInvincible(veh,true)
  SetVehRadioStation(veh, "OFF")
  SetVehicleHasBeenOwnedByPlayer(veh, true)
end  

RegisterNetEvent('boatstore:bought')
AddEventHandler('boatstore:bought', function(model, plate)
  WarMenu.CloseMenu()
  local carid = GetHashKey(model)
  local playerPed = GetPlayerPed(-1)
  if playerPed and playerPed ~= -1 then
   RequestModel(carid)
   while not HasModelLoaded(carid) do
    Citizen.Wait(0)
   end

   veh = CreateVehicle(carid, -865.812, -1387.122, 0.399, 0.0, true, false)
   SetVehicleOnGroundProperly(veh)
   SetVehicleNumberPlateText(veh, plate)
   TaskWarpPedIntoVehicle(playerPed, veh, -1)
   SetVehicleEngineOn(veh, true, true)
   SetVehicleIsConsideredByPlayer(veh, true)
  end
end)


RegisterNetEvent('boatgarage:vehicles')
AddEventHandler('boatgarage:vehicles', function(vehicules)
 ownedboats = {}
 ownedboats = vehicules
end)

Citizen.CreateThread(function()
 WarMenu.CreateMenu('boatgarage', 'Garage')
 while true do
  Citizen.Wait(5)
  if WarMenu.IsMenuOpened('boatgarage') then
   for _,v in pairs(ownedboats) do
    if v.state == 1 then
     if WarMenu.Button(v.model, v.plate) then
      spawnBoat(v.model, v.plate)
      WarMenu.CloseMenu()
     end
    elseif v.state == 0 then
     if WarMenu.Button(v.model, "Out") then
      exports.pNotify:SendNotification({text = "<font color='#ed4444'>Boat Already Out"})
     end
    end
   end
   WarMenu.Display()
  end
 end
end)

function spawnBoat(model, plate)
  local carid = GetHashKey(model)
  local playerPed = GetPlayerPed(-1)
  if playerPed and playerPed ~= -1 then
   RequestModel(carid)
   while not HasModelLoaded(carid) do
    Citizen.Wait(0)
   end

   veh = CreateVehicle(carid, -840.28, -1380.60, 0.60, 0.0, true, false)
   TaskWarpPedIntoVehicle(playerPed, veh, -1)
   SetVehicleOnGroundProperly(veh)
   SetVehicleNumberPlateText(veh, plate)
   SetVehicleEngineOn(veh, true, true)
   SetVehicleIsConsideredByPlayer(veh, true)
   TriggerServerEvent('boat:out', plate)
  end
end

Citizen.CreateThread(function()
 while true do
  Wait(5)
  local coords = GetEntityCoords(GetPlayerPed(-1))
  if(GetDistanceBetweenCoords(coords, -2010.034, -1040.577, 1.461, true) < 25) and not IsPedInAnyVehicle(GetPlayerPed(-1)) then
   DrawMarker(21, -2010.034, -1040.577, 1.461, 0, 0, 0, 0, 0, 0, 1.2,1.2,0.5, 0, 82, 165, 240, 0, 0, 2, 0, 0, 0, 0)
   if(GetDistanceBetweenCoords(coords, -2010.034, -1040.577, 1.461, true) < 5.0) then
    drawTxt('~b~Press ~g~E~b~ To Access Garage')
    if IsControlPressed(0, 38) then
     WarMenu.OpenMenu('boatgarage')
    end
   end
  elseif(GetDistanceBetweenCoords(coords, -840.28, -1380.60, 0.60, true) < 25) and not IsPedInAnyVehicle(GetPlayerPed(-1)) then
   DrawMarker(21, -840.28, -1380.60, 1.20, 0, 0, 0, 0, 0, 0, 1.2,1.2,0.5, 0, 82, 165, 240, 0, 0, 2, 0, 0, 0, 0)
   if(GetDistanceBetweenCoords(coords, -840.28, -1380.60, 0.60, true) < 5.0) then
    drawTxt('~b~Press ~g~E~b~ To Access Garage')
    if IsControlPressed(0, 38) then
     WarMenu.OpenMenu('boatgarage')
    end
   end
  elseif(GetDistanceBetweenCoords(coords, -840.28, -1380.60, 0.60, true) < 25) and IsPedInAnyVehicle(GetPlayerPed(-1)) then
   DrawMarker(21, -840.28, -1380.60, 1.20, 0, 0, 0, 0, 0, 0, 1.2,1.2,0.5, 0, 128, 255, 240, 0, 0, 2, 0, 0, 0, 0)
   if(GetDistanceBetweenCoords(coords, -840.28, -1380.60, 0.60, true) < 5.0) then
    drawTxt('~b~Press ~g~ENTER~b~ To Store Your Boat')
    if IsControlJustPressed(0, 176) then
     SetVehicleForwardSpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
     ClearPedTasksImmediately(GetPlayerPed(-1))
     Wait(300)
     StockVehicleMenu()
    end
   end
  end
 end
end)

function StockVehicleMenu()
 if IsAnyVehicleNearPoint(-840.28, -1380.60, 0.60, 5.0) then
  local current = GetVehiclePedIsIn(GetPlayerPed(-1), true)
  TriggerServerEvent('boatgarage:storevehicle', GetVehicleNumberPlateText(current))
  DeleteVehicle(current)
  SetEntityCoords(GetPlayerPed(-1), -840.393, -1385.446, 1.605)
 else
  exports.pNotify:SendNotification({text = "<font color='#ed4444'>No Boat"})
 end
end

function drawTxt(text)
  SetTextFont(0)
  SetTextProportional(0)
  SetTextScale(0.32, 0.32)
  SetTextColour(0, 255, 255, 255)
  SetTextDropShadow(0, 0, 0, 0, 255)
  SetTextEdge(1, 0, 0, 0, 255)
  SetTextDropShadow()
  SetTextOutline()
  SetTextCentre(1)
  SetTextEntry("STRING")
  AddTextComponentString(text)
  DrawText(0.5, 0.93)
end