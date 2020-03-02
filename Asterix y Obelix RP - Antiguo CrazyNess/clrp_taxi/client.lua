local dropLocations = {{x = 293.476, y = -590.163, z = 42.7371}, {x = 253.404, y = -375.86, z = 44.0819}, {x = 120.808, y = -300.416, z = 45.1399}, {x = -38.4132, y = -381.576, z = 38.3456}, {x = -107.442, y = -614.377, z = 35.6703}, {x = -252.292, y = -856.474, z = 30.5626}, {x = -236.138, y = -988.382, z = 28.7749}, {x = -276.989, y = -1061.18, z = 25.6853}, {x = -576.451, y = -998.989, z = 21.785}, {x = -602.798, y = -952.63, z = 21.6353}, {x = -790.653, y = -961.855, z = 14.8932}, {x = -912.588, y = -864.756, z = 15.0057}, {x = -1069.77, y = -792.513, z = 18.8075}, {x = -1306.94, y = -854.085, z = 15.0959}, {x = -1468.51, y = -681.363, z = 26.178}, {x = -1380.89, y = -452.7, z = 34.0843}, {x = -1326.35, y = -394.81, z = 36.0632}, {x = -1383.68, y = -269.985, z = 42.4878}, {x = -1679.61, y = -457.339, z = 39.4048}, {x = -1812.45, y = -416.917, z = 43.6734}, {x = -2043.64, y = -268.291, z = 22.9927}, {x = -2186.45, y = -421.595, z = 12.6776}, {x = -1862.08, y = -586.528, z = 11.1747}, {x = -1859.5, y = -617.563, z = 10.8788}, {x = -1634.95, y = -988.302, z = 12.6241}, {x = -1283.99, y = -1154.16, z = 5.30998}, {x = -1126.47, y = -1338.08, z = 4.63434}, {x = -867.907, y = -1159.67, z = 5.00795}, {x = -847.55, y = -1141.38, z = 6.27591}, {x = -722.625, y = -1144.6, z = 10.2176}, {x = -575.503, y = -318.446, z = 34.5273}, {x = -592.309, y = -224.853, z = 36.1209}, {x = -559.594, y = -162.873, z = 37.7547}, {x = -534.992, y = -65.6695, z = 40.634}, {x = -758.234, y = -36.6906, z = 37.2911}, {x = -1375.88, y = 20.9516, z = 53.2255}, {x = -1320.25, y = -128.018, z = 48.097}, {x = -1285.71, y = 294.287, z = 64.4619}, {x = -1245.67, y = 386.533, z = 75.0908}, {x = -760.355, y = 285.015, z = 85.0667}, {x = -626.786, y = 254.146, z = 81.0964}, {x = -563.609, y = 267.962, z = 82.5116}, {x = -486.806, y = 271.977, z = 82.8187}, {x = 88.295, y = 250.867, z = 108.188}, {x = 234.087, y = 344.678, z = 105.018}, {x = 434.963, y = 96.707, z = 99.1713}, {x = 482.617, y = -142.533, z = 58.1936}, {x = 762.651, y = -786.55, z = 25.8915}, {x = 809.06, y = -1290.8, z = 25.7946}, {x = 490.819, y = -1751.37, z = 28.0987}, {x = 432.351, y = -1856.11, z = 27.0352}, {x = 164.348, y = -1734.54, z = 28.8982}, {x = -57.6909, y = -1501.4, z = 31.1084}, {x = 52.2241, y = -1566.65, z = 29.006}, {x = 310.222, y = -1376.76, z = 31.4442}, {x = 181.967, y = -1332.79, z = 28.8773}, {x = -74.6091, y = -1100.64, z = 25.738}, {x = -887.045, y = -2187.46, z = 8.13248}, {x = -749.584, y = -2296.59, z = 12.4627}, {x = -1064.83, y = -2560.66, z = 19.6811}, {x = -1033.44, y = -2730.24, z = 19.6868}}
local findFares = false 
local currentCustomer = nil
local findNPC = true
local taxiClient = false
local taxiPay = 0
local taxiClientLocation = {}
local pedBlip = nil

