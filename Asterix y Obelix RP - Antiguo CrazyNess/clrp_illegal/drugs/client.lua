currentPolice = 0

currentMultipler = 1.0



local disableShuffle = true

function disableSeatShuffle(flag)

	disableShuffle = flag

end



Citizen.CreateThread(function()

	while true do

		Citizen.Wait(10)

		if IsPedInAnyVehicle(GetPlayerPed(-1), false) and disableShuffle then

			if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0) == GetPlayerPed(-1) then

				if GetIsTaskActive(GetPlayerPed(-1), 165) then

					SetPedIntoVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)

				end

			end

		end

	end

end)



RegisterNetEvent("SeatShuffle")

AddEventHandler("SeatShuffle", function()

	if IsPedInAnyVehicle(GetPlayerPed(-1), false) then

		disableSeatShuffle(false)

		Citizen.Wait(5000)

		disableSeatShuffle(true)

	else

		CancelEvent()

	end

end)



RegisterCommand("shuff", function(source, args, raw) --change command here

    TriggerEvent("SeatShuffle")

end, false) --False, allow everyone to run it





RegisterCommand('cartel', function(source, args, rawCommand)

 if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 631.830, 3016.357, 42.724, true) < 50) and DecorGetInt(GetPlayerPed(-1), "Faction") == 1 then

  TriggerServerEvent('drugs:startZone')

  TriggerServerEvent('addReputation', 100)

 else

  exports['clrp_notify']:DoHudText('inform',  "The Cartel Wont Deliver Here, Go To Your Pickup Location!")

 end

end)





RegisterCommand('escobar', function(source, args, rawCommand)

  if DecorGetInt(GetPlayerPed(-1), "Faction") == 1 then 

   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),64.237, 7230.599, 2.621) <= 15 ) then

    TriggerServerEvent('coke:startZone')

   else

    exports['clrp_notify']:DoHudText('error',  "The Cartel Wont Deliver Here, Go To Your Pickup Location!")

   end

  else

   exports['clrp_notify']:DoHudText('error',  "You have no links with the cartel!")

  end

end)



RegisterCommand('tuner', function(source, args, rawCommand)

  if exports['core']:GetItemQuantity(175) >= 1 and DecorGetInt(GetPlayerPed(-1), "Job") == 39 then

    TriggerEvent("xgc-tuner:openTuner")   

  else

    exports['clrp_notify']:DoHudText('error', 'You need to be a Tuner and have a Tuners chip')

  end  

end)



RegisterNetEvent("coke:delivery")

