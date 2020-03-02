local nearObject = false 
local isNearObject = false
local objectLoc = {}
local clostestProp = nil
local doorListClub = {
 [1] = { ["obj"] = "ba_prop_door_club_entrance", ["x"] = -1607.449, ["y"] = -3006.301, ["z"] = -79.006, ["locked"] = true},
 [2] = { ["obj"] = "ba_prop_door_club_generic_vip", ["x"] = -1607.250, ["y"] = -3006.058, ["z"] = -75.205, ["locked"] = true},
}

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(200)
  nearObject = false
  isNearObject = false   
  local myCoords = GetEntityCoords(GetPlayerPed(-1))
  if not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
   for i = 1, #doorListClub do
    if(GetDistanceBetweenCoords(myCoords, doorListClub[i]["x"], doorListClub[i]["y"], doorListClub[i]["z"], true) < 2.0) then
     clostestProp = GetClosestObjectOfType(myCoords.x, myCoords.y, myCoords.z, 3.5, GetHashKey(doorListClub[i]["obj"]), false, false)
     if clostestProp ~= nil and clostestProp ~= 0 then
      local coords = GetEntityCoords(clostestProp)
      isNearObject = true
      objectLoc = {['x'] = coords.x, ['y'] = coords.y, ['z'] = coords.z, ['locked'] = doorListClub[i]["locked"], id = i, object = clostestProp}
     end
    end
   end
  else 
   Wait(2500)
  end
 end
end)

Citizen.CreateThread(function()
 while true do
  Wait(5)
  if isNearObject then 
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), objectLoc.x, objectLoc.y, objectLoc.z, true) < 1.3) then
    if DecorGetInt(GetPlayerPed(-1), "Job") == 25 or DecorGetInt(GetPlayerPed(-1), "Job") == 1 then 
     if objectLoc.locked then 
      drawTxt("~b~Press ~g~E~b~ To Unlock Door") 
     else 
      drawTxt("~b~Press ~g~E~b~ To Lock Door") 
     end
    else 
     if objectLoc.locked then 
      drawTxt("~b~Press ~g~E~b~ To Attempt To Lockpick Door") 
     end
    end
    FreezeEntityPosition(objectLoc.object, objectLoc.locked)
    if IsControlJustPressed(0, 38) then
     playLockAnimation()
     if DecorGetInt(GetPlayerPed(-1), "Job") == 25 or DecorGetInt(GetPlayerPed(-1), "Job") == 1 then 
      if objectLoc.locked then
       FreezeEntityPosition(objectLoc.object, false)
       if objectLoc.id == 10 or objectLoc.id == 11 then
        TriggerServerEvent('doorLockclub:LockDoor', 10, false)
        TriggerServerEvent('doorLockclub:LockDoor', 11, false)
     elseif objectLoc.id == 12 or objectLoc.id == 13 then
        TriggerServerEvent('doorLockclub:LockDoor', 12, false)
        TriggerServerEvent('doorLockclub:LockDoor', 13, false)
     else
        TriggerServerEvent('doorLockclub:LockDoor', objectLoc.id, false)
     end
      else
       FreezeEntityPosition(objectLoc.object, true)
       if objectLoc.id == 10 or objectLoc.id == 11 then
        TriggerServerEvent('doorLockclub:LockDoor', 10, true)
        TriggerServerEvent('doorLockclub:LockDoor', 11, true)
       elseif objectLoc.id == 12 or objectLoc.id == 13 then
        TriggerServerEvent('doorLockclub:LockDoor', 12, true)
        TriggerServerEvent('doorLockclub:LockDoor', 13, true)
       else
        TriggerServerEvent('doorLockclub:LockDoor', objectLoc.id, true)
       end
      end
     else 
      if exports['core']:GetItemQuantity(7) > 0 and not IsPedCuffed(GetPlayerPed(-1)) then
       ExecuteCommand('me ha fallado el bloqueo de la puerta')
       TriggerEvent("inventory:removeQty", 7, 1)
       if math.random(1,10) > 6 then 
        ExecuteCommand('me ha fallado el bloqueo de la puerta')
        FreezeEntityPosition(objectLoc.object, false)
        if objectLoc.id == 10 or objectLoc.id == 11 then
         TriggerServerEvent('doorLockclub:LockDoor', 10, false)
         TriggerServerEvent('doorLockclub:LockDoor', 11, false)
        elseif objectLoc.id == 12 or objectLoc.id == 13 then
         TriggerServerEvent('doorLockclub:LockDoor', 12, false)
         TriggerServerEvent('doorLockclub:LockDoor', 13, false)
        else
         TriggerServerEvent('doorLockclub:LockDoor', objectLoc.id, false)
        end
       else 
        ExecuteCommand('me ha fallado el bloqueo de la puerta de la celda')
       end 
      else
       TriggerEvent('chatMessage', '^1Requieres un Lockpick')
      end
     end
    end
   end
  end
 end
end)

RegisterNetEvent('doorLockclub:LockDoor')
AddEventHandler('doorLockclub:LockDoor', function(door, bool)
 doorListClub[door]["locked"] = bool
end)

RegisterNetEvent('doorLockclub:doors')
AddEventHandler('doorLockclub:doors', function(doors)
 doorListClub = doors
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

function playLockAnimation()
 RequestAnimDict('missheistfbisetup1')
 while not HasAnimDictLoaded('missheistfbisetup1') do
  Citizen.Wait(10)
 end
 TaskPlayAnim(PlayerPedId(), "missheistfbisetup1", "unlock_enter_janitor", 8.0, 8.0, -1, 50, 0, false, false, false)
 Wait(2000)
 ClearPedTasks(PlayerPedId())
end