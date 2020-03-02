local myHelicopter = nil


AddEventHandler('npc:revive', function()
 local npc = GetClosestNPC()
 if DoesEntityExist(npc) then
  TaskStartScenarioInPlace(PlayerPedId(), 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
  Citizen.Wait(13000)
  ResurrectPed(npc)
  ReviveInjuredPed(npc)
  AttachEntityToEntity(npc, PlayerPedId(), 4103, 11816, 0.48, 0.00, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
  ClearPedTasksImmediately(npc)
  TaskStartScenarioInPlace(npc, "WORLD_HUMAN_BUM_SLUMPED", 0, true)
  SetPedKeepTask(npc, true)
  Wait(3000)
  DetachEntity(npc, PlayerPedId(), true)
  ClearPedTasks(PlayerPedId())
  SetPedKeepTask(npc, true)
  Wait(16000)
  ClearPedTasks(npc)
 end
end)

--
--
-- RegisterCommand('heli', function()
--  if DecorGetBool(PlayerPedId(), 'isOfficer') then
--   RequestModel(GetHashKey('s_m_m_pilot_01'))
--   while not HasModelLoaded(GetHashKey('s_m_m_pilot_01')) do
--    Citizen.Wait(5)
--   end
--   myHelicopter = CreateVehicle(GetHashKey('polmav'), 454.139, -993.380, 43.692, 0, true, false)
--   local ped = CreatePedInsideVehicle(vehicle, 7, GetHashKey('s_m_m_pilot_01'), -1, true, false)
--   local ownerVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
--   TaskHeliMission(ped, vehicle, ownerVehicle, GetPlayerPed(-1), 0.0, 0.0, 0.0, 9, 90.0, 150.0, 0.0, false, 70, false, false)
--   SetVehicleLivery(vehicle, 2)
--  end
-- end)
--
-- RegisterCommand('delheli', function()
--  if DecorGetBool(PlayerPedId(), 'isOfficer') then
--   if DoesEntityExist(myHelicopter) then
--    SetEntityAsMissionEntity(myHelicopter, false, false)
--    DeleteVehicle(myHelicopter)
--   end
--  end
-- end)
--
-- RegisterNetEvent('backup:helicopter')
-- AddEventHandler('backup:helicopter', function()
--   RequestModel(GetHashKey('s_m_m_pilot_01'))
--   while not HasModelLoaded(GetHashKey('s_m_m_pilot_01')) do
--    Citizen.Wait(5)
--   end
--   local vehicle = CreateVehicle(GetHashKey('polmav'), 454.139, -993.380, 43.692, 0, true, false)
--   local ped = CreatePedInsideVehicle(vehicle, 7, GetHashKey('s_m_m_pilot_01'), -1, true, false)
--   local ownerVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
--   TaskHeliMission(ped, vehicle, ownerVehicle, PlayerPedId(), 0.0, 0.0, 0.0, 9, 30.0, 50.0, 0.0, false, 70, false, false)
--   SetVehicleLivery(vehicle, 2)
-- end)
--
--
--
--
--
--
--
--













function GetClosestNPC()
 local playerped = PlayerPedId()
 local playerCoords = GetEntityCoords(playerped)
 local handle, ped = FindFirstPed()
 local success
 local rped = nil
 local distanceFrom
 repeat
  local pos = GetEntityCoords(ped)
  local distance = GetDistanceBetweenCoords(playerCoords, pos, true)
  if canPedBeUsed(ped) and distance < 5.0 and (distanceFrom == nil or distance < distanceFrom) then
   distanceFrom = distance
   rped = ped
  end
  success, ped = FindNextPed(handle)
 until not success
 EndFindPed(handle)
 return rped
end

function canPedBeUsed(ped)
 if ped == nil then
  return false
 end

 if ped == GetPlayerPed(-1) then
  return false
 end

 if not DoesEntityExist(ped) then
  return false
 end

 if IsPedAPlayer(ped) then
  return false
 end

 if IsPedSwimming(ped) then
  return false
 end

 if IsPedOnAnyBike(ped) or IsPedInAnyBoat(ped) or IsPedInFlyingVehicle(ped) then
  return false
 end

 if not IsEntityDead(ped) then
  return false
 end

 local pedType = GetPedType(ped)
 if pedType == 6 or pedType == 27 or pedType == 29 or pedType == 28 then
  return false
 end
 return true
end



















-- NPC
local hostageLocations = {
	{x = -2020.404, y = -1039.355, z = 2.583, heading = 259.660, model = 'a_m_y_business_03'},
	{x = -2066.235, y = -1027.665, z = 3.061, heading = 241.278, model = 'a_f_m_business_02'},
	{x = -2035.644, y = -1029.730, z = 5.882, heading = 293.625, model = 'a_m_y_vinewood_02'},
	{x = -2084.862, y = -1020.638, z = 5.884, heading = 353.947, model = 'a_f_y_indian_01'},
	{x = -2122.450, y = -1005.161, z = 8.055, heading = 222.946, model = 'a_f_y_business_04'},
	{x = -2086.472, y = -1015.027, z = 8.971, heading = 90.959, model = 'a_f_y_business_04'},
}

local hostageLocations2 = {
	{x = -617.461, y = -1623.320, z = 33.011, heading = 350.242, model = 'a_m_y_business_03'},
	{x = -605.562, y = -1633.731, z = 33.052, heading = 50.854, model = 'a_f_m_business_02'},
	{x = -579.483, y = -1626.879, z = 33.069, heading = 24.016, model = 'a_m_y_vinewood_02'},
	{x = -571.588, y = -1600.493, z = 27.011, heading = 270.549, model = 'a_f_y_indian_01'},
	{x = -582.824, y = -1613.315, z = 27.035, heading = 265.035, model = 'a_f_y_business_04'},
	{x = -604.158, y = -1609.293, z = 27.011, heading = 251.744, model = 'a_f_y_business_04'},
}


local guardLocations = {
	{x = -2082.781, y = -1019.074, z = 8.971},
	{x = -2095.054, y = -1014.794, z = 8.980},
	{x = -2052.357, y = -1027.852, z = 8.971},
	{x = -2067.497, y = -1027.069, z = 11.909},
	{x = -2084.705, y = -1019.484, z = 12.782}, 
	{x = -2076.947, y = -1017.752, z = 5.884},
	{x = -2091.153, y = -1016.650, z = 5.889},
	{x = -2069.793, y = -1019.667, z = 3.068}, 
	{x = -2055.386, y = -1031.259, z = 2.591}, 
}

local guardLocations2 = {
  {x = -624.610, y = -1617.891, z = 33.011},
  {x = -613.152, y = -1627.565, z = 33.011},
  {x = -589.640, y = -1617.641, z = 33.011},
  {x = -562.686, y = -1629.919, z = 33.006},
  {x = -560.712, y = -1608.055, z = 27.011},
  {x = -579.439, y = -1601.442, z = 27.011},
  {x = -602.275, y = -1599.913, z = 30.405}, 
  {x = -605.656, y = -1621.540, z = 27.011},
}

function spawnHostages()
 for i,v in pairs(hostageLocations) do
  loadModel(v.model)
  loadAnimation('random@mugging3')
  local hostage = CreatePed(4, GetHashKey(v.model), v.x, v.y, v.z, v.heading, true, true)
  SetBlockingOfNonTemporaryEvents(hostage, false)
  SetPedFleeAttributes(hostage, 0, 0)
  TaskPlayAnim(hostage, "random@mugging3", "handsup_standing_base", 8.0, -8, -1, 14, 0, 0, 0, 0)
  SetPedKeepTask(hostage, true)
  SetModelAsNoLongerNeeded(GetHashKey(v.model))
 end
end

function spawnHostages2()
 for i,v in pairs(hostageLocations2) do
  loadModel(v.model)
  loadAnimation('random@mugging3')
  local hostage2 = CreatePed(4, GetHashKey(v.model), v.x, v.y, v.z, v.heading, true, true)
  SetBlockingOfNonTemporaryEvents(hostage2, false)
  SetPedFleeAttributes(hostage2, 0, 0)
  TaskPlayAnim(hostage2, "random@mugging3", "handsup_standing_base", 8.0, -8, -1, 14, 0, 0, 0, 0)
  SetPedKeepTask(hostage2, true)
  SetModelAsNoLongerNeeded(GetHashKey(v.model))
 end
end

function spawnGuards()
 for i,v in pairs(guardLocations) do
  loadModel('s_m_y_blackops_02')
  local ped = CreatePed(4, GetHashKey('s_m_y_blackops_02'), v.x, v.y, v.z, v.heading, true, true)
  SetPedShootRate(ped, math.random(500,800))
  SetPedAlertness(ped, 3)
  SetPedAccuracy(ped, math.random(50,75))
  SetEntityMaxHealth(ped, 450)
  SetEntityHealth(ped, 450)
  SetPedArmour(ped, 250)
  SetPedFleeAttributes(ped, 0, 0)
  SetPedCombatAttributes(ped, 46, true)
  SetPedCombatAbility(ped, 2)
  SetPedCombatRange(ped, 0)
  SetPedPathAvoidFire(ped, 1)
  SetPedGeneratesDeadBodyEvents(ped, 1)
  SetPedCombatMovement(ped, math.random(1,2))
  if math.random(1,10) > 7 then
   GiveWeaponToPed(ped, GetHashKey("WEAPON_COMBATPDW"), 5000, true, true)
  else
   GiveWeaponToPed(ped, GetHashKey("WEAPON_COMBATPISTOL"), 5000, true, true)
  end
  SetPedRelationshipGroupHash(ped, GetHashKey("security_guard"))
  SetModelAsNoLongerNeeded(GetHashKey(v.model))
 end
end

function spawnGuards2()
 for i,v in pairs(guardLocations2) do
  loadModel('s_m_y_blackops_02')
  local ped2 = CreatePed(4, GetHashKey('s_m_y_blackops_02'), v.x, v.y, v.z, v.heading, true, true)
  SetPedShootRate(ped2, math.random(500,800))
  SetPedAlertness(ped2, 3)
  SetPedAccuracy(ped2, math.random(50,75))
  SetEntityMaxHealth(ped2, 450)
  SetEntityHealth(ped2, 450)
  SetPedArmour(ped2, 250)
  SetPedFleeAttributes(ped2, 0, 0)
  SetPedCombatAttributes(ped2, 46, true)
  SetPedCombatAbility(ped2, 2)
  SetPedCombatRange(ped2, 0)
  SetPedPathAvoidFire(ped2, 1)
  SetPedGeneratesDeadBodyEvents(ped2, 1)
  SetPedCombatMovement(ped2, math.random(1,2))
  if math.random(1,10) > 7 then
   GiveWeaponToPed(ped2, GetHashKey("WEAPON_COMBATPDW"), 5000, true, true)
  else
   GiveWeaponToPed(ped2, GetHashKey("WEAPON_COMBATPISTOL"), 5000, true, true)
  end
  SetPedRelationshipGroupHash(ped2, GetHashKey("security_guard"))
  SetModelAsNoLongerNeeded(GetHashKey(v.model))
 end
end

RegisterCommand('aruTraining', function(source, args, rawCommand)
 if DecorGetBool(GetPlayerPed(-1), "isOfficer") and DecorGetInt(PlayerPedId(), 'Faction') == 108 then
  spawnHostages()
  spawnGuards()
 end
end)

RegisterCommand('aruTraining2', function(source, args, rawCommand)
 if DecorGetBool(GetPlayerPed(-1), "isOfficer") and DecorGetInt(PlayerPedId(), 'Faction') == 108 then
  spawnHostages2()
  spawnGuards2()
 end
end)

function loadModel(model)
 RequestModel(GetHashKey(model))
 while not HasModelLoaded(GetHashKey(model)) do
  Wait(0)
 end
end

function loadAnimation(animation)
 RequestAnimDict(animation)
 while not HasAnimDictLoaded(animation) do
  Citizen.Wait(10)
 end
end