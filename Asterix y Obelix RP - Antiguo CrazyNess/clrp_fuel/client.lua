local stopRefueling = false
local fuelPricePerGallon = 3.50
local ownedGasStations = {}
local currentStation = {}
local myCharacterID = 0
local gasStations = {
 [1] = {x = 265.021, y = -1261.426, z = 27.561},
 [2] = {x = 49.413, y = 2778.794, z = 58.044},
 [3] = {x = 264.020, y = 2607.060, z = 45.077},
 [4] = {x = 1039.273, y = 2669.578, z = 39.519},
 [5] = {x = 1207.258, y = 2660.072, z = 38.370},
 [6] = {x = 2539.683, y = 2594.090, z = 37.945},
 [7] = {x = 2676.345, y = 3265.660, z = 55.241},
 [8] = {x = 2003.081, y = 3779.308, z = 32.181},
 [9] = {x = 1690.675, y = 4927.306, z = 42.232},
 [10] = {x = 1703.706, y = 6421.047, z = 32.637},
 [11] = {x = 180.106, y = 6602.975, z = 31.869},
 [12] = {x = -89.964, y = 6415.001, z = 31.542},
 [13] = {x = -2554.844, y = 2334.303, z = 33.078},
 [14] = {x = -1800.208, y = 803.479, z = 138.651},
 [15] = {x = -1436.596, y = -276.069, z = 46.208},
 [16] = {x = -2096.601, y = -319.175, z = 13.169},
 [17] = {x = -723.442, y = -932.854, z = 19.214},
 [18] = {x = -525.397, y = -1211.845, z = 18.185},
 [19] = {x = -68.785, y = -1760.784, z = 29.428},
 [20] = {x = 818.003, y = -1028.854, z = 26.327},
 [21] = {x = 1208.343, y = -1402.372, z = 35.224},
 [22] = {x = 1181.144, y = -329.479, z = 69.280},
 [23] = {x = 620.661, y = 268.569, z = 103.089},
 [24] = {x = 2580.882, y = 361.810, z = 108.469},
 [25] = {x = -734.934, y = -1456.686, z = 5.001}, -- Shanks Street
 [26] = {x = -990.657, y = -1395.874, z = -0.113}, -- Boat Station
 [27] = {x = -1077.431, y = -3386.516, z = 13.945}, -- LSIA
 [28] = {x = 1785.047, y = 3330.366, z = 41.376}, --Sandy Airfield
}

local fuelBlacklist = {
 [1] = 'BMX',
 [2] = 'SCORCHER',
 [3] = 'FIXTER',
 [4] = 'CRUISER', 
}

RegisterCommand('refuel', function(source, args, rawCommand)
 local ped = PlayerPedId()
 if IsPedInAnyVehicle(ped, false) then 	
  local vehicle = GetVehiclePedIsIn(ped, false)
  if HasPedGotWeapon(ped, GetHashKey('WEAPON_PETROLCAN')) then 
   local vehicleFuel = DecorGetInt(vehicle, "_Fuel_Level")
   if vehicleFuel < 20000 then 
    local newFuel = (vehicleFuel + 50000)
    DecorSetInt(vehicle, "_Fuel_Level", newFuel)  
   end
  end
 end
end) 

 DecorRegister("_Fuel_Level", 3);
 DecorRegister("_Max_Fuel_Level", 3);