AddEventHandler("coke:delivery", function() 

    local pos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 10.0, 0.0)

    Citizen.CreateThread(function()

      local pilot, aircraft, crate

        local requiredModels = {"cuban800", "s_m_m_pilot_02", "prop_boxpile_06b"}



        for i = 1, #requiredModels do

            RequestModel(GetHashKey(requiredModels[i]))

            while not HasModelLoaded(GetHashKey(requiredModels[i])) do

                Wait(0)

            end

        end



        local rHeading = math.random(0, 360) + 0.0

        local planeSpawnDistance = (3000.0 and tonumber(3000.0) + 0.0) or 400.0

        local theta = (rHeading / 180.0) * 3.14

        local rPlaneSpawn = vector3(pos.x, pos.y, pos.z) - vector3(math.cos(theta) * planeSpawnDistance, math.sin(theta) * planeSpawnDistance, -500.0)

        

        local dx = pos.x - rPlaneSpawn.x

        local dy = pos.y - rPlaneSpawn.y

        local heading = GetHeadingFromVector_2d(dx, dy)



        aircraft = CreateVehicle(GetHashKey("cuban800"), rPlaneSpawn, heading, true, true)

        SetEntityHeading(aircraft, heading)

        SetVehicleDoorsLocked(aircraft, 2)

        SetEntityDynamic(aircraft, true)

        ActivatePhysics(aircraft)

        SetVehicleForwardSpeed(aircraft, 60.0)

        SetHeliBladesFullSpeed(aircraft)

        SetVehicleEngineOn(aircraft, true, true, false)

        ControlLandingGear(aircraft, 3) 

        OpenBombBayDoors(aircraft)

        SetEntityProofs(aircraft, true, false, true, false, false, false, false, false)



        pilot = CreatePedInsideVehicle(aircraft, 1, GetHashKey("s_m_m_pilot_02"), -1, true, true)

        SetBlockingOfNonTemporaryEvents(pilot, true) 

        SetPedRandomComponentVariation(pilot, false)

        SetPedKeepTask(pilot, true)

        SetPlaneMinHeightAboveTerrain(aircraft, 50) 

        

        TaskVehicleDriveToCoord(pilot, aircraft, vector3(pos.x, pos.y, pos.z) + vector3(0.0, 0.0, 150.0), 60.0, 0, GetHashKey("cuban800"), 262144, 15.0, -1.0)

        

        local droparea = vector2(pos.x, pos.y)

        local planeLocation = vector2(GetEntityCoords(aircraft).x, GetEntityCoords(aircraft).y)

        while not IsEntityDead(pilot) and #(planeLocation - droparea) > 5.0 do

            Wait(100)

            planeLocation = vector2(GetEntityCoords(aircraft).x, GetEntityCoords(aircraft).y) 

        end

        

        TaskVehicleDriveToCoord(pilot, aircraft, 0.0, 0.0, 500.0, 60.0, 0, GetHashKey("cuban800"), 262144, -1.0, -1.0) 

        SetEntityAsNoLongerNeeded(pilot) 

        SetEntityAsNoLongerNeeded(aircraft)



        local crateSpawn = vector3(pos.x, pos.y, GetEntityCoords(aircraft).z - 5.0)

        crate = CreateObject(GetHashKey("prop_boxpile_06b"), crateSpawn, true, true, true) 

        SetEntityLodDist(crate, 1000) 

        ActivatePhysics(crate)

        SetDamping(crate, 2, 0.1) 

        SetEntityVelocity(crate, 0.0, 0.0, -0.2)

        if DoesEntityExist(crate) then 

  		 Wait(15000)

         cokeDelivered(crate)

        end



        for i = 1, #requiredModels do

            Wait(0)

            SetModelAsNoLongerNeeded(GetHashKey(requiredModels[i]))

        end

     end)

end)



function cokeDelivered(prop)

  DeleteObject(prop)

  local plate = "xxsdrtghyuujhdjsjenenfjfjtjtjtj"

  if(plate == "xxsdrtghyuujhdjsjenenfjfjtjtjtj") then

   showLoadingPrompt("Enter Plate", 3)

   DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8S", "", "", "", "", "", 20)

   while (UpdateOnscreenKeyboard() == 0) do

    DisableAllControlActions(0);

    Wait(0);

   end

   if (GetOnscreenKeyboardResult()) then

    local option = tostring(GetOnscreenKeyboardResult())

    if(option ~= nil and option ~= 0) then

     plate = ""..option

    end

   end

  end

  stopLoadingPrompt()

  if (plate ~= "xxsdrtghyuujhdjsjenenfjfjtjtjtj") then

   TriggerServerEvent('coke:addDrugs', plate)

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



-- Selling Drugs To Npc