Citizen.CreateThread( function()
 while true do 
  Citizen.Wait(5)    
  if findFares then
   if findNPC then 
    local nearNPC = getNPC()
    local pedCoords = GetEntityCoords(currentCustomer, true)
    PlaySoundFrontend(-1, "HACKING_SUCCESS", 0, 1);
    TriggerEvent('chatMessage', "Nuevo cliente encontrado!", {66, 134, 244})
    currentCustomer = nearNPC
    taxiClientLocation = dropLocations[math.random(1, #dropLocations)]
    
    pedBlip = AddBlipForEntity(currentCustomer)
    HideNumberOnBlip(pedBlip)
    SetBlipScale(pedBlip,  0.8)
    SetBlipAlpha(pedBlip, 255)
    SetBlipColour(pedBlip, 49)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Taxi Client')
    EndTextCommandSetBlipName(pedBlip)
    findNPC = false
   end

   if DoesEntityExist(currentCustomer) then 
    local playerCoords = GetEntityCoords(GetPlayerPed(-1), true)
    local playerTaxi = GetVehiclePedIsIn(GetPlayerPed(-1), false)
    local pedCoords = GetEntityCoords(currentCustomer, true)

    if GetDistanceBetweenCoords(playerCoords, pedCoords, false) > 15.0 then
     DrawMarker(2, pedCoords.x, pedCoords.y, pedCoords.z+1.50, 0, 0, 0, 0, 0, 0, 0.4,0.4,0.4, 255, 255, 0, 255, 1, 1, 2, 0, 0, 0, 0)
    elseif GetDistanceBetweenCoords(playerCoords, pedCoords, false) < 15.0 then 
     SetBlockingOfNonTemporaryEvents(currentCustomer, true)
     SetPedFleeAttributes(currentCustomer, 0, 0)
     TaskEnterVehicle(currentCustomer, playerTaxi, -1, 2, 1.00, 1)
     Wait(7500)
     if IsPedInVehicle(currentCustomer, playerTaxi, true) then 
      findFares = false
      taxiClient = true
      taxiClientLocation = dropLocations[math.random(1, #dropLocations)]
      taxiPay = CalculateTravelDistanceBetweenPoints(pedCoords, taxiClientLocation.x, taxiClientLocation.y, taxiClientLocation.z)/2
      if taxiPay > 5000 then 
       taxiPay = 5000
      end
      SetJobBlip(taxiClientLocation.x, taxiClientLocation.y, taxiClientLocation.z)
      RemoveBlip(pedBlip)
     end
    end
   end
  else
   Citizen.Wait(5000)
  end
 end
end)

Citizen.CreateThread( function()
 while true do 
  Citizen.Wait(5)    
  if taxiClient then
   local playerTaxi = GetVehiclePedIsIn(GetPlayerPed(-1), false)
   if IsPedInVehicle(currentCustomer, playerTaxi, false) then 
    local playerCoords = GetEntityCoords(GetPlayerPed(-1), true)
    if GetDistanceBetweenCoords(playerCoords, taxiClientLocation.x, taxiClientLocation.y, taxiClientLocation.z, false) < 10.0 then
     if IsVehicleStopped(playerTaxi) then 
      TaskLeaveVehicle(currentCustomer, playerTaxi, 0)
      SetEntityAsMissionEntity(currentCustomer, false, false)
      TaskWanderStandard(currentCustomer, 10.0, 10)
      deleteBlip()
      TriggerEvent('chatMessage', "Has sido pagado, $"..taxiPay, {78, 244, 66})
      TriggerServerEvent('taxi:pay', taxiPay)
      Wait(60000)
      DeleteEntity(currentCustomer)
      currentCustomer = nil
      taxiClientLocation = {}
      taxiPay = 0
      findNPC = true
      findFares = true
     end
    else 
     DrawMarker(2, taxiClientLocation.x, taxiClientLocation.y, taxiClientLocation.z+1.50, 0, 0, 0, 0, 0, 0, 1.1,1.1,1.1, 255, 255, 0, 255, 1, 1, 2, 0, 0, 0, 0) 
    end
   end
  else
   Citizen.Wait(5000)
  end
 end
end)

RegisterCommand('fares', function(source, args, rawCommand)
 findFares = not findFares
 if findFares then 
  TriggerEvent('chatMessage', "Ahora estás buscando clientes de taxi", {255, 255, 0})
  findNPC = true
 else 
  TriggerEvent('chatMessage', "Ya no estás buscando clientes de taxis", {255, 255, 0})
  currentCustomer = nil
  deleteBlip()
  findNPC = false
  findFares = false
  RemoveBlip(pedBlip)
 end
end)

RegisterCommand('denyfare', function(source, args, rawCommand)
 currentCustomer = nil
 findNPC = true
 deleteBlip()
 findFares = true
 RemoveBlip(pedBlip)
end)


-- Finding Random NPCS
function getNPC()
 local playerCoords = GetEntityCoords(GetPlayerPed(-1))
 local handle, ped = FindFirstPed()
 local success
 local rped = nil
 local distanceFrom
 repeat
  local pos = GetEntityCoords(ped)
  local distance = GetDistanceBetweenCoords(playerCoords, pos, true)
  if canPedBeUsed(ped) and distance < 75.0 and (distanceFrom == nil or distance < distanceFrom) then
   distanceFrom = distance
   rped = ped
   SetEntityAsMissionEntity(rped, true, true)
  end
  success, ped = FindNextPed(handle)
  until not success
  EndFindPed(handle)
 return rped
end

function canPedBeUsed(ped)
 if ped == nil then return false end
 if ped == GetPlayerPed(-1) then return false end
 if not DoesEntityExist(ped) then return false end
 if not IsPedOnFoot(ped) then return false end
 if IsEntityDead(ped) then return false end
 if not IsPedHuman(ped) then return false end
 if IsPedAPlayer(ped) then return false end
 return true
end


local missionblip = nil
function SetJobBlip(x,y,z)
 if DoesBlipExist(missionblip) then RemoveBlip(missionblip) end
 missionblip = AddBlipForCoord(x,y,z)
 SetBlipSprite(missionblip, 164)
 SetBlipColour(missionblip, 53)
 SetBlipRoute(missionblip, true)
 BeginTextCommandSetBlipName("STRING")
 AddTextComponentString("Destino")
 EndTextCommandSetBlipName(missionblip)
end

function deleteBlip()
 RemoveBlip(missionblip)
end















-- Settings
local enableTaxiGui = true -- Enables the GUI (Default: true)
local fareCost = 1.22  --(1.66 = $100 per minute) Cost per second
local costPerMile = 100.0 
local initialFare = 100.0 -- the cost to start a fare

DecorRegister("fares", 1)
DecorRegister("miles", 1)
DecorRegister("meteractive", 2)
DecorRegister("initialFare", 1)
DecorRegister("costPerMile", 1)
DecorRegister("fareCost", 1)

-- NUI Variables
local inTaxi = false
local meterOpen = false
local meterActive = false

-- Open Gui and Focus NUI
function openGui()
  SendNUIMessage({openMeter = true})
end

-- Close Gui and disable NUI
function closeGui()
  SendNUIMessage({openMeter = false})
  meterOpen = false
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1000)
    local ped = GetPlayerPed(-1)
    local veh = GetVehiclePedIsIn(ped, false)
    if IsPedInAnyTaxi(GetPlayerPed(-1)) and GetPedInVehicleSeat(veh, -1) ~= ped then
      local ped = GetPlayerPed(-1)
      local veh = GetVehiclePedIsIn(ped, false)
      TriggerEvent('taxi:updatefare', veh)
      openGui()
      meterOpen = true
    end
    if meterActive and GetPedInVehicleSeat(veh, -1) == ped then
      local _fare = DecorGetFloat(veh, "fares")
      local _miles = DecorGetFloat(veh, "miles")
      local _fareCost = DecorGetFloat(veh, "fareCost")

      if _fareCost ~= 0 then
        DecorSetFloat(veh, "fares", _fare + _fareCost)
      else
        DecorSetFloat(veh, "fares", _fare + fareCost)
      end
      DecorSetFloat(veh, "miles", _miles + round(GetEntitySpeed(veh) * 0.000621371, 5))
      TriggerEvent('taxi:updatefare', veh)
    end
    if IsPedInAnyTaxi(GetPlayerPed(-1)) and not GetPedInVehicleSeat(veh, -1) == ped then
      TriggerEvent('taxi:updatefare', veh)
    end
  end
end)

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(5)
  if(IsPedInAnyTaxi(GetPlayerPed(-1))) then
    if (inTaxi == false) then
      TriggerEvent('taxi:toggleDisplay')
    end
    inTaxi = true
    local ped = GetPlayerPed(-1)
    local veh = GetVehiclePedIsIn(ped, false)
    if(IsPedInAnyTaxi(GetPlayerPed(-1)) and GetPedInVehicleSeat(veh, -1) == ped) then
      if IsControlJustReleased(0, 311)  then -- K
        openGui()
        TriggerEvent('taxi:toggleHire')
        Citizen.Wait(100)
      end
      if IsControlJustReleased(0,7) then -- L
        openGui()
        TriggerEvent('taxi:resetMeter')
        TriggerEvent('chatMessage', '^3Meter Reset')
        Citizen.Wait(100)
      end
    end
  else
    if(meterOpen) then
      closeGui()
    end
    meterOpen = false
    Wait(5000)
  end
 end
end)

function round(num, numDecimalPlaces)
  local mult = 5^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

-- NUI Callback Methods
RegisterNUICallback('close', function(data, cb)
  closeGui()
  cb('ok')
end)

AddEventHandler('taxi:toggleDisplay', function()
  local ped = GetPlayerPed(-1)
  local veh = GetVehiclePedIsIn(ped, false)
  if(IsPedInAnyTaxi(GetPlayerPed(-1)) and GetPedInVehicleSeat(veh, -1) == ped) then
    if meterOpen then
      closeGui()
      meterOpen = false
    else
      local _fare = DecorGetFloat(veh, "fares")
      if _fare < initialFare then
        DecorSetFloat(veh, "fares", initialFare)
      end
      TriggerEvent('taxi:updatefare', veh)
      openGui()
      meterOpen = true
    end
  end
end)

AddEventHandler('taxi:toggleHire', function()
  local ped = GetPlayerPed(-1)
  local veh = GetVehiclePedIsIn(ped, false)
  if(IsPedInAnyTaxi(GetPlayerPed(-1)) and GetPedInVehicleSeat(veh, -1) == ped) then
    if meterActive then
      SendNUIMessage({meterActive = false})
      meterActive = false
      DecorSetBool(veh, "meteractive", false)
      TriggerEvent('chatMessage', '^2Meter Stopped')
    else
      SendNUIMessage({meterActive = true})
      meterActive = true
      DecorSetBool(veh, "meteractive", true)
      TriggerEvent('chatMessage', '^2Meter Running')
    end
  end
end)

AddEventHandler('taxi:resetMeter', function()
  local ped = GetPlayerPed(-1)
  local veh = GetVehiclePedIsIn(ped, false)
  if(IsPedInAnyTaxi(GetPlayerPed(-1)) and GetPedInVehicleSeat(veh, -1) == ped) then
    local _fare = DecorGetFloat(veh, "fares")
    local _miles = DecorGetFloat(veh, "miles")
    DecorSetFloat(veh, "initialFare", initialFare)
    DecorSetFloat(veh, "costPerMile", costPerMile)
    DecorSetFloat(veh, "fareCost", fareCost)
    DecorSetFloat(veh, "fares", DecorGetFloat(veh, "initialFare"))
    DecorSetFloat(veh, "miles", 0.0)
    TriggerEvent('taxi:updatefare', veh)
  end
end)


-- Send NUI message to update
RegisterNetEvent('taxi:updatefare')
AddEventHandler('taxi:updatefare', function(veh)
  local _fare = DecorGetFloat(veh, "fares")*exports['core']:getVat(3)
  local _miles = DecorGetFloat(veh, "miles")*exports['core']:getVat(3)
  local farecost = _fare + (_miles * DecorGetFloat(veh, "costPerMile"))*exports['core']:getVat(3)

  SendNUIMessage({
    updateBalance = true,
    balance = string.format("%.2f", farecost),
    player = string.format("%.2f", _miles),
    meterActive = DecorGetBool(veh, "meteractive")
  })
end)