-- \o/ Gas Cans!!!!!!
-- Refueling Vehicles At Gas Stations
Citizen.CreateThread(function()
 while true do
  local ped = PlayerPedId() 
  Citizen.Wait(5)
  if not IsPedInAnyVehicle(ped, false) then
   if HasPedGotWeapon(ped, GetHashKey('WEAPON_PETROLCAN')) then 
    if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PETROLCAN") then
     local pos = GetEntityCoords(ped)
     local vehicle = GetClosestVehicle(pos.x, pos.y, pos.z, 3.0, 0, 71)
     if DoesEntityExist(vehicle) then 
      drawTxt("~b~Hold ~g~E~b~ Repostar vehículo!")
      if IsControlJustPressed(0, 38) then 
       local vehicleFuel = DecorGetInt(vehicle, "_Fuel_Level")
       if vehicleFuel < 20000 then 
        loadAnimDict("weapon@w_sp_jerrycan")
        TaskPlayAnim(GetPlayerPed(-1), "weapon@w_sp_jerrycan", "fire", 1.0, 2, -1, 49, 0, 0, 0, 0)
        Wait(15000)
        ClearPedTasksImmediately(ped)
        RemoveWeaponFromPed(ped, GetHashKey("WEAPON_PETROLCAN"))
        TriggerServerEvent('fuel:removePetrolCan')
        local newFuel = (vehicleFuel + 50000)
        DecorSetInt(vehicle, "_Fuel_Level", newFuel)  
       else 
        TriggerEvent("pNotify:SendNotification", {text = "El vehículo debe tener menos del 20% de combustible"}) 
       end 
      end
     end
    end 
   end
  else 
   Citizen.Wait(2500)
  end
 end
end) 


-- Burning Fuel
function initFuelRandom(vehicle)
  local randomFuel = math.random(25000,55000)
  DecorSetInt(vehicle, "_Fuel_Level", randomFuel)
  DecorSetInt(vehicle, "_Max_Fuel_Level", 100000)
end

function fuelCheckEmpty(vehicle)
 local currentFuel = DecorGetInt(vehicle, "_Fuel_Level")
 if currentFuel < 1 then
  SetVehicleEngineOn(vehicle, false, true, false)
  SetVehicleUndriveable(vehicle, true)
 end
end

function burnFuel(vehicle)
 if GetIsVehicleEngineRunning(vehicle) == 1 then
  if canVehicleUseFuel(vehicle) then 
   local currentFuel = DecorGetInt(vehicle, "_Fuel_Level")
   local speed = GetEntitySpeed(vehicle)
   --local speedMph = math.ceil(speed * 2.236936)
   local speedMph = math.ceil(speed * 3.6)   
   if speedMph < 4 then
    burnRate = 4
   else
    burnRate = speedMph
   end
   local afterFuelBurn = (currentFuel - burnRate)
   DecorSetInt(vehicle, "_Fuel_Level", afterFuelBurn)
  end
 end
end

function canVehicleUseFuel(vehicle)
 local isUsing = true
 for i=1, #fuelBlacklist do 
  if GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)) == fuelBlacklist[i] then 
   isUsing = false
  end
 end
 return isUsing
end

Citizen.CreateThread(function()
 while true do
  local ped = PlayerPedId()
  local vehicle = GetVehiclePedIsIn(ped, false)
  if IsPedInAnyVehicle(ped, false) and GetPedInVehicleSeat(vehicle, -1) == ped then
   if not DecorExistOn(vehicle, "_Fuel_Level") then
    initFuelRandom(vehicle)
   else
    burnFuel(vehicle)
   end
   fuelCheckEmpty(vehicle)
  end
  Wait(1000)
 end
end)

function loadAnimDict(dict)
  while(not HasAnimDictLoaded(dict)) do
    RequestAnimDict(dict)
    Citizen.Wait(1)
  end
end

-- Owning Fuel Stations
RegisterNetEvent('fuel:updateStations')
AddEventHandler('fuel:updateStations', function(owned, id)
 ownedGasStations = owned
 myCharacterID = id
end)

