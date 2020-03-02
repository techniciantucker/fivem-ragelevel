local windows = 0

Citizen.CreateThread(function()
 WarMenu.CreateMenu('playermenu', 'Player Menu')
 WarMenu.CreateSubMenu('inventory', 'playermenu')
 WarMenu.CreateSubMenu('vehicle', 'playermenu')
 WarMenu.CreateSubMenu('other', 'playermenu')
 WarMenu.CreateSubMenu('settings', 'playermenu')
 WarMenu.CreateSubMenu('weapons', 'playermenu')
  WarMenu.CreateSubMenu('docs', 'playermenu')
 local currentItemIndex1 = 1
 local selectedItemIndex1 = 1
 local currentItemIndex2 = 1
 local selectedItemIndex2 = 1
 local hud = true 
 while true do
  Citizen.Wait(5)
  if WarMenu.IsMenuOpened('playermenu') then
   if WarMenu.Button('Phone') then
    TriggerEvent("phone:open")
    WarMenu.CloseMenu('playermenu')
   elseif WarMenu.Button('Inventario', getQuantity()..'/120') then
    WarMenu.OpenMenu('Inventory')
   elseif WarMenu.MenuButton('Weapons', 'weapons') then
   elseif WarMenu.MenuButton('Documents', 'docs') then   
   elseif WarMenu.Button('Animaciones') then
   	WarMenu.CloseMenu('playermenu')
   	TriggerEvent('animations:open')
   elseif WarMenu.MenuButton('Vehicle', 'vehicle') then
   elseif WarMenu.MenuButton('Other', 'other') then  	
   elseif WarMenu.MenuButton('Settings', 'settings') then
   end
   WarMenu.Display()
  -- Vehicle Actions
  elseif WarMenu.IsMenuOpened('vehicle') then
   if WarMenu.Button('Motor', Enginestatus()) then
    toggleEngine()
   elseif WarMenu.Button('Door Locks', Lockstatus()) then
   	TriggerEvent('garage:togglelocks')
   elseif WarMenu.Button('Underglow', Underglowstatus()) then
    toggleUnderglow()
   elseif WarMenu.Button('Ventanas', windowstatus()) then
    toggleWindows()
   elseif WarMenu.ComboBox('Doors', {'Front Left','Front Right','Back Left', 'Back Right', 'Trunk', 'Hood'}, currentItemIndex1, selectedItemIndex1, function(currentIndex1, selectedIndex1)
     currentItemIndex1 = currentIndex1
     selectedItemIndex1 = currentItemIndex1
    end) then
    if selectedItemIndex1 == 6 then
     toggleHood()
    elseif selectedItemIndex1 == 5 then
     toggleTrunk() 
    elseif selectedItemIndex1 == 4 then
     toggleBackRight()
    elseif selectedItemIndex1 == 3 then
     toggleBackLeft()
    elseif selectedItemIndex1 == 2 then
     toggleFrontRight()
    elseif selectedItemIndex1 == 1 then
     toggleFrontLeft()
    end
   elseif WarMenu.ComboBox('Switch Seat', {'Driver','Passenger','Left Rear', 'Right Rear'}, currentItemIndex2, selectedItemIndex2, function(currentIndex2, selectedIndex2)
     currentItemIndex2 = currentIndex2
     selectedItemIndex2 = currentItemIndex2
    end) then
    if selectedItemIndex2 == 4 then
     SetPedIntoVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1)), 2)
    elseif selectedItemIndex2 == 3 then
     SetPedIntoVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1)), 1)
    elseif selectedItemIndex2 == 2 then
     SetPedIntoVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1)), 0)
    elseif selectedItemIndex2 == 1 then
     SetPedIntoVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1)), -1)
    end
   elseif WarMenu.MenuButton('Back', 'playermenu') then
   end
   WarMenu.Display()
   -- Other Menu
  elseif WarMenu.IsMenuOpened('other') then
   if WarMenu.Button('Dar dinero') then
   	local t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
      local amount = getMoney()
      TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_PARKING_METER", 0, true)
      TriggerServerEvent('player:givemoney', GetPlayerServerId(t), amount)
      Wait(2600)
      ClearPedTasksImmediately(GetPlayerPed(-1))
    end
   elseif WarMenu.Button('Dar dinero sucio') then
    local t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
      local amount = getMoney()
      TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_PARKING_METER", 0, true)
      TriggerServerEvent('player:givedmoney', GetPlayerServerId(t), amount)
      Wait(2600)
      ClearPedTasksImmediately(GetPlayerPed(-1))
    end
   elseif WarMenu.Button('House Key') then
	  TriggerEvent("housing:keys")
    WarMenu.CloseMenu()
   elseif WarMenu.Button('Tu ID') then
    TriggerServerEvent('player:showid')
    WarMenu.CloseMenu()
   elseif WarMenu.Button('Toggle Mask') then
    TriggerEvent('clothing:togglemask')
   elseif WarMenu.Button('Toggle Glasses') then
    TriggerEvent('clothing:toggleglasses')
   elseif WarMenu.Button('Toggle Helmet') then
    TriggerEvent('clothing:togglehelmet')
   elseif WarMenu.MenuButton('Back', 'playermenu') then
   end
   WarMenu.Display()
   -- Setting's Menu
  elseif WarMenu.IsMenuOpened('settings') then
   if WarMenu.Button('Toggle HUD') then
    if hud then 
     TriggerEvent('hud:status', false)
    else
     TriggerEvent('hud:status', true)  
    end
    hud = not hud
   elseif WarMenu.Button('Toggle OOC') then
    TriggerEvent('chat:toggleooc')
   elseif WarMenu.MenuButton('Back', 'playermenu') then
   end
   WarMenu.Display()
  elseif WarMenu.IsMenuOpened('weapons') and not DecorGetBool(GetPlayerPed(-1), 'isInStorage') then
   for _,v in pairs(getWeapons()) do
    if WarMenu.ComboBox(v.label, {'Give'}, currentItemIndex2, selectedItemIndex2, function(currentIndex2, selectedIndex2)
     currentItemIndex2 = currentIndex2
     selectedItemIndex2 = currentItemIndex2
    end) then
    if selectedItemIndex2 == 1 then 
     local t, distance = GetClosestPlayer()
     if(distance ~= -1 and distance < 5) then
      RemoveWeaponFromPed(GetPlayerPed(-1), v.name)
      TriggerServerEvent('weapon:give', v.name, v.label, v.id, GetPlayerServerId(t))
      WarMenu.OpenMenu('weapons')
     end
    end
    end
   end
   WarMenu.Display()
   elseif WarMenu.IsMenuOpened('docs') then
    if WarMenu.Button('Show ID') then
     TriggerServerEvent('player:showid')
    elseif WarMenu.Button('Drivers License') then
     TriggerServerEvent('player:dmvl')
    elseif WarMenu.Button('Gun License') then
     TriggerServerEvent('player:gunL') 
    elseif WarMenu.Button('Fake IDs') then
     TriggerEvent('fakeids:openmenu')
     WarMenu.CloseMenu()
    end
   WarMenu.Display()
  end
  -- Open Player Menu
  if IsControlJustPressed(0, 20) and not IsPedCuffed(GetPlayerPed(-1)) then
   WarMenu.OpenMenu('playermenu')
  elseif IsDisabledControlPressed(1, 36) and IsDisabledControlJustPressed(1, 38) and IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then 
   toggleEngine()
  end
  if IsControlJustPressed(0, 47) then 
   TriggerEvent('garage:togglelocks')
  end
 end
