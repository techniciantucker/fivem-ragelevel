local myHouse = {}
local allHouses = {}
local myCharacterID = {}
local houseBlips = {}
local showHouseBlips = false
local inHouse = false
local houseSold = false
local aprRate = 5


DecorRegister("inHouse", 2)
DecorSetBool(GetPlayerPed(-1), "inHouse", false)

RegisterNetEvent('homes:load')
AddEventHandler('homes:load', function(apartments, myID)
 allHouses = apartments
 myCharacterID = myID
end)


RegisterCommand('house', function(source, args, rawCommand)
 local pedCoords = GetEntityCoords(PlayerPedId(), true)
 if args[1] == 'buy' then
  for id, v in pairs(allHouses) do
   if GetDistanceBetweenCoords(pedCoords, v.frontDoor.x, v.frontDoor.y, v.frontDoor.z, true) < 2.5 then
    if not v.owned then
     TriggerServerEvent('homes:purchase', id, v)
    end
   end
  end

 elseif args[1] == 'finance' then
  for id, v in pairs(allHouses) do
   if GetDistanceBetweenCoords(pedCoords, v.frontDoor.x, v.frontDoor.y, v.frontDoor.z, true) < 2.5 then
    if not v.owned then
     TriggerServerEvent('finance:newFinance', 'House', v.price, id)
    end
   end
  end

 elseif args[1] == 'price' then
  for id, v in pairs(allHouses) do
   if GetDistanceBetweenCoords(pedCoords, v.frontDoor.x, v.frontDoor.y, v.frontDoor.z, true) < 2.5 then
    if not v.owned then
     TriggerEvent('chatMessage', 'House Price: $'..v.price, {200, 75, 75})
     local housePrice = math.floor(v.price*aprRate)
     --TriggerEvent('chatMessage', 'Finance: $'..math.floor(housePrice/5)..' Deposit, $'..math.floor(math.floor(housePrice-housePrice/5)/10)..' Weekly.', {200, 75, 75})
    else
     TriggerEvent('chatMessage', 'Home Owner: '..v.owner, {200, 75, 75})
    end
   end
  end

 elseif args[1] == 'sell' then
  for id, v in pairs(allHouses) do
   if GetDistanceBetweenCoords(pedCoords, v.frontDoor.x, v.frontDoor.y, v.frontDoor.z, true) < 2.5 and not houseSold then
    if v.char_id == myCharacterID then
     if not houseSold then
      houseSold = true
      TriggerServerEvent('homes:sell', id)
     end
    end
   end
  end

 elseif args[1] == 'exit' then
  local frontDoor = GetClosestObjectOfType(pedCoords.x, pedCoords.y, pedCoords.z, 2.0, GetHashKey(myHouse.doorProp), false, false, false)
  if DoesEntityExist(frontDoor) then
   TriggerEvent('dooranim')
   RemoveIpl(myHouse.ipl)
   SetEntityCoords(PlayerPedId(), myHouse.frontDoor.x, myHouse.frontDoor.y, myHouse.frontDoor.z-0.95)
   TriggerServerEvent('homes:updatePowerUsage', myHouse)
   inHouse = false
   DecorSetBool(GetPlayerPed(-1), "inHouse", inHouse)
   TriggerEvent('sync:insideInterior', false)
   exitHighHouse()
  end

 elseif args[1] == 'enter' then
  for id, v in pairs(allHouses) do
   if GetDistanceBetweenCoords(pedCoords, v.frontDoor.x, v.frontDoor.y, v.frontDoor.z, true) < 2.5 then
    if v.owned then
     if v.char_id == myCharacterID or v.doorLocked == false or DecorGetBool(PlayerPedId(), 'isOfficer') or hasHouseKey(myCharacterID, v.keys) then
      myHouse = v

      TriggerEvent('dooranim')
      Citizen.Wait(300)
      DoScreenFadeOut(100)
      Citizen.Wait(100)

      -- Teleporting
      RequestIpl(v.ipl)
      Teleport(v.exitDoor.x, v.exitDoor.y, v.exitDoor.z-0.95)
      SetEntityHeading(PlayerPedId(), 96.215)
      DecorSetBool(GetPlayerPed(-1), "inHouse", true)

      -- Setting Interior Props
      local houseID = GetInteriorAtCoords(v.exitDoor.x, v.exitDoor.y, v.exitDoor.z)
      if IsValidInterior(houseID) and v.interiorID == 1 then
       EnableInteriorProp(houseID, "swap_clean_apt")
       EnableInteriorProp(houseID, "swap_sofa_A")
       EnableInteriorProp(houseID, "swap_mrJam_A")
       EnableInteriorProp(houseID, "layer_debra_pic")
       RefreshInterior(houseID)
      end

      TriggerEvent('sync:insideInterior', true)

      local doorObject = GetClosestObjectOfType(v.exitDoor.x, v.exitDoor.y, v.exitDoor.z, 10.0, GetHashKey(v.doorProp), false, false, false)
      FreezeEntityPosition(doorObject, true)

      if v.interiorID == 4 then
       enterHighHouse(v.exitDoor)
      end

      Wait(500)
      DoScreenFadeIn(500)

      inHouse = true
     end
    end
   end
  end

 elseif args[1] == 'inv' then
  local storageDrawer = GetClosestObjectOfType(pedCoords.x, pedCoords.y, pedCoords.z, 3.0, myHouse.storageProp, false, false, false)
  if DoesEntityExist(storageDrawer) then
   if myHouse.id ~= nil then
   -- TriggerServerEvent('inventory:getStorageInventory', 'house-'..myHouse.id, myHouse.storage)
	   TriggerServerEvent('homes:inventory', myHouse.id)
   end
  end

 elseif args[1] == 'outfit' then
  local wardDrope = GetClosestObjectOfType(pedCoords.x, pedCoords.y, pedCoords.z, 3.5, myHouse.outfitProp, false, false, false)
  if DoesEntityExist(wardDrope) then
   TriggerEvent('outfit:open')
  end

 elseif args[1] == 'store' then
  if args[2] == 'dirty' then
   local amount = tonumber(args[3])
   TriggerServerEvent('house:storeCash', myHouse.id, 'dirty', amount)
  elseif args[2] == 'cash' then
   local amount = tonumber(args[3])
   TriggerServerEvent('house:storeCash', myHouse.id, 'cash', amount)
  end

 elseif args[1] == 'take' then
  if args[2] == 'dirty' then
   local amount = tonumber(args[3])
   TriggerServerEvent('house:takeCash', myHouse.id, 'dirty', amount)
  elseif args[2] == 'cash' then
   local amount = tonumber(args[3])
   TriggerServerEvent('house:takeCash', myHouse.id, 'cash', amount)
  end

 else
  TriggerEvent('chat:addMessage', {template = '<div style="text-align: center;">Housing</font></div> <hr/>'})
  TriggerEvent('chat:addMessage', {template = '<div style="text-align: center;">/house buy</div>'})
  TriggerEvent('chat:addMessage', {template = '<div style="text-align: center;">/house finance</div>'})
  TriggerEvent('chat:addMessage', {template = '<div style="text-align: center;">/house sell</div>'})
  TriggerEvent('chat:addMessage', {template = '<div style="text-align: center;">/house enter</div>'})
  TriggerEvent('chat:addMessage', {template = '<div style="text-align: center;">/house exit</div>'})
  TriggerEvent('chat:addMessage', {template = '<div style="text-align: center;">/house price</div>'})
  TriggerEvent('chat:addMessage', {template = '<div style="text-align: center;">/house inv</div>'})
  TriggerEvent('chat:addMessage', {template = '<div style="text-align: center;">/house outfit</div>'})
  TriggerEvent('chat:addMessage', {template = '<div style="text-align: center;">/house (store/take) (dirty/cash) (amount)</div>'})
  TriggerEvent('chat:addMessage', {template = '<div style="text-align: center;">/houseKey</div>'})
 end
end)


RegisterCommand('knock', function(source, args, rawCommand)
 TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 8.0, 'doorknock', 0.5)
end)

local radioOn = false

RegisterCommand('radio', function(source, args, rawCommand)
 local pos = GetEntityCoords(PlayerPedId(), true)
 local radioObject = GetClosestObjectOfType(pos.x, pos.y, pos.z, 3.5, myHouse.radioProp, false, false, false)
 print(radioObject)
 if DoesEntityExist(radioObject) then
  if radioOn == false then
   if tonumber(args[1]) then
    Citizen.InvokeNative(0x651D3228960D08AF, "SE_Script_Placed_Prop_Emitter_Boombox", radioObject)
    SetEmitterRadioStation("SE_Script_Placed_Prop_Emitter_Boombox", GetRadioStationName(tonumber(args[1])))
    SetStaticEmitterEnabled("SE_Script_Placed_Prop_Emitter_Boombox", true)
   else
    Citizen.InvokeNative(0x651D3228960D08AF, "SE_Script_Placed_Prop_Emitter_Boombox", radioObject)
    SetEmitterRadioStation("SE_Script_Placed_Prop_Emitter_Boombox", GetRadioStationName(math.random(1, 8)))
    SetStaticEmitterEnabled("SE_Script_Placed_Prop_Emitter_Boombox", true)
   end
   radioOn = true
  else
   SetStaticEmitterEnabled("SE_Script_Placed_Prop_Emitter_Boombox", false)
   radioOn = false
  end
 end
end)


RegisterCommand('houses', function(source, args, rawCommand)
 showHouseBlips = not showHouseBlips
 if showHouseBlips then
  for id, v in pairs(allHouses) do
   houseBlips[id] = AddBlipForCoord(v.frontDoor.x, v.frontDoor.y, v.frontDoor.z)
   SetBlipSprite(houseBlips[id], 375)
   SetBlipDisplay(houseBlips[id], 4)
   SetBlipScale(houseBlips[id], 0.5)
   SetBlipAsShortRange(houseBlips[id], true)
   if v.owned then SetBlipColour(houseBlips[id], 1) end
   BeginTextCommandSetBlipName("STRING")
   if v.owned then AddTextComponentString('Owned House') else AddTextComponentString('Buyable House') end
   EndTextCommandSetBlipName(houseBlips[id])
  end
 else
  for id, v in pairs(houseBlips) do
   RemoveBlip(v)
  end
 end
end)

------------------------------------
----- Managing Your Own House  -----
------------------------------------
Citizen.CreateThread(function()
 WarMenu.CreateLongMenu('manageHouse', 'My House')
 while true do
  Citizen.Wait(5)
  if inHouse then
   local pos = GetEntityCoords(PlayerPedId(), true)

   local baseObject = GetClosestObjectOfType(pos.x, pos.y, pos.z, 25.0, myHouse.computerProp, false, false, false)

   if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), myHouse.exitDoor.x, myHouse.exitDoor.y, myHouse.exitDoor.z, true) < 1.5 then
    showMessage('~w~Press ~g~E~w~ To Exit House')
    if IsControlJustPressed(0, 38) then
     RemoveIpl(myHouse.ipl)
     SetEntityCoords(PlayerPedId(), myHouse.frontDoor.x, myHouse.frontDoor.y, myHouse.frontDoor.z-0.95)
     inHouse = false
     DecorSetBool(GetPlayerPed(-1), "inHouse", inHouse)
     TriggerEvent('sync:insideInterior', false)
     exitHighHouse()
    end
   end


   if DoesEntityExist(baseObject) then
    local coords = GetEntityCoords(baseObject, true)
    if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), coords.x, coords.y, coords.z+0.50, true) < 2.0 then
     showMessage('~w~Press ~g~E~w~ To Manage My House')
     if IsControlJustPressed(0, 38) then
      WarMenu.OpenMenu('manageHouse')
     end
    end

    if WarMenu.IsMenuOpened('manageHouse') then
     if WarMenu.Button('Storage Upgrade', '~g~$15K') then
      TriggerServerEvent('homes:upgradeStorage', myHouse.id)
     elseif WarMenu.Button('Garage Upgrade', '~g~$20K') then
      TriggerServerEvent('homes:upgradeGarage', myHouse.id)
     elseif WarMenu.Button('Toggle Door Locks') then
      TriggerServerEvent('homes:updateLocks', myHouse.id)
     elseif WarMenu.Button('Pay Power Bill', '~g~$'..myHouse.powerUsage) then
      myHouse.powerUsage = 0
      TriggerServerEvent('homes:payPowerBill', myHouse)
     end
     WarMenu.Display()
    end
   end
  else
   Citizen.Wait(2000)
   DecorSetBool(GetPlayerPed(-1), "inHouse", inHouse)
  end
 end
end)


function showMessage(msg)
 BeginTextCommandDisplayHelp("STRING")
 AddTextComponentScaleform(msg)
 EndTextCommandDisplayHelp(0, false, false, -1)
end


------------------------------------
-- Real Estate Commands To Houses --
------------------------------------
RegisterCommand('setGarage', function(source, args, rawCommand)
 if myHouse.id ~= nil then
  local pos = GetEntityCoords(PlayerPedId(), true)
  TriggerServerEvent('homes:setGarage', tonumber(myHouse.id), {x = pos.x, y = pos.y, z = pos.z})
 end
end)

RegisterCommand('store', function(source, args, rawCommand)
 if myHouse.id ~= nil then
  local pedCoords = GetEntityCoords(PlayerPedId(), true)
  for id, v in pairs(allHouses) do
   if v.char_id == myCharacterID or hasHouseKey(myCharacterID, v.keys) then
    if GetDistanceBetweenCoords(pedCoords, v.myGarage.x, v.myGarage.y, v.myGarage.z, false) < 5 and IsPedInAnyVehicle(PlayerPedId(), false) then
     StoreVehicle(v.myVehicles, v.id, v.garageSlots)
    end
   end
  end
 end
end)

function StoreVehicle(myVehicles, houseID, garageSlots)
 local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), true)
 local components = GetVehProps(vehicle)
 local fuel = DecorGetInt(vehicle, "_Fuel_Level")
 local name = GetDisplayNameFromVehicleModel(components.model)
 if #myVehicles <= garageSlots then
  TriggerServerEvent("homes:storeVehicle", components, houseID, fuel, name)
  SetEntityAsMissionEntity(vehicle, false, false)
  Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle))
  TriggerEvent("pNotify:SendNotification", {text = "Vehicle Stored"})
 else
  TriggerEvent("pNotify:SendNotification", {text = "Garage Full"})
 end
end

RegisterCommand('drive', function(source, args, rawCommand)
 local pedCoords = GetEntityCoords(PlayerPedId(), true)
 for i, v in pairs(allHouses) do
  if v.myGarage ~= nil then
   if v.char_id == myCharacterID or hasHouseKey(myCharacterID, v.keys) then
    if GetDistanceBetweenCoords(pedCoords, v.myGarage.x, v.myGarage.y, v.myGarage.z, false) < 5 then
     for id,data in pairs(v.myVehicles) do
      if tonumber(args[1]) == id then
       SpawnVehicle(data)
       TriggerServerEvent("homes:removeVehicle", v.id, data.components.plate)
      end
     end
    end
   end
  end
 end
end)

RegisterCommand('vehicles', function(source, args, rawCommand)
 local pedCoords = GetEntityCoords(PlayerPedId(), true)
 for id, v in pairs(allHouses) do
  if v.char_id == myCharacterID or hasHouseKey(myCharacterID, v.keys) then
   if GetDistanceBetweenCoords(pedCoords, v.myGarage.x, v.myGarage.y, v.myGarage.z, false) < 5 then
    TriggerServerEvent('homes:myVehicles', v.id)
   end
  end
 end
end)



function SpawnVehicle(data)
 local pos = GetEntityCoords(PlayerPedId(), true)
 RequestModel(data.components.model)
 while not HasModelLoaded(data.components.model) do
  Citizen.Wait(0)
 end
 vehicle = CreateVehicle(data.components.model, pos.x, pos.y, pos.z, GetEntityHeading(PlayerPedId()), true, false)
 SetVehicleProperties(vehicle, data.components)
 TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
 SetVehicleEngineOn(vehicle, true)
 SetVehicleHasBeenOwnedByPlayer(vehicle, true)
 SetEntityAsMissionEntity(vehicle, true, true)
end


function hasHouseKey(char_id, keys)
 if keys ~= nil then
  for id,v in pairs(keys) do
   if v.char_id == char_id then
    return true
   end
  end
  return false
 end
end


RegisterCommand('houseKey', function(source, args, rawCommand)
 local pedCoords = GetEntityCoords(PlayerPedId(), true)
 for id, v in pairs(allHouses) do
  if v.char_id == myCharacterID then
   if args[1] == 'give' then
    TriggerServerEvent('houseKey:give', v.id, tonumber(args[2]))
   elseif args[1] == 'take' then
    TriggerServerEvent('houseKey:take', v.id, tonumber(args[2]))
   elseif args[1] == 'reset' then
    TriggerServerEvent('houseKey:reset', v.id)
   elseif args[1] == 'list' then
    TriggerEvent('chat:addMessage', {template = '<div style="text-align: center;">House Keys</font></div> <hr/>'})
    for Kid,x in pairs(v.keys) do
     TriggerEvent('chat:addMessage', source, {template = '<div><font style="font-weight: 550;">['..Kid..'] </font>'..x.name..'</div>'})
    end
   else
    TriggerEvent('chat:addMessage', {template = '<div style="text-align: center;">House Keys</font></div> <hr/>'})
    TriggerEvent('chat:addMessage', {template = '<div style="text-align: center;">/houseKey give ID</div>'})
    TriggerEvent('chat:addMessage', {template = '<div style="text-align: center;">/houseKey take ID</div>'})
    TriggerEvent('chat:addMessage', {template = '<div style="text-align: center;">/houseKey list</div>'})
    TriggerEvent('chat:addMessage', {template = '<div style="text-align: center;">/houseKey reset</div>'})
   end
  end
 end
end)


Citizen.CreateThread(function()
 while true do
  Citizen.Wait(25)
  if NetworkIsGameInProgress() and IsPlayerPlaying(PlayerId()) then
   local ped = GetPlayerPed(-1)

   for _, player in ipairs(GetActivePlayers()) do
    local otherPed = GetPlayerPed(player)
    if otherPed ~= ped then
     if DecorGetBool(otherPlayerPed, "inHouse") and not inHouse then
      SetEntityLocallyInvisible(otherPlayerPed)
     end
    end
   end
  end
 end
end)

RegisterNetEvent('finance:loadFinance')
AddEventHandler('finance:loadFinance', function(finance, aprRate)
 myFinance = finance
 aprRate = aprRate
end)