Citizen.CreateThread(function()
 WarMenu.CreateLongMenu('gasStation', 'Gas Station')
 WarMenu.CreateLongMenu('buyFuel', 'Gas Station')
 WarMenu.CreateLongMenu('manageEmployees', 'Gas Station')
 while true do
  Citizen.Wait(5)
  -- Menu
  if WarMenu.IsMenuOpened('gasStation') then
   if WarMenu.Button('Fuel Level', currentStation.fuel) then 
    WarMenu.OpenMenu('buyFuel')
   elseif WarMenu.Button('Fuel Price', '~g~$'..currentStation.fuel_price) then
    local newfuel = getResult()
    TriggerServerEvent('fuel:updatefuel', newfuel, currentStation.id) 
    WarMenu.CloseMenu()
   elseif WarMenu.Button('Station Bank', '~g~$'..currentStation.bank) then
    TriggerServerEvent('fuel:takeBank', currentStation.bank, currentStation.id) 
    WarMenu.CloseMenu()
   elseif WarMenu.Button('Manage Employees') then 
    WarMenu.OpenMenu('manageEmployees')
   elseif WarMenu.Button('~o~Sell Station', '~g~$'..currentStation.price-250000) then
    TriggerServerEvent('fuel:sell', currentStation.id, currentStation.price/2)
    WarMenu.CloseMenu()
   end
   WarMenu.Display()
  elseif WarMenu.IsMenuOpened('buyFuel') then
   if WarMenu.Button('1K Fuel', '~g~$950') then 
    TriggerServerEvent('fuel:buyFuel', currentStation.id, 1000, 950)
    WarMenu.CloseMenu()
   elseif WarMenu.Button('2.5K Fuel', '~g~$1750') then 
    TriggerServerEvent('fuel:buyFuel', currentStation.id, 2500, 1750)
    WarMenu.CloseMenu()
   elseif WarMenu.Button('5K Fuel', '~g~$2750') then 
    TriggerServerEvent('fuel:buyFuel', currentStation.id, 5000, 2750)
    WarMenu.CloseMenu()
   elseif WarMenu.Button('10K Fuel', '~g~$4750') then 
    TriggerServerEvent('fuel:buyFuel', currentStation.id, 10000, 4750)
    WarMenu.CloseMenu()
   elseif WarMenu.Button('50K Fuel', '~g~$25000') then 
    TriggerServerEvent('fuel:buyFuel', currentStation.id, 50000, 25000)
    WarMenu.CloseMenu()
   elseif WarMenu.Button('250K Fuel', '~g~$100000') then 
    TriggerServerEvent('fuel:buyFuel', currentStation.id, 250000, 100000)
    WarMenu.CloseMenu()
   end
   WarMenu.Display()
  elseif WarMenu.IsMenuOpened('manageEmployees') then
   if WarMenu.Button('Add New Employee') then 
    local char_id = getResult()
    TriggerServerEvent('fuel:givekey', currentStation.id, char_id) 
    WarMenu.CloseMenu()
   end
   if currentStation.employees ~= 'No Keys' then
    local keys = json.decode(currentStation.employees)
    for _,k in pairs(keys) do
     if WarMenu.Button(k.name, 'Fire') then
      TriggerServerEvent("fuel:takekey", currentStation.id, k.id)
     end
    end
   end
   WarMenu.Display()
  end
 end
end)


function getResult()
 DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 6)
  while (UpdateOnscreenKeyboard() == 0) do
    DisableAllControlActions(0);
    Wait(0);
  end
  if (GetOnscreenKeyboardResult()) then
    local result = GetOnscreenKeyboardResult()
    return tonumber(result)
  end
end

function getMaxFuel(veh)
 if DecorExistOn(veh, "_Max_Fuel_Level") then 
  if DecorGetInt(veh, "_Max_Fuel_Level") < 100000 then
   return 100000
  else 
   return DecorGetInt(veh, "_Max_Fuel_Level")
  end
 else
  return 100000
 end
end

function isEmployee(id)
 if ownedGasStations[id].employees ~= 'No Keys' then 
  local keys = json.decode(ownedGasStations[id].employees)
  for _,v in pairs(keys) do 
   if v.id == myCharacterID then 
    return true
   end
  end
 end
end