end)

function getMoney()
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

--FMMC_KEY_TIP8
function GetResult()
 local amount = "xxsdrtghyuujhdjsjenenfjfjtjtjtj"
 showLoadingPrompt("Enter An Amount", 3)
 DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 6)
  while (UpdateOnscreenKeyboard() == 0) do
    DisableAllControlActions(0);
    Wait(0);
  end
  if (GetOnscreenKeyboardResult()) then
    local result = GetOnscreenKeyboardResult()
    stopLoadingPrompt()
    if(option ~= nil and option ~= 0) then
     amount = ""..option
     if (amount ~= "xxsdrtghyuujhdjsjenenfjfjtjtjtj" and tonumber(amount) > 0) then
      return tonumber(amount)
     end
    end
  end
end

function toggleEngine()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if vehicle ~= nil and vehicle ~= 0 and GetPedInVehicleSeat(vehicle, 0) then
        SetVehicleEngineOn(vehicle, (not GetIsVehicleEngineRunning(vehicle)), false, true)
    end
end

function Enginestatus()
 local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
 if GetIsVehicleEngineRunning(vehicle) == 1 then
  return '~g~Running'
 else
  return '~r~Off'
 end
end

function Lockstatus()
 local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
 local locked = GetVehicleDoorLockStatus(vehicle)
 if locked == 2 then
  return '~r~Locked'
 else
  return '~g~Unlocked'
 end
