--[[local relationshipTypes = {
 {group = "AMBIENT_GANG_LOST", name = 'The Lost MC'},
 {group = "AMBIENT_GANG_MEXICAN", name = 'The Mexican Cartel'},
 {group = "AMBIENT_GANG_FAMILY", name = 'The Familys'},
 {group = "AMBIENT_GANG_BALLAS", name = 'The Ballas'},
 {group = "AMBIENT_GANG_MARABUNTE", name = 'The Marabunte'},
 {group = "AMBIENT_GANG_CULT", name = 'The Cult'},
 {group = "AMBIENT_GANG_SALVA", name = 'The Salva'},
 {group = "AMBIENT_GANG_WEICHENG", name = 'The Weicheng'},
 {group = "AMBIENT_GANG_HILLBILLY", name = 'The Hillbillys'},
} 


Citizen.CreateThread(function()
 RemovePedFromGroup(PlayerPedId())
 while true do 
  Citizen.Wait(5)
  
  local currentNPC = getNPC()
  if DoesEntityExist(currentNPC) then 
   for id, v in pairs(relationshipTypes) do 
    if GetPedRelationshipGroupHash(currentNPC) == GetHashKey(v.group) then 
     print('Ped Is Part Of '..v.name)
    end
   end
  end  
 end
end)


-- Finding Random NPCS
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
 if IsPedAPlayer(ped) then return false end
 return true
end

local localEMS = {}
local onScene = false

RegisterCommand("ems", function(source, args, rawCommand)
 local ped = PlayerPedId()
 local pos = GetEntityCoords(ped, true)

 LoadModel('ambulance')
 LoadModel('s_m_m_paramedic_01')

 localEMS['vehicle'] = CreateVehicle(GetHashKey('ambulance'), 328.434, -548.366, 28.744, 270.711, true, false)
 localEMS['ped'] = CreatePedInsideVehicle(localEMS['vehicle'], 5, GetHashKey('s_m_m_paramedic_01'), -1, true, false)

 SetVehicleEngineOn(localEMS['vehicle'], true, true)
 SetVehicleLivery(localEMS['vehicle'], 3)
 SetVehicleSiren(localEMS['vehicle'], true)

 SetDriveTaskDrivingStyle(localEMS['ped'], 1074528293)
 SetDriverAbility(localEMS['ped'], 1.0)

 local backupUnit = AddBlipForEntity(localEMS['vehicle'])
 SetBlipSprite(backupUnit, 56)
 SetBlipColour(backupUnit, 7)

 TaskVehicleDriveToCoordLongrange(localEMS['ped'], localEMS['vehicle'], pos.x, pos.y, pos.z, 20.0, 1074004284, 15.0)

 while not onScene do 
  Citizen.Wait(5)
  if GetDistanceBetweenCoords(GetEntityCoords(localEMS['ped'], false), pos.x, pos.y, pos.z, false) < 15.0 then  
   onScene = true 
   break
  end
 end 

 while GetEntitySpeed(localEMS['vehicle']) > 1 do 
  Citizen.Wait(5)
 end

 TaskLeaveVehicle(localEMS['ped'], localEMS['vehicle'], 256)

 while IsPedInAnyVehicle(localEMS['ped'], false) do 
  Citizen.Wait(1)
 end

 TaskGoToEntity(localEMS['ped'], ped, -1, 1.0, 10.0, 1073741824.0, 0)(localEMS['ped'], ped, -1, 1.0, 10.0, 1073741824.0, 0)


 while not arrived do
  Citizen.Wait(5)
  if GetDistanceBetweenCoords(GetEntityCoords(localEMS['ped'], false), pos.x, pos.y, pos.z, false) < 2.5 then  
   break
  end
 end

 TaskStartScenarioInPlace(localEMS['ped'], 'CODE_HUMAN_MEDIC_KNEEL', 0, true)
 Wait(2500)
 ClearPedTasksImmediately(localEMS['ped'])
 
 DoScreenFadeOut(1000)
 Citizen.Wait(5000)
 NetworkResurrectLocalPlayer(pos.x, pos.y, pos.z, true, true, false)
 TaskWarpPedIntoVehicle(ped, localEMS['vehicle'], 1)
 TaskWarpPedIntoVehicle(localEMS['ped'], localEMS['vehicle'], -1)
 Citizen.Wait(5000)
 DoScreenFadeIn(1000)

 TaskVehicleDriveToCoordLongrange(localEMS['ped'], localEMS['vehicle'], 363.867, -593.083, 28.682, 15.0, 1074004284, 2.0)

 while not arrived do
  Citizen.Wait(5)
  if GetDistanceBetweenCoords(GetEntityCoords(localEMS['ped'], false), 363.867, -593.083, 28.682, false) < 10.0 then  
   break
  end
 end
 
 DoScreenFadeOut(1000)
 Citizen.Wait(5000)
 DeletePed(localEMS['ped'])
 DeleteVehicle(localEMS['vehicle'])
 SetEntityCoords(ped, 349.024, -589.890, 43.315)
 ExecuteCommand('bed')
 ExecuteCommand('bed')
 ExecuteCommand('bed')
 TriggerEvent('ems:heal')
 Citizen.Wait(5000)
 DoScreenFadeIn(1000)
end)

]]


