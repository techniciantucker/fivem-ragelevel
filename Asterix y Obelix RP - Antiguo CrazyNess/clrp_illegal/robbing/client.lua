local targetInventory = nil
local targetMoney = nil
local targetPlayer = nil
local test = true
local isDragged = false 
local playerStillDragged = false
local currentPolice = 0


Citizen.CreateThread(function()
 while true do
  Wait(5)
  if currentPolice >= 0 then
   if IsControlJustPressed(0, 311) and not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
    local t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 5) then
     if DecorGetBool(GetPlayerPed(t), "Handsup") then
      local progress = exports['clrp-taskbar']:taskbar(5000, 'Searching Person')
      ExecuteCommand('me searches threw the persons pockets')
      if progress == 100 then
       if DecorGetBool(GetPlayerPed(t), "Handsup") then
        TriggerServerEvent('inventory:playerInventory', GetPlayerServerId(t))
       end
      end
     end
    end
   end
  else
   Citizen.Wait(2500)
  end
 end
end)

-- Citizen.CreateThread(function()
 -- WarMenu.CreateLongMenu('rob', 'Robbing')
 -- while true do
  -- Wait(5)
  -- if currentPolice >= 1 then 
   -- if IsControlJustPressed(0, 311) and not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
    -- local t, distance = GetClosestPlayer()
    -- if(distance ~= -1 and distance < 5) then
     -- if DecorGetBool(GetPlayerPed(t), "Handsup") then
      -- TriggerServerEvent('rob:getPlayerInventory', GetPlayerServerId(t))
     -- end
    -- end
   -- end
  -- end
  -- if WarMenu.IsMenuOpened('rob') then
   -- local inventory = targetInventory
   -- if WarMenu.Button('Money: ~g~$'..targetMoney) then 
    -- takeMoney(targetMoney)
   -- end
   -- for i = 1,#inventory do
    -- if (inventory[i].q > 0) then
     -- if WarMenu.Button(tostring(inventory[i].name), tonumber(inventory[i].q)) then
      -- takeItem(inventory[i].id, inventory[i].name, inventory[i].q)
     -- end
    -- end
   -- end
   -- WarMenu.Display()
  -- end
 -- end
-- end)

RegisterNetEvent('rob:inventory')
AddEventHandler('rob:inventory', function(inv, money, target)
 targetInventory = inv 
 targetMoney = money
 targetPlayer = target
 WarMenu.OpenMenu('rob')
end)

-- Nearest Players
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
            local distance = Vdist(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"])
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
    
    return closestPlayer, closestDistance
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

function takeItem(item, name, quantity)
 local amount = "xxsdrtghyuujhdjsjenenfjfjtjtjtj"
 if(amount == "xxsdrtghyuujhdjsjenenfjfjtjtjtj") then
  showLoadingPrompt("Enter Quantity", 3)
  DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8S", "", "", "", "", "", 20)
  while (UpdateOnscreenKeyboard() == 0) do
   DisableAllControlActions(0);
   Wait(0);
  end
  if (GetOnscreenKeyboardResult()) then
   local option = tonumber(GetOnscreenKeyboardResult())
   if(option ~= nil and option ~= 0) then
    amount = ""..option
   end
  end
 end
 stopLoadingPrompt()
 if (amount ~= "xxsdrtghyuujhdjsjenenfjfjtjtjtj" and tonumber(amount) > 0) then
  TriggerServerEvent('rob:takeItem', item, name, amount, targetPlayer)
 end
end

function takeMoney(cash)
 local amount = "xxsdrtghyuujhdjsjenenfjfjtjtjtj"
 if(amount == "xxsdrtghyuujhdjsjenenfjfjtjtjtj") then
  showLoadingPrompt("Enter Amount To Steal", 3)
  DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8S", "", "", "", "", "", 20)
  while (UpdateOnscreenKeyboard() == 0) do
   DisableAllControlActions(0);
   Wait(0);
  end
  if (GetOnscreenKeyboardResult()) then
   local option = tonumber(GetOnscreenKeyboardResult())
   if(option ~= nil and option ~= 0) then
    amount = ""..option
   end
  end
 end
 stopLoadingPrompt()
 if (amount ~= "xxsdrtghyuujhdjsjenenfjfjtjtjtj" and tonumber(amount) > 0) then
  if tonumber(cash) >= tonumber(amount) then
   TriggerServerEvent('rob:takeMoney', amount, targetPlayer)
  end
 end
end

-- Zip Ties
DecorRegister("isZiped", 2)
DecorSetBool(GetPlayerPed(-1), "isZiped", false)

RegisterCommand('ziptie', function(source, args, rawCommand)
 if exports['core']:GetItemQuantity(74) > 0 then 
  local t, distance = GetClosestPlayer()
  if(distance ~= -1 and distance < 5) then
   if DecorGetBool(GetPlayerPed(t), "Handsup") == 1 then
    TriggerServerEvent('robbery:cuff', GetPlayerServerId(t))
    TriggerEvent("inventory:removeQty", 74, 1)
   end
  end
 end
end)

RegisterCommand('cut', function(source, args, rawCommand)
 if exports['core']:GetItemQuantity(75) > 0 then 
  local t, distance = GetClosestPlayer()
  if(distance ~= -1 and distance < 5) then
   if DecorGetBool(GetPlayerPed(t), "isZiped") then
   	TriggerServerEvent('robbery:uncuff', GetPlayerServerId(t))
   end
  end
 end
end)

RegisterCommand('drag', function(source, args, rawCommand)
 local t, distance = GetClosestPlayer()
 if(distance ~= -1 and distance < 5) then
  if DecorGetBool(GetPlayerPed(t), "isZiped") then
   TriggerServerEvent('robbery:drag', GetPlayerServerId(t))
  end
 end
end)


RegisterNetEvent('robbery:drag')
AddEventHandler('robbery:drag', function(cop)
 if not IsPedInAnyVehicle(GetPlayerPed(-1)) and IsPedCuffed(GetPlayerPed(-1)) then
  isDragged = not isDragged
  ped = tonumber(cop)
 end
end)

RegisterNetEvent('robbery:cuff')
AddEventHandler('robbery:cuff', function()
 if not IsPedCuffed(GetPlayerPed(-1)) then
  SetEnableHandcuffs(PlayerPedId(), true)
  DecorSetBool(GetPlayerPed(-1), "isZiped", true) 
  Wait(600000)
  if IsPedCuffed(GetPlayerPed(-1)) then 
   SetEnableHandcuffs(PlayerPedId(), false)
   DecorSetBool(GetPlayerPed(-1), "isZiped", false) 
   ClearPedTasksImmediately(GetPlayerPed(-1))
   print('Zip Ties Broken')
  end
 end
end)

RegisterNetEvent('robbery:uncuff')
AddEventHandler('robbery:uncuff', function()
 if IsPedCuffed(GetPlayerPed(-1)) then
  SetEnableHandcuffs(PlayerPedId(), false)
  DecorSetBool(GetPlayerPed(-1), "isZiped", false) 
  ClearPedTasksImmediately(GetPlayerPed(-1))
 end
end)


Citizen.CreateThread(function()
 while true do
  Wait(5)
  if isDragged then
   local ped = GetPlayerPed(GetPlayerFromServerId(ped))
   local myped = GetPlayerPed(-1)
   AttachEntityToEntity(myped, ped, 4103, 11816, 0.48, 0.00, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
   playerStillDragged = true
  else
   if(playerStillDragged) then
    DetachEntity(GetPlayerPed(-1), true, false)
    playerStillDragged = false
   end
  end
 end
end)

Citizen.CreateThread(function() 
 while true do 
  Wait(0) 
  if DecorGetBool(PlayerPedId(), "isZiped") == 1 then 
   DisableControlAction(0, 69, true) -- INPUT_VEH_ATTACK
   DisableControlAction(0, 92, true) -- INPUT_VEH_PASSENGER_ATTACK
   DisableControlAction(0, 114, true) -- INPUT_VEH_FLY_ATTACK
   DisableControlAction(0, 140, true) -- INPUT_MELEE_ATTACK_LIGHT
   DisableControlAction(0, 141, true) -- INPUT_MELEE_ATTACK_HEAVY
   DisableControlAction(0, 142, true) -- INPUT_MELEE_ATTACK_ALTERNATE
   DisableControlAction(0, 257, true) -- INPUT_ATTACK2
   DisableControlAction(0, 263, true) -- INPUT_MELEE_ATTACK1
   DisableControlAction(0, 264, true) -- INPUT_MELEE_ATTACK2
   DisableControlAction(0, 24, true) -- INPUT_ATTACK
   DisableControlAction(0, 25, true) -- INPUT_AIM
   DisableControlAction(0, 23, true) -- INPUT_ENTER
   DisableControlAction(0, 75, true) -- INPUT_VEH_EXIT
  end
 end
end)

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(500)
  if not changed then
   local IsCuffed = IsPedCuffed(PlayerPedId()) 
   if IsCuffed and not IsEntityPlayingAnim(PlayerPedId(), "mp_arresting", "idle", 3) then
    Citizen.Wait(500)
    TaskPlayAnim(PlayerPedId(), "mp_arresting", "idle", 8.0, -8, -1, 49, 0, 0, 0, 0)
   end
  else
   changed = false
  end
 end
end)