end

function toggleUnderglow()
 local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
 if IsVehicleNeonLightEnabled(vehicle, 0) then 
  SetVehicleNeonLightEnabled(vehicle, 0, false)
  SetVehicleNeonLightEnabled(vehicle, 1, false)
  SetVehicleNeonLightEnabled(vehicle, 2, false)
  SetVehicleNeonLightEnabled(vehicle, 3, false)
 else
  SetVehicleNeonLightEnabled(vehicle, 0, true)
  SetVehicleNeonLightEnabled(vehicle, 1, true)
  SetVehicleNeonLightEnabled(vehicle, 2, true)
  SetVehicleNeonLightEnabled(vehicle, 3, true)
 end
end

function Underglowstatus()
 local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
 if IsVehicleNeonLightEnabled(vehicle, 0) then 
  return '~g~On'
 else
  return '~r~Off'
 end
end

function toggleWindows()
 local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
 if windows == 0 then
  RollDownWindows(vehicle)
  windows = 1
 elseif windows == 1 then
  RollUpWindow(vehicle, 0)
  RollUpWindow(vehicle, 1)
  RollUpWindow(vehicle, 2)
  RollUpWindow(vehicle, 3)
  windows = 0
 end
end

function windowstatus()
 if windows == 0 then
  return '~g~Up'
 elseif windows == 1 then
  return '~r~Down'
 end
end

function toggleHood()
 local playerVeh = GetVehiclePedIsIn(GetPlayerPed(-1), true)
 if GetVehicleDoorAngleRatio(playerVeh, 4) > 0.0 then 
  SetVehicleDoorShut(playerVeh, 4, false)            
 else
  SetVehicleDoorOpen(playerVeh, 4, false)      
 end
end 

function toggleTrunk()
 local playerVeh = GetVehiclePedIsIn(GetPlayerPed(-1), true)
 if GetVehicleDoorAngleRatio(playerVeh, 5) > 0.0 then 
  SetVehicleDoorShut(playerVeh, 5, false)            
 else
  SetVehicleDoorOpen(playerVeh, 5, false)      
 end
end

function toggleBackLeft()
 local playerVeh = GetVehiclePedIsIn(GetPlayerPed(-1), true)
 if GetVehicleDoorAngleRatio(playerVeh, 2) > 0.0 then 
  SetVehicleDoorShut(playerVeh, 2, false)            
 else
  SetVehicleDoorOpen(playerVeh, 2, false)      
 end
end

function toggleBackRight()
 local playerVeh = GetVehiclePedIsIn(GetPlayerPed(-1), true)
 if GetVehicleDoorAngleRatio(playerVeh, 3) > 0.0 then 
  SetVehicleDoorShut(playerVeh, 3, false)            
 else
  SetVehicleDoorOpen(playerVeh, 3, false)      
 end
end

function toggleFrontLeft()
 local playerVeh = GetVehiclePedIsIn(GetPlayerPed(-1), true)
 if GetVehicleDoorAngleRatio(playerVeh, 0) > 0.0 then 
  SetVehicleDoorShut(playerVeh, 0, false)            
 else
  SetVehicleDoorOpen(playerVeh, 0, false)      
 end
end

function toggleFrontRight()
 local playerVeh = GetVehiclePedIsIn(GetPlayerPed(-1), true)
 if GetVehicleDoorAngleRatio(playerVeh, 1) > 0.0 then 
  SetVehicleDoorShut(playerVeh, 1, false)            
 else
  SetVehicleDoorOpen(playerVeh, 1, false)      
 end
end

RegisterNetEvent('sendProximityMessageNumber')
AddEventHandler('sendProximityMessageNumber', function(id, name, number)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
    exports.pNotify:SendNotification({text = name.."'s Numero de telefono: <font color='lightblue'>"..number, timeout = 25000, layout='bottomCenter'})
  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
    exports.pNotify:SendNotification({text = name.."'s Numero de telefono: <font color='lightblue'>"..number, timeout = 25000, layout='bottomCenter'})
  end
end)