Citizen.CreateThread(function()

  while true do

    Wait(5)

  local pos = GetEntityCoords(GetPlayerPed(-1), true)

  rped = GetRandomPedAtCoord(pos['x'], pos['y'], pos['z'], 1.3, 1.35, 1.35, 3, _r)

    if DecorGetBool(GetPlayerPed(-1), "isOfficer") or DecorGetBool(GetPlayerPed(-1), "isParamedic") or DecorGetInt(GetPlayerPed(-1), "Job") == 3 or DecorGetInt(GetPlayerPed(-1), "Job") == 39 then ---- use this stop whitelist selling

    else 

    if DoesEntityExist(rped) and not IsPedInAnyVehicle(GetPlayerPed(-1), false) then

      if exports['core']:GetItemQuantity(121) > 0 or exports['core']:GetItemQuantity(84) > 0 then

        DrawText3Ds(pos['x'], pos['y'], pos['z'],'~y~[E]~w~ Ofrecer Mariahuana')

        if IsControlJustPressed(0, 38) then

          if currentPolice >= 0 then

            local randomizer = math.random(0,100)

            local copalert = math.random(0,100)

            if randomizer >= 90 then

              RejectSale()

             if copalert >= 70 then

              Snitch()

             end             

            else

              MakeSale()

              TriggerServerEvent('addReputation', 1)

            end

          else

            exports['clrp_notify']:DoHudText('inform',  "No hay suficiente policía en la ciudad")

          end

        end
		
       elseif exports['core']:GetItemQuantity(123) > 0 then

        DrawText3Ds(pos['x'], pos['y'], pos['z']+0.10,'~y~[E]~w~ Ofrecer Purro')

        if IsControlJustPressed(0, 38) then

          if currentPolice >= 0 then

            local randomizer = math.random(0,100)

            local copalert = math.random(0,100)

            if randomizer >= 75 then

              RejectSale()

             if copalert >= 60 then

              Snitch()

             end             

            else

              MakeSale()

              TriggerServerEvent('addReputation', 2)

            end

          else

            exports['clrp_notify']:DoHudText('inform',  "No hay suficiente policía en la ciudad")

          end

        end 
		
       elseif exports['core']:GetItemQuantity(50) > 0 then

        DrawText3Ds(pos['x'], pos['y'], pos['z']+0.10,'~y~[E]~w~ Ofrecer Ketamine')

        if IsControlJustPressed(0, 38) then

          if currentPolice >= 0 then

            local randomizer = math.random(0,100)

            local copalert = math.random(0,100)

            if randomizer >= 75 then

              RejectSale()

             if copalert >= 60 then

              Snitch()

             end             

            else

              MakeSale()

              TriggerServerEvent('addReputation', 2)

            end

          else

            exports['clrp_notify']:DoHudText('inform',  "No hay suficiente policía en la ciudad")

          end

        end 

       elseif exports['core']:GetItemQuantity(157) > 0 then

        DrawText3Ds(pos['x'], pos['y'], pos['z']-0.10,'~y~[E]~w~ Ofrecer Crystal Meth')

        if IsControlJustPressed(0, 38) then

          if currentPolice >= 1 then

            local randomizer = math.random(0,100)

            local copalert = math.random(0,100)

            if randomizer >= 70 then

              RejectSale()

             if copalert >= 50 then

              Snitch()

             end             

            else

              MakeSale()

              TriggerServerEvent('addReputation', 3)

            end

          else

            exports['clrp_notify']:DoHudText('inform',  "No hay suficiente policía en la ciudad")

          end

        end

       elseif exports['core']:GetItemQuantity(159) > 0 then

        DrawText3Ds(pos['x'], pos['y'], pos['z']-0.20,'~y~[E]~w~ Ofrecer Heroin')

        if IsControlJustPressed(0, 38) then

          if currentPolice >= 1 then

            local randomizer = math.random(0,100)

            local copalert = math.random(0,100)

            if randomizer >= 70 then

              RejectSale()

             if copalert >= 50 then

              Snitch()

             end             

            else

              MakeSale()

              TriggerServerEvent('addReputation', 3)

            end

          else

            exports['clrp_notify']:DoHudText('inform',  "No hay suficiente policía en la ciudad")

          end

        end

      elseif exports['core']:GetItemQuantity(110) > 0 then

        DrawText3Ds(pos['x'], pos['y'], pos['z']+0.20,'~y~[E]~w~ Ofrecer Cocaine')

        if IsControlJustPressed(0, 38) then

         if currentPolice >= 1 then

          local randomizer = math.random(0,100)

          local copalert = math.random(0,100)

          if randomizer >= 65 then

            RejectSale()

           if copalert >= 50 then

            Snitch()

           end             

          else

            MakeSale()

            TriggerServerEvent('addReputation', 3)

          end

          else

            exports['clrp_notify']:DoHudText('inform',  "No hay suficiente policía en la ciudad")

          end

        end       

      end

    end

   end 

  end

end)



---((XzuRV New Drug Script))

