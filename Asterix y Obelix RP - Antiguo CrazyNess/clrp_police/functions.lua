-----------------
-- Duty Status --
-----------------
-- function toggleDuty()
 -- if DecorGetBool(GetPlayerPed(-1), 'isInService') then 
  -- DecorSetBool(GetPlayerPed(-1), 'isInService', false)
  -- TriggerServerEvent("blips:deactivate")
  -- TriggerServerEvent('police:duty', false)
  -- RemoveAllPedWeapons(GetPlayerPed(-1), true)
  -- SetPedAsCop(PlayerPedId(), false)
 -- else
  -- DecorSetBool(GetPlayerPed(-1), 'isInService', true)
  -- RemoveAllPedWeapons(GetPlayerPed(-1), true)
  -- TriggerServerEvent('police:duty', true)
  -- TriggerServerEvent("blips:activate", 'police')
  -- SetPedRelationshipGroupHash(PlayerPedId(), 'COP')
  -- SetPedRelationshipGroupHash(PlayerPedId(), GetHashKey('COP'))
  -- SetPedAsCop(PlayerPedId(), true)
 -- end
-- end


function OnDuty()
  RemoveAllPedWeapons(GetPlayerPed(-1), true)
  TriggerServerEvent("police:loadclothing")  
  TriggerServerEvent('police:duty', true)
  TriggerServerEvent("blips:activate", 'police')
  SetPedRelationshipGroupHash(PlayerPedId(), 'COP')
  SetPedRelationshipGroupHash(PlayerPedId(), GetHashKey('COP'))
  SetPedAsCop(PlayerPedId(), true)
end

function OffDuty()
  DecorSetBool(GetPlayerPed(-1), 'isInService', false)
  TriggerServerEvent("blips:deactivate")
  TriggerServerEvent('police:duty', false)
  RemoveAllPedWeapons(GetPlayerPed(-1), true)
  SetPedAsCop(PlayerPedId(), false)
end
-------------
-- Weapons --
-------------
function giveBasicLoadout(ped)
 GiveWeaponToPed(ped, GetHashKey('WEAPON_FLASHLIGHT'), 5000, false, false)
 GiveWeaponToPed(ped, GetHashKey('WEAPON_NIGHTSTICK'), 5000, false, false)
 GiveWeaponToPed(ped, GetHashKey('WEAPON_STUNGUN'), 5000, false, false)
 GiveWeaponToPed(ped, GetHashKey('WEAPON_FIREEXTINGUISHER'), 5000, false, false)
 GiveWeaponToPed(ped, GetHashKey('WEAPON_PETROLCAN'), 5000, false, false)
 SetPedInfiniteAmmo(ped, true, GetHashKey('WEAPON_FIREEXTINGUISHER'))
end

--------------
-- Vehicles --
--------------
function spawnVehicle(veh)
 local pos = GetEntityCoords(GetPlayerPed(-1))
 RequestModel(GetHashKey(veh))
 while not HasModelLoaded(GetHashKey(veh)) do
  Citizen.Wait(0)
 end
 vehicle = CreateVehicle(GetHashKey(veh), pos.x, pos.y, pos.z, GetEntityHeading(PlayerPedId()), true, false)
 local id = NetworkGetNetworkIdFromEntity(vehicle)
 SetNetworkIdCanMigrate(id, true)
 SetNetworkIdExistsOnAllMachines(id, true)
 SetVehicleDirtLevel(vehicle, 0)
 TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
 SetVehicleHasBeenOwnedByPlayer(vehicle, true)
 SetEntityAsMissionEntity(vehicle, true, true)
 SetVehicleMod(vehicle, 16, 20)
 SetVehicleEngineOn(vehicle, true)
 DecorSetInt(vehicle, "_Max_Fuel_Level", 150000)
 DecorSetInt(vehicle, "_Fuel_Level", 150000)
 SetVehicleLivery(vehicle, 3)
end

---------------
-- Menu Shit --
---------------
local IsDragged = false 
local cuffed = false
local changed = false
local prevMaleVariation = 0
local prevFemaleVariation = 0
local playerStillDragged = false