-- RegisterNetEvent('player:showid')
-- AddEventHandler('player:showid', function(id, fullname, gender, dob, job)
  -- local myId = PlayerId()
  -- local pid = GetPlayerFromServerId(id)
  -- if pid == myId then
   -- TriggerEvent("fs_freemode:notify", 'CHAR_BLANK_ENTRY', 4, 2, "ID Card", false, 'Name: '..fullname..'~n~ DOB: '..dob..'~n~Gender: '..gender..'~n~Job: '..job..' ~n~License: C000') 
  -- elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
   -- TriggerEvent("fs_freemode:notify", 'CHAR_BLANK_ENTRY', 4, 2, "ID Card", false, 'Name: '..fullname..'~n~ DOB: '..dob..'~n~Gender: '..gender..'~n~Job: '..job..' ~n~License: C000') 
  -- end
-- end)

RegisterNetEvent('player:showid')
AddEventHandler('player:showid', function(id, fullname, gender, dob, job, cid)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
   TriggerEvent("fs_freemode:notify", 'CHAR_BLANK_ENTRY', 4, 2, "ID Card", false, 'Name: '..fullname..'~n~ DOB: '..dob..'~n~Gender: '..gender..'~n~Job: '..job..' ~n~License: C000'..cid..' ~n~ ~n~') 
  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
   TriggerEvent("fs_freemode:notify", 'CHAR_BLANK_ENTRY', 4, 2, "ID Card", false, 'Name: '..fullname..'~n~ DOB: '..dob..'~n~Gender: '..gender..'~n~Job: '..job..' ~n~License: C000'..cid..' ~n~ ~n~') 
  end
end)

RegisterNetEvent('player:showdmv')
AddEventHandler('player:showdmv', function(id, fullname, address, points, reg)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
   TriggerEvent("fs_freemode:notify", 'CHAR_PEGASUS_DELIVERY', 4, 2, "Drivers License", false, 'Name: '..fullname..'~n~ Address: '..address..'~n~Active Points: '..points..'~n~Date Registered: '..reg..' ~n~ ~n~') 
  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
   TriggerEvent("fs_freemode:notify", 'CHAR_PEGASUS_DELIVERY', 4, 2, "Drivers License", false, 'Name: '..fullname..'~n~ Address: '..address..'~n~Active Points: '..points..'~n~Date Registered: '..reg..' ~n~ ~n~') 
  end
end)

RegisterNetEvent('player:gunlicense')
AddEventHandler('player:gunlicense', function(id, fullname, reg, appointed)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
   TriggerEvent("fs_freemode:notify", 'CHAR_AMMUNATION', 4, 2, "Gun License", false, 'Name: '..fullname..'~n~Date Registered: '..reg..'~n~Granted By: '..appointed..' ~n~') 
  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
   TriggerEvent("fs_freemode:notify", 'CHAR_AMMUNATION', 4, 2, "Gun License", false, 'Name: '..fullname..'~n~Date Registered: '..reg..'~n~Granted By: '..appointed..' ~n~') 
  end
end)

RegisterNetEvent("fs_freemode:notify")
AddEventHandler("fs_freemode:notify", function(icon, type, color, sender, title, text)
  Citizen.InvokeNative(0x92F0DA1E27DB96DC, tonumber(color))
  SetNotificationTextEntry("STRING")
  AddTextComponentString(text)
  SetNotificationMessage(icon, icon, true, type, sender, title, text)
  DrawNotification(false, true)
end)

function GetPedMugshot(ped)
  local mugshot = RegisterPedheadshot(ped)
  while not IsPedheadshotReady(mugshot) do
    Citizen.Wait(0)
  end

  return mugshot, GetPedheadshotTxdString(mugshot)
end

function GetPlayers()
    local players = {}

    for i = 0, 256 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end

function GetClosestPlayer()
  local players = GetPlayers()
  local closestDistance = -1
  local closestPlayer = -1
  local ply = GetPlayerPed(-1)
  local plyCoords = GetEntityCoords(ply, 0)
  
  for index,value in ipairs(players) do
    local target = GetPlayerPed(value)
    if(target ~= ply) then
      local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
      local distance = GetDistanceBetweenCoords(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
      if(closestDistance == -1 or closestDistance > distance) then
        closestPlayer = value
        closestDistance = distance
      end
    end
  end
  
  return closestPlayer, closestDistance
end

function showLoadingPrompt(showText, showType)
    Citizen.CreateThread(function()
        Citizen.Wait(0)
        N_0xaba17d7ce615adbf("STRING") -- set type
        AddTextComponentString(showText) -- sets the text
        N_0xbd12f8228410d9b4(showType) -- show promt (types = 3)
    end)
end

function stopLoadingPrompt()
    Citizen.CreateThread(function()
        Citizen.Wait(0)
        N_0x10d373323e5b9c0d()
    end)
end