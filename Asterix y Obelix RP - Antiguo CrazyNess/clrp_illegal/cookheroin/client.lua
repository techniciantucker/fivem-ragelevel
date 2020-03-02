local stealTimer = false
local creationStage = 0



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
  local factor = (string.len(text)) / 370
  --DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

function LoadAnim(animDict)
  RequestAnimDict(animDict)

  while not HasAnimDictLoaded(animDict) do
    Citizen.Wait(10)
  end
end



Citizen.CreateThread(function ()
 while true do
  Citizen.Wait(5)
  local coords = GetEntityCoords(GetPlayerPed(-1))
   if (GetDistanceBetweenCoords(coords, -108.901, -7.241, 70.520-0.95, true) > 50.0) and creationStage > 0 then
   	exports.pNotify:SendNotification({text = "You left it out on the table and a crackhead took it you dickhead!."})
   	creationStage = 0
   end
   if(GetDistanceBetweenCoords(coords, -108.901, -7.241, 70.520-0.95, true) < 5.0) and creationStage == 0 then
    --DrawMarker(27, -108.901, -7.241, 70.520-0.95, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 0, 82, 165, 240, 0, 0, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(coords, -108.901, -7.241, 70.520-0.95, true) < 1.5) then
      DrawText3Ds( -108.901, -7.241, 70.520, '~g~[E]~c~ ~c~Start Heroin Cook')
     if IsControlJustPressed(0, 38) then
   	  if exports['core']:GetItemQuantity(275) >= 10 and exports['core']:GetItemQuantity(276) >= 10 and exports['core']:GetItemQuantity(179) >= 5 and exports['core']:GetItemQuantity(112) >= 1 then
        exports.pNotify:SendNotification({text = "unpacking ingredients."})
        TriggerEvent("mythic_progbar:client:progress", {
          name = "unpacking",
          duration = 25000,
          label = "unpacking ingredients",
          useWhileDead = false,
          canCancel = false,
          controlDisables = {
              disableMovement = true,
              disableCarMovement = true,
              disableMouse = false,
              disableCombat = true,
          },
          animation = {
              animDict = "missheistdockssetup1clipboard@idle_a",
              anim = "idle_a",
              flags = 49,
          },
          prop = {
              model = "",
          }
      }, function(status)
          if not status then
            exports['mythic_notify']:DoHudText('inform', 'Unpacked ingredients!')
          end
      end)
   	   creationStage = 1
        TriggerEvent("inventory:removeQty", 179, 5)
        TriggerEvent("inventory:removeQty", 275, 10)
   	   TriggerEvent("inventory:removeQty", 276, 10)
   	  else
   	   exports.pNotify:SendNotification({text = "You must have 10x Opium, 10x Diacetylmorphine, some kitchen scales and 5x shrink wrap!"})
   	  end
   	 end
   	end
   end
   if(GetDistanceBetweenCoords(coords,  -110.986, -6.382, 70.520-0.95, true) < 5.0) and creationStage == 1 then
    --DrawMarker(27, -110.986, -6.382, 70.520-0.95, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 0, 82, 165, 240, 0, 0, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(coords, -110.986, -6.382, 70.520-0.95, true) < 1.5) then
      DrawText3Ds( -110.986, -6.382, 70.520, '~g~[E]~c~ ~c~start cooking')
     if IsControlJustPressed(0, 38) then
      TriggerEvent("mythic_progbar:client:progress", {
        name = "cooking",
        duration = 25000,
        label = "cooking",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "missheistdockssetup1clipboard@idle_a",
            anim = "idle_a",
            flags = 49,
        },
        prop = {
            model = "",
        }
    }, function(status)
        if not status then
          exports['mythic_notify']:DoHudText('inform', 'cooked ingredients')
        end
    end)
      creationStage = 2
     end
    end
   end
   if(GetDistanceBetweenCoords(coords, -112.192, -7.853, 70.520-0.95, true) < 5.0) and creationStage == 2 then
    --DrawMarker(27, -112.192, -7.853, 70.520-0.95, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 0, 82, 165, 240, 0, 0, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(coords, -112.192, -7.853, 70.520-0.95, true) < 1.5) then
      DrawText3Ds( -112.192, -7.853, 70.520,'~g~[E]~c~ ~c~to seal up the packs')
     if IsControlJustPressed(0, 38) then
      --API_ProgressBar("Shrink wrapping Oz's", 250)
      TriggerEvent("mythic_progbar:client:progress", {
        name = "Unpacking",
        duration = 25000,
        label = "wrapping bars",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "missheistdockssetup1clipboard@idle_a",
            anim = "idle_a",
            flags = 49,
        },
        prop = {
            model = "prop_paper_bag_small",
        }
    }, function(status)
        if not status then
          exports['mythic_notify']:DoHudText('inform', 'Wrapped Up 4x Bars Of H')
        end
    end)      
      if math.random(1, 100) >= 50 then
       TriggerServerEvent('addReputation', 10)
       TriggerEvent("inventory:addQty", 162, 4)
       --exports.pNotify:SendNotification({text = "You've weighed and bagged 36 oz's"})
       creationStage = 0
      else
       TriggerEvent("inventory:addQty", 162, 4)
       --exports.pNotify:SendNotification({text = "You've weighed and bagged 36 oz's"})
       creationStage = 0
     end
    end
   end
  end
 end
end)

