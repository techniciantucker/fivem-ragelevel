--============================--
-- Capital Life RP Job System --
--============================--
local missionblip = nil
local blip = nil 
local vehicle = nil

function getParkingPosition(spots)
 for id,v in pairs(spots) do 
  if GetClosestVehicle(v.x, v.y, v.z, 3.0, 0, 70) == 0 then  
   return true, v
  end
 end 
 TriggerEvent('chatMessage', '^1Estacionamiento lleno, por favor espere')
end

function SetWorkPlace(x,y,z)
 if DoesBlipExist(blip) then RemoveBlip(blip) end
 blip = AddBlipForCoord(x, y, z)
 SetBlipSprite (blip, 430)
 SetBlipDisplay(blip, 4)
 SetBlipScale  (blip, 0.8)
 SetBlipColour (blip, 18)
 SetBlipAsShortRange(blip, true)
 BeginTextCommandSetBlipName("STRING")
 AddTextComponentString("Work Place")
 EndTextCommandSetBlipName(blip)
end 

function SpawnJobVehicle(model, x,y,z)
 if DoesEntityExist(vehicle) then DeleteVehicle(vehicle) end
 local vehiclehash = GetHashKey(model)
 RequestModel(vehiclehash)
 while not HasModelLoaded(vehiclehash) do
  Citizen.Wait(0)
 end
 vehicle = CreateVehicle(vehiclehash, x,y,z, GetEntityHeading(PlayerPedId()), true, false)
 SetVehicleDirtLevel(vehicle, 0)
 TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
 SetVehicleHasBeenOwnedByPlayer(vehicle, true)
 SetEntityAsMissionEntity(vehicle, true, true)
 SetVehicleMod(vehicle,16, 20)
 SetVehicleEngineOn(vehicle, true)
 SetVehicleLivery(vehicle, vehlivery)
 DecorSetInt(vehicle, "_Fuel_Level", 75000)
end

function SetJobBlip(x,y,z)
 if DoesBlipExist(missionblip) then RemoveBlip(missionblip) end
 missionblip = AddBlipForCoord(x,y,z)
 SetBlipSprite(missionblip, 164)
 SetBlipColour(missionblip, 53)
 SetBlipRoute(missionblip, true)
 BeginTextCommandSetBlipName("STRING")
 AddTextComponentString("Destination")
 EndTextCommandSetBlipName(missionblip)
end



function RemoveJobBlip()
 if DoesBlipExist(missionblip) then RemoveBlip(missionblip) end
end

function Notify(message)
 exports.pNotify:SendNotification({text = message})
end

function LoadAnim(animDict)
  RequestAnimDict(animDict)

  while not HasAnimDictLoaded(animDict) do
    Citizen.Wait(10)
  end
end

function LoadModel(model)
  RequestModel(model)

  while not HasModelLoaded(model) do
    Citizen.Wait(10)
  end
end
