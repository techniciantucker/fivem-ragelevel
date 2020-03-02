local scrapyards = {
  {x = -540.131, y = -1637.794, z = 19.893, id = 1}, -- ScrapYard
}

local currentStock = {}
local currentStore = nil

RegisterNetEvent('scrapyard:getstock')
AddEventHandler('scrapyard:getstock', function(results)
 currentStock = results
end)

local scrapmetalDelivery = 0
local steelbarsDelivery = 0

local nearPoint = false

Citizen.CreateThread(function()
 WarMenu.CreateLongMenu('scrap', "Menu")
 WarMenu.CreateLongMenu('yard', "Yard")
 WarMenu.CreateLongMenu('stocking', "Stock Listing")
 WarMenu.CreateLongMenu('stocklisting', "Stock Listing")
 while true do  
  local coords = GetEntityCoords(GetPlayerPed(-1))
  Citizen.Wait(5)
  if not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
   for id,v in pairs(scrapyards) do
    if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 15.0) then
     DrawMarker(25, v.x, v.y, v.z-0.99, 0, 0, 0, 0, 0, 0, 0.8,0.8,0.5, 255, 15, 15, 200, 0, true, 2, 0, 0, 0, 0)
     if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.2) then
       drawTxt('~c~Press ~g~E~c~ Open scrap Menu')
      if IsControlJustPressed(0, 38) then
       currentStore = v.id
       WarMenu.OpenMenu('scrap')
       TriggerServerEvent('scrapyard:getstock', v.id)
      end
     end
    end
   end
  end

  if DecorGetInt(GetPlayerPed(-1), "Job") == 33 then
   if(GetDistanceBetweenCoords(coords, -523.880, -1635.497, 18.035, true) < 15.0) then
    DrawMarker(25, -523.880, -1635.497, 18.035-0.95, 0, 0, 0, 0, 0, 0, 0.65,0.65,0.5, 255, 255, 255, 200, 0, true, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(coords, -523.880, -1635.497, 18.035, true) < 1.2) then
     drawTxt('~c~Press ~g~E~c~ To Open Stock')
     if IsControlJustPressed(0, 38) then
      TriggerServerEvent('scrapyard:getstock', 2)
      WarMenu.OpenMenu('yard')
      Wait(100)
     end
    end
   end
  end

  if scrapmetalDelivery == 0 and steelbarsDelivery == 0 and not IsPedInAnyVehicle(GetPlayerPed(-1), false) and DecorGetInt(GetPlayerPed(-1), "Job") == 34 then
   if(GetDistanceBetweenCoords(coords, -535.471, -1628.848, 18.035, true) < 15.0) then
    DrawMarker(25, -535.471, -1628.848, 18.035-0.95, 0, 0, 0, 0, 0, 0, 0.65,0.65,0.5, 255, 255, 255, 200, 0, true, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(coords, -535.471, -1628.848, 18.035, true) < 1.2) then
     drawTxt('~c~Press ~g~E~c~ To Open Stock Ledger')
     if IsControlJustPressed(0, 38) then
      TriggerServerEvent('scrapyard:getstock', 2)
      WarMenu.OpenMenu('stocking')
      Wait(100)
     end
    end
   end
  end

  if scrapmetalDelivery == 1 and DecorGetInt(GetPlayerPed(-1), "Job") == 34 then
   if(GetDistanceBetweenCoords(coords, 2415.862, 3107.906, 48.153, true) < 15.0) then
    nearPoint = true
    DrawMarker(20, 2415.862, 3107.906, 48.153, 0, 0, 0, 0, 0, 0, 0.65,0.65,0.5, 255, 15, 15, 200, 0, true, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(coords, 2415.862, 3107.906, 48.153, true) < 1.2) then
     drawTxt('~c~Press ~g~E~c~ To Collect Scrap')
     if IsControlJustPressed(0, 38) then
      RemoveJobBlip()
      scrapmetalDelivery = 2
      SetJobBlip(-546.707, -1635.487, 19.020)
      TriggerEvent("pNotify:SendNotification", {text= "Return the scrap to the scrapyard"})
     end
    end
   else
    nearPoint = false
   end
  end

  if steelbarsDelivery == 1 and DecorGetInt(GetPlayerPed(-1), "Job") == 34 then
   if(GetDistanceBetweenCoords(coords, -185.557, 6291.188, 31.488, true) < 15.0) then
    nearPoint = true
    DrawMarker(20, -185.557, 6291.188, 31.488, 0, 0, 0, 0, 0, 0, 0.65,0.65,0.5, 255, 15, 15, 200, 0, true, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(coords, -185.557, 6291.188, 31.488, true) < 1.2) then
     drawTxt('~c~Press ~g~E~c~ To Collect Metal Bars')
     if IsControlJustPressed(0, 38) then
      RemoveJobBlip()
      steelbarsDelivery = 2
      SetJobBlip(-546.707, -1635.487, 19.020)
      TriggerEvent("pNotify:SendNotification", {text= "Return the scrap to the scrapyard"})
     end
    end
   else
    nearPoint = false
   end
  end

  if steelbarsDelivery == 2 or scrapmetalDelivery == 2 and DecorGetInt(GetPlayerPed(-1), "Job") == 34 and IsPedInAnyVehicle(GetPlayerPed(-1), false) then
   if(GetDistanceBetweenCoords(coords, -546.707, -1635.487, 19.020, true) < 15.0) then
    nearPoint = true
    DrawMarker(20, -546.707, -1635.487, 19.020, 0, 0, 0, 0, 0, 0, 0.65,0.65,0.5, 255, 15, 255, 200, 0, true, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(coords, -546.707, -1635.487, 19.020, true) < 1.2) then
     drawTxt('~c~Press ~g~E~c~ To Drop Off Scrap')
     if IsControlJustPressed(0, 38) then
      RemoveJobBlip()
      local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1))
      SetEntityAsMissionEntity(vehicle, true, true)
      Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle))

      if steelbarsDelivery == 2 then
       TriggerServerEvent('scrapyard:addstock', 2, 293, math.random(42,75))
       TriggerServerEvent('jobs:addmoney', math.random(200, 250))
       scrapmetalDelivery = 0
       steelbarsDelivery = 0
      elseif scrapmetalDelivery == 2 then
       TriggerServerEvent('scrapyard:addstock', 2, 294, math.random(35,50))
       TriggerServerEvent('jobs:addmoney', math.random(100, 180))
       scrapmetalDelivery = 0
       steelbarsDelivery = 0
      end
     end
    end
   else
    nearPoint = false
   end
  end

  if not IsPedInAnyVehicle(GetPlayerPed(-1), false) and DecorGetInt(GetPlayerPed(-1), "Job") == 33 then
   if(GetDistanceBetweenCoords(coords, -521.818, -1624.223, 17.798, true) < 15.0) then
    DrawMarker(25, -521.818, -1624.223, 17.798-0.99, 0, 0, 0, 0, 0, 0, 0.8,0.8,0.5, 255, 255, 255, 200, 0, true, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(coords, -521.818, -1624.223, 17.798, true) < 1.2) then
     drawTxt('~c~Press ~g~E~c~ Restock Nuts and Bolts')
     if IsControlJustPressed(0, 38) then
      API_ProgressBar('Packaging Nuts and Bolts', 30)
      Wait(3000)
      TriggerServerEvent('scrapyard:addstock', 1, 296, 1)
     end
    end
   end
  end

  if not IsPedInAnyVehicle(GetPlayerPed(-1), false) and DecorGetInt(GetPlayerPed(-1), "Job") == 33 then
   if(GetDistanceBetweenCoords(coords, -539.266, -1620.055, 17.798, true) < 15.0) then
    DrawMarker(25, -539.266, -1620.055, 17.798-0.99, 0, 0, 0, 0, 0, 0, 0.8,0.8,0.5, 255, 255, 255, 200, 0, true, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(coords, -539.266, -1620.055, 17.798, true) < 1.2) then
     drawTxt('~c~Press ~g~E~c~ Melting Bars')
     if IsControlJustPressed(0, 38) then
      if exports['core']:GetItemQuantity(294) >= 1 and exports['core']:GetItemQuantity(293) >= 1 then
       SetEntityCoords(GetPlayerPed(-1), -539.266, -1620.055, 17.798-0.95)
       SetEntityHeading(GetPlayerPed(-1), 124.934)
       TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_WELDING", 32, true)
       TriggerEvent("inventory:removeQty", 293, 1)
       TriggerEvent("inventory:removeQty", 294, 1)
       API_ProgressBar('Melting steel', 200)
       Wait(20000)
       API_ProgressBar('Processing Steel', 200)
       Wait(20000)
       API_ProgressBar('Sorting', 200)
       Wait(20000)
       TriggerServerEvent('scrapyard:addstock', 1, 295, 3)
       ClearPedTasks(GetPlayerPed(-1))
       if math.random(1, 100) <= 30 then
        local pay = math.random(10, 50)
        TriggerServerEvent('jobs:addmoney', pay)
        TriggerEvent("pNotify:SendNotification", {text= "You've created x3 Steel Blocks."})
       else
        TriggerEvent("pNotify:SendNotification", {text= "You've created x3 Steel Blocks"})
       end
      else
       TriggerEvent("pNotify:SendNotification", {text= "You need at least 1 Steel Bar and 1 Pile of Scrap Metal to do this!"})
      end
     end
    end
   end
  end

  if not IsPedInAnyVehicle(GetPlayerPed(-1), false) and DecorGetInt(GetPlayerPed(-1), "Job") == 33 then
    if(GetDistanceBetweenCoords(coords, -534.329, -1615.745, 17.798, true) < 15.0) then
     DrawMarker(25, -534.329, -1615.745, 17.798-0.99, 0, 0, 0, 0, 0, 0, 0.8,0.8,0.5, 255, 255, 255, 200, 0, true, 2, 0, 0, 0, 0)
     if(GetDistanceBetweenCoords(coords, -534.329, -1615.745, 17.798, true) < 1.2) then
      drawTxt('~c~ [~g~E~c~] Make Metal Springs')
      if IsControlJustPressed(0, 38) then
       if exports['core']:GetItemQuantity(294) >= 1 then
        SetEntityCoords(GetPlayerPed(-1), -534.329, -1615.745, 17.798-0.95)
        SetEntityHeading(GetPlayerPed(-1), 124.934)
        TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_WELDING", 32, true)
        TriggerEvent("inventory:removeQty", 294, 1)
        API_ProgressBar('Scrapping Bars', 200)
        Wait(20000)
        API_ProgressBar('Bending Steel Bar', 200)
        Wait(20000)
        API_ProgressBar('Packaging Spring', 200)
        Wait(20000)
        TriggerServerEvent('scrapyard:addstock', 1, 114, 1)
        ClearPedTasks(GetPlayerPed(-1))
        if math.random(1, 100) <= 30 then
         local pay = math.random(20, 40)
         TriggerServerEvent('jobs:addmoney', pay)
         TriggerEvent("pNotify:SendNotification", {text= "You have created a metal spring."})
        else
         TriggerEvent("pNotify:SendNotification", {text= "You have created a metal spring"})
        end
       else
        TriggerEvent("pNotify:SendNotification", {text= "You need at least 1 steel bar to do this!"})
       end
      end
     end
    end
   end

  if WarMenu.IsMenuOpened('scrap') then
   for ind,v in pairs(currentStock) do
    if v.amount > 0 then
     if WarMenu.Button(v.stockname.." ["..v.amount.."]", " ~g~$"..v.price) then
      local item = v.itemid
      TriggerServerEvent('scrapyard:removestock', currentStore, item, 1, v.price)
      TriggerServerEvent('shops:purchase', v.stockname, v.price, 1, item)
      TriggerServerEvent('bank:intoSharedBank', v.price, 19)
      TriggerServerEvent('scrapyard:getstock', currentStore)
     end
    elseif v.amount <= 0 then
     if WarMenu.Button(v.stockname, "~r~No Stock") then
     TriggerEvent("pNotify:SendNotification", {text= "This item is currently out of stock!"})
     end
    end
   end
   WarMenu.Display()
  end

  if WarMenu.IsMenuOpened('yard') then
   for ind,v in pairs(currentStock) do
    if v.amount > 0 then
     if WarMenu.Button(v.stockname, " ["..v.amount.."]") then
      local item = v.itemid
      TriggerServerEvent('scrapyard:removestock', 2, item, 1, 0)
      TriggerServerEvent('shops:purchase', v.stockname, 0, 1, item)
      TriggerServerEvent('scrapyard:getstock', 2)
     end
    elseif v.amount <= 0 then
     if WarMenu.Button(v.stockname, "~r~No Stock") then
     TriggerEvent("pNotify:SendNotification", {text= "The suppliers need to collect more "..v.stockname})
     end
    end
   end
   WarMenu.Display()
  end

  if WarMenu.IsMenuOpened('stocklisting') then
   for ind,v in pairs(currentStock) do
    if v.amount > 0 then
     if WarMenu.Button(v.stockname.." ["..v.amount.."]", "~g~$"..v.price) then
      local item = v.itemid
      TriggerServerEvent('scrapyard:removestock', 3, item, 1, 0)
      TriggerServerEvent('shops:purchase', v.stockname, 0, 1, item)
      TriggerServerEvent('scrapyard:getstock', 3)
     end
    elseif v.amount <= 0 then
     if WarMenu.Button(v.stockname, "~r~No Stock") then
     TriggerEvent("pNotify:SendNotification", {text= "The suppliers need to collect more "..v.stockname})
     end
    end
   end
   WarMenu.Display()
  end

  if WarMenu.IsMenuOpened('stocking') then
   for ind,v in pairs(currentStock) do
    if WarMenu.Button(v.stockname.." Delivery", " ["..v.amount.."]") then
     local item = v.itemid
     WarMenu.CloseMenu()
     SpawnJobTruck('scrap', -546.707, -1635.487, 19.020)
     if item == 294 then
      scrapmetalDelivery = 1
      SetJobBlip(2415.862, 3107.906, 48.153)
     elseif item == 293 then
      steelbarsDelivery = 1
      SetJobBlip(-185.557, 6291.188, 31.488)
     end
    end
   end
   WarMenu.Display()
  end

  if scrapmetalDelivery == 1 and not nearPoint then
   drawTxt('~c~Drive to collect the ~g~ Scrap Metal')
  elseif steelbarsDelivery == 1 and not nearPoint then
   drawTxt('~c~Drive to collect the ~g~ Steel Bars')
  elseif scrapmetalDelivery == 2 and not nearPoint then
   drawTxt('~c~Return and drop off the ~g~Scrap Metal ~c~to be paid!')
  elseif steelbarsDelivery == 2 and not nearPoint then
   drawTxt('~c~Return and drop off the ~g~Steel Bars ~c~to be paid!')
  end

 end
end)


function SpawnJobTruck(model, x,y,z)
 if DoesEntityExist(vehicle) then DeleteVehicle(vehicle) end
 local vehiclehash = GetHashKey(model)
 RequestModel(vehiclehash)
 while not HasModelLoaded(vehiclehash) do
  Citizen.Wait(0)
 end
 vehicle = CreateVehicle(vehiclehash, x,y,z, 122.814, true, false)
 SetVehicleDirtLevel(vehicle, 0)
 TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
 SetVehicleHasBeenOwnedByPlayer(vehicle, true)
 SetEntityAsMissionEntity(vehicle, true, true)
 SetVehicleMod(vehicle,16, 20)
 SetVehicleEngineOn(vehicle, true)
 SetVehicleLivery(vehicle, vehlivery)
 DecorSetInt(vehicle, "_Fuel_Level", 75000)
end