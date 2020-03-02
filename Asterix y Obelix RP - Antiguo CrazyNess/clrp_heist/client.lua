local missionVehicle = nil
local missionPeds = {}
local isMissionActive = false

-- after attack, make them blow open back doors using bs tech
-- give money after all dead and back doors are open
-- call police when truck is attacked
-- do shit and things


RegisterNetEvent('heist:start')
AddEventHandler('heist:start', function()
 spawnMoneyTruck()
 isMissionActive = true
 print('Misión iniciada')
end)

Citizen.CreateThread(function()
 TriggerEvent('heist:start')
 while true do
  Citizen.Wait(5)
  if DoesEntityExist(missionVehicle) and isMissionActive then
   -- Heist Finished
   if GetDistanceBetweenCoords(GetEntityCoords(missionVehicle), -19.337, -672.261, 32.338, false) < 5 then 
    SetEntityAsMissionEntity(missionVehicle, true, true)
    DeleteVehicle(missionVehicle)
    for i=1, 4 do 
     DeletePed(missionPeds[i]) 
    end
    print('Nadie atacó el camión, se eliminaron los peds - Misión finalizada')
   end
  else 
   Citizen.Wait(2500)
  end
 end
end)


function spawnMoneyTruck()
 setupModel(GetHashKey("stockade"))
 setupModel(GetHashKey("s_m_m_security_01"))
 missionVehicle = CreateVehicle(GetHashKey("stockade"), -123.553, 6479.601, 31.465, 133.145, true, false)
 RequestCollisionForModel(GetHashKey("stockade"))
 NetworkRegisterEntityAsNetworked(missionVehicle)
 SetEntityAsMissionEntity(missionVehicle, true, true)
 SetVehicleDoorsLocked(missionVehicle, 7)
 SetEntityAsNoLongerNeeded(missionVehicle)
 SetVehicleOnGroundProperly(missionVehicle)
 for i=1, 4 do
  missionPeds[i] = CreatePedInsideVehicle(missionVehicle, 2, GetHashKey("s_m_m_security_01"), getFreeVehicleSeat(missionVehicle), true, false)
  SetEntityAsMissionEntity(missionPeds[i], 1, 1)
  setGaurd(missionPeds[i])
 end
 TaskVehicleDriveToCoordLongrange(missionPeds[1], missionVehicle, -19.337, -672.261, 32.338, 35.0, 447, 1.0)
end

function getFreeVehicleSeat(vehicle)
 if(IsVehicleSeatFree(vehicle, -1)) then
  return -1
 elseif(IsVehicleSeatFree(vehicle, 0)) then
  return 0 
 elseif(IsVehicleSeatFree(vehicle, 1)) then
  return 1 
 elseif(IsVehicleSeatFree(vehicle, 2)) then
  return 2 
 end
end

function setupModel(model)
  RequestModel(model)
  while not HasModelLoaded(model) do
    RequestModel(model)
    Wait(0)
  end
  SetModelAsNoLongerNeeded(model)
end

function setGaurd(ped)
 SetPedShootRate(ped, 800)
 SetPedAlertness(ped, 3)
 SetPedAccuracy(ped, 100)
 SetPedCanSwitchWeapon(ped, true)
 SetEntityMaxHealth(ped, 800)
 SetEntityHealth(ped, 800)
 SetPedArmour(ped, 150)
 SetPedFleeAttributes(ped, 0, 0)
 SetPedCombatAttributes(ped, 46, true)
 SetPedCombatAbility(ped, 2)
 SetPedCombatRange(ped, 95)
 SetPedPathAvoidFire(ped, 1)
 SetPedPathCanUseLadders(ped,1)
 SetPedPathCanDropFromHeight(ped, 1)
 SetPedPathPreferToAvoidWater(ped, 1)
 SetPedGeneratesDeadBodyEvents(ped, 1)
 SetPedCombatAttributes(Ped, 5, true)	
 SetPedCombatAttributes(Ped, 16, true)
 SetPedCombatAttributes(Ped, 46, true)
 SetPedCombatAttributes(Ped, 26, true)
 SetPedCombatAttributes(Ped, 3, false)
 SetPedCombatAttributes(Ped, 2, true)
 if math.random(1,10) > 7 then
  GiveWeaponToPed(ped, GetHashKey("WEAPON_COMBATPDW"), 5000, true, true)
 else
  GiveWeaponToPed(ped, GetHashKey("WEAPON_COMBATPISTOL"), 5000, true, true)
 end
 SetPedRelationshipGroupHash(ped, GetHashKey("security_guard"))
end