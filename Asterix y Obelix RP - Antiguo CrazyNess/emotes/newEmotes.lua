local smokeProp = nil
local cigarProp = nil 
local jointProp = nil 
local hasSmokes = true

RegisterCommand("smoke", function(source, args, rawCommand)
 loadAnim('mp_player_int_uppersmoke')
 if exports['core']:GetItemQuantity(15) > 0 then
  if smokeProp == nil then 
   if not HasNamedPtfxAssetLoaded('cut_chinese1') then
    RequestNamedPtfxAsset('cut_chinese1')
    while not HasNamedPtfxAssetLoaded('cut_chinese1') do
     Wait(1)
    end
   end
   SetPtfxAssetNextCall('cut_chinese1')
   TriggerEvent("inventory:removeQty", 15, 1)
   smokeProp = CreateObject(GetHashKey('prop_amb_ciggy_01'), 0.0, 0.0, 0.0, true, true, true)
   AttachEntityToEntity(smokeProp, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 26611), 0.035, -0.01, -0.010, 100.0, 0.0, -100.0, true, true, false, true, 1, true)
   TaskPlayAnim(GetPlayerPed(-1), 'mp_player_int_uppersmoke', 'mp_player_int_smoke', 3.0, -1, -1, 63, 1, false, false, false)
   StartParticleFxLoopedOnEntity('cs_cig_smoke', smokeProp, -0.08, 0.0, 0.0, 0.1, 0.0, 0.0, 1.25, false, false, false)
  else 
   DetachEntity(smokeProp, GetPlayerPed(-1), false)
   DeleteObject(smokeProp)
   ClearPedTasks(GetPlayerPed(-1))
   smokeProp = nil 
  end
 end
end)

RegisterCommand("joint", function(source, args, rawCommand)
 loadAnim('mp_player_int_uppersmoke')
 if exports['core']:GetItemQuantity(17) > 0 then
  if jointProp == nil then 
   if not HasNamedPtfxAssetLoaded('cut_chinese1') then
    RequestNamedPtfxAsset('cut_chinese1')
    while not HasNamedPtfxAssetLoaded('cut_chinese1') do
     Wait(1)
    end
   end
   SetPtfxAssetNextCall('cut_chinese1')
   TriggerEvent("inventory:removeQty", 17, 1)
   jointProp = CreateObject(GetHashKey('p_cs_joint_02'), 0.0, 0.0, 0.0, true, true, true)
   AttachEntityToEntity(jointProp, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 26611), 0.035, -0.01, -0.010, 100.0, 0.0, -100.0, true, true, false, true, 1, true)
   TaskPlayAnim(GetPlayerPed(-1), 'mp_player_int_uppersmoke', 'mp_player_int_smoke', 3.0, -1, -1, 63, 1, false, false, false)
   StartParticleFxLoopedOnEntity('cs_cig_smoke', jointProp, -0.095, 0.0, 0.0, 0.1, 0.0, 0.0, 1.25, false, false, false)
  else 
   DetachEntity(jointProp, GetPlayerPed(-1), false)
   DeleteObject(jointProp)
   ClearPedTasks(GetPlayerPed(-1))
   jointProp = nil 
  end
 end
end)

RegisterCommand("cigar", function(source, args, rawCommand)
 loadAnim('mp_player_int_uppersmoke')
 if exports['core']:GetItemQuantity(16) > 0 then
  if cigarProp == nil then 
   if not HasNamedPtfxAssetLoaded('cut_chinese1') then
    RequestNamedPtfxAsset('cut_chinese1')
    while not HasNamedPtfxAssetLoaded('cut_chinese1') do
     Wait(1)
    end
   end
   SetPtfxAssetNextCall('cut_chinese1')
   TriggerEvent("inventory:removeQty", 16, 1)
   cigarProp = CreateObject(GetHashKey('prop_cigar_03'), 0.0, 0.0, 0.0, true, true, true)
   AttachEntityToEntity(cigarProp, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 26611), 0.050, 0.080, -0.010, 100.0, 0.0, -100.0, true, true, false, true, 1, true)
   TaskPlayAnim(GetPlayerPed(-1), 'mp_player_int_uppersmoke', 'mp_player_int_smoke', 3.0, -1, -1, 63, 1, false, false, false)
   StartParticleFxLoopedOnEntity('cs_cig_smoke', cigarProp, -0.005, 0.0, 0.0, 0.1, 0.0, 0.0, 1.25, false, false, false)
  else 
   DetachEntity(cigarProp, GetPlayerPed(-1), false)
   DeleteObject(cigarProp)
   ClearPedTasks(GetPlayerPed(-1))
   cigarProp = nil 
  end
 end
end)



--- teste
RegisterCommand("kidnap", function(source, args, rawCommand)
 local closestPed = getNPC()

 if not IsEntityAttachedToEntity(closestPed, GetPlayerPed(PlayerId())) then
  --TriggerEvent("dispatch:custom", '10-66')
  local finished = exports['clrp-taskbar']:taskBar(1000,"Obteniendo Clorhidrato de cocaína")
  if finished == 100 then
   if math.random(1, 10) >= 6 then
    loadAnim('nm')
    loadAnim('missfinale_c2mcs_1')
    if closestPed then
     local closestPed = getNPC()
     TaskPlayAnim(closestPed, 'nm', 'firemans_carry', 8.0, -1, -1, 1, 1, 0, 0, 0)
     AttachEntityToEntity(closestPed, GetPlayerPed(PlayerId()), GetPedBoneIndex(GetPlayerPed(PlayerId()), 40269), -0.1, 0.0, 0.1, 25.0, -290.0, -150.0, 1, 1, 0, 1, 0, 1)
     TaskPlayAnim(GetPlayerPed(PlayerId()), 'missfinale_c2mcs_1', 'fin_c2_mcs_1_camman', 1.0, -1, -1, 50, 0, 0, 0, 0)
    end
   else
    TaskCombatPed(closestPed, PlayerPedId(), 0, 16)
    Citizen.Wait(10000)
    TaskReactAndFleePed(closestPed, PlayerPedId())
   end
  end
 else
  DetachEntity(closestPed, GetPlayerPed(PlayerId()), true)
  ClearPedTasksImmediately(closestPed)
  ClearPedTasksImmediately(GetPlayerPed(PlayerId()))
 end
end)
--- New Commands
local isCarrying = false

RegisterCommand("carry", function(source, args, rawCommand)
 loadAnim('missfinale_c2mcs_1')
 local t, distance = GetClosestPlayer()
 if(distance ~= -1 and distance < 3) then 
  --if DecorGetBool(GetPlayerPed(t), "Handsup") then
   if isCarrying then 
    ClearPedTasksImmediately(GetPlayerPed(PlayerId()))
    TriggerServerEvent('anims:carry', GetPlayerServerId(t))
    isCarrying = false
   else   
    isCarrying = true 
    TriggerServerEvent('anims:carry', GetPlayerServerId(t))
    TaskPlayAnim(GetPlayerPed(PlayerId()), 'missfinale_c2mcs_1', 'fin_c2_mcs_1_camman', 1.0, -1, -1, 50, 0, 0, 0, 0)
   end
  --end
 end
end)

RegisterNetEvent('anims:doCarry')
AddEventHandler('anims:doCarry', function(otherPlayer)
 if IsEntityAttachedToEntity(GetPlayerPed(PlayerId()), GetPlayerPed(GetPlayerFromServerId(otherPlayer))) then
  DetachEntity(GetPlayerPed(PlayerId()), GetPlayerPed(GetPlayerFromServerId(otherPlayer)), true)
  ClearPedTasksImmediately(GetPlayerPed(PlayerId()))
 else 
  loadAnim('nm')
  AttachEntityToEntity(GetPlayerPed(PlayerId()), GetPlayerPed(GetPlayerFromServerId(otherPlayer)), GetPedBoneIndex(GetPlayerPed(PlayerId()), 40269), -0.1, 0.0, 0.1, 25.0, -290.0, -150.0, 1, 1, 0, 1, 0, 1)
  TaskPlayAnim(GetPlayerPed(PlayerId()), 'nm', 'firemans_carry', 8.0, -1, -1, 1, 1, 0, 0, 0)
 end 
end)

RegisterCommand("carryPed", function(source, args, rawCommand)
 loadAnim('nm')
 loadAnim('missfinale_c2mcs_1')
 local closestPed = getNPC()
 if closestPed then
  if IsEntityAttachedToEntity(closestPed, GetPlayerPed(PlayerId())) then 
   DetachEntity(closestPed, GetPlayerPed(PlayerId()), true)
   ClearPedTasksImmediately(closestPed)
   ClearPedTasksImmediately(GetPlayerPed(PlayerId()))
  else 
   local closestPed = getNPC()
   TaskPlayAnim(closestPed, 'nm', 'firemans_carry', 8.0, -1, -1, 1, 1, 0, 0, 0)
   AttachEntityToEntity(closestPed, GetPlayerPed(PlayerId()), GetPedBoneIndex(GetPlayerPed(PlayerId()), 40269), -0.1, 0.0, 0.1, 25.0, -290.0, -150.0, 1, 1, 0, 1, 0, 1)
   TaskPlayAnim(GetPlayerPed(PlayerId()), 'missfinale_c2mcs_1', 'fin_c2_mcs_1_camman', 1.0, -1, -1, 50, 0, 0, 0, 0)
  end
 end
end)

function loadProp(prop)
 RequestModel(GetHashKey(model))
 while not HasModelLoaded(GetHashKey(model)) do
  Citizen.Wait(1)
 end
end

function loadAnim(anim)
 RequestAnimDict(anim) 
 while not HasAnimDictLoaded(anim) do 
  Citizen.Wait(1) 
 end
end

function getNPC()
 local playerCoords = GetEntityCoords(GetPlayerPed(-1))
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
   SetEntityAsMissionEntity(rped, true, true)
  end
  success, ped = FindNextPed(handle)
  until not success
  EndFindPed(handle)
 return rped
end

function canPedBeUsed(ped)
 if ped == nil then return false end
 if ped == GetPlayerPed(-1) then return false end
 if not DoesEntityExist(ped) then return false end
 if not IsPedOnFoot(ped) then return false end
 if IsEntityDead(ped) then return false end
 if not IsPedHuman(ped) then return false end
 return true
end

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