--[[ Fuel Tank Upgrades
local vehicleMultiplyer = {
  [0] = 1.2, --Compact
  [1] = 1.3, --Sedan
  [2] = 1.4, --SUV
  [3] = 1.4, --Coupes
  [4] = 1.45, --Muscle
  [5] = 1.5, --Sports Classics
  [6] = 1.5, --Sports
  [7] = 1.6, --Super
  [8] = 1.25, --Motorcycles
  [9] = 1.2, --Off-road
  [10] = 1.2, --Industrial
  [11] = 1.2, --Utility
  [12] = 1.3, --Vans
  [17] = 1.4, --Service
  [18] = 1.4, --Emergency
  [20] = 1.2, --Commercial
}

Citizen.CreateThread(function()
 WarMenu.CreateLongMenu('fuelTank', 'Fuel Tank')
 local blip = AddBlipForCoord(175.293, -1561.661, 28.469)
 SetBlipSprite(blip, 361)
 SetBlipScale(blip, 0.4)
 SetBlipAsShortRange(blip, true)
 BeginTextCommandSetBlipName("STRING")
 AddTextComponentString('Upgrade Fuel Tank')
 EndTextCommandSetBlipName(blip)
 while true do
  local ped = PlayerPedId() 
  Citizen.Wait(5)
  if IsPedInAnyVehicle(ped, false) and GetPedInVehicleSeat(GetVehiclePedIsIn(ped, false), -1) == ped then 
   local vehicle = GetVehiclePedIsIn(ped, false)
   local vehCoords = GetEntityCoords(vehicle)
   if GetDistanceBetweenCoords(vehCoords, 175.293, -1561.661, 28.469, true) < 5 then
    drawTxt('~b~Press ~g~E~b~ To Upgrade Your Fuel Tank')
    if IsControlJustPressed(0, 38) then 
     WarMenu.OpenMenu('fuelTank')
    end
   end
  end
  if WarMenu.IsMenuOpened('fuelTank') then
   local vehicle = GetVehiclePedIsIn(ped, false)
   if WarMenu.Button('Level 1- 125%', '~g~$'..math.floor(15000 * vehicleMultiplyer[GetVehicleClass(vehicle)])) then
    TriggerServerEvent('fuel:upgradeTank', 125000, math.floor(15000 * vehicleMultiplyer[GetVehicleClass(vehicle)]))
   elseif WarMenu.Button('Level 2 - 150%', '~g~$'..math.floor(25000 * vehicleMultiplyer[GetVehicleClass(vehicle)])) then
    TriggerServerEvent('fuel:upgradeTank', 150000, math.floor(25000 * vehicleMultiplyer[GetVehicleClass(vehicle)]))
   elseif WarMenu.Button('Level 3 - 175%', '~g~$'..math.floor(30000 * vehicleMultiplyer[GetVehicleClass(vehicle)])) then
    TriggerServerEvent('fuel:upgradeTank', 175000, math.floor(30000 * vehicleMultiplyer[GetVehicleClass(vehicle)]))
   elseif WarMenu.Button('Level 4 - 200%', '~g~$'..math.floor(35000 * vehicleMultiplyer[GetVehicleClass(vehicle)])) then
    TriggerServerEvent('fuel:upgradeTank', 200000, math.floor(35000 * vehicleMultiplyer[GetVehicleClass(vehicle)]))
   end
   WarMenu.Display()
  end
 end
end)

RegisterNetEvent('fuel:upgradeTank')
AddEventHandler('fuel:upgradeTank', function(cap)
 local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
 DecorSetInt(vehicle, "_Max_Fuel_Level", cap)
end)
]]

local isNearStation = false
local currentID = 0
local hold = false
local isPlayingAnimation = false 
local vehicleFuel = 0 

Citizen.CreateThread(function()
 for _, item in pairs(gasStations) do
  item.blip = AddBlipForCoord(item.x, item.y, item.z)
  SetBlipSprite(item.blip, 361)
  SetBlipScale(item.blip, 0.4)
  SetBlipAsShortRange(item.blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('Gas Station')
  EndTextCommandSetBlipName(item.blip)
 end
 while true do
  Citizen.Wait(2000)
  for id,v in pairs(gasStations) do  
   if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), v.x, v.y, v.z, true) < 12 and IsPedOnFoot(PlayerPedId()) and GetInteriorFromEntity(PlayerPedId()) == 0 and DoesEntityExist(GetVehiclePedIsIn(PlayerPedId(), true)) then 
    isNearStation = true
    currentID = id
   elseif not IsPedOnFoot(PlayerPedId()) or IsPedRunning(PlayerPedId()) then 
    isNearStation = false
   end
  end
 end
