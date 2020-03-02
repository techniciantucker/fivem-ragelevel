local isMissionActive = false
local vehicleSpawns = {
 {x = 24.686, y = -1739.761, z = 28.917, h = 51.106, vehicle = 'bodhi2', ped = 'a_m_y_gay_02'},
 {x = -17.388, y = -1412.411, z = 28.928, h = 269.906, vehicle = 'mesa', ped = 'a_m_y_gay_02'},
 {x = -643.430, y = -1217.833, z = 11.305, h = 300.190, vehicle = 'baller', ped = 'a_m_y_gay_02'},
 {x = -581.784, y = -1119.109, z = 21.796, h = 92.113, vehicle = 'felon2', ped = 'a_m_y_gay_02'},
 {x = -333.561, y = -903.937, z = 30.692, h = 167.936, vehicle = 'huntley', ped = 'a_m_y_gay_02'},
 {x = 209.384, y = -793.875, z = 30.810, h = 249.151, vehicle = 'issi', ped = 'a_m_y_gay_02'},
 {x = 890.539, y = -44.804, z = 78.680, h = 59.829, vehicle = 'zion', ped = 'a_m_y_gay_02'},
 {x = 2033.811, y = 3452.891, z = 43.482, h = 217.860, vehicle = 'vodoo', ped = 'a_m_y_gay_02'},
 {x = 888.774, y = 3647.808, z = 32.454, h = 290.304, vehicle = 'dominator', ped = 'a_m_y_gay_02'},
 {x = 209.049, y = 3160.262, z = 41.879, h = 0.483, vehicle = 'blade', ped = 'a_m_y_gay_02'},
 {x = -270.061, y = 6089.322, z = 31.216, h = 314.179, vehicle = 'felon', ped = 'a_m_y_gay_02'},
 {x = -140.129, y = 6495.668, z = 29.633, h = 351.992, vehicle = 'ruiner', ped = 'a_m_y_gay_02'},
 {x = 150.462, y = 6606.917, z = 31.489, h = 355.383, vehicle = 'tornado3', ped = 'a_m_y_gay_02'},
 {x = 2539.896, y = 2634.813, z = 37.861, h = 67.193, vehicle = 'tornado3', ped = 'a_m_y_gay_02'},
 -- TODO: ADD MORE LOCATIONS
}

AddEventHandler('tow:newMission', function()
 if isMissionActive then
  return
 end

 local mission = vehicleSpawns[math.random(1, #vehicleSpawns)]
 local closestShop = getNearestShop(mission.x, mission.y, mission.z)

 RequestModel(GetHashKey(mission.vehicle))
 while not HasModelLoaded(GetHashKey(mission.vehicle)) do
  Citizen.Wait(0)
 end

 RequestModel(GetHashKey(mission.ped))
 while not HasModelLoaded(GetHashKey(mission.ped)) do
  Citizen.Wait(0)
 end

 vehicle = CreateVehicle(GetHashKey(mission.vehicle), mission.x, mission.y, mission.z, mission.h, true, false)
 SetVehicleHasBeenOwnedByPlayer(vehicle, true)
 SetEntityAsMissionEntity(vehicle, true, true)
 SetVehicleOnGroundProperly(vehicle)


 SetVehicleDamage(vehicle, 0.0, 1.0, 0.1, math.random(100, 1000) + 0.0, 1850.0, true)
 SetVehicleDamage(vehicle, -0.2, 1.0, 0.5, math.random(100, 1000) + 0.0, 650.0, true)
 SetVehicleDamage(vehicle, -0.7, -0.2, 0.3, math.random(100, 1000) + 0.0, 500.0, true)

 SetVehicleEngineHealth(vehicle, math.random(0, 500))
 SetVehicleBodyHealth(vehicle, math.random(0, 500))

 if math.random(1, 10) >= 7 then
  SetVehicleTyreBurst(vehicle, math.random(1, 3), false, 1000.0)
 end

 -- ped = CreatePedInsideVehicle(vehicle, 2, GetHashKey(mission.ped), -1, true, false)
 --
 -- TaskLeaveVehicle(ped, vehicle, 64)
 -- SetPedFleeAttributes(ped, 0, 0)
 -- SetPedCombatAttributes(ped, 17, 1)
 -- SetPedSeeingRange(ped, 0.0)
 -- SetPedHearingRange(ped, 0.0)
 -- SetPedAlertness(ped, 0)


 SetNewWaypoint(mission.x, mission.y)
 isMissionActive = true

 while isMissionActive do
  Citizen.Wait(5)
  local playerCoords = GetEntityCoords(PlayerPedId(), false)

  if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, mission.x, mission.y, mission.z, true) < 50 and not IsEntityAttached(vehicle) then
   DrawMarker(2, mission.x, mission.y, mission.z+2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.9, 0.9, 0.9, 255, 255, 0, 255, true, true, 0, true, nil, nil, false)
   if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, mission.x, mission.y, mission.z, true) < 5 then
    showMessage('~w~Tow this vehicle back to the shop')
    if not IsWaypointActive() then
     SetNewWaypoint(closestShop.x, closestShop.y)
    end
   end
  end

  if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, closestShop.x, closestShop.y, closestShop.z, false) < 100 and not IsEntityAttached(vehicle) then
   if not DoesEntityExist(vehicle) then
    TriggerServerEvent('tow:complete')
    DeleteEntity(vehicle)
    DeleteEntity(ped)
    ped = nil
    vehicle = nil
    isMissionActive = false
   end
  end
 end
end)



function getNearestShop(x, y, z)
 local allMechanicShops = {
  [1] = {1135.558, -784.924, 56.619},
  [2] = {393.578, 3560.084, 16.239},
  [3] = {31.015, 6487.921, -13.446}
 }

 local shortestDistance = 100000
 local closestShop = {}
 for _,v in pairs(allMechanicShops) do
  local currentDistance = GetDistanceBetweenCoords(x, y, z, v[1], v[2], v[3], true)
  if currentDistance < shortestDistance then
   shortestDistance = currentDistance
   closestShop["x"] = v[1]
   closestShop["y"] = v[2]
   closestShop["z"] = v[3]
  end
 end

 return closestShop
end

function showMessage(msg)
 BeginTextCommandDisplayHelp("STRING")
 AddTextComponentScaleform(msg)
 EndTextCommandDisplayHelp(0, false, false, -1)
end