function RejectSale()

  rpped = rped

  SetEntityAsMissionEntity(rped)

  TaskStartScenarioInPlace(GetPlayerPed(-1), 'prop_human_parking_meter', false, true)

  FreezeEntityPosition(GetPlayerPed(-1),true)

  Wait(3000)

  exports['clrp_notify']:DoHudText('error', 'Oferta rechazada')

  FreezeEntityPosition(GetPlayerPed(-1),false)

  ClearPedTasksImmediately(rpped)

  ClearPedTasks(GetPlayerPed(-1))

  SetPedAsNoLongerNeeded(rpped)

  TriggerServerEvent('removeReputation', 1)

end

function MakeSale()

  rpped = rped

  SetEntityAsMissionEntity(rped)

  TaskStartScenarioInPlace(GetPlayerPed(-1), 'prop_human_parking_meter', false, true)

  TaskStartScenarioInPlace(rped, 'prop_human_parking_meter', false, true)

  FreezeEntityPosition(GetPlayerPed(-1), true)

  FreezeEntityPosition(rped, true)

  Wait(8000)

  FreezeEntityPosition(GetPlayerPed(-1), false)

  FreezeEntityPosition(rped, false)

  ClearPedTasksImmediately(rpped)

  ClearPedTasks(GetPlayerPed(-1))

  DrugsSell()

  SetPedAsNoLongerNeeded(rpped)

end

function Snitch() 

  Wait(1000)

  TriggerEvent('dispatch:cds')

  local snitch = math.random(1,5)

  if snitch == 1 then

    exports['clrp_notify']:DoLongHudText('inform', 'No quiero esa mierda, ¡vete o llamo a la policía!') 

  elseif snitch == 2 then

    exports['clrp_notify']:DoLongHudText('inform', '¿Me ves cara de drogadicto? Voy a llamar a la policía!!') 

  elseif snitch == 3 then

    exports['clrp_notify']:DoLongHudText('error', 'Metete esa mierda por el culo, voy a llamar ahora mismo a la policía!!')

  elseif snitch == 4 then

      exports['clrp_notify']:DoLongHudText('inform', 'Vete a la mierda, estoy llamando a la policía!!')

  elseif snitch == 5 then

    exports['clrp_notify']:DoLongHudText('inform', 'Esta es mi zona, largo de aqui o llamo a la policía!!')

  end

end 

---((XzuRV New Drug Script))

function DrugsSell()

  local rep = DecorGetInt(GetPlayerPed(-1), "Reputation")
  local weed = exports['core']:GetItemQuantity(121)
  local purro = exports['core']:GetItemQuantity(123)
  local ketamine = exports['core']:GetItemQuantity(50)             
  local meth = exports['core']:GetItemQuantity(157)
  local heroin = exports['core']:GetItemQuantity(159)
  local coke = exports['core']:GetItemQuantity(110) 



  local weedPricePerBag = math.random(35, 40)
  local purroPricePerBag = math.random(40, 55)
  local ketaminePricePerBag = math.random(55, 65)
  local methPricePerBag = math.random(85, 100)
  local heroinPricePerBag = math.random(100, 115)
  local cokePricePerBag = math.random(115, 130)   



  if weed > 0 then-- and or > 5

    local weedSoldBags = math.random(1, weed)

    if rep >= 5000 and weed >= 9 then

      weedSoldBags = math.random(1, 9)

    elseif rep >= 4000 and weed >= 8 then

      weedSoldBags = math.random(1, 8)

    elseif rep >= 3000 and weed >= 7 then 

      weedSoldBags = math.random(1, 7)

    elseif rep >= 2000 and weed >= 6 then 

      weedSoldBags = math.random(1, 6)

    elseif rep >= 1000 and weed >= 5 then 

      weedSoldBags = math.random(1, 5)

    elseif rep < 1000 and weed >= 4 then 

      weedSoldBags = math.random(1, 4)

    elseif weed < 4 then 

      weedSoldBags = 1  

     end  



    local weedSoldPrice = math.floor(weedSoldBags * weedPricePerBag* currentMultipler) 

    exports['clrp_notify']:DoHudText('inform',  "Usted vendió " .. weedSoldBags .." Gram(s) Of Weed For $".. weedSoldPrice .." ")

    TriggerEvent("inventory:removeQty", 121, weedSoldBags)

    TriggerServerEvent('drug:addDirtyMoney', weedSoldPrice)

    TriggerServerEvent('addReputation', 1)



  elseif ketamine > 0 then                      ---- XZURV KETAMINE

    local ketamineSoldBags = math.random(1, ketamine)

    if rep >= 5000 and ketamine >= 9 then

      ketamineSoldBags = math.random(1, 9)

    elseif rep >= 4000 and ketamine >= 7 then

      ketamineSoldBags = math.random(1, 7)

    elseif rep >= 3000 and ketamine >= 6 then 

      ketamineSoldBags = math.random(1, 6)

    elseif rep >= 2000 and ketamine >= 5 then 

      ketamineSoldBags = math.random(1, 5)

    elseif rep >= 1000 and ketamine >= 4 then 

      ketamineSoldBags = math.random(1, 4)

    elseif rep < 1000 and ketamine >= 3 then 

      ketamineSoldBags = math.random(1, 3)

    elseif ketamine < 3 then 

      ketamineSoldBags = 1

     end



    local ketamineSoldPrice = math.floor(ketamineSoldBags * ketaminePricePerBag* currentMultipler) 

    exports['clrp_notify']:DoHudText('inform',  "Usted vendió " .. ketamineSoldBags .." Gram(s) Of Ketamine For $".. ketamineSoldPrice .." ")

    TriggerEvent("inventory:removeQty", 50, ketamineSoldBags)

    TriggerServerEvent('drug:addDirtyMoney', ketamineSoldPrice)

    TriggerServerEvent('addReputation', 2) 

elseif purro > 0 then                      ---- XZURV purro

    local purroSoldBags = math.random(1, purro)

    if rep >= 5000 and purro >= 9 then

      purroSoldBags = math.random(1, 9)

    elseif rep >= 4000 and purro >= 7 then

      purroSoldBags = math.random(1, 7)

    elseif rep >= 3000 and purro >= 6 then 

      purroSoldBags = math.random(1, 6)

    elseif rep >= 2000 and purro >= 5 then 

      purroSoldBags = math.random(1, 5)

    elseif rep >= 1000 and purro >= 4 then 

      purroSoldBags = math.random(1, 4)

    elseif rep < 1000 and purro >= 3 then 

      purroSoldBags = math.random(1, 3)

    elseif purro < 3 then 

      purroSoldBags = 1

     end



    local purroSoldPrice = math.floor(purroSoldBags * purroPricePerBag* currentMultipler) 

    exports['clrp_notify']:DoHudText('inform',  "Usted vendió " .. purroSoldBags .." Gram(s) Of purro For $".. purroSoldPrice .." ")

    TriggerEvent("inventory:removeQty", 123, purroSoldBags)

    TriggerServerEvent('drug:addDirtyMoney', purroSoldPrice)

    TriggerServerEvent('addReputation', 2) 

  elseif meth > 0 then                      ---- XZURV meth

    local methSoldBags = math.random(1, meth)

    if rep >= 5000 and meth >= 8 then

      methSoldBags = math.random(1, 8)

    elseif rep >= 4000 and meth >= 7 then 

      methSoldBags = math.random(1, 7)

    elseif rep >= 3000 and meth >= 6 then 

      methSoldBags = math.random(1, 6)

    elseif rep >= 2000 and meth >= 5 then 

      methSoldBags = math.random(1, 5)

    elseif rep >= 1000 and meth >= 4 then 

      methSoldBags = math.random(1, 4)

    elseif rep < 1000 and meth >= 3 then 

      methSoldBags = math.random(1, 3)

    elseif meth < 3 then 

      methSoldBags = 1

     end 



    local methSoldPrice = math.floor(methSoldBags * methPricePerBag* currentMultipler) 

    exports['clrp_notify']:DoHudText('inform',  "Usted vendió " .. methSoldBags .." Gram(s) Of Crystal Meth For $".. methSoldPrice .." ")

    TriggerEvent("inventory:removeQty", 157, methSoldBags)

    TriggerServerEvent('drug:addDirtyMoney', methSoldPrice)

    TriggerServerEvent('addReputation', 3) 



  elseif heroin > 0 then                      ---- XZURV heroin

    local heroinSoldBags = math.random(1, heroin)

    if rep >= 5000 and heroin >= 8 then

      heroinSoldBags = math.random(1, 8)

    elseif rep >= 4000 and heroin >= 6 then 

      heroinSoldBags = math.random(1, 6)

    elseif rep >= 3000 and heroin >= 5 then 

      heroinSoldBags = math.random(1, 5)

    elseif rep >= 2000 and heroin >= 4 then 

      heroinSoldBags = math.random(1, 4)

    elseif rep >= 1000 and heroin >= 3 then 

      heroinSoldBags = math.random(1, 3)

    elseif rep < 1000 and heroin >= 3 then 

      heroinSoldBags = math.random(1, 3)

    elseif heroin < 3 then 

      heroinSoldBags = 1

     end    

    local heroinSoldPrice = math.floor(heroinSoldBags * heroinPricePerBag* currentMultipler) 

    exports['clrp_notify']:DoHudText('inform',  "Usted vendió " .. heroinSoldBags .." Gram(s) Of Heroin For $".. heroinSoldPrice .." ")

    TriggerEvent("inventory:removeQty", 159, heroinSoldBags)

    TriggerServerEvent('drug:addDirtyMoney', heroinSoldPrice)

    TriggerServerEvent('addReputation', 3)



  elseif coke > 0 then 

    local cokeSoldBags = math.random(1, coke)

    if rep >= 5000 and coke >= 8 then

      cokeSoldBags = math.random(1, 8)

    elseif rep >= 4000 and coke >= 6 then 

      cokeSoldBags = math.random(1, 6)

    elseif rep >= 3000 and coke >= 5 then 

      cokeSoldBags = math.random(1, 5)

    elseif rep >= 2000 and coke >= 4 then 

      cokeSoldBags = math.random(1, 4)

    elseif rep >= 1000 and coke >= 3 then 

      cokeSoldBags = math.random(1, 3)

    elseif coke < 3 then 

      cokeSoldBags = 1 

     end   

    local cokeSoldPrice = math.floor(cokeSoldBags * cokePricePerBag * currentMultipler) 

    exports['clrp_notify']:DoHudText('inform',  "Usted vendió " .. cokeSoldBags .." Gram(s) Of Coke For $".. cokeSoldPrice .." ")

    TriggerEvent("inventory:removeQty", 110, cokeSoldBags)

    TriggerServerEvent('drug:addDirtyMoney', cokeSoldPrice)

    TriggerServerEvent('addReputation', 3)  

  end

