local robberyInProgress = false 
local isNearStore = false
local storeLoc = {}
local cashRegister = nil
local storeRobberies = {[1] = 534367705, [2] = 303280717}
local robberyBlip = nil
local currentPolice = 0
local currentStore = {}

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(1250)
  isNearStore = false
  local pos = GetEntityCoords(GetPlayerPed(-1))
  for i = 1, #storeRobberies do
   cashRegister = GetClosestObjectOfType(pos.x, pos.y, pos.z, 1.5, storeRobberies[i], false, false)
   if cashRegister ~= nil and cashRegister ~= 0 and not robberyInProgress then
    local coords = GetEntityCoords(cashRegister)
    isNearStore = true
    storeLoc = {['x'] = coords.x, ['y'] = coords.y, ['z'] = coords.z + 0.2}
    break
   end
  end
 end
end)

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(5)
  if not robberyInProgress and currentPolice >= 2 and not DecorGetBool(GetPlayerPed(-1), "isOfficer") and not DecorGetBool(GetPlayerPed(-1), "isParamedic") then
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), storeLoc.x, storeLoc.y, storeLoc.z, true) < 0.8) then
    drawTxt('~b~Pulse ~g~E~b~ Romper la caja registradora abierta')
    if IsControlJustPressed(0, 38) and IsPedArmed(GetPlayerPed(-1), 4) then
     robberyInProgress = true
     currentStore = storeLoc
     TriggerServerEvent('robberies:start', 'Store', storeLoc)
     local status = ProgressBar('Robbing Store', 1550)
     if status then 
      if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), currentStore.x, currentStore.y, currentStore.z, true) < 5.0) then
       TriggerServerEvent('robberies:end', 'Store', storeLoc, math.random(10000,15500))
       TriggerServerEvent('addReputation', 5)
       Wait(300000)
      end
     end
    end 
   end
  end
 end
end)
 
Citizen.CreateThread(function()
 while true do
  Citizen.Wait(5)
  if robberyInProgress then
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), storeLoc.x, storeLoc.y, storeLoc.z, true) > 20.0) then
    TriggerServerEvent('robberies:cancel', 'Store', storeLoc)
    robberyInProgress = false 
    Wait(25000)
   end
  end
 end
end)

RegisterNetEvent('robberies:killBlip')
AddEventHandler('robberies:killBlip', function()
 if DoesBlipExist(robberyBlip) then 
  RemoveBlip(robberyBlip)
 end
end)

RegisterNetEvent('robberies:addBlip')
AddEventHandler('robberies:addBlip', function(blip)
 if DecorGetBool(GetPlayerPed(-1), "isOfficer") then
  if not DoesBlipExist(robberyBlip) then 
   robberyBlip = AddBlipForCoord(blip.x, blip.y, blip.z) 
   SetBlipSprite(robberyBlip, 161)
   SetBlipScale(robberyBlip, 1.2)
   SetBlipColour(robberyBlip, 3)
   PulseBlip(robberyBlip)
   PlaySoundFrontend(-1, "CHECKPOINT_MISSED", 'HUD_MINI_GAME_SOUNDSET', 1)
   Wait(600)
   PlaySoundFrontend(-1, "CHECKPOINT_MISSED", 'HUD_MINI_GAME_SOUNDSET', 1)
   Wait(600)  
   PlaySoundFrontend(-1, "CHECKPOINT_MISSED", 'HUD_MINI_GAME_SOUNDSET', 1)
  end
 end
end)

-----------------------------------------------------------------
-- Robbing NPCS
-----------------------------------------------------------------
local robbedRecently = false
local robbingNPC = false

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(5)
  local aiming, targetPed = GetEntityPlayerIsFreeAimingAt(PlayerId(-1))
  if aiming and not robbingNPC and not IsPedInAnyVehicle(GetPlayerPed(-1), false) and IsPedArmed(GetPlayerPed(-1), 4) and currentPolice > 0 and not DecorGetBool(GetPlayerPed(-1), "isOfficer") and not DecorGetBool(GetPlayerPed(-1), "isParamedic") then
   local coords = GetEntityCoords(GetPlayerPed(-1), true)
   local npcCoords = GetEntityCoords(targetPed, true)

   if DoesEntityExist(targetPed) and IsEntityAPed(targetPed) and not IsPedAPlayer(targetPed) and IsPedHuman(targetPed) and not IsPedInAnyVehicle(targetPed, false) then
    if not robbedRecently and not IsEntityDead(targetPed) and GetDistanceBetweenCoords(coords.x, coords.y, coords.z, npcCoords.x, npcCoords.y, npcCoords.z, true) < 12 then
     robNpc(targetPed)
    end
   end
  end
 end
end)

function robNpc(targetPed)
 robbedRecently = true
 robbingNPC = true
 local pay = math.random(150,2250)
 Citizen.CreateThread(function()
  if currentPolice > 0 then
   RequestAnimDict('random@mugging3')
   while not HasAnimDictLoaded('random@mugging3') do
    Citizen.Wait(10)
   end

   if math.random(1,10) > 6 then TriggerEvent("dispatch:robbery") end
    SetPedFleeAttributes(targetPed, 0, 0)
    TaskPlayAnim(targetPed, "random@mugging3", "handsup_standing_base", 8.0, -8, -1, 12, 1, 0, 0, 0)
    Citizen.Wait(14000)
    ClearPedTasks(targetPed)
    TriggerEvent('chatMessage', '^3Encontraste ^2$'..pay.."^3 En sus bolsillos")
    TriggerServerEvent('robbery:giveCash', pay)
    TriggerServerEvent('addReputation', 5)
    Wait(600000)
    robbedRecently = false
    robbingNPC = false
  else
   TriggerEvent('chatMessage', '^1No hay suficiente policía en la ciudad')
  end
 end)
end

-----------------------------------------------------------------
-- Robbing Jewlery Store
-----------------------------------------------------------------
local vangelicoRobbery = false 
local cabinits = {
  [1] = {x = -626.700, y = -238.604, z = 38.057, brokenOpen = false},
  [2] = {x = -625.664, y = -237.858, z = 38.057, brokenOpen = false},
  [3] = {x = -626.890, y = -235.493, z = 38.057, brokenOpen = false},
  [4] = {x = -627.905, y = -233.826, z = 38.057, brokenOpen = false},
  [5] = {x = -624.865, y = -227.906, z = 38.057, brokenOpen = false},
  [6] = {x = -623.891, y = -227.214, z = 38.057, brokenOpen = false},
  [7] = {x = -623.932, y = -228.120, z = 38.057, brokenOpen = false},
  [8] = {x = -620.535, y = -226.665, z = 38.057, brokenOpen = false},
  [9] = {x = -619.717, y = -227.605, z = 38.057, brokenOpen = false},
  [10] = {x = -618.314, y = -229.464, z = 38.057, brokenOpen = false},     
  [11] = {x = -617.627, y = -230.462, z = 38.057, brokenOpen = false}, 
  [12] = {x = -619.647, y = -230.382, z = 38.057, brokenOpen = false}, 
  [13] = {x = -621.046, y = -228.438, z = 38.057, brokenOpen = false}, 
  [14] = {x = -619.207, y = -233.606, z = 38.057, brokenOpen = false}, 
  [15] = {x = -620.205, y = -234.331, z = 38.057, brokenOpen = false}, 
  [16] = {x = -620.069, y = -233.466, z = 38.057, brokenOpen = false}, 
  [17] = {x = -623.144, y = -233.004, z = 38.057, brokenOpen = false}, 
  [18] = {x = -624.371, y = -231.135, z = 38.057, brokenOpen = false}, 
  [19] = {x = -625.810, y = -234.709, z = 38.057, brokenOpen = false}, 
  [20] = {x = -626.884, y = -233.117, z = 38.057, brokenOpen = false}, 
}

Citizen.CreateThread(function()
 while true do
  local coords = GetEntityCoords(GetPlayerPed(-1), false)
  Citizen.Wait(5)
  if not vangelicoRobbery and currentPolice >= 3 and not DecorGetBool(GetPlayerPed(-1), "isOfficer") and not DecorGetBool(GetPlayerPed(-1), "isParamedic") then
   if(GetDistanceBetweenCoords(coords, -621.297, -231.683, 38.057, true) < 25.0) then
    DrawMarker(25, -621.297, -231.683, 38.057-0.95, 0, 0, 0, 0, 0, 0, 0.8,0.8,0.5, 255, 15, 15, 200, 0, true, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(coords, -621.297, -231.683, 38.057, true) < 1.5) then
     drawTxt('~b~Pulse ~g~E~b~ Comenzar el robo de vangelicos')
     if IsControlJustPressed(0, 38) and IsPedArmed(GetPlayerPed(-1), 4) then
      TriggerServerEvent('vangelicoRobbery:start', {x = coords.x, y = coords.y, z = coords.z})
      TriggerServerEvent('addReputation', 10)
     end 
    end
   end
  end
  if vangelicoRobbery and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -621.297, -231.683, 38.057, true) > 20.0 then
   for i=1, 20 do cabinits[i].brokenOpen = false end
   TriggerServerEvent('vangelicoRobbery:cancel')
   vangelicoRobbery = false 
   Wait(300000)
  end
 end
end)

Citizen.CreateThread(function()
 while true do
  local coords = GetEntityCoords(GetPlayerPed(-1), false)
  Citizen.Wait(5)
  if vangelicoRobbery then 
   for i,v in pairs(cabinits) do
    if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 15.0) and not v.brokenOpen then
     DrawMarker(25, v.x, v.y, v.z-0.95, 0, 0, 0, 0, 0, 0, 0.5,0.5,0.5, 255, 15, 15, 200, 0, true, 2, 0, 0, 0, 0)
     if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.0) then
      drawTxt('~b~Pulse ~g~E~b~ Para romper el gabinete abierto')
      if IsControlJustPressed(0, 38) then
       v.brokenOpen = true
       loadAnimDict("missheist_jewel") 
       TaskPlayAnim(GetPlayerPed(-1), "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
       Citizen.Wait(7500)
       ClearPedTasksImmediately(GetPlayerPed(-1))
       PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
       TriggerEvent("inventory:addQty", 88, math.random(1,2))
      end 
     end
    end
   end
  end
 end
end)

RegisterNetEvent('vangelicoRobbery:started')
AddEventHandler('vangelicoRobbery:started', function()
 vangelicoRobbery = true
 spawnGuards()
end)  

RegisterNetEvent('vangelicoRobbery:ended')
AddEventHandler('vangelicoRobbery:ended', function()
 vangelicoRobbery = false
end)  

RegisterNetEvent('hud:updatepresence')
AddEventHandler('hud:updatepresence', function(copss)
 currentPolice = copss
end)  

function loadAnimDict( dict )  
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 

local guardLocations = {
 {x = -631.406, y = -229.196, z = 38.057, heading = 14.867}, 
 {x = -626.708, y = -224.322, z = 38.057, heading = 216.267}, 
}

function loadModel(model)
 RequestModel(GetHashKey(model))
 while not HasModelLoaded(GetHashKey(model)) do
  Wait(0)
 end
end

function spawnGuards()
 local randomSpawns = ran
 for i,v in pairs(guardLocations) do 
   loadModel('s_m_m_highsec_01')
   local ped = CreatePed(4, GetHashKey('s_m_m_highsec_01'), v.x, v.y, v.z, v.heading, true, true)
   SetPedShootRate(ped, 900)
   SetPedAlertness(ped, 3)
   SetPedAccuracy(ped, 100)
   SetEntityMaxHealth(ped, 450)
   SetEntityHealth(ped, 450)
   SetPedArmour(ped, 250)
   SetPedFleeAttributes(ped, 0, 0)
   SetPedCombatAttributes(ped, 46, true)
   SetPedCombatAbility(ped, 2)
   SetPedCombatRange(ped, 2)
   SetPedPathAvoidFire(ped, 1)
   SetPedGeneratesDeadBodyEvents(ped, 1)
   GiveWeaponToPed(ped, GetHashKey("WEAPON_COMBATPISTOL"), 5000, true, true)
   SetPedRelationshipGroupHash(ped, GetHashKey("COP"))
   SetPedRelationshipGroupHash(ped, "COP")
   SetModelAsNoLongerNeeded(GetHashKey('s_m_m_highsec_01')) 
   TaskShootAtEntity(ped, GetPlayerPed(-1), 25000, GetHashKey("FIRING_PATTERN_FULL_AUTO"))
 end
end


