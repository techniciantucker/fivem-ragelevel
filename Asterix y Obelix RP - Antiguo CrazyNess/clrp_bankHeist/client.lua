local robberyInProgress = false 
local robberyInWaiting = false 
local currentPolice = 0
local totalPayOut = 0
local brokenOpen = 0 
local hostageLocations = {
 {x = 242.851, y = 223.885, z = 106.287, heading = 340.081, model = 'a_m_y_business_03'}, 
 {x = 247.193, y = 218.027, z = 106.287, heading = 264.487, model = 'a_f_m_business_02'}, 
 {x = 251.518, y = 221.341, z = 106.287, heading = 335.102, model = 'a_m_y_vinewood_02'}, 
 {x = 251.021, y = 219.823, z = 106.287, heading = 337.044, model = 'a_f_y_indian_01'}, 
 {x = 252.319, y = 223.404, z = 106.287, heading = 161.139, model = 'a_f_y_business_04'}, 
 {x = 243.648, y = 226.282, z = 106.288, heading = 159.647, model = 'a_f_y_business_04'}, 
 {x = 243.280, y = 229.495, z = 106.287, heading = 249.880, model = 'ig_bankman'}, 
}

local guardLocations = {
 {x = 234.979, y = 212.646, z = 110.283, heading = 341.230}, 
 {x = 236.364, y = 229.621, z = 110.278, heading = 272.020}, 
 {x = 258.183, y = 206.046, z = 110.283, heading = 345.461}, 
 {x = 266.883, y = 222.378, z = 110.283, heading = 351.867}, 
}

local securityBoxes = {
{x = 263.561, y = 216.314, z = 101.683, heading = 342.185, isOpen = false},
{x = 264.648, y = 215.954, z = 101.683, heading = 342.185, isOpen = false},
{x = 265.706, y = 215.503, z = 101.683, heading = 342.185, isOpen = false},
{x = 266.174, y = 214.760, z = 101.683, heading = 247.370, isOpen = false},
{x = 265.923, y = 214.008, z = 101.683, heading = 247.370, isOpen = false},
{x = 265.539, y = 212.938, z = 101.683, heading = 247.370, isOpen = false},
{x = 264.440, y = 212.203, z = 101.683, heading = 162.370, isOpen = false},
{x = 263.342, y = 212.536, z = 101.683, heading = 162.370, isOpen = false},
{x = 262.194, y = 212.883, z = 101.683, heading = 162.370, isOpen = false},
}

local backDoors = {
 {enter = {x = 255.156, y = 228.445, z = 106.287}, exit = {x = 256.095, y = 275.090, z = 105.621}},
 {enter = {x = 255.400, y = 228.654, z = 101.683}, exit = {x = 283.800, y = 264.535, z = 105.585}}
}

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(5)
  if not robberyInWaiting and currentPolice >= 6 then 
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 253.489, 228.302, 101.683, true) < 25.0) then
    DrawMarker(25, 253.489, 228.302, 101.683-0.99, 0, 0, 0, 0, 0, 0, 0.8,0.8,0.5, 255, 15, 15, 200, 0, true, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 253.489, 228.302, 101.683, true) < 1.2) then
     drawTxt('~b~Pulse ~g~E~b~ Iniciar el robo del banco')
     if IsControlJustPressed(0, 38) and IsPedArmed(GetPlayerPed(-1), 4) then
      TriggerServerEvent('bankHeist:begin')
      robberyInWaiting = true
     end 
    end
   end
  end
 end
end)

RegisterNetEvent('bankHeist:begin')
AddEventHandler('bankHeist:begin', function(robberID)
 robberyInProgress = true
 if robberID == 3 then 
  spawnHostages()
  spawnGuards()
 end
 if ProgressBar('Heist In Progress', 2500) then 
  local pos = GetEntityCoords(GetPlayerPed(-1), false)
  local vaultDoor = GetClosestObjectOfType(pos.x, pos.y, pos.z, 100.0, 961976194, 0, 0, 0)
  local vaultHeading = GetEntityHeading(vaultDoor)
  while round(vaultHeading, 1) ~= 20.0 do 
   Citizen.Wait(0)
   SetEntityHeading(vaultDoor, round(vaultHeading, 1) - 0.1)  
   vaultHeading = GetEntityHeading(vaultDoor)
  end
  while robberyInProgress do
   local coords = GetEntityCoords(GetPlayerPed(-1))
   Citizen.Wait(5)
   for i,v in pairs(securityBoxes) do 
    if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 15.0) and not v.isOpen and robberID == 3 then
     DrawMarker(25, v.x, v.y, v.z-0.99, 0, 0, 0, 0, 0, 0, 0.4,0.4,0.5, 255, 15, 15, 150, 0, true, 2, 0, 0, 0, 0)
     if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 0.75) then
      drawTxt('~b~Pulse ~g~E~b~ Para romper la caja de seguridad abierta')
      if IsControlJustPressed(0, 38) then
       SetEntityCoords(GetPlayerPed(-1), v.x, v.y, v.z-0.95)
       SetEntityHeading(GetPlayerPed(-1), v.heading)
 	     v.isOpen = true 
       local drillObject = CreateObject(GetHashKey('hei_prop_heist_drill'), 0.0, 0.0, 0.0, true, true, true)

 	   -- Breaking Open Animation
       loadModel('hei_prop_heist_drill')
       loadAnimation("anim@heists@fleeca_bank@drilling")
       TaskPlayAnim(GetPlayerPed(-1), "anim@heists@fleeca_bank@drilling", "intro", 8.0, 1.0, -1, 2, 0, 0, 0, 0)
       AttachEntityToEntity(drillObject, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
       Wait(6200)
       TaskPlayAnim(GetPlayerPed(-1), "anim@heists@fleeca_bank@drilling", "drill_straight_start", 8.0, 1.0, -1, 2, 0, 0, 0, 0)
       Wait(5000)
       TaskPlayAnim(GetPlayerPed(-1), "anim@heists@fleeca_bank@drilling", "outro", 8.0, 1.0, -1, 2, 0, 0, 0, 0)
       PlaySoundFrontend(-1, "Drill_Pin_Break", 'DLC_HEIST_FLEECA_SOUNDSET', 1);
       Wait(5000)
       ClearPedTasks(GetPlayerPed(-1))
       DeleteObject(drillObject)
       local payOut = math.random(100000, 200000)
       totalPayOut = totalPayOut+payOut
       brokenOpen = brokenOpen+1
       TriggerServerEvent('bankHeist:payOut', payOut, totalPayOut)
       if brokenOpen == 9 then TriggerServerEvent('bankHeist:finished') end
      end 
     end
    end
   end
  
   -- Lockpickable Backdoors
   for i,v in pairs(backDoors) do 
    if(GetDistanceBetweenCoords(coords, v.enter.x, v.enter.y, v.enter.z, true) < 10.0) and exports['core']:GetItemQuantity(89) > 0 then
     DrawMarker(25, v.enter.x, v.enter.y, v.enter.z-0.99, 0, 0, 0, 0, 0, 0, 0.8,0.8,0.5, 255, 15, 15, 150, 0, true, 2, 0, 0, 0, 0)
     if(GetDistanceBetweenCoords(coords, v.enter.x, v.enter.y, v.enter.z, true) < 1.2) then
      drawTxt('~b~Pulse ~g~E ~b~To Lockpick Backdoor')
      if IsControlJustPressed(0, 38) then 
       if ProgressBar('Lockpicking In Progress', 250) then 
        Teleport(v.exit.x, v.exit.y, v.exit.z-0.95)
        robberyInProgress = false 
        robberyInWaiting = false 
        totalPayOut = 0
       end
      end
     end
    end
   end
  end
 end
end)

RegisterNetEvent('hud:updatepresence')
AddEventHandler('hud:updatepresence', function(copss)
 currentPolice = copss
end)

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

function spawnGuards()
 for i,v in pairs(guardLocations) do 
  loadModel('s_m_m_highsec_01')
  local ped = CreatePed(4, GetHashKey('s_m_m_highsec_01'), v.x, v.y, v.z, v.heading, true, true)
  SetPedShootRate(ped, 950)
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
  if math.random(1,10) > 7 then
   GiveWeaponToPed(ped, GetHashKey("WEAPON_COMBATPDW"), 5000, true, true)
  else
   GiveWeaponToPed(ped, GetHashKey("WEAPON_COMBATPISTOL"), 5000, true, true)
  end
  SetPedRelationshipGroupHash(ped, GetHashKey("security_guard"))
  SetModelAsNoLongerNeeded(GetHashKey(v.model)) 
 end
end

function round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

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

function Teleport(x,y,z)
  Wait(100)
  RequestCollisionAtCoord(x,y,z)
  while not HasCollisionLoadedAroundEntity(GetPlayerPed(-1)) do 
    RequestCollisionAtCoord(x,y,z)
    Citizen.Wait(0)
  end
  SetEntityCoords(GetPlayerPed(-1), x,y,z)
end

-- Progress Bar 

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

RegisterNetEvent('bankHeist:killBlip')
AddEventHandler('bankHeist:killBlip', function()
 if DoesBlipExist(robberyBlip) then 
  RemoveBlip(robberyBlip)
 end
end)

RegisterNetEvent('bankHeist:addBlip')
AddEventHandler('bankHeist:addBlip', function()
 if DecorGetBool(GetPlayerPed(-1), "isOfficer") then
  if not DoesBlipExist(robberyBlip) then 
   robberyBlip = AddBlipForCoord(253.489, 228.302, 101.683) 
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