end



RegisterNetEvent('hud:updatepresence')

AddEventHandler('hud:updatepresence', function(copss)

 currentPolice = copss

 if currentPolice == 0 then 

  currentMultipler = 0.8

 elseif currentPolice == 1 then 

  currentMultipler = 1.0

 elseif currentPolice == 2 then 

  currentMultipler = 1.1

 elseif currentPolice == 3 then 

  currentMultipler = 1.2

 elseif currentPolice == 4 then 

  currentMultipler = 1.3

 elseif currentPolice == 5 then

  currentMultipler = 1.4

 elseif currentPolice == 6 then

  currentMultipler = 1.5

elseif currentPolice >= 7 then

  currentMultipler = 1.8

 end 

end)






RegisterNetEvent("drugs:delivery")

AddEventHandler("drugs:delivery", function() 

    local pos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 10.0, 0.0)

    Citizen.CreateThread(function()

      local pilot, aircraft, crate

        local requiredModels = {"cuban800", "s_m_m_pilot_02", "prop_boxpile_06b"}



        for i = 1, #requiredModels do

            RequestModel(GetHashKey(requiredModels[i]))

            while not HasModelLoaded(GetHashKey(requiredModels[i])) do

                Wait(0)

            end

        end



        local rHeading = math.random(0, 360) + 0.0

        local planeSpawnDistance = (3000.0 and tonumber(3000.0) + 0.0) or 400.0

        local theta = (rHeading / 180.0) * 3.14

        local rPlaneSpawn = vector3(pos.x, pos.y, pos.z) - vector3(math.cos(theta) * planeSpawnDistance, math.sin(theta) * planeSpawnDistance, -500.0)

        

        local dx = pos.x - rPlaneSpawn.x

        local dy = pos.y - rPlaneSpawn.y

        local heading = GetHeadingFromVector_2d(dx, dy)



        aircraft = CreateVehicle(GetHashKey("cuban800"), rPlaneSpawn, heading, true, true)

        SetEntityHeading(aircraft, heading)

        SetVehicleDoorsLocked(aircraft, 2)

        SetEntityDynamic(aircraft, true)

        ActivatePhysics(aircraft)

        SetVehicleForwardSpeed(aircraft, 60.0)

        SetHeliBladesFullSpeed(aircraft)

        SetVehicleEngineOn(aircraft, true, true, false)

        ControlLandingGear(aircraft, 3) 

        OpenBombBayDoors(aircraft)

        SetEntityProofs(aircraft, true, false, true, false, false, false, false, false)



        pilot = CreatePedInsideVehicle(aircraft, 1, GetHashKey("s_m_m_pilot_02"), -1, true, true)

        SetBlockingOfNonTemporaryEvents(pilot, true) 

        SetPedRandomComponentVariation(pilot, false)

        SetPedKeepTask(pilot, true)

        SetPlaneMinHeightAboveTerrain(aircraft, 50) 

        

        TaskVehicleDriveToCoord(pilot, aircraft, vector3(pos.x, pos.y, pos.z) + vector3(0.0, 0.0, 150.0), 60.0, 0, GetHashKey("cuban800"), 262144, 15.0, -1.0)

        

        local droparea = vector2(pos.x, pos.y)

        local planeLocation = vector2(GetEntityCoords(aircraft).x, GetEntityCoords(aircraft).y)

        while not IsEntityDead(pilot) and #(planeLocation - droparea) > 5.0 do

            Wait(100)

            planeLocation = vector2(GetEntityCoords(aircraft).x, GetEntityCoords(aircraft).y) 

        end

        

        TaskVehicleDriveToCoord(pilot, aircraft, 0.0, 0.0, 500.0, 60.0, 0, GetHashKey("cuban800"), 262144, -1.0, -1.0) 

        SetEntityAsNoLongerNeeded(pilot) 

        SetEntityAsNoLongerNeeded(aircraft)



        local crateSpawn = vector3(pos.x, pos.y, GetEntityCoords(aircraft).z - 5.0)

        crate = CreateObject(GetHashKey("prop_boxpile_06b"), crateSpawn, true, true, true) 

        SetEntityLodDist(crate, 1000) 

        ActivatePhysics(crate)

        SetDamping(crate, 2, 0.1) 

        SetEntityVelocity(crate, 0.0, 0.0, -0.2)

        if DoesEntityExist(crate) then 

  		 Wait(15000)

         drugsDelivered(crate)

        end



        for i = 1, #requiredModels do

            Wait(0)

            SetModelAsNoLongerNeeded(GetHashKey(requiredModels[i]))

        end

     end)

end)



function drugsDelivered(prop)

  DeleteObject(prop)

  local plate = "xxsdrtghyuujhdjsjenenfjfjtjtjtj"

  if(plate == "xxsdrtghyuujhdjsjenenfjfjtjtjtj") then

   showLoadingPrompt("Enter Plate", 3)

   DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8S", "", "", "", "", "", 20)

   while (UpdateOnscreenKeyboard() == 0) do

    DisableAllControlActions(0);

    Wait(0);

   end

   if (GetOnscreenKeyboardResult()) then

    local option = tostring(GetOnscreenKeyboardResult())

    if(option ~= nil and option ~= 0) then

     plate = ""..option

    end

   end

  end

  stopLoadingPrompt()

  if (plate ~= "xxsdrtghyuujhdjsjenenfjfjtjtjtj") then

   TriggerServerEvent('drugs:addDrugs', plate)

  end

end





function Teleport(x,y,z)

  RequestCollisionAtCoord(x,y,z)



  while not HasCollisionLoadedAroundEntity(GetPlayerPed(-1)) do

    RequestCollisionAtCoord(x,y,z)

    Citizen.Wait(0)

  end



  SetEntityCoords(GetPlayerPed(-1), x,y,z)

end