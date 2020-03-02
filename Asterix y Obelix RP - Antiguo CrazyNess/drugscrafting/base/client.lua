local inGUI = false
local recipies = {
    [2] = {id = 2, name = "Bars of Cocaine", amount = 4, requirements = "1 x Brick of Cocaine, 1 x Smelly Proof Baggy, 1 x Stanley Knife, 1 x Cooking Scales", rep = 6000},
    [1] = {id = 1, name = "Oz's of Cocaine", amount = 9, requirements = "1 x Bar of Cocaine, 1 x Bundle of Baggies, 1 x Stanley Knife, 1 x Digital Scales", rep = 5000},
    --[3] = {id = 3, name = "Gram's of Cocaine", amount = 28, requirements = "1 x Oz of Cocaine, 1 x Bundle of Baggies, 1 x Digital Scales", rep = 500},
    --[4] = {id = 4, name = "Gram's of Cocaine", amount = 28, requirements = "1 x Oz of Cocaine, 1 x Bundle of Baggies, 1 x Digital Scales", rep = 500},

}

function EnableGui(enable, chars)
    SetNuiFocus(enable, enable)
    guiEnabled = enable
    inGUI = true
    SendNUIMessage({type = "enableui",  enable = enable, characters = chars})
end 

RegisterNetEvent("crafting:loadrecipiesballas")
AddEventHandler("crafting:loadrecipiesballas", function()
 local html = ''
 local rep = DecorGetInt(GetPlayerPed(-1), "Reputation")
 local ballas = DecorGetInt(GetPlayerPed(-1), "Faction") == 1 or DecorGetInt(GetPlayerPed(-1), "Faction") == 23
 if rep < 0 then
  rep = 0
 end
 for id,v in pairs(recipies) do  
   if rep >= v.rep and ballas then
   local char = string.format('<div class="character" id="%s"><p>%s<span class="date">Crafts: %s</span></p><p>%s</p></div>', v.id, v.name, v.amount, tostring(v.requirements))
   html = html..char
   end
 end
 EnableGui(true, html)
end)
-- NUI Callback Events
RegisterNUICallback('selectrecipe', function(data, cb)
  EnableGui(false,false)
  cb('ok')
    TriggerEvent("mythic_progbar:client:progress", {
        name = "crafting_coke",
        duration = 10000,
        label = "Cutting Down Coke",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
    }, function(status)
        if not status then
          TriggerEvent('craftingballas:trigger:'..data.id)
          inGUI = false
        end
    end)
end)

RegisterNUICallback('escape', function(data, cb)
  _GuiEnabled = false
  SetNuiFocus(false, false)
  SendNUIMessage({open = false})
  inGUI = false
end)

--[[Citizen.CreateThread(function()
  while true do
   Wait(10)   -- STAGE ONE --
  if DecorGetInt(GetPlayerPed(-1), "Faction") == 1 or DecorGetInt(GetPlayerPed(-1), "Faction") == 23 then 
   if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1461.98669, -535.15955, 68.154, true) < 0.5 and not inGUI then
    DrawText3Ds(-1461.98669, -535.15955, 68.154,"~p~[E]~w~ Cut Coke Down")
    if IsControlJustPressed(0, 38) then          --- aprtment
     TriggerEvent('crafting:loadrecipiesballas')
    end
   end
   if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1450.109, -525.85955, 69.556, true) < 0.5 then
    DrawText3Ds(-1450.109, -525.85955, 69.556,"~p~[E]~w~ Ground Floor")
    if IsControlJustPressed(0, 38) then          --- aprtment
     Teleport(-1447.46, -537.623 , 34.74)
    end
   end
   if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1447.46, -537.623 , 34.74, true) < 0.5 then
    DrawText3Ds(-1447.46, -537.623 , 34.74,"~p~[E]~w~ Apartment")
    if IsControlJustPressed(0, 38) then    
     Teleport(-1450.109, -525.85955, 69.556)
    end
   end
   end 
  end
end)
]]--
---------------------------------((((((STAGE TWO))))))
local lock = true
local open = false
Citizen.CreateThread(function()
  while true do
    Wait(10)
  if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1450.109, -525.85955, 69.556, true) < 0.5 then
    DrawText3Ds(-1450.109, -525.85955, 69.556,"~p~[E]~w~ Take Lift To Ground Floor")
    if IsControlJustPressed(0, 38) then    
     Teleport(-1447.46, -537.623 , 34.74)
    end
  end
  if DecorGetInt(GetPlayerPed(-1), "Faction") == 1 or DecorGetInt(GetPlayerPed(-1), "Faction") == 23 then 
   if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1461.98669, -535.15955, 68.154, true) < 0.5 and not inGUI then
    DrawText3Ds(-1461.98669, -535.15955, 68.154,"~p~[E]~w~ Cut Coke Down")
    if IsControlJustPressed(0, 38) then          --- aprtment
     TriggerEvent('crafting:loadrecipiesballas')
    end
   end
  end
  if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1447.46, -537.623 , 34.74, true) < 0.5 then
    if lock == true and DecorGetInt(GetPlayerPed(-1), "Faction") == 1 and DecorGetInt(GetPlayerPed(-1), "Job") == 30 then 
      DrawText3Ds(-1447.46, -537.623 , 34.74,"~p~[E]~w~ Call Lift To Ground Level") 
    elseif lock == false and DecorGetInt(GetPlayerPed(-1), "Faction") == 1 and DecorGetInt(GetPlayerPed(-1), "Job") == 30 then 
      DrawText3Ds(-1447.46, -537.623 , 34.74,"~p~[E]~w~ Send Lift Back To Apartment")
    end  
      if IsControlJustPressed(0, 38) then
        if lock == true then
         lock = false
         open = true
         playLockAnimation()
        else
         playLockAnimation()
         lock = true
         open = false
        end
      end  
    if open == true then 
      DrawText3Ds(-1447.46, -537.623 , 34.74+0.1,"~p~[H]~w~ Take Lift To Apartment")
      if IsControlJustPressed(0, 74) then   
        Teleport(-1450.109, -525.85955, 69.556)
      end
    end
   end   
  end 
end)

function playLockAnimation()
  RequestAnimDict('missheistfbisetup1')
  while not HasAnimDictLoaded('missheistfbisetup1') do
   Citizen.Wait(10)
  end
  TaskPlayAnim(PlayerPedId(), "missheistfbisetup1", "unlock_enter_janitor", 8.0, 8.0, -1, 50, 0, false, false, false)
  Wait(2000)
  ClearPedTasks(PlayerPedId())
end

---------------------------------((((((STAGE TWO))))))
function Teleport(x,y,z)
  Wait(100)
  RequestCollisionAtCoord(x,y,z)
  while not HasCollisionLoadedAroundEntity(GetPlayerPed(-1)) do 
    RequestCollisionAtCoord(x,y,z)
    Citizen.Wait(0)
  end
  SetEntityCoords(GetPlayerPed(-1), x,y,z)
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



