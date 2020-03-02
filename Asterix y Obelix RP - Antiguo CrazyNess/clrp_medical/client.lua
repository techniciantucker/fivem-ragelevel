local bloodLevel = 2000
local bloodLoss = 0.00
local currentWounds = 0
local allWeapons = {
 {hash = "WEAPON_HEAVYPISTOL", damageMultiplier = 0.35, woundMultipler = 1, ragdollSetting = 0}, 
 {hash = "WEAPON_STUNGUN", damageMultiplier = 0.0, woundMultipler = 1, ragdollSetting = 0},
 {hash = "WEAPON_NIGHTSTICK", damageMultiplier = 0.0, woundMultipler = 1, ragdollSetting = 0},
 {hash = "WEAPON_PUMPSHOTGUN", damageMultiplier = 0.80, woundMultipler = math.random(3,8), ragdollSetting = 2},
 {hash = "WEAPON_CARBINERIFLE", damageMultiplier = 1.45, woundMultipler = 1, ragdollSetting = 3},
 {hash = "WEAPON_MICROSMG", damageMultiplier = 0.55, woundMultipler = 1, ragdollSetting = 0},
 {hash = "WEAPON_COMBATPDW", damageMultiplier = 0.75, woundMultipler = 1, ragdollSetting = 0},
 {hash = "WEAPON_FLASHLIGHT", damageMultiplier = 0.0, woundMultipler = 1, ragdollSetting = 0},
 {hash = "WEAPON_FIREEXTINGUISHER", damageMultiplier = 0.0, woundMultipler = 1, ragdollSetting = 0},
 {hash = "WEAPON_PETROLCAN", damageMultiplier = 0.05, woundMultipler = 1, ragdollSetting = 0},
 {hash = "WEAPON_BZGAS", damageMultiplier = 0.05, woundMultipler = 1, ragdollSetting = 0},
 {hash = "WEAPON_FLARE", damageMultiplier = 0.0, woundMultipler = 1, ragdollSetting = 0},
 {hash = "WEAPON_ASSAULTSMG", damageMultiplier = 0.65, woundMultipler = 1, ragdollSetting = 0},
 {hash = "WEAPON_SPECIALCARBINE", damageMultiplier = 0.80, woundMultipler = 1, ragdollSetting = 0},
 {hash = "WEAPON_ASSAULTSHOTGUN", damageMultiplier = 0.55, woundMultipler = math.random(5,8), ragdollSetting = 2},
 {hash = "WEAPON_KNIFE", damageMultiplier = 0.20, woundMultipler = 1, ragdollSetting = 0},
 {hash = "WEAPON_BAT", damageMultiplier = 0.0, woundMultipler = 1, ragdollSetting = 0},
 {hash = "WEAPON_CROWBAR", damageMultiplier = 0.10, woundMultipler = 1, ragdollSetting = 0},
 {hash = "WEAPON_GOLFCLUB", damageMultiplier = 0.0, woundMultipler = 1, ragdollSetting = 0},
 {hash = "WEAPON_DAGGER", damageMultiplier = 0.25, woundMultipler = 1, ragdollSetting = 0},
 {hash = "WEAPON_KNUCKLE", damageMultiplier = 0.05, woundMultipler = 1, ragdollSetting = 0},
 {hash = "WEAPON_MACHETE", damageMultiplier = 0.30, woundMultipler = 1, ragdollSetting = 0},
 {hash = "WEAPON_WRENCH", damageMultiplier = 0.0, woundMultipler = 1, ragdollSetting = 0},
 {hash = "WEAPON_PISTOL", damageMultiplier = 0.35, woundMultipler = 1, ragdollSetting = 0},
 {hash = "WEAPON_SNSPISTOL", damageMultiplier = 0.25, woundMultipler = 1, ragdollSetting = 0},
 {hash = "WEAPON_COMBATPISTOL", damageMultiplier = 0.45, woundMultipler = 1, ragdollSetting = 0},
 {hash = "WEAPON_HEAVYPISTOL", damageMultiplier = 0.55, woundMultipler = 1, ragdollSetting = 0},
 {hash = "WEAPON_PISTOL50", damageMultiplier = 0.55, woundMultipler = 1, ragdollSetting = 0},
 {hash = "WEAPON_SWITCHBLADE", damageMultiplier = 0.25, woundMultipler = 1, ragdollSetting = 0},
 {hash = "WEAPON_REVOLVER", damageMultiplier = 0.35, woundMultipler = 1, ragdollSetting = 0},
 {hash = "WEAPON_MARKSMANPISTOL", damageMultiplier = 0.20, woundMultipler = 1, ragdollSetting = 0},
 {hash = "WEAPON_SAWNOFFSHOTGUN", damageMultiplier = 0.60, woundMultipler = math.random(2,4), ragdollSetting = 3},
 {hash = "WEAPON_COMPACTRIFLE", damageMultiplier = 0.55, woundMultipler = 1, ragdollSetting = 0},
 {hash = "WEAPON_ADVANCEDRIFLE", damageMultiplier = 0.85, woundMultipler = 1, ragdollSetting = 0},
 {hash = "WEAPON_SMG", damageMultiplier = 0.64, woundMultipler = 1, ragdollSetting = 0},
 {hash = "WEAPON_BULLPUPRIFLE", damageMultiplier = 0.44, woundMultipler = 1, ragdollSetting = 0},
 {hash = "WEAPON_MACHINEPISTOL", damageMultiplier = 0.45, woundMultipler = 1, ragdollSetting = 0},
 {hash = "WEAPON_APPISTOL", damageMultiplier = 0.45, woundMultipler = 1, ragdollSetting = 0},
 {hash = "WEAPON_MINISMG", damageMultiplier = 0.60, woundMultipler = 1, ragdollSetting = 0},
 {hash = "WEAPON_MICROSMG", damageMultiplier = 0.60, woundMultipler = 1, ragdollSetting = 0},
 {hash = "WEAPON_MG", damageMultiplier = 1.90, woundMultipler = 1, ragdollSetting = 0},
 {hash = "WEAPON_BATTLEAXE", damageMultiplier = 0.35, woundMultipler = 1, ragdollSetting = 0},
 {hash = "WEAPON_POOLCUE", damageMultiplier = 0.0, woundMultipler = 1, ragdollSetting = 0},
 {hash = "WEAPON_BALL", damageMultiplier = 0.0, woundMultipler = 1, ragdollSetting = 0},
 {hash = "WEAPON_DBSHOTGUN", damageMultiplier = 0.95, woundMultipler = math.random(4,8), ragdollSetting = 3},
 {hash = "WEAPON_GUSENBERG", damageMultiplier = 0.55, woundMultipler = 1, ragdollSetting = 0},
 {hash = "WEAPON_ASSAULTRIFLE_MK2", damageMultiplier = 0.55, woundMultipler = 1, ragdollSetting = 0},
 {hash = "WEAPON_CARBINERIFLE_MK2", damageMultiplier = 0.85, woundMultipler = 1, ragdollSetting = 0},
 {hash = "WEAPON_COMBATMG_MK2", damageMultiplier = 0.85, woundMultipler = 1, ragdollSetting = 0},
 {hash = "WEAPON_MUSKET", damageMultiplier = 2.75, woundMultipler = 1, ragdollSetting = 2},
 {hash = "WEAPON_SNIPERRIFLE", damageMultiplier = 5.95, woundMultipler = 1, ragdollSetting = 3},
 {hash = "WEAPON_HEAVYSNIPER", damageMultiplier = 8.92, woundMultipler = 1, ragdollSetting = 3},
 {hash = "WEAPON_PISTOL_MK2", damageMultiplier = 0.35, woundMultipler = 1, ragdollSetting = 0},
 {hash = "WEAPON_SMG_MK2", damageMultiplier = 0.35, woundMultipler = 1, ragdollSetting = 0},
 {hash = "WEAPON_FALL", damageMultiplier = 0.07, woundMultipler = 1, ragdollSetting = 0},
 {hash = "WEAPON_RUN_OVER_BY_CAR", damageMultiplier = 0.07, woundMultipler = 1, ragdollSetting = 0},
 {hash = "WEAPON_FIRE", damageMultiplier = 0.15, woundMultipler = 1, ragdollSetting = 0},
 {hash = "WEAPON_COUGAR", damageMultiplier = 0.25, woundMultipler = 1, ragdollSetting = 0},
}

Citizen.CreateThread(function()
 while true do
  local ped = GetPlayerPed(-1)
  Citizen.Wait(5)
  -- Defining Blood Loss 
  for i,v in ipairs(allWeapons) do
   if HasEntityBeenDamagedByWeapon(ped, GetHashKey(v.hash), 0) then
    if GetPedArmour(ped) == 0 then 
     local weaponRange = getWeaponRange(GetHashKey(v.hash)) or 1.0
     local bloodLossMultipler = v.damageMultiplier * v.woundMultipler * weaponRange
     bloodLoss = bloodLoss + bloodLossMultipler
     currentWounds = currentWounds + v.woundMultipler

     if v.ragdollSetting == 0 then -- Default Damage
	    ShakeGameplayCam('JOLT_SHAKE', 1.50)
      if math.random(1, 100) >= 50 then 
       SetPedToRagdoll(ped, 250, 2500, 3 , true, true, false)
      end
     elseif v.ragdollSetting == 1 then -- Small Damage
      SetPedToRagdoll(ped, 550, 2500, 2 , true, true, false)
      ShakeGameplayCam('JOLT_SHAKE', 1.75)
     elseif v.ragdollSetting == 2 then -- Medium Damage
      SetPedToRagdoll(ped, 4550, 2500, 0 , true, true, false)
      ShakeGameplayCam('JOLT_SHAKE', 2.00)
     elseif v.ragdollSetting == 3 then -- Large Damage
      SetPedToRagdoll(ped, 7250, 2500, 0 , true, true, false)
      ShakeGameplayCam('JOLT_SHAKE', 2.25)
     end

     local hit, bone = GetPedLastDamageBone(ped)
     if bone == 31086 then
      if not HasEntityBeenDamagedByWeapon(ped, GetHashKey('WEAPON_FALL'), 0) then
       TriggerEvent('chatMessage', "^1Has recibido un golpe crítico en la cabeza")
	   TriggerEvent('chatMessage', "", {30, 144, 255}, "^1Has recibido un golpe crítico en la cabeza")
       local headShotMultipler = 7.50 * v.woundMultipler * weaponRange
       bloodLoss = bloodLoss + headShotMultipler
       SetPedToRagdoll(ped, 8500, 14000, 0, true, true, false) 
       ShakeGameplayCam('JOLT_SHAKE', 5.00)
      end
     end

     ClearEntityLastDamageEntity(ped)
     Wait(50)
    end
   end
  end
 end
end) 

Citizen.CreateThread(function()
 while true do
  local ped = GetPlayerPed(-1)
  Citizen.Wait(0)

  -- Lossing Blood
  if not IsEntityDead(ped) then 
   if bloodLoss > 0.00 then
    bloodLevel = GetEntityHealth(ped)
    Wait(50)
    if bloodLevel > 0 and not stopBleeding then 
     bloodLevel = bloodLevel-bloodLoss
     SetEntityHealth(PlayerPedId(), round(bloodLevel, 0))
     Wait(200)
    end
   end
  else
   Citizen.Wait(2500)
  end
 end
end) 

Citizen.CreateThread(function()
 while true do
  local ped = GetPlayerPed(-1)
  Citizen.Wait(250)
  -- Effects
  if bloodLoss > 0.00 and not stopBleeding then 
   if bloodLevel > 750 and bloodLevel < 1150 then 
    RequestAnimSet("move_m@injured")
    while not HasAnimSetLoaded("move_m@injured") do 
     Citizen.Wait(0) 
    end
    SetPedMovementClipset(ped, "move_m@injured", true)
   elseif bloodLevel > 450 and bloodLevel < 750 then 
    ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.05)
    StartScreenEffect('DeathFailMPDark', 0, true)
   elseif bloodLevel > 10 and bloodLevel < 450 then 
    ShakeGameplayCam('DEATH_FAIL_IN_EFFECT_SHAKE', 0.25)
   elseif bloodLevel < 10 then 
    StopAllScreenEffects()
    StopGameplayCamShaking(true)
    SetEntityHealth(ped, 0)
    bloodLevel = 0 
   end 
   if IsEntityDead(ped) then 
    bloodLevel = 0 
   end
  end
 end
end) 

Citizen.CreateThread(function()
 while true do
  local ped = GetPlayerPed(-1)
  Citizen.Wait(5)
  -- Stop Blood When In Ambulance
  if bloodLoss > 0.00 and bloodLevel > 0 then
   if IsPedInAnyVehicle(ped, false) then
    local vehicle = GetVehiclePedIsIn(ped, false)
    if GetVehicleClass(vehicle) == 18 then
     if GetPedInVehicleSeat(vehicle, -1) ~= ped and GetPedInVehicleSeat(vehicle, 0) ~= ped then 
      stopBleeding = true 
     end
    end
   elseif not IsPedInAnyPoliceVehicle(ped) and stopBleeding then 
    stopBleeding = false
   end
  else 
   Citizen.Wait(500)
  end 
 end
end) 

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(15000)
  -- Rise Blood Level When Not Cut
  if bloodLoss < 0.10 and bloodLevel < 1250 and bloodLevel > 100 then
   bloodLevel = bloodLevel+math.random(1,75)
  end 
 end
end) 



-- Commands & Items 
RegisterNetEvent('ems:revive')
AddEventHandler('ems:revive', function()
 SetPlayerInvincible(GetPlayerPed(-1), false)
 NetworkResurrectLocalPlayer(GetEntityCoords(GetPlayerPed(-1)), true, true, false)
 ResetPedMovementClipset(GetPlayerPed(-1), true) 
 -- New System 
 bloodLevel = 1000
 currentWounds = currentWounds/2
 local newBloodLoss = round(bloodLoss/2, 2)
 bloodLoss = bloodLoss-newBloodLoss
 if bloodLoss <= 0.00 then 
  bloodLoss = 0.00
 end
end)

RegisterNetEvent('ems:heal')
AddEventHandler('ems:heal', function()
 --exports.pNotify:SendNotification({text = "Has sido sanado"})
 exports['clrp_notify']:DoLongHudText('success', 'Has sido sanado')
 TriggerEvent('hud:varibles', {thirst = 100, hunger = 100})
 StopAllScreenEffects()
 ClearPedBloodDamage(GetPlayerPed(-1))
 ResetPedMovementClipset(GetPlayerPed(-1), true)
 -- New System 
 bloodLevel = 2000
 currentWounds = 0
 bloodLoss = 0.00
 SetEntityHealth(PlayerPedId(), 2000)
end)

local online_ems = 0
local online_cops = 0

RegisterNetEvent('hud:updatepresence')
AddEventHandler('hud:updatepresence', function(copss, emss)
 online_ems = emss
 online_cops = copss
end)

RegisterNetEvent('ems:medkit')
AddEventHandler('ems:medkit', function()
 local t, distance = GetClosestPlayer()
 if(distance ~= -1 and distance < 5) then 
  if online_ems == 0 and online_cops <= 3 then 
   TaskStartScenarioInPlace(GetPlayerPed(-1), 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
   Citizen.Wait(30000)
   ClearPedTasks(GetPlayerPed(-1))
   TriggerServerEvent('ems:revive', GetPlayerServerId(t))
  else 
   TriggerEvent('chatMessage', "La policía está en línea, los botiquines están desactivados")
  end
 else
  TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_BUM_WASH", 0, true)
  Wait(5000)
  ClearPedTasks(GetPlayerPed(-1))
  bloodLevel = 1000
  currentWounds = currentWounds-currentWounds/2
  local newBloodLoss = round(bloodLoss/currentWounds, 2)
  bloodLoss = bloodLoss-newBloodLoss
 end
end)

RegisterNetEvent('ems:bandage')
AddEventHandler('ems:bandage', function()
 local t, distance = GetClosestPlayer()
 if(distance ~= -1 and distance < 5) then 
  TaskStartScenarioInPlace(GetPlayerPed(-1), 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
  Citizen.Wait(30000)
  ClearPedTasks(GetPlayerPed(-1))
  TriggerServerEvent('ems:Usedbandage', GetPlayerServerId(t))
 else
  TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_BUM_WASH", 0, true)
  Wait(2500)
  ClearPedTasks(GetPlayerPed(-1))
  if currentWounds > 0 then
   local newBloodLoss = round(bloodLoss/currentWounds, 2)
   currentWounds = currentWounds-1
   if bloodLoss-newBloodLoss < 0 then 
    bloodLoss = 0.00
   else 
    bloodLoss = bloodLoss-newBloodLoss
   end
  end
 end
end)

RegisterNetEvent('ems:Usedbandage')
AddEventHandler('ems:Usedbandage', function()
 if currentWounds > 0 then
  local newBloodLoss = round(bloodLoss/currentWounds, 2)
  currentWounds = currentWounds-1
  if bloodLoss-newBloodLoss < 0 then 
   bloodLoss = 0.00
  else 
   bloodLoss = bloodLoss-newBloodLoss
  end
 end
end)


-------------------------------------------------------------------------
------------------------------ Heal Items -------------------------------
-------------------------------------------------------------------------
RegisterCommand('bandage', function(source, args, rawCommand)
 local times = tonumber(args[1])

 if DecorGetBool(GetPlayerPed(-1), "isInService") then
  local t, distance = GetClosestPlayer()
  if distance ~= -1 and distance < 4 then
   if exports['core']:GetItemQuantity(10) > 0 then
    TriggerEvent("inventory:removeQty", 10, 1)
    TaskStartScenarioInPlace(GetPlayerPed(-1), 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
    Wait(2000)
    ClearPedTasks(GetPlayerPed(-1))
    for i=1, times do
     TriggerServerEvent('ems:Usedbandage', GetPlayerServerId(t))
    end
   end
  end
 end
end)

RegisterCommand('bloodbag', function(source, args, rawCommand)
 if DecorGetBool(GetPlayerPed(-1), "isInService") then
  local t, distance = GetClosestPlayer()
  if distance ~= -1 and distance < 4 then
   if exports['core']:GetItemQuantity(59) > 0 then
    TriggerEvent("inventory:removeQty", 59, 1)
    TaskStartScenarioInPlace(GetPlayerPed(-1), 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
    Wait(2000)
    ClearPedTasks(GetPlayerPed(-1))
    TriggerServerEvent('ems:setBlood', GetPlayerServerId(t), 2500)
   end
  end
 end
end)

RegisterNetEvent('ems:setBlood')
AddEventHandler('ems:setBlood', function(newLevel)
 bloodLevel = newLevel
 SetEntityHealth(GetPlayerPed(-1), newLevel)
end)

local bleedingTypes = {
	[1] = "Sangrado ligero",
 	[2] = "Sangrado moderado",
	[3] = "Sangrado abundante",
	[4] = "Sangrado Muy Pesado",
}

-- RegisterCommand('showMedical', function(source, args, rawCommand)
--  if currentWounds <= 0 then
--   ExecuteCommand('me shows no signs of injury')
--  elseif currentWounds <= 4 then
--   ExecuteCommand('me shows signs of '..bleedingTypes[1])
--  elseif currentWounds <= 7 then
--   ExecuteCommand('me shows signs of '..bleedingTypes[1])
--  elseif currentWounds <= 11 then
--   ExecuteCommand('me shows signs of '..bleedingTypes[2])
--  elseif currentWounds <= 14 then
--   ExecuteCommand('me shows signs of '..bleedingTypes[2])
--  elseif currentWounds <= 18 then
--   ExecuteCommand('me shows signs of '..bleedingTypes[3])
--  elseif currentWounds >= 18 then
--   ExecuteCommand('me shows signs of '..bleedingTypes[4])
--  end
-- end)

RegisterNetEvent('medical:showMedical')
AddEventHandler('medical:showMedical', function(newLevel)
 if currentWounds <= 0 then
  ExecuteCommand('me shows no signs of injury')
 elseif currentWounds <= 4 then
  ExecuteCommand('me shows signs of '..bleedingTypes[1]..', they will need '..currentWounds..' bandages')
 elseif currentWounds <= 7 then
  ExecuteCommand('me shows signs of '..bleedingTypes[1]..', they will need '..currentWounds..' bandages')
 elseif currentWounds <= 11 then
  ExecuteCommand('me shows signs of '..bleedingTypes[2]..', they will need '..currentWounds..' bandages')
 elseif currentWounds <= 14 then
  ExecuteCommand('me shows signs of '..bleedingTypes[2]..', they will need '..currentWounds..' bandages')
 elseif currentWounds <= 18 then
  ExecuteCommand('me shows signs of '..bleedingTypes[3]..', they will need '..currentWounds..' bandages')
 elseif currentWounds >= 18 then
  ExecuteCommand('me shows signs of '..bleedingTypes[4]..', they will need '..currentWounds..' bandages')
 end
end)

-------------------------------------------------------------------------
------------------------------ Heal Items -------------------------------
-------------------------------------------------------------------------
local checkedPlayers = {}

function getWeaponRange(lastWeapon)
 local foundShooter = false
 checkedPlayers = {}
 for i=1, 256 do 
  if not foundShooter then 
   local t, distance = getTargetPlayer()
   if distance ~= -1 then
    if IsPedArmed(GetPlayerPed(t), 7) then
     if GetSelectedPedWeapon(GetPlayerPed(t)) == lastWeapon then
      local vicCoords = GetEntityCoords(GetPlayerPed(-1), true)
      local shooterCoords = GetEntityCoords(GetPlayerPed(t), true)
      local shooterDistance = GetDistanceBetweenCoords(vicCoords, shooterCoords, true)
      foundShooter = true 
      if shooterDistance <= 3.5 then 
       return 4.0 
      elseif shooterDistance >= 3.5 and shooterDistance <= 8.0 then 
       return 3.0 
      elseif shooterDistance >= 8.0 and shooterDistance <= 16.0 then 
       return 2.0
      elseif shooterDistance >= 16.0 then
       return 1.0
      end
     end
    end
   end
  end
 end 
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
            local distance = Vdist(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"])
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
    
    return closestPlayer, closestDistance
end


function getTargetPlayer()
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
            if(closestDistance == -1) and not checkedPlayers[target] then
                closestPlayer = value
                closestDistance = distance
                checkedPlayers[target] = true
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

-------------------------------------------------------------------------
------------------------------ Heal Points ------------------------------
-------------------------------------------------------------------------
function DrawText3DTest(x,y,z, text)
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
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

local healpoints = {
 {x= -449.67, y= -340.83, z= 33.50, showblip = true},
 {x= 1156.74, y= -1529.11, z= 33.8434, showblip = true},
 {x= -247.01, y= 6331.45, z= 31.4262, showblip = true},
 {x= 1826.98, y= 3693.34, z= 34.2243, showblip = true},
 {x= 340.278, y= -1396.029, z= 32.509, showblip = true},
 {x = 308.036, y = -594.812, z = 42.3, showblip = false},
}

local blackMarketDoctors = { 
 {x = 104.658, y = -1976.016, z = 20.959},  
 {x = 1541.388, y = 3596.068, z = 35.453},  
 {x = -454.735, y = 6197.384, z = 29.553}, 
}

Citizen.CreateThread(function()
 while true do
  Wait(5)
  for _,v in pairs(healpoints) do
   if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 25 then
    if v.showblip then DrawMarker(27, v.x, v.y, v.z, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 0, 155, 255, 200, 0, 0, 0, 0) end
    if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x,v.y,v.z, true) < 1.4 then
    -- drawTxt("~b~Pulse ~g~E~b~ Para obtener tratamiento [~g~$150~b~]")
	 --DrawText3DTest("GO GO GO!." )
	 DrawText3DTest(306.993, -595.159, 43.284, "~g~[E]~b~ Para obtener tratamiento." )
     if IsControlJustPressed(1,38) then
      if IsEntityDead(GetPlayerPed(-1)) then 
       TriggerEvent('ems:revive')
      end
      local healTime = 2000 + bloodLoss + currentWounds - bloodLevel
      bloodLoss = 0.0
	  local finished = exports["clrp-taskbar"]:taskBar(1700,"Obteniendo tratamiento")	  
      if finished == 100 then

       if DecorGetBool(GetPlayerPed(-1), "isInService") then 
        TriggerServerEvent('ems:payHeal', 0) 
       else 
        TriggerServerEvent('ems:payHeal', 150) 
		 DoScreenFadeOut(1000)
         SetEntityCoords(GetPlayerPed(-1), 318.203, -583.908, 43.284)
         Citizen.Wait(5000)
         ExecuteCommand('bed')
         Citizen.Wait(5000)
         DoScreenFadeIn(1000)		
       end
      end
     end
    end
   end 
  end
 end
end)
-- Citizen.CreateThread(function()
 -- while true do
  -- Wait(5)
  -- for _,v in pairs(healpoints) do
   -- if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 25 then
    -- if v.showblip then DrawMarker(27, v.x, v.y, v.z, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 0, 155, 255, 200, 0, 0, 0, 0) end
    -- if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x,v.y,v.z, true) < 1.4 then
     -- drawTxt("~b~Pulse ~g~E~b~ Para obtener tratamiento [~g~$150~b~]")
     -- if IsControlJustPressed(1,38) then
      -- if IsEntityDead(GetPlayerPed(-1)) then 
       -- TriggerEvent('ems:revive')
      -- end
      -- local healTime = 2000 + bloodLoss + currentWounds - bloodLevel
      -- bloodLoss = 0.0
      -- if ProgressBar('Receiving Treatment', healTime/4) then
       -- if DecorGetBool(GetPlayerPed(-1), "isInService") then 
        -- TriggerServerEvent('ems:payHeal', 0) 
       -- else 
        -- TriggerServerEvent('ems:payHeal', 150) 
       -- end
      -- end
     -- end
    -- end
   -- end 
  -- end
 -- end
-- end)

Citizen.CreateThread(function()
 while true do
  Wait(5)
  for _,v in pairs(blackMarketDoctors) do
   if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 25 then
    DrawMarker(27, v.x, v.y, v.z-0.95, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 55, 55, 230, 0, 0, 0, 0)
    if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x,v.y,v.z, true) < 1.4 then
     drawTxt("~b~Pulse ~g~E~b~ Para obtener tratamiento [~g~$500~b~]")
     if IsControlJustPressed(1,38) then
      if IsEntityDead(GetPlayerPed(-1)) then 
       TriggerEvent('ems:revive')
      end
      local healTime = 2000 + bloodLoss + currentWounds - bloodLevel
      bloodLoss = 0.0
      if ProgressBar('Receiving Treatment', healTime/4) then
       TriggerServerEvent('ems:payHeal', 500) 
      end
     end
    end
   end 
  end
 end
end)


-------------------------------------------------------------------------
------------------------------ Needed Shit ------------------------------
-------------------------------------------------------------------------
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

local progress_time = 0.20
local progress_bar = false
local progress_bar_duration = 20
local progress_bar_text = ''

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(progress_bar_duration)
  if(progress_time > 0)then
   progress_time = progress_time - 0.002
  end
 end
end)

function ProgressBar(text, time)
 progress_bar_text = text
 progress_bar_duration = time
 progress_time = 0.20
 progress_bar = true
 while progress_bar do
  Citizen.Wait(0)
  DrawRect(0.50, 0.90, 0.20, 0.05, 0, 0, 0, 100)
  drawUI(0.910, 1.375, 1.0, 1.0, 0.55, progress_bar_text, 255, 255, 255, 255, false)
  if progress_time > 0 then
   DrawRect(0.50, 0.90, 0.20-progress_time, 0.05, 75, 156, 237, 225)
  elseif progress_time < 1 and progress_bar then 
   progress_bar = false
   return true
  end
 end
end

-- Medical Statistics HUD
Citizen.CreateThread(function()
 while true do
  Citizen.Wait(5)
  if IsControlJustPressed(0, 19) then
   drawStasttics = not drawStasttics
  end 
  if drawStasttics then 
   DrawRect(0.9200, 0.5000, 0.1435, 0.150, 40, 40, 40, 220) 
   drawUI(1.3875, 0.925, 1.0, 1.0, 0.42, "~r~Estadísticas medicas", 255, 255, 255, 255, false)
   drawUI(1.355, 0.955, 1.0, 1.0, 0.42, "~g~Nivel sangre                                 ~w~"..round(bloodLevel, 0), 255, 255, 255, 255, false)
   drawUI(1.355, 0.985, 1.0, 1.0, 0.42, "~g~Pérdida sangre                               ~w~"..round(bloodLoss, 2), 255, 255, 255, 255, false)
   drawUI(1.355, 1.015, 1.0, 1.0, 0.42, "~g~Heridas abiertas                              ~w~"..currentWounds, 255, 255, 255, 255, false)
  end
 end
end) 

function drawUI(x,y ,width,height,scale, text, r,g,b,a, center)
 SetTextFont(4)
 SetTextProportional(0)
 SetTextScale(scale, scale)
 SetTextColour(r, g, b, a)
 SetTextDropShadow(0, 0, 0, 0,255)
 SetTextEdge(2, 0, 0, 0, 255)
 SetTextDropShadow()
 SetTextOutline()
 SetTextEntry("STRING")
 AddTextComponentString(text)
 DrawText(x - width/2, y - height/2 + 0.005)
end

function round(num, idp)
  if idp and idp>0 then
    local mult = 10^idp
    return math.floor(num * mult + 0.5) / mult
  end
  return math.floor(num + 0.5)
end
-------------------------------------------------------------------------
------------------------------ Heal Items -------------------------------
-------------------------------------------------------------------------
local checkedPlayers = {}

function getWeaponRange(lastWeapon)
 local foundShooter = false
 checkedPlayers = {}
 for i=1, 32 do
  if not foundShooter then
   local t, distance = getTargetPlayer()
   if distance ~= -1 then
    if IsPedArmed(GetPlayerPed(t), 7) then
     if GetSelectedPedWeapon(GetPlayerPed(t)) == lastWeapon then
      local vicCoords = GetEntityCoords(GetPlayerPed(-1), true)
      local shooterCoords = GetEntityCoords(GetPlayerPed(t), true)
      local shooterDistance = GetDistanceBetweenCoords(vicCoords, shooterCoords, true)
      foundShooter = true
      if shooterDistance <= 3.5 then
       return 4.0
      elseif shooterDistance >= 3.5 and shooterDistance <= 8.0 then
       return 3.0
      elseif shooterDistance >= 8.0 and shooterDistance <= 16.0 then
       return 2.0
      elseif shooterDistance >= 16.0 then
       return 1.0
      end
     end
    end
   end
  end
 end
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
            local distance = Vdist(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"])
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end

    return closestPlayer, closestDistance
end


function getTargetPlayer()
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
            if(closestDistance == -1) and not checkedPlayers[target] then
                closestPlayer = value
                closestDistance = distance
                checkedPlayers[target] = true
            end
        end
    end

    return closestPlayer, closestDistance
end

function GetPlayers()
    local players = {}

    for i = 0, 63 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end

-------------------------------------------------------------------------
------------------------------ Needed Shit ------------------------------
-------------------------------------------------------------------------

------------------------------------------------------------


RegisterNetEvent('hospital:setBed')
AddEventHandler('hospital:setBed', function(hospital, id, pos)
 DoScreenFadeOut(200)

 local bedHashes = {1631638868, -1091386327, -1182962909, 1631638868, 2117668672, -335052794, -884387580, 1937985747, -1284191201, -1211387925, -980185685}
 local bed = nil

 for k,v in ipairs(bedHashes) do
  bed = GetClosestObjectOfType(pos.x, pos.y, pos.z, 2.0, v, false, false, false)
  if bed ~= 0 then
   break
  end
 end

 if bed ~= nil and DoesEntityExist(bed) then
  TriggerEvent('medical:stopBleeding')

  FreezeEntityPosition(PlayerPedId(), true)
  SetEntityHealth(PlayerPedId(), 1000)
  RequestAnimDict('dead')
  local bedCoords = GetEntityCoords(bed)
  SetEntityCoords(PlayerPedId(), bedCoords.x , bedCoords.y, bedCoords.z, 1, 1, 0, 0)
  SetEntityHeading(PlayerPedId(), GetEntityHeading(bed) + 180.0)
  TaskPlayAnim(PlayerPedId(),'dead', 'dead_a', 8.0, 1.0, -1, 45, 1.0, 0, 0, 0)

  Wait(200)
  DoScreenFadeIn(200)

  local progress = exports['clrp-taskbar']:taskbar(30000, 'Being Treated')

  if progress == 100 then
   while true do
    Citizen.Wait(5)

    showMessage('~w~Press ~g~E ~w~To Leave The Bed')

    if IsControlJustPressed(0, 38) then

     FreezeEntityPosition(PlayerPedId(), false)
     ClearPedTasks(PlayerPedId())
     TriggerServerEvent('hospital:checkOut', hospital, id)
     SetEntityHealth(PlayerPedId(), 2000)

     if DecorGetBool(GetPlayerPed(-1), "isInService") or medicalInsurance then
      TriggerServerEvent('ems:payHeal', 0)
     else
      TriggerServerEvent('ems:payHeal', 500)
     end
     break
    end
   end
  end
 end
end)