RegisterNetEvent('police:vehiclein')
AddEventHandler('police:vehiclein', function()
  local pos = GetEntityCoords(GetPlayerPed(-1))
  local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 20.0, 0.0)
  local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
  local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)

  if vehicleHandle ~= nil then
    if(IsVehicleSeatFree(vehicleHandle, 1)) then
      SetPedIntoVehicle(GetPlayerPed(-1), vehicleHandle, 1)
    elseif(IsVehicleSeatFree(vehicleHandle, 2)) then
      SetPedIntoVehicle(GetPlayerPed(-1), vehicleHandle, 2)
    end
  end
  IsDragged = false
  DecorSetBool(PlayerPedId(), 'Seatbelt', true)
end)

RegisterNetEvent('police:vehicleout')
AddEventHandler('police:vehicleout', function(t)
  local ped = GetPlayerPed(t)
  ClearPedTasksImmediately(ped)
  plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
  local xnew = plyPos.x+1
  local ynew = plyPos.y+1
  SetEntityCoords(GetPlayerPed(-1), xnew, ynew, plyPos.z)
  DecorSetBool(PlayerPedId(), 'Seatbelt', false)
end)

RegisterNetEvent('police:handcuff')
AddEventHandler('police:handcuff', function()
 RequestAnimDict("mp_arresting")
 RequestAnimDict('mp_arrest_paired')
 while not HasAnimDictLoaded("mp_arresting") or not HasAnimDictLoaded('mp_arrest_paired') do
  Citizen.Wait(0)
 end
 if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
  if cuffed then
   ClearPedTasks(PlayerPedId())
   SetEnableHandcuffs(PlayerPedId(), false)
   UncuffPed(PlayerPedId())
   if GetEntityModel(PlayerPedId()) == GetHashKey("mp_f_freemode_01") then SetPedComponentVariation(PlayerPedId(), 7, prevFemaleVariation, 0, 0) elseif GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") then SetPedComponentVariation(PlayerPedId(), 7, prevMaleVariation, 0, 0) end
  else
   TaskPlayAnim(GetPlayerPed(-1), "mp_arrest_paired", "crook_p2_back_right", 8.0, -8, -1, 48, 0, 0, 0, 0)
   Wait(4000)
   if GetEntityModel(PlayerPedId()) == GetHashKey("mp_f_freemode_01") then prevFemaleVariation = GetPedDrawableVariation(PlayerPedId(), 7) SetPedComponentVariation(PlayerPedId(), 7, 25, 0, 0) elseif GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") then prevMaleVariation = GetPedDrawableVariation(PlayerPedId(), 7) SetPedComponentVariation(PlayerPedId(), 7, 41, 0, 0) end
   SetEnableHandcuffs(PlayerPedId(), true)
   TaskPlayAnim(PlayerPedId(), "mp_arresting", "idle", 8.0, -8, -1, 49, 0, 0, 0, 0)
  end
  cuffed = not cuffed
  changed = true
 end
end)

RegisterNetEvent('police:hardcuff')
AddEventHandler('police:hardcuff', function()
  if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
    local ped = PlayerPedId()
    RequestAnimDict("mp_arresting")
    while not HasAnimDictLoaded("mp_arresting") do
      Citizen.Wait(0)
    end
    
    if hardcuffed then
      ClearPedTasks(ped)
      SetEnableHandcuffs(ped, false)
      FreezeEntityPosition(ped, false)
      UncuffPed(ped)
      if GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then -- mp female
        SetPedComponentVariation(ped, 7, prevFemaleVariation, 0, 0)
      elseif GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then -- mp male
        SetPedComponentVariation(ped, 7, prevMaleVariation, 0, 0)
      end
    else
      if GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then -- mp female
        prevFemaleVariation = GetPedDrawableVariation(ped, 7)
        SetPedComponentVariation(ped, 7, 25, 0, 0)
      
      elseif GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then -- mp male
        prevMaleVariation = GetPedDrawableVariation(ped, 7)
        SetPedComponentVariation(ped, 7, 41, 0, 0)
      end
      SetEnableHandcuffs(ped, true)
      FreezeEntityPosition(ped, true)
      TaskPlayAnim(ped, "mp_arresting", "idle", 8.0, -8, -1, 49, 0, 0, 0, 0)
    end
    hardcuffed = not hardcuffed
    changed = true
  end
end)

RegisterNetEvent('police:uncuff')
AddEventHandler('police:uncuff', function()
  if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
    ClearPedTasks(PlayerPedId())
    SetEnableHandcuffs(PlayerPedId(), false)
    UncuffPed(PlayerPedId())
    FreezeEntityPosition(PlayerPedId(), false)

    RequestAnimDict("mp_arresting")
    while not HasAnimDictLoaded("mp_arresting") do
      Citizen.Wait(0)
    end

    if cuffed then
      ClearPedTasks(PlayerPedId())
      SetEnableHandcuffs(PlayerPedId(), false)
      UncuffPed(PlayerPedId())
      if GetEntityModel(PlayerPedId()) == GetHashKey("mp_f_freemode_01") then -- mp female
        SetPedComponentVariation(PlayerPedId(), 7, prevFemaleVariation, 0, 0)
      elseif GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") then -- mp male
        SetPedComponentVariation(PlayerPedId(), 7, prevMaleVariation, 0, 0)
      end
    end
    cuffed = false
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

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(1)
  if cuffed and hardcuffed then
   SetPedDropsWeapon(PlayerPedId())
   if IsPedRunning(PlayerPedId()) then
    Wait(1000)
    if math.random(1,1000) > 750 then
     SetPedToRagdoll(PlayerPedId(), 1000, 1000, 0, 0, 0, 0)
     TaskPlayAnim(PlayerPedId(), "mp_arresting", "idle", 8.0, -8, -1, 49, 0, 0, 0, 0)
    end
   end
  else 
   Citizen.Wait(2500)
  end
 end
end)

Citizen.CreateThread(function() 
 while true do 
  Wait(1) 
  if cuffed or hardcuffed then
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
  else
   Citizen.Wait(2500)
  end
 end
end)

Citizen.CreateThread(function()
 while true do
  Wait(5)
  if IsDragged then
   local ped = GetPlayerPed(GetPlayerFromServerId(CopPed))
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

RegisterNetEvent('police:drag')
AddEventHandler('police:drag', function(cop)
 if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
  IsDragged = not IsDragged
  CopPed = tonumber(cop)
 end
end)

RegisterNetEvent('police:panic')
AddEventHandler('police:panic', function(x,y,z)
 if DecorGetBool(GetPlayerPed(-1), "isInService") then
  TriggerEvent("pNotify:SendNotification", {text= "Un oficial está en peligro. Código de identificación y respuesta de todas las unidades disponibles 3."})
  local transG = 250
  local location = AddBlipForCoord(x,y,z)
  SetBlipSprite(location,  161)
  SetBlipScale(location , 1.5)
  SetBlipColour(location,  75)
  SetBlipAlpha(location,  transG)
  SetBlipAsShortRange(location,  1)
  PulseBlip(location)
  PlaySoundFrontend(-1, "HACKING_FAILURE", 0, 1);
  Wait(1000)
  PlaySoundFrontend(-1, "HACKING_FAILURE", 0, 1);
  Wait(1000)
  PlaySoundFrontend(-1, "HACKING_FAILURE", 0, 1);
  Wait(1000)
  PlaySoundFrontend(-1, "HACKING_FAILURE", 0, 1);
  Wait(1000)
  PlaySoundFrontend(-1, "HACKING_FAILURE", 0, 1);
  Wait(1000)
  PlaySoundFrontend(-1, "HACKING_FAILURE", 0, 1);
  Wait(1000)
  PlaySoundFrontend(-1, "HACKING_FAILURE", 0, 1);
  Wait(1000)
  PlaySoundFrontend(-1, "HACKING_FAILURE", 0, 1);
  Wait(1000)
  PlaySoundFrontend(-1, "HACKING_FAILURE", 0, 1);
  while transG ~= 0 do
    Wait(240 * 4)
    transG = transG - 1
    SetBlipAlpha(location,  transG)
    if transG == 0 then
      SetBlipSprite(location,  2)
      return
    end
  end
 end
end)

RegisterNetEvent('police:byebyeweapons')
AddEventHandler('police:byebyeweapons', function(target)
  local playerped = GetPlayerPed(-1)
  RemoveAllPedWeapons(playerped, true)
end)


--=================================================================================================
--===================================== BAC Test ==================================================
--=================================================================================================

DecorRegister("BAC_Active", 2)
DecorSetBool(GetPlayerPed(-1), "BAC_Active", false)
DecorRegister("_BAC_Level", 1)
DecorSetFloat(GetPlayerPed(-1), "_BAC_Level", 0.0)

function addBAC(amount)
 local BAC_Driving_Limit = 0.11
 local currentBAC = DecorGetFloat(GetPlayerPed(-1), "_BAC_Level")
 local newBAC = currentBAC + amount
 DecorSetFloat(GetPlayerPed(-1), "_BAC_Level", newBAC)
 if newBAC >= BAC_Driving_Limit then
  local isBACactive = DecorGetBool(GetPlayerPed(-1), "BAC_Active")
  if not isBACactive then
   DecorSetBool(GetPlayerPed(-1), "BAC_Active", true)  
  end
 end
end

AddEventHandler("police:bac", function(amount)
 addBAC(amount)
end)

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(60000) -- Every Minute remove some BAC
  local currentBAC = DecorGetFloat(GetPlayerPed(-1), "_BAC_Level")
  if currentBAC > 0 then
   local newBAC = currentBAC - 0.0005 --BAC to remove

   if newBAC < 0 then
    newBAC = 0
   end
   DecorSetFloat(GetPlayerPed(-1), "_BAC_Level", newBAC) 
   if newBAC == 0 then
    DecorSetBool(GetPlayerPed(-1), "BAC_Active", false) 
   end
  end
 end
end)



--=================================================================================================
--===================================== GSR Test ==================================================
--=================================================================================================
local GSR_LastShot = 0
local GSR_ExpireTime = 15

DecorRegister("GSR_Active", 2)
DecorSetBool(GetPlayerPed(-1), "GSR_Active", false) 

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(5)
  if IsPedShooting(GetPlayerPed(-1)) and GetSelectedPedWeapon(GetPlayerPed(-1)) ~= GetHashKey("WEAPON_BALL") then
   TriggerEvent("police:wfired")
  end

  local isGSRactive = DecorGetBool(GetPlayerPed(-1), "GSR_Active")
  if isGSRactive then
   if GSR_LastShot + (GSR_ExpireTime * 1000 * 60) <= GetGameTimer() then
    DecorSetBool(GetPlayerPed(-1), "GSR_Active", false)     
   end
  else 
   Citizen.Wait(2500)
  end
 end
end)

AddEventHandler("police:wfired", function()
 GSR_LastShot = GetGameTimer()
 local isGSRactive = DecorGetBool(GetPlayerPed(-1), "GSR_Active")
 if not isGSRactive then
  DecorSetBool(GetPlayerPed(-1), "GSR_Active", true)
 end
end)

--=================================================================================================
--===================================== Radar =====================================================
--=================================================================================================
local radar = true 
local lastDetVehf = {}
local lastDetVehr = {}
local vehicleFlags = {}

RegisterNetEvent('radar:updateFlags')
AddEventHandler('radar:updateFlags', function(flags)
 vehicleFlags = flags 
end)

Citizen.CreateThread(function()
 while true do
  Wait(5)

  if (DecorGetBool(GetPlayerPed(-1), 'isOfficer') and IsPedInAnyPoliceVehicle(GetPlayerPed(-1))) then
   local veh = GetVehiclePedIsIn(GetPlayerPed(-1))
   local vehpos = GetEntityCoords(veh)
   local offsetf = GetOffsetFromEntityInWorldCoords(veh, 0.0, 360.0, 0.0)
   local detvehf = getVehicleInDirection(vehpos, offsetf, veh)

   if ((detvehf ~= 0) and (IsEntityAVehicle(detvehf)) and (detvehf ~= lastDetVeh) and (not IsVehicleSeatFree(detvehf, -1))) then
    --local mph = math.ceil(GetEntitySpeed(detvehf, false) * 2.236936)
    local mph = math.ceil(GetEntitySpeed(detvehf, false) * 3.6)	
    local vtype = GetDisplayNameFromVehicleModel(GetEntityModel(detvehf))
    local plate = GetVehicleNumberPlateText(detvehf)
    local driver = GetPedInVehicleSeat(detvehf, -1)
    local driverbelt = '~g~On'

    lastDetVehf.mph = mph
    lastDetVehf.vtype = vtype
    lastDetVehf.plate = plate
    lastDetVehf.driverbelt = '~g~On'

    if DecorGetBool(driver, 'Seatbelt') then 
     lastDetVehf.driverbelt = '~g~On'
     driverbelt = '~g~On'
    else
     lastDetVehf.driverbelt = '~o~Off'
     driverbelt = '~o~Off'
    end

    drawRadarFront(mph, vtype, plate, driverbelt)
    if IsControlJustPressed(0, 79) then TriggerServerEvent('radar:check', 'Front', vtype, plate, mph) end
   elseif (lastDetVehf.mph) then
    if IsControlJustPressed(0, 79) then TriggerServerEvent('radar:check', 'Front', lastDetVehf.vtype, lastDetVehf.plate, lastDetVehf.mph) end
    if lastDetVehf.mph > 75 then 
     drawRadarFront(lastDetVehf.mph, tostring('~r~'..lastDetVehf.vtype..'~b~'), lastDetVehf.plate, lastDetVehf.driverbelt)
    else
     drawRadarFront(lastDetVehf.mph, lastDetVehf.vtype, lastDetVehf.plate, lastDetVehf.driverbelt)
    end
   end

   -- Radar trasero
   local offsetr = GetOffsetFromEntityInWorldCoords(veh, 0.0, -360.0, 0.0)
   local detvehr = getVehicleInDirection(vehpos, offsetr, veh)

   if ((detvehr ~= 0) and (IsEntityAVehicle(detvehr)) and (detvehr ~= lastDetVeh) and (not IsVehicleSeatFree(detvehr, -1))) then
    --local mph = math.ceil(GetEntitySpeed(detvehr, false) * 2.236936)
    local mph = math.ceil(GetEntitySpeed(detvehr, false) * 3.6)	
    local vtype = GetDisplayNameFromVehicleModel(GetEntityModel(detvehr))
    local plate = GetVehicleNumberPlateText(detvehr)
    local driver = GetPedInVehicleSeat(detvehr, -1)

    lastDetVehr.mph = mph
    lastDetVehr.vtype = vtype
    lastDetVehr.plate = plate
    lastDetVehr.driverbelt = '~g~On'

    if DecorGetBool(driver, 'Seatbelt') then 
     lastDetVehr.driverbelt = '~g~On'
    else
     lastDetVehr.driverbelt = '~o~Off'
    end
   
    drawRadarRear(mph, vtype, plate, driverbelt)
    if IsControlJustPressed(0, 79) then TriggerServerEvent('radar:check', 'Rear', vtype, plate, mph) end
   elseif (lastDetVehr.mph) then
    if IsControlJustPressed(0, 79) then TriggerServerEvent('radar:check', 'Rear', lastDetVehr.vtype, lastDetVehr.plate, lastDetVehr.mph) end
    if lastDetVehr.mph > 75 then 
     drawRadarRear(lastDetVehr.mph, tostring('~r~'..lastDetVehr.vtype..'~b~'), lastDetVehr.plate, lastDetVehr.driverbelt)
    else
     drawRadarRear(lastDetVehr.mph, lastDetVehr.vtype, lastDetVehr.plate, lastDetVehr.driverbelt)
    end
   end
  else 
   Citizen.Wait(2500)
  end
 end
end)

function getVehicleInDirection(coordFrom, coordTo, ignore)
  local rayHandle = StartShapeTestRay(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, ignore, 0)
  local _, _, _, _, vehicle = GetShapeTestResult(rayHandle)
  return vehicle
end

function drawRadarFront(mph, vtype, plate, dbelt)
  SetTextFont(4)
  SetTextProportional(0)
  SetTextScale(0.42, 0.42)
  SetTextColour(255, 255, 255, 255)
  SetTextDropShadow(0, 0, 0, 0, 255)
  SetTextEdge(1, 0, 0, 0, 255)
  SetTextDropShadow()
  SetTextOutline()
  SetTextCentre(0)
  BeginTextCommandDisplayText("STRING")
  if vehicleFlags[plate] and vehicleFlags[plate].isFlagged then
   AddTextComponentSubstringPlayerName(string.format("Radar frontal: ~b~%s | %s | %s MPH | Seatbelt: %s | ~r~Vehículo marcado por %s", vtype, plate, mph, dbelt, vehicleFlags[plate].Flagger))
  else 
   AddTextComponentSubstringPlayerName(string.format("Radar frontal: ~b~%s | %s | %s MPH | Seatbelt: %s", vtype, plate, mph, dbelt))
  end
  EndTextCommandDisplayText(0.5, 0.91)
end

function drawRadarRear(mph, vtype, plate, dbelt)
  SetTextFont(4)
  SetTextProportional(0)
  SetTextScale(0.42, 0.42)
  SetTextColour(255, 255, 255, 255)
  SetTextDropShadow(0, 0, 0, 0, 255)
  SetTextEdge(1, 0, 0, 0, 255)
  SetTextDropShadow()
  SetTextOutline()
  SetTextCentre(0)
  BeginTextCommandDisplayText("STRING")
  if vehicleFlags[plate] and vehicleFlags[plate].isFlagged then
   AddTextComponentSubstringPlayerName(string.format("Radar trasero: ~b~%s | %s | %s MPH | Seatbelt: %s | ~r~Vehículo marcado por %s", vtype, plate, mph, dbelt, vehicleFlags[plate].Flagger))
  else 
   AddTextComponentSubstringPlayerName(string.format("Radar trasero: ~b~%s | %s | %s MPH | Seatbelt: %s", vtype, plate, mph, dbelt))
  end
  EndTextCommandDisplayText(0.5, 0.945)
end


--=================================================================================================
--===================================== Spikes ====================================================
--=================================================================================================
local spikeStrips = {}
local tireBurst = false


RegisterNetEvent('spike:load')
AddEventHandler('spike:load', function(spikes)
 spikeStrips = spikes
 tireBurst = false 
end)

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(5)
  if IsPedInAnyVehicle(PlayerPedId(), false) or DecorGetBool(PlayerPedId(), 'isOfficer') then     
   local coords = GetEntityCoords(PlayerPedId(), true)
   local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
   for id,v in pairs(spikeStrips) do 
    if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, false) < 75.0 then 
     DrawMarker(1, v.x, v.y, v.z-1.0, 0, 0, 0, 0, 0, 0, 3.5,0.05,0.3, 255, 0, 0, 240, 0, 1, 2, 0, 0, 0, 0)
     if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, false) < 3.0 then 
      if not tireBurst and IsPedInAnyVehicle(PlayerPedId(), false) then 
       TriggerServerEvent('spike:remove', id) 
       Wait(500)
       tireBurst = true
       for i=1, 8 do 
        SetVehicleTyreBurst(vehicle, i, true, 50.0)
        Wait(7500)
       end
      end
     end
    end
   end
  else
   Citizen.Wait(2500) 
   tireBurst = false
  end 
 end
end)

-- RegisterCommand('spike', function(source, args, rawCommand)
 -- if DecorGetBool(GetPlayerPed(-1), "isOfficer") then 
  -- loadAnimDict("pickup_object")
  -- TaskPlayAnim(PlayerPedId(), "pickup_object", "pickup_low", 1.0, 1, -1, 33, 0, 0, 0, 0)
  -- Citizen.Wait(1700)
  -- ClearPedTasksImmediately(PlayerPedId())
  -- local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 3.0, 0))
  -- TriggerServerEvent('spike:add', {x = x, y = y, z = z})
 -- end
-- end)

-- RegisterCommand('spike2', function(source, args, rawCommand)
 -- if DecorGetBool(GetPlayerPed(-1), "isOfficer") then 
  -- loadAnimDict("pickup_object")
  -- TaskPlayAnim(PlayerPedId(), "pickup_object", "pickup_low", 1.0, 1, -1, 33, 0, 0, 0, 0)
  -- Citizen.Wait(1700)
  -- ClearPedTasksImmediately(PlayerPedId())
  -- local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 8.0, 0))
  -- local x2,y2,z2 = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 3.0, 0))
  -- TriggerServerEvent('spike:add', {x = x, y = y, z = z})
  -- TriggerServerEvent('spike:add', {x = x2, y = y2, z = z2})
 -- end
-- end)

local barrierObject = GetHashKey('prop_barrier_work05')
local coneObject = GetHashKey('prop_mp_cone_01')
local objectPos = {}
local roadBlocks = {}
objList = {
	[1] = "prop_mp_cone_01",
	[2] = "prop_mp_barrier_02b",
	[3] = "prop_barrier_work05",
	[4] = "prop_flare_01",
	[5] = "prop_flare_01b",
	[6] = "prop_mp_cone_01",
}

-- Barriers
RegisterCommand('barrier', function(source, args, rawCommand)
 local barrierType = tonumber(args[1])
 if DecorGetBool(PlayerPedId(), "isOfficer") then
  local playerHeading = GetEntityHeading(PlayerPedId())

  loadModel(coneObject)
  loadModel(barrierObject)

  loadAnimDict('anim@narcotics@trash')
  TaskPlayAnim(PlayerPedId(), 'anim@narcotics@trash', 'drop_front', 0.9, -8, 1700, 49, 3.0, 0, 0, 0)

  if barrierType == 1 then
   local finished = exports["np-taskbar"]:taskBar(1800,"Placing Roadblock")
   if finished == 100 then  
   --local progress = exports["clrp_progressBar"]:progressBar(1800, "Placing Roadblock")
   --if progress == 100 then
    local barrierPos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.2, 0.0)
		local conePos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 2.2, 0.0)
		local conePos2 = GetOffsetFromEntityInWorldCoords(PlayerPedId(), -1.5, 2.2, 0.0)
		local barrier = CreateObject(barrierObject, barrierPos.x, barrierPos.y, barrierPos.z, true, false, false)
		local cone = CreateObject(coneObject, conePos.x, conePos.y, conePos.z, true, false, false)
		local cone2 = CreateObject(coneObject, conePos2.x, conePos2.y, conePos2.z, true, false, false)

		PlaceObjectOnGroundProperly(barrier)
		PlaceObjectOnGroundProperly(cone)
		PlaceObjectOnGroundProperly(cone2)
    SetEntityHeading(barrier, playerHeading)
    TriggerServerEvent('police:placeRoadBlock', {x = barrierPos.x, y = barrierPos.y, z = barrierPos.z})
   end

  elseif barrierType == 2 then
   local finished = exports["np-taskbar"]:taskBar(1000,"Placing Cone")
   if finished == 100 then    
  -- local progress = exports["clrp_progressBar"]:progressBar(1000, "Placing Cone")
  -- if progress == 100 then
		local conePos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.2, 0.0)
		local cone = CreateObject(coneObject, conePos.x, conePos.y, conePos.z, true, true, true)
		PlaceObjectOnGroundProperly(cone)
		SetEntityHeading(cone, playerHeading)
   end

  elseif barrierType == 3 then
   local finished = exports["np-taskbar"]:taskBar(1000,"Placing Barrier")
   if finished == 100 then    
   --local progress = exports["clrp_progressBar"]:progressBar(1000, "Placing Barrier")
   --if progress == 100 then
		local conePos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.2, 0.0)
		local cone = CreateObject(barrierObject, conePos.x, conePos.y, conePos.z, true, true, true)
		PlaceObjectOnGroundProperly(cone)
		SetEntityHeading(cone, playerHeading)
   end
  elseif barrierType == 4 then
   for i = 1, #objList do
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 0.25, 0.0))
    objFound = GetClosestObjectOfType(x, y, z, 5.0, GetHashKey(objList[i]), 0, 0, 0)
    if objList[i] == 'prop_barrier_work05' then
     objectPos = GetEntityCoords(objFound, true)
    end
    DeleteObject(objFound)
    DeleteObject(objFound)
    DeleteEntity(objFound)
   end
   Wait(2000)
   TriggerServerEvent('police:removeRoadBlock', {x = objectPos.x, y = objectPos.y, z = objectPos.z})
  end
 end
end)

function loadAnimDict(dict)
 while not HasAnimDictLoaded(dict) do
  RequestAnimDict(dict)
  Citizen.Wait(5)
 end
end

function loadModel(model)
 RequestModel(model)
 while not HasModelLoaded(model) do
  Citizen.Wait(1)
 end
end

RegisterNetEvent('police:roadBlock')
AddEventHandler('police:roadBlock', function(blocks)
 roadBlocks = blocks
 print('Roadblocks Updated')
end)

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(5)
  if roadBlocks ~= {} then
   local playerCoords = GetEntityCoords(PlayerPedId(), true)
   for id,v in pairs(roadBlocks) do
    if GetDistanceBetweenCoords(playerCoords, v.x, v.y, v.z, true) < 40 then
	 	 local closestVehicle = GetClosestVehicle(v.x, v.y, v.z, 30.0, 0, 70)
     if GetEntitySpeed(closestVehicle) > 2.5 then
		  SetVehicleForwardSpeed(closestVehicle, GetEntitySpeed(closestVehicle)-0.15)
     else
      TaskVehicleTempAction(GetPedInVehicleSeat(closestVehicle, -1), closestVehicle, 27, 1)
     end
    end
   end
  else
   Citizen.Wait(2500)
  end
 end
end)