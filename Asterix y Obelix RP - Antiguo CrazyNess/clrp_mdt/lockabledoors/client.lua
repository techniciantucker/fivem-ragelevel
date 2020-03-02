local nearObject = false 
local isNearObject = false
local objectLoc = {}
local clostestProp = nil
local doorList = {
 [1] = { ["obj"] = "v_ilev_ph_gendoor004", ["x"] = 449.69815063477, ["y"] = -986.46911621094, ["z"] = 30.689594268799, ["locked"] = true},
 [2] = { ["obj"] = "v_ilev_arm_secdoor", ["x"] = 452.61877441406, ["y"] = -982.7021484375, ["z"] = 30.689598083496, ["locked"] = true},
 [3] = { ["obj"] = "v_ilev_ph_gendoor002", ["x"] = 447.23818969727, ["y"] = -980.63006591797, ["z"] = 30.689598083496, ["locked"] = true},
 [4] = { ["obj"] = "v_ilev_ph_gendoor005", ["x"] = 443.97, ["y"] = -989.033, ["z"] = 30.6896, ["locked"] = true},
 [5] = { ["obj"] = "v_ilev_ph_gendoor005", ["x"] = 445.37, ["y"] = -988.705, ["z"] = 30.6896, ["locked"] = true},
 [6] = { ["obj"] = "v_ilev_ph_cellgate", ["x"] = 462.151, ["y"] = -1002.363, ["z"] = 24.915, ["locked"] = true},
 [7] = { ["obj"] = "v_ilev_ph_cellgate", ["x"] = 462.146, ["y"] = -998.773, ["z"] = 24.915, ["locked"] = true},
 [8] = { ["obj"] = "v_ilev_ph_cellgate", ["x"] = 462.262, ["y"] = -994.420, ["z"] = 24.915, ["locked"] = true},
 [9] = { ["obj"] = "v_ilev_ph_cellgate", ["x"] = 464.356, ["y"] = -993.120, ["z"] = 24.915, ["locked"] = true},
 [10] = { ["obj"] = "v_ilev_gtdoor", ["x"] = 464.126, ["y"] = -1002.78, ["z"] = 24.9149, ["locked"] = true},
 [11] = { ["obj"] = "v_ilev_gtdoor", ["x"] = 464.18, ["y"] = -1004.31, ["z"] = 24.9152, ["locked"] = true},
 [12] = { ["obj"] = "v_ilev_gtdoor02", ["x"] = 465.467, ["y"] = -983.446, ["z"] = 43.6918, ["locked"] = true},
 [13] = { ["obj"] = "v_ilev_gtdoor02", ["x"] = 462.979, ["y"] = -984.163, ["z"] = 43.6919, ["locked"] = true},
 [14] = { ["obj"] = "v_ilev_gtdoor", ["x"] = 464.274, ["y"] = -1003.624, ["z"] = 24.915, ["locked"] = true},
 [25] = { ["obj"] = "v_ilev_rc_door2", ["x"] = 468.089, ["y"] = -1014.470, ["z"] = 26.386, ["locked"] = true},
 [26] = { ["obj"] = "v_ilev_rc_door2", ["x"] = 469.216, ["y"] = -1014.541, ["z"] = 26.386, ["locked"] = true},
 [27] = { ["obj"] = "hei_prop_station_gate", ["x"] = 488.927, ["y"] = -1020.020, ["z"] = 95.082, ["locked"] = true},
 -- Paleto & Sandy Shores
 [15] = { ["obj"] = "prop_ld_jail_door", ["x"] = 1844.308, ["y"] = 3682.194, ["z"] = -118.227, ["locked"] = true},
 [16] = { ["obj"] = "prop_ld_jail_door", ["x"] = 1839.846, ["y"] = 3679.854, ["z"] = -118.227, ["locked"] = true},
 [17] = { ["obj"] = "prop_ld_jail_door", ["x"] = 1835.651, ["y"] = 3677.252, ["z"] = -118.227, ["locked"] = true},
 [18] = { ["obj"] = "prop_ld_jail_door", ["x"] = -439.784, ["y"] = 6005.499, ["z"] = -118.761, ["locked"] = true},
 [19] = { ["obj"] = "prop_ld_jail_door", ["x"] = -436.146, ["y"] = 6001.814, ["z"] = -118.761, ["locked"] = true},
 [20] = { ["obj"] = "prop_ld_jail_door", ["x"] = -432.589, ["y"] = 5998.325, ["z"] = -118.761, ["locked"] = true},
 [21] = { ["obj"] = "v_ilev_cd_entrydoor", ["x"] = -440.338, ["y"] = 6008.994, ["z"] = -118.762, ["locked"] = true},
 [22] = { ["obj"] = "v_ilev_cd_entrydoor", ["x"] = 1847.624, ["y"] = 3681.653, ["z"] = -118.762, ["locked"] = true},
 [23] = { ["obj"] = "v_ilev_ct_door03", ["x"] = 1832.872, ["y"] = 3673.053, ["z"] = -118.762, ["locked"] = true},
 [24] = { ["obj"] = "v_ilev_ct_door03", ["x"] = -428.287, ["y"] = 5997.221, ["z"] = -118.762, ["locked"] = true},
 -- Vinewood PF
 [28] = { ["obj"] = "xm_prop_iaa_base_door_01", ["x"] = 2050.999, ["y"] = 2964.209, ["z"] = -67.302, ["locked"] = true},
 [29] = { ["obj"] = "xm_prop_iaa_base_door_01", ["x"] = 2055.101, ["y"] = 2969.914, ["z"] = -67.302, ["locked"] = true},
 [30] = { ["obj"] = "xm_prop_iaa_base_door_01", ["x"] = 2055.117, ["y"] = 2981.144, ["z"] = -67.302, ["locked"] = true},
 [31] = { ["obj"] = "xm_prop_iaa_base_door_01", ["x"] = 2051.054, ["y"] = 2975.374, ["z"] = -67.302, ["locked"] = true},
 [32] = { ["obj"] = "xm_prop_iaa_base_door_01", ["x"] = 2061.030, ["y"] = 2984.562, ["z"] = -67.301, ["locked"] = true},
 [33] = { ["obj"] = "xm_prop_iaa_base_door_01", ["x"] = 2062.071, ["y"] = 2983.855, ["z"] = -67.301, ["locked"] = true},
 [34] = { ["obj"] = "xm_prop_iaa_base_door_02", ["x"] = 2047.359, ["y"] = 2969.699, ["z"] = -67.302, ["locked"] = true},
 [35] = { ["obj"] = "xm_prop_iaa_base_door_02", ["x"] = 2047.861, ["y"] = 2970.682, ["z"] = -67.302, ["locked"] = true},
 [36] = { ["obj"] = "xm_prop_iaa_base_door_02", ["x"] = 2060.357, ["y"] = 2977.538, ["z"] = -67.302, ["locked"] = true},
 [37] = { ["obj"] = "xm_prop_iaa_base_door_02", ["x"] = 2061.123, ["y"] = 2978.610, ["z"] = -67.302, ["locked"] = true},
 }

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(200)
  nearObject = false
  isNearObject = false   
  local myCoords = GetEntityCoords(GetPlayerPed(-1))
  if not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
   for i = 1, #doorList do
    if(GetDistanceBetweenCoords(myCoords, doorList[i]["x"], doorList[i]["y"], doorList[i]["z"], true) < 2.0) then
     clostestProp = GetClosestObjectOfType(myCoords.x, myCoords.y, myCoords.z, 3.5, GetHashKey(doorList[i]["obj"]), false, false)
     if clostestProp ~= nil and clostestProp ~= 0 then
      local coords = GetEntityCoords(clostestProp)
      isNearObject = true
      objectLoc = {['x'] = coords.x, ['y'] = coords.y, ['z'] = coords.z, ['locked'] = doorList[i]["locked"], id = i, object = clostestProp}
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
    if DecorGetInt(GetPlayerPed(-1), "Job") == 1 or DecorGetInt(GetPlayerPed(-1), "Job") == 2 then 
     if objectLoc.locked then 
      drawTxt("~b~Presiona ~g~E~b~ para abrir") 
     else 
      drawTxt("~b~Presiona ~g~E~b~ para cerrar") 
     end
    else 
     if objectLoc.locked then 
      drawTxt("~b~Presiona ~g~E~b~ para intentar cerrar") 
     end
    end
    FreezeEntityPosition(objectLoc.object, objectLoc.locked)
    if IsControlJustPressed(0, 38) then
     playLockAnimation()
     if DecorGetInt(GetPlayerPed(-1), "Job") == 1 or DecorGetInt(GetPlayerPed(-1), "Job") == 2 then 
      if objectLoc.locked then
       FreezeEntityPosition(objectLoc.object, false)
       if objectLoc.id == 10 or objectLoc.id == 11 then
        TriggerServerEvent('doorLock:LockDoor', 10, false)
        TriggerServerEvent('doorLock:LockDoor', 11, false)
     elseif objectLoc.id == 12 or objectLoc.id == 13 then
        TriggerServerEvent('doorLock:LockDoor', 12, false)
        TriggerServerEvent('doorLock:LockDoor', 13, false)
     else
        TriggerServerEvent('doorLock:LockDoor', objectLoc.id, false)
     end
      else
       FreezeEntityPosition(objectLoc.object, true)
       if objectLoc.id == 10 or objectLoc.id == 11 then
        TriggerServerEvent('doorLock:LockDoor', 10, true)
        TriggerServerEvent('doorLock:LockDoor', 11, true)
       elseif objectLoc.id == 12 or objectLoc.id == 13 then
        TriggerServerEvent('doorLock:LockDoor', 12, true)
        TriggerServerEvent('doorLock:LockDoor', 13, true)
       else
        TriggerServerEvent('doorLock:LockDoor', objectLoc.id, true)
       end
      end
     else 
      if exports['core']:GetItemQuantity(7) > 0 and not IsPedCuffed(GetPlayerPed(-1)) then
       ExecuteCommand('me is attempting to lockpick the cell door')
       TriggerEvent("inventory:removeQty", 7, 1)
       if math.random(1,10) > 6 then 
        ExecuteCommand('me has successfully lockpicked the cell door')
        FreezeEntityPosition(objectLoc.object, false)
        if objectLoc.id == 10 or objectLoc.id == 11 then
         TriggerServerEvent('doorLock:LockDoor', 10, false)
         TriggerServerEvent('doorLock:LockDoor', 11, false)
        elseif objectLoc.id == 12 or objectLoc.id == 13 then
         TriggerServerEvent('doorLock:LockDoor', 12, false)
         TriggerServerEvent('doorLock:LockDoor', 13, false)
        else
         TriggerServerEvent('doorLock:LockDoor', objectLoc.id, false)
        end
       else 
        ExecuteCommand('me has failed to lockpick the cell door')
       end 
      else
       TriggerEvent('chatMessage', '^1Necesitas la llave')
      end
     end
    end
   end
  end
 end
end)

RegisterNetEvent('doorLock:LockDoor')
AddEventHandler('doorLock:LockDoor', function(door, bool)
 doorList[door]["locked"] = bool
end)

RegisterNetEvent('doorLock:doors')
AddEventHandler('doorLock:doors', function(doors)
 doorList = doors
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