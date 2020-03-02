local weedThirst = 0

local growthTimer = 0

local weedPlanted = false 

local currentPolice = 0



RegisterNetEvent("weed:plantStart")

AddEventHandler("weed:plantStart", function()

  local ped = PlayerPedId()

  if IsEntityInZone(ped, 'GRAPES') then 

   if not IsPedInAnyVehicle(ped, false) and not weedPlanted and GetInteriorFromEntity(PlayerPedId()) == 0 then 

    if exports['core']:GetItemQuantity(118) > 0 then

     local pos = GetEntityCoords(ped)

     TriggerEvent("inventory:removeQty", 118, 1)

     TaskStartScenarioInPlace(ped, "WORLD_HUMAN_GARDENER_PLANT", 0, true)

     Wait(10000)

     ClearPedTasks(ped)

     TriggerEvent('weed:plant', {x = pos.x, y = pos.y, z = pos.z}, ped)

    else 

     TriggerEvent('chatMessage', "WEED", {27, 186, 0}, "Necesita al menos 1x Weed Seed para comenzar el proceso de cultivo")

    end 

   end

  else 

   TriggerEvent('chatMessage', "WEED", {27, 186, 0}, "Necesitas estar en el área de semillas de uva para plantar una planta de hierba")

  end

end)



RegisterNetEvent('weed:plant')

AddEventHandler('weed:plant', function(pos, ped)

 local weedStageOne = true

 local weedStafeTwo = false 

 local weedStageThree = false

 local weedFertilized = false

 weedThirst = 0 

 weedPlanted = true

 growthTimer = 250

 while weedStageOne do

  Wait(5) 

  local coords = GetEntityCoords(ped)

  if not weedFertilized then 

    if GetDistanceBetweenCoords(coords, pos.x, pos.y, pos.z, true) < 1 then 

      DrawText3Ds(pos.x, pos.y, pos.z,'~w~[~y~E~w~]Fertilize')

      if exports['core']:GetItemQuantity(16) > 0 then 

        if IsControlJustPressed(0, 38) then  

          weedFertilized = true

          TriggerEvent("inventory:removeQty", 16, 1) 

          Wait(200)

        end    

      end

    end

  end

  -- Water

  if weedFertilized and weedThirst < 75 and IsPedOnFoot(ped) then 

    if GetDistanceBetweenCoords(coords, pos.x, pos.y, pos.z, true) < 1 then 

      DrawText3Ds(pos.x, pos.y, pos.z,'~w~[~y~E~w~]Water')

    if exports['core']:GetItemQuantity(13) > 0 then 

     if IsControlJustPressed(0, 38) then 

      weedThirst = 100 

      TriggerEvent("inventory:removeQty", 13, 1)

     end

    end

   end

  end

  if weedThirst > 25 and growthTimer == 200 then 

   weedStageOne = false 

   weedStageTwo = true

  end

 end

 -- Stage 2

 if weedStageTwo then 

  local _, worldZ = GetGroundZFor_3dCoord(pos.x, pos.y, pos.z)

  local weedPlant = CreateObject(GetHashKey('prop_weed_02'), pos.x, pos.y, worldZ+0.40, true, true, true)

  local weedPlantPot = CreateObject(GetHashKey('prop_oiltub_01'), pos.x, pos.y, worldZ, true, true, true)

  FreezeEntityPosition(weedPlant, true)

  FreezeEntityPosition(weedPlantPot, true)

  SetEntityAsMissionEntity(weedPlantPot, true, true)

  SetEntityAsMissionEntity(weedPlant, true, true)

  while weedStageTwo do 

   Wait(5)

   local coords = GetEntityCoords(ped)

   if weedThirst < 45 then 

    if GetDistanceBetweenCoords(coords, pos.x, pos.y, pos.z, true) < 1 then  

    DrawText3Ds(pos.x, pos.y, pos.z,'~w~[~y~E~w~]Cut Down') 

     if exports['core']:GetItemQuantity(13) > 0 then 

      if IsControlJustPressed(0, 38) then 

       weedThirst = weedThirst + 55 

       TriggerEvent("inventory:removeQty", 13, 1)

      end

     end

    end

   end

   if growthTimer < 1 then

   	DeleteObject(weedPlant)

    DeleteObject(weedPlantPot)

    weedStageThree = true 

    weedStageTwo = false 

   end

  end

 end



 -- Weed Stage 3

 if weedStageThree then 

  local _, worldZ = GetGroundZFor_3dCoord(pos.x, pos.y, pos.z)

  local weedPlant = CreateObject(GetHashKey('prop_weed_01'), pos.x, pos.y, worldZ+0.40, true, true, true)

  local weedPlantPot = CreateObject(GetHashKey('prop_oiltub_01'), pos.x, pos.y, worldZ, true, true, true)

  FreezeEntityPosition(weedPlant, true)

  FreezeEntityPosition(weedPlantPot, true)

  SetEntityAsMissionEntity(weedPlantPot, true, true)

  SetEntityAsMissionEntity(weedPlant, true, true)

  while weedStageThree do 

   Wait(5)

   local coords = GetEntityCoords(ped)

   if GetDistanceBetweenCoords(coords, pos.x, pos.y, pos.z, true) < 3 then 

    drawTxt('~b~Press ~g~E~b~ Para cortar la planta') 

    if IsControlJustPressed(0, 38) then 

     TriggerEvent("inventory:addQty", 120, 6)

     TriggerEvent('chatMessage', "WEED", {27, 186, 0}, "Te han dado 6x Oz de hierba")

     DeleteObject(weedPlant)

     DeleteObject(weedPlantPot)

     weedPlant = nil

     weedPlanted = false 

     weedThirst = 0 

	   growthTimer = 0

	   weedStageThree = false 

    end

   end

  end

 end

end)



Citizen.CreateThread(function()

 while true do

  Citizen.Wait(895)

  if weedPlanted then 

   if weedThirst > 0 then 

    weedThirst = weedThirst - 1

   end

  end 

 end

end)



Citizen.CreateThread(function()

 while true do

  Citizen.Wait(5)

  if weedPlanted then 

   if growthTimer > 0 then 

    --drawTxt('\n~b~Sed actual de plantas: ~g~'..weedThirst..' ~b~| Crecimiento actual: ~g~'..growthTimer)
	DrawText3D('\n~b~Sed actual de plantas: ~g~'..weedThirst..' ~b~| Crecimiento actual: ~g~'..growthTimer)

   end

  end 

 end

end)




local tobacco = {

  {x = 2216.431, y = 5578.511, z = 53.708},

  {x = 2232.475, y = 5577.691, z = 53.883},

  {x = 2230.854, y = 5575.537, z = 53.780},

  {x = 2215.792, y = 5576.156, z = 53.581},

  {x = 2218.678, y = 5576.140, z = 53.596},

  {x = 2221.883, y = 5575.837, z = 53.621},

  {x = 2225.695, y = 5577.826, z = 53.715},

}



local pickingTob = false



Citizen.CreateThread(function()

  while true do

   Citizen.Wait(5)

   for _,v in pairs(tobacco) do

    if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z) <= 2 and not pickingTob then

      DrawText3Ds(v.x, v.y, v.z,'~m~[~y~E ~m~]Recoger')

     if IsControlJustPressed(0, 38) then 

      pickingTob = true

      TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_ATM", 0, true)

      API_ProgressBar('Picking Leaf', 20)

      Wait(5000)
      --local finished = exports["clrp-taskbar"]:taskBar(40000,"Recogiendo hoja")	  
      --if finished == 100 then
      TriggerEvent("inventory:addQty", 122, 1)
      ClearPedTasksImmediately(GetPlayerPed(-1))
      pickingTob = false	  
      --end
	 
     end

    end

   end

  end

 end)



 --[XZURV WEEDSEED PICKING SCRIPT]--

-- local seeds = {

  -- {x = 2344.161, y = -1898.400, z = 78.347},

  -- {x = 2348.375, y = -1901.138, z = 79.701},

  -- {x = 2344.807, y = -1901.730, z = 77.920},

  -- {x = 2229.092, y = 5602.859, z = 54.686},

  -- {x = -1180.140, y = 4929.909, z = 222.905},

  -- {x = 2331.473, y = -1183.360, z = 68.383}

-- }



-- local pickingTob = false



-- Citizen.CreateThread(function()

  -- while true do

   -- Citizen.Wait(5)

   -- for _,v in pairs(seeds) do

    -- if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z) <= 2 and not pickingTob then

      -- DrawText3Ds(v.x, v.y, v.z,'~y~[E]~w~ Check')

     -- if IsControlJustPressed(0, 38) then 

      -- pickingTob = true

      -- TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_GARDENER_PLANT", 0, true)

      -- API_ProgressBar('Digging up Plant', 450)

      -- Wait(45000)

      -- TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_GARDENER_PLANT", 0, true)

      -- API_ProgressBar('Checking for Seed', 450)

      -- Wait(45000)

      -- TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_GARDENER_PLANT", 0, true)

      -- API_ProgressBar('Picking Weed Seed', 450)

      -- Wait(45000)

      -- TriggerEvent("inventory:addQty", 118, 1)

     -- -- -- TriggerEvent("core:log", tostring("[SEED] player:" .. GetPlayerName(source) "Has Picked A Weed Seed", "admin"))

      -- TriggerServerEvent("seed:check")

      -- ClearPedTasksImmediately(GetPlayerPed(-1))

      -- pickingTob = false

     -- end

    -- end

   -- end

  -- end

 -- end)



local bromide = {

  {x = 3559.993, y = 3674.487, z = 28.122}, ----- ketamine

}



local pickingTob = false



Citizen.CreateThread(function()

  while true do

   Citizen.Wait(5)

   for _,v in pairs(bromide) do

    if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z) <= 1 and not pickingTob then

     DrawText3Ds(v.x, v.y, v.z,'~y~[E]~w~ Steal')

     if IsControlJustPressed(0, 38) then 

      pickingTob = true

      TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_ATM", 0, true)

      API_ProgressBar('    Collecting Chemicals', 250)

      Citizen.Wait(25000)
	  --local finished = exports["clrp-taskbar"]:taskBar(20000,"Recolección productos químicos")	  
      --if finished == 100 then
      TriggerEvent("inventory:addQty", 18, 1)
      ClearPedTasksImmediately(GetPlayerPed(-1))
      pickingTob = false
     --end
     end

    end

   end

  end

 end) ---- ketamine



local methylamine = {

  {x = 3534.762, y = 3660.551, z = 28.122}, ----- ketamine

}



local pickingTob = false



Citizen.CreateThread(function()

  while true do

   Citizen.Wait(5)

   for _,v in pairs(methylamine) do

    if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z) <= 1 and not pickingTob then

      DrawText3Ds(v.x, v.y, v.z,'~y~[E]~w~ Steal')

     if IsControlJustPressed(0, 38) then 

      pickingTob = true

      TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_ATM", 0, true)

      API_ProgressBar('    Collecting Chemicals', 250)

      Citizen.Wait(25000)
	  --local finished = exports["clrp-taskbar"]:taskBar(20000,"Recolección productos químicos")	  
      --if finished == 100 then
      TriggerEvent("inventory:addQty", 20, 1)

      ClearPedTasksImmediately(GetPlayerPed(-1))

      pickingTob = false
     -- end
     end

    end

   end

  end

 end) ---- ketamine





Citizen.CreateThread(function()

 while true do

  Citizen.Wait(2125)

  if weedPlanted then 

   if weedThirst > 0 then

    if growthTimer > 0 then 

     if exports['clrp_sync']:isDay() then

      growthTimer = growthTimer - 2

     else 

      growthTimer = growthTimer - 1

     end

    end

   end

  end 

 end

end)             ------ WEEED SYNC





Citizen.CreateThread(function()

  while true do

   Citizen.Wait(2125)

   if weedPlanted2 then 

    if weedThirst2 > 0 then

     if growthTimer2 > 0 then 

      if exports['clrp_sync']:isDay() then

       growthTimer2 = growthTimer2 - 2

      else 

       growthTimer2 = growthTimer2 - 1

      end

     end

    end

   end 

  end

end)



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



local location1 = false

local location2 = false

local xzurvcoco = false

local xzurvbreakingbad = false

local xzurvsmackheads = false

RegisterNetEvent("xzurv:purchasemeth")

AddEventHandler("xzurv:purchasemeth", function() 

  xzurvbreakingbad = true

end)



RegisterNetEvent("xzurv:purchaseheroin")

AddEventHandler("xzurv:purchaseheroin", function() 

  xzurvsmackheads = true

end)



RegisterNetEvent("xzurv:purchasecoke")

AddEventHandler("xzurv:purchasecoke", function() 

  xzurvcoco = true

end)



RegisterNetEvent("weed:seedspurchased1")

AddEventHandler("weed:seedspurchased1", function() 

  location1 = true

end)



RegisterNetEvent("weed:seedspurchased2")

AddEventHandler("weed:seedspurchased2", function() 

  location2 = true

end)



-- Citizen.CreateThread(function()

  -- while true do

   -- Citizen.Wait(5)

    -- if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 1545.976, 2166.509, 78.728) <= 2 and not location1 then

     -- DrawText3Ds(1545.976, 2166.509, 78.728,'~y~[E]~w~ Purchase 2x Weed Seed ~g~$350\n~y~[R]~w~Purchase 1x Weed Seed ~g~$200')

     -- if IsControlJustPressed(0, 38) then

      -- TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_ATM", 0, true)

      -- API_ProgressBar('Purchasing Weed Seeds', 45)

      -- Wait(5000)

      -- ClearPedTasksImmediately(GetPlayerPed(-1))

      -- TriggerServerEvent('weed:purchaseseeds1', 2)

      -- Wait(1000)

     -- elseif IsControlJustPressed(0, 45) then

      -- TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_ATM", 0, true)

      -- API_ProgressBar('Purchasing Weed Seeds', 45)

      -- Wait(5000)

      -- ClearPedTasksImmediately(GetPlayerPed(-1))

      -- TriggerServerEvent('weed:purchaseseeds1', 1)

      -- Wait(1000)

     -- end

    -- end



    --[[if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1263.397, -1142.865, 7.545) <= 2 and not location2 then

      DrawText3Ds(-1263.397, -1142.865, 7.545,'~y~[E]~w~ Purchase 2x Weed Seed ~g~$350\n~y~[R]~w~Purchase 1x Weed Seed ~g~$200')

      if IsControlJustPressed(0, 38) then

       TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_ATM", 0, true)

       API_ProgressBar('Purchasing Weed Seeds', 45)

       Wait(5000)

       ClearPedTasksImmediately(GetPlayerPed(-1))

       TriggerServerEvent('weed:purchaseseeds2', 2)

       Wait(1000)

      elseif IsControlJustPressed(0, 45) then

       TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_ATM", 0, true)

       API_ProgressBar('Purchasing Weed Seeds', 45)

       Wait(5000)

       ClearPedTasksImmediately(GetPlayerPed(-1))

       TriggerServerEvent('weed:purchaseseeds2', 1)

       Wait(1000)

      end

     end]]--



     -- if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -101.639, -62.980, 62.738) <= 1.5 and not xzurvcoco then

      -- DrawText3Ds( -101.639, -62.980, 62.738+0.25,"~y~[E]~w~ 2 Oz's of Cocaine ~g~$2650\n~y~[R]~w~ 1 Oz of Cocaine ~g~$1400") 

      -- if IsControlJustPressed(0, 38) then

       -- TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_ATM", 0, true)

       -- API_ProgressBar('Purchasing Cocaine', 45)

       -- Wait(5000)

       -- ClearPedTasksImmediately(GetPlayerPed(-1))

       -- TriggerServerEvent('xzurv:purchasecoke', 2)

       -- Wait(1000)

      -- elseif IsControlJustPressed(0, 45) then

       -- TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_ATM", 0, true)

       -- API_ProgressBar('Purchasing Cocaine', 45)

       -- Wait(5000)

       -- ClearPedTasksImmediately(GetPlayerPed(-1))

       -- TriggerServerEvent('xzurv:purchasecoke', 1)

       -- Wait(1000)

      -- end

     -- end

     

     -- if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 907.028, 3643.555, 32.705) <= 1.5 and not xzurvbreakingbad then

      -- DrawText3Ds( 907.028, 3643.555, 32.705+0.25,"~y~[E]~w~ 2 Oz's of Crystal Meth ~g~$2200\n~y~[R]~w~ 1 Oz of Crystal Meth ~g~$1300") 

      -- if IsControlJustPressed(0, 38) then

       -- TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_ATM", 0, true)

       -- API_ProgressBar('Purchasing Crystal Meth', 45)

       -- Wait(5000)

       -- ClearPedTasksImmediately(GetPlayerPed(-1))

       -- TriggerServerEvent('xzurv:purchasemeth', 2)

       -- Wait(1000)

      -- elseif IsControlJustPressed(0, 45) then

       -- TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_ATM", 0, true)

       -- API_ProgressBar('Purchasing Crystal Meth', 45)

       -- Wait(5000)

       -- ClearPedTasksImmediately(GetPlayerPed(-1))

       -- TriggerServerEvent('xzurv:purchasemeth', 1)

       -- Wait(1000)

      -- end

     -- end

     -- if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -321.399, 6302.532, 36.784) <= 1.5 and not xzurvsmackheads then

      -- DrawText3Ds( -320.687, 6303.422,36.584+0.25,"~y~[E]~w~ 2 Oz's of Heroin ~g~$2400\n~y~[R]~w~ 1 Oz of Heroin ~g~$1300") 

      -- if IsControlJustPressed(0, 38) then

       -- TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_ATM", 0, true)

       -- API_ProgressBar('Purchasing Heroin', 45)

       -- Wait(5000)

       -- ClearPedTasksImmediately(GetPlayerPed(-1))

       -- TriggerServerEvent('xzurv:purchaseheroin', 2)

       -- Wait(1000)

      -- elseif IsControlJustPressed(0, 45) then

       -- TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_ATM", 0, true)

       -- API_ProgressBar('Purchasing Heroin', 45)

       -- Wait(5000)

       -- ClearPedTasksImmediately(GetPlayerPed(-1))

       -- TriggerServerEvent('xzurv:purchaseheroin', 1)

       -- Wait(1000)

      -- end

     -- end

  -- end

 -- end)



-- Peds

Citizen.CreateThread(function()

  spawnDrugDealers()

 end)

 

 local drug1 = nil

 --local drug2 = nil

 local xzurv = nil

 local smack = nil

 local baghead = nil



 function spawnDrugDealers()

  if drug1 == nil then

   RequestModel(GetHashKey('s_m_y_dealer_01'))

   while not HasModelLoaded(GetHashKey('s_m_y_dealer_01')) do

    Wait(1)

   end

 

   drug1 = CreatePed(2, GetHashKey('s_m_y_dealer_01'), 1545.976, 2166.509, 77.728, 205.545, false, false)

   SetPedFleeAttributes(drug1, 0, 0)

   SetPedDiesWhenInjured(drug1, false)

   TaskStartScenarioInPlace(drug1, "WORLD_HUMAN_DRUG_DEALER", 0, true)

   SetPedKeepTask(drug1, true)

  end -- add drug dealers

  --[[if drug2 == nil then 

   RequestModel(GetHashKey('a_m_m_mexcntry_01'))

   while not HasModelLoaded(GetHashKey('a_m_m_mexcntry_01')) do

    Wait(1)

   end

 

   drug2 = CreatePed(2, GetHashKey('a_m_m_mexcntry_01'), -1263.397, -1142.865, 7.545, 335.935, false, false)

   SetPedFleeAttributes(drug2, 0, 0)

   SetPedDiesWhenInjured(drug2, false)

   TaskStartScenarioInPlace(drug2, "WORLD_HUMAN_DRUG_DEALER", 0, true)

   SetPedKeepTask(drug2, true)

  end ]]--

  if xzurv == nil then 

    RequestModel(GetHashKey('g_m_m_armboss_01'))

    while not HasModelLoaded(GetHashKey('g_m_m_armboss_01')) do

     Wait(1)

    end

  

    xzurv = CreatePed(2, GetHashKey('g_m_m_armboss_01'), -101.639, -62.980, 62.738, 226.605, false, false)

    SetPedFleeAttributes(xzurv, 0, 0)

    SetPedDiesWhenInjured(xzurv, false)

    TaskStartScenarioInPlace(xzurv, "WORLD_HUMAN_DRUG_DEALER", 0, true)

    SetPedKeepTask(xzurv, true)

   end 

   if baghead == nil then 

    RequestModel(GetHashKey('a_m_o_acult_02'))

    while not HasModelLoaded(GetHashKey('a_m_o_acult_02')) do

     Wait(1)

    end



    baghead = CreatePed(2, GetHashKey('a_m_o_acult_02'), 907.028, 3643.555, 32.705, 191.152, false, false)

    SetPedFleeAttributes(baghead, 0, 0)

    SetPedDiesWhenInjured(baghead, false)

    TaskStartScenarioInPlace(baghead, "WORLD_HUMAN_DRUG_DEALER", 0, true)

    SetPedKeepTask(baghead, true)

   end 

   if smack == nil then 

    RequestModel(GetHashKey('A_M_M_Malibu_01'))

    while not HasModelLoaded(GetHashKey('A_M_M_Malibu_01')) do

     Wait(1)

    end

    smack = CreatePed(2, GetHashKey('A_M_M_Malibu_01'), -320.687, 6303.422, 36.584, 253.911, false, false)

    SetPedFleeAttributes(smack, 0, 0)

    SetPedDiesWhenInjured(smack, false)

    TaskStartScenarioInPlace(smack, "WORLD_HUMAN_DRUG_DEALER", 0, true)

    SetPedKeepTask(smack, true)

   end 

end





function DrawText3Ds(x,y,z, text)

  local onScreen,_x,_y=World3dToScreen2d(x,y,z)

  local px,py,pz=table.unpack(GetGameplayCamCoords())

  SetTextScale(0.35, 0.35)

  SetTextFont(4)

  SetTextProportional(1)

  SetTextColour(255, 255, 255, 215)

  SetTextEntry("STRING")

  SetTextCentre(1)

  AddTextComponentString(text)

  DrawText(_x,_y)

end


function DrawText3D(x,y,z, text)
 local onScreen,_x,_y=World3dToScreen2d(x,y,z)
 local px,py,pz=table.unpack(GetGameplayCamCoords())
 local factor = (string.len(text)) / 370
 SetTextScale(0.37, 0.37)
 SetTextFont(4)
 SetTextProportional(1)
 SetTextColour(255, 255, 255, 215)
 SetTextEntry("STRING")
 SetTextCentre(1)
 AddTextComponentString(text)
 DrawText(_x,_y)
 DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 40, 40, 40, 150)
end