end)


Citizen.CreateThread(function()
 while true do
  Citizen.Wait(5)
  if isNearStation and not ownedGasStations[currentID] then  
   local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
   local vehCoords = GetEntityCoords(vehicle, true)
   DrawMarker(2, vehCoords.x, vehCoords.y, vehCoords.z+2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.8, 0.8, 0.8, 255, 50, 50, 100, true, true, 0, true, nil, nil, false)
   if not hold then drawTxt("~b~Hold ~g~E~b~ To Refuel! [~g~$"..fuelPricePerGallon.."~b~]") else drawTxt("~g~Refueling") end    
   if IsControlJustPressed(0, 38) and not stopRefueling then vehicleFuel = DecorGetInt(vehicle, "_Fuel_Level") hold = false end
   if IsControlPressed(0, 38) and not stopRefueling then 
    hold = true
    if DecorGetInt(vehicle, "_Fuel_Level") < getMaxFuel(vehicle) then 
     stopRefueling = false
     refuelingVehicle = true
    end
   elseif IsControlJustReleased(0, 38) and not stopRefueling then 
    if DoesEntityExist(vehicle) then 
     refuelingVehicle = false hold = false stopRefueling = false Wait(100)
     TriggerServerEvent('fuel:pay', vehicleFuel, DecorGetInt(vehicle, "_Fuel_Level"), fuelPricePerGallon)
     isPlayingAnimation = false 
     ClearPedTasksImmediately(PlayerPedId())
    end
   elseif IsControlJustReleased(0, 38) and stopRefueling then 
    if DoesEntityExist(vehicle) then 
     refuelingVehicle = false hold = false stopRefueling = false Wait(100)
     TriggerServerEvent('fuel:pay', vehicleFuel, DecorGetInt(vehicle, "_Fuel_Level"), fuelPricePerGallon)
     isPlayingAnimation = false
     ClearPedTasksImmediately(PlayerPedId())
    end
   else 
    hold = false
   end
   drawTxt('\n~b~Press ~g~H~b~ To Purchase Gas Station ~b~[~g~$500000~b~]')
   if IsControlJustPressed(0, 74) then 
    TriggerServerEvent('fuel:purchase', currentID)
   end
  else 
   Citizen.Wait(2500)
  end
 end
end) 

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(5)
  if isNearStation and ownedGasStations[currentID] then  
   local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
   local vehCoords = GetEntityCoords(vehicle, true)
   DrawMarker(2, vehCoords.x, vehCoords.y, vehCoords.z+2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.8, 0.8, 0.8, 255, 50, 50, 100, true, true, 0, true, nil, nil, false)
   if ownedGasStations[currentID].fuel > 5 then 
    if not hold then drawTxt("~b~Hold ~g~E~b~ To Refuel! [~g~$"..ownedGasStations[currentID].fuel_price.."~b~]") else drawTxt("~g~Refueling") end    
    if IsControlJustPressed(0, 38) and not stopRefueling then vehicleFuel = DecorGetInt(vehicle, "_Fuel_Level") hold = false end
    if IsControlPressed(0, 38) and not stopRefueling then 
     hold = true
     if DecorGetInt(vehicle, "_Fuel_Level") < getMaxFuel(vehicle) then 
      stopRefueling = false
      refuelingVehicle = true
     end
    elseif IsControlJustReleased(0, 38) and not stopRefueling then 
     if DoesEntityExist(vehicle) then 
      refuelingVehicle = false hold = false stopRefueling = false Wait(100)
      TriggerServerEvent('fuel:payOwners', vehicleFuel, DecorGetInt(vehicle, "_Fuel_Level"), ownedGasStations[currentID])
      isPlayingAnimation = false 
      Wait(100)
      TriggerServerEvent('fuel:updateStations') 
      ClearPedTasksImmediately(PlayerPedId())   
     end
    elseif IsControlJustReleased(0, 38) and stopRefueling then 
     if DoesEntityExist(vehicle) then 
      refuelingVehicle = false hold = false stopRefueling = false Wait(100)
      isPlayingAnimation = false 
      TriggerServerEvent('fuel:payOwners', vehicleFuel, DecorGetInt(vehicle, "_Fuel_Level"), ownedGasStations[currentID])
      Wait(100)
      TriggerServerEvent('fuel:updateStations')
      ClearPedTasksImmediately(PlayerPedId())
     end
    else 
     hold = false
    end
   else 
    drawTxt("~r~Gas Station Is Out Of Fuel") 
   end
  -- Owner Stuffz
   if ownedGasStations[currentID].char_id == myCharacterID or isEmployee(currentID) then 
    drawTxt("\n~b~Press ~g~H~b~ To Manage Your Gas Station") 
    if IsControlJustPressed(0, 74) then 
     currentStation = ownedGasStations[currentID]
     WarMenu.OpenMenu('gasStation')
    end
   else 
    drawTxt("\n~b~Station Owned By ~g~"..ownedGasStations[currentID].owner) 
   end
  else 
   Citizen.Wait(2500)
  end
 end
end) 

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(0)
  if refuelingVehicle then
   local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
   DecorSetInt(vehicle, "_Fuel_Level", tonumber(DecorGetInt(vehicle, "_Fuel_Level") + 25))
 
   if not isPlayingAnimation then 
    loadAnimDict("weapon@w_sp_jerrycan") 
    TaskPlayAnim(PlayerPedId(), "weapon@w_sp_jerrycan", "fire", 1.0, 2, -1, 49, 0, 0, 0, 0)
    isPlayingAnimation = true 
   end

   -- Drawing 
   local currentfuel = DecorGetInt(vehicle, "_Fuel_Level") * 0.001
   drawUI(0.514, 1.436, 1.0, 1.0, 0.42, "~b~FUEL ~w~"..round(currentfuel, 1).."%", 89, 194, 255, 255, false)
   DisableControlAction(0, 23, true) -- INPUT_VEH_EXIT
   DisableControlAction(0, 20, true) -- Disable Z Menu

   if DecorGetInt(vehicle, "_Fuel_Level") == getMaxFuel(vehicle) then
    refuelingVehicle = false
    DecorSetInt(vehicle, "_Fuel_Level", getMaxFuel(vehicle))
    stopRefueling = true 
    TriggerEvent('chatMessage', 'Fuel Tank Is Full!', {100,200,100})
    ClearPedTasksImmediately(PlayerPedId())
   elseif DecorGetInt(vehicle, "_Fuel_Level") > getMaxFuel(vehicle) then
    TriggerEvent('chatMessage', 'Fuel Tank Is Full!', {100,200,100})
    ClearPedTasksImmediately(PlayerPedId())
    refuelingVehicle = false
    DecorSetInt(vehicle, "_Fuel_Level", getMaxFuel(vehicle))
    stopRefueling = true 
   end
  end
 end
end)

function drawUI(x,y ,width,height,scale, text, r,g,b,a, center)
 SetTextFont(4)
 SetTextProportional(0)
 SetTextScale(scale, scale)
 SetTextColour(r, g, b, a)
 SetTextDropShadow(0, 0, 0, 0,255)
 SetTextEdge(2, 0, 0, 0, 255)
 SetTextDropShadow()
 SetTextOutline()
 SetTextEntry("STRING")
 AddTextComponentString(text)
 DrawText(x - width/2, y - height/2 + 0.005)
end

function round(num, dec)
  local mult = 10^(dec or 0)
  return math.floor(num * mult + 0.5) / mult
end
