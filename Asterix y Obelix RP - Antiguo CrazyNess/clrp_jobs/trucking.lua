local onDuty = true
local onMission = false
local trailerSpawned = false
local missionBlip = nil
local missionTrailer = nil
local currentPolice = 0
local runningMission = nil
local truckingStops = {[1] = {x = 1985.520, y = 3049.130, z = 47.215}}
local truckingJobs = {
 [1] = {['Name'] = 'Ron Delivery', ['Trailer'] = 'tanker2', ['Start'] = {x = -267.358, y = -2506.178, z = 6.001, h = 230.104}, ['End'] = {x = 2554.392, y = 420.714, z = 108.458}, ['Time'] = 8, ['Pay'] = 11500, ['ID'] = 1, ['Timeout'] = 0},
 [2] = {['Name'] = 'Ron Delivery 2', ['Trailer'] = 'tanker2', ['Start'] = {x = -431.124, y = -2712.927, z = 6.000, h = 226.780}, ['End'] = {x = 2690.955, y = 3271.511, z = 55.241}, ['Time'] = 10, ['Pay'] = 15500, ['ID'] = 2, ['Timeout'] = 0},
 [3] = {['Name'] = 'Clucking Delivery', ['Trailer'] = 'Trailers2', ['Start'] = {x = -270.609, y = 6068.515, z = 31.465, h = 135.597}, ['End'] = {x = -250.442, y = -249.834, z = 36.519}, ['Time'] = 10, ['Pay'] = 14500, ['ID'] = 3, ['Timeout'] = 0},
 [4] = {['Name'] = 'Vehicle Delivery', ['Trailer'] = 'TR4', ['Start'] = {x = 2125.896, y = 4814.746, z = 41.196, h = 112.546}, ['End'] = {x = -18.794, y = -1110.080, z = 26.672}, ['Time'] = 10, ['Pay'] = 14750, ['ID'] = 4, ['Timeout'] = 0},
 [5] = {['Name'] = 'Weapon Delivery', ['Trailer'] = 'TrailerS4', ['Start'] = {x = -318.258, y = 6094.551, z = 31.462, h = 224.977}, ['End'] = {x = -12.162, y = -1023.656, z = 28.979}, ['Time'] = 12, ['Pay'] = 15750, ['ID'] = 5, ['Timeout'] = 0},
 [6] = {['Name'] = 'Military Delivery', ['Trailer'] = 'ArmyTanker', ['Start'] = {x = -818.411, y = -2633.347, z = 13.812, h = 220.622}, ['End'] = {x = -2126.148, y = 3248.155, z = 32.810}, ['Time'] = 13, ['Pay'] = 15750, ['ID'] = 6, ['Timeout'] = 0},
 [7] = {['Name'] = 'Lumber Delivery', ['Trailer'] = 'TrailerLogs', ['Start'] = {x = 1201.779, y = -1317.171, z = 35.225, h = 348.208}, ['End'] = {x = 2233.997, y = 5148.706, z = 56.214}, ['Time'] = 14, ['Pay'] = 16750, ['ID'] = 7, ['Timeout'] = 0},
 [8] = {['Name'] = 'General Delivery', ['Trailer'] = 'Trailers2', ['Start'] = {x = 891.429, y = -1535.160, z = 30.327, h = 128.036}, ['End'] = {x = -262.187, y = 6061.911, z = 31.565}, ['Time'] = 13, ['Pay'] = 15750, ['ID'] = 8, ['Timeout'] = 0},
 [9] = {['Name'] = 'Ron Delivery 3', ['Trailer'] = 'tanker2', ['Start'] = {x = 30.511, y = -2468.861, z = 6.007, h = 146.296}, ['End'] = {x = -526.724, y = -1210.757, z = 18.185}, ['Time'] = 7, ['Pay'] = 8500, ['ID'] = 9, ['Timeout'] = 0},
 [10] = {['Name'] = 'Ron Delivery 4', ['Trailer'] = 'tanker2', ['Start'] = {x = -833.247, y = -2659.469, z = 13.812, h = 240.447}, ['End'] = {x = 1198.329, y = -1390.379, z = 35.228}, ['Time'] = 10, ['Pay'] = 10000, ['ID'] = 10, ['Timeout'] = 0},
 [11] = {['Name'] = 'Clucking Delivery 2', ['Trailer'] = 'Trailers2', ['Start'] = {x = 11.912, y = 6275.024, z = 31.247, h = 118.225}, ['End'] = {x = 1855.807, y = 2533.688, z = 45.672}, ['Time'] = 10, ['Pay'] = 14500, ['ID'] = 11, ['Timeout'] = 0},
 [12] = {['Name'] = 'Vehicle Delivery 2', ['Trailer'] = 'TR4', ['Start'] = {x = 1691.773, y = 3261.190, z = 40.877, h = 284.563}, ['End'] = {x = -20.654, y = -1113.054, z = 26.672}, ['Time'] = 9, ['Pay'] = 13000, ['ID'] = 12, ['Timeout'] = 0},
 [13] = {['Name'] = 'Vehicle Delivery 3', ['Trailer'] = 'TR4', ['Start'] = {x = -44.711, y = -1075.836, z = 26.700, h = 70.744}, ['End'] = {x = -978.544, y = -2865.713, z = 13.948}, ['Time'] = 7, ['Pay'] = 8000, ['ID'] = 13, ['Timeout'] = 0},
 [14] = {['Name'] = 'Weapon Delivery', ['Trailer'] = 'TrailerS4', ['Start'] = {x = 1055.822, y = -3132.256, z = 5.901, h = 351.877}, ['End'] = {x = -321.916, y = 6097.657, z = 31.462}, ['Time'] = 14, ['Pay'] = 15750, ['ID'] = 14, ['Timeout'] = 0},
 [15] = {['Name'] = 'Military Delivery', ['Trailer'] = 'ArmyTanker', ['Start'] = {x = -978.307, y = -2866.010, z = 13.948, h = 58.726}, ['End'] = {x = -2268.314, y = 3446.501, z = 31.615}, ['Time'] = 15, ['Pay'] = 15750, ['ID'] = 15, ['Timeout'] = 0},
}

function beginMission(currentMission)
 local isTrailerAttached = false 
 local missionTruck = GetVehiclePedIsIn(GetPlayerPed(-1), false)
 runningMission = currentMission
 onMission = true 
 SetNewWaypoint(currentMission['Start']['x'], currentMission['Start']['y'])
 while onMission do
  Citizen.Wait(5)
  if not isTrailerAttached then
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1), false), currentMission['Start']['x'], currentMission['Start']['y'], currentMission['Start']['z'], true) < 50) then
    DrawMarker(2, currentMission['Start']['x'], currentMission['Start']['y'], currentMission['Start']['z']+5.0, 0, 0, 0, 0, 0, 0, 1.5,1.5,1.5, 0, 200, 0, 125, 1, 1, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1), false), currentMission['Start']['x'], currentMission['Start']['y'], currentMission['Start']['z'], true) < 25.0) then 
     if not DoesEntityExist(missionTrailer) then 
      createMissionTrailer(currentMission['Trailer'], currentMission['Start'])
     end
     if IsVehicleAttachedToTrailer(missionTruck) then
      isTrailerAttached = true
      setTruckingBlip(currentMission['End']['x'], currentMission['End']['y'], currentMission['End']['z'])
     end
    end
   end
  elseif isTrailerAttached then
   if(GetDistanceBetweenCoords(GetEntityCoords(missionTrailer, false), currentMission['End']['x'], currentMission['End']['y'], currentMission['End']['z'], true) < 50) then
    DrawMarker(2, currentMission['End']['x'], currentMission['End']['y'], currentMission['End']['z']+2.5, 0, 0, 0, 0, 0, 0, 1.5,1.5,1.5, 200, 0, 0, 125, 1, 1, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(GetEntityCoords(missionTrailer, false), currentMission['End']['x'], currentMission['End']['y'], currentMission['End']['z'], true) < 10.0) then 
     if not IsVehicleAttachedToTrailer(missionTruck) then
      RemoveBlip(missionBlip)
      DeleteEntity(missionTrailer)
      missionTrailer = nil 
      trailerSpawned = false
      isTrailerAttached = false
      onMission = false
      runningMission = nil
      truckingJobs[currentMission['ID']]['Timeout'] = 15
      if currentMission['Time'] > 0 then
       if currentPolice > 0 then 
        TriggerServerEvent('trucking:addmoney', currentMission['Pay'])
       else 
        TriggerServerEvent('trucking:addmoney', currentMission['Pay']/2)
       end
      else
       TriggerServerEvent('trucking:addmoney', math.floor(currentMission['Pay'] - math.floor(currentMission['Pay']/4)))
      end
     end
    end
   end
  end
 end
end

function createMissionTrailer(veh, pos)
 if not trailerSpawned then
  trailerSpawned = true
  local model = GetHashKey(veh)
  RequestModel(model)
  while not HasModelLoaded(model) do
   Citizen.Wait(0)
  end
  missionTrailer = CreateVehicle(model, pos.x, pos.y, pos.z, pos.h, true, false)
  local id = NetworkGetNetworkIdFromEntity(missionTrailer)
  SetNetworkIdCanMigrate(id, true)
  SetNetworkIdExistsOnAllMachines(id, true)
  SetVehicleHasBeenOwnedByPlayer(missionTrailer, true)
  SetEntityAsMissionEntity(missionTrailer, true, true)
  SetVehicleOnGroundProperly(missionTrailer)
  return missionTrailer
 end
end

function setTruckingBlip(x,y,z)
 missionBlip = AddBlipForCoord(x,y,z)
 SetBlipSprite(missionBlip, 164)
 SetBlipRoute(missionBlip, true)
 BeginTextCommandSetBlipName("STRING")
 AddTextComponentString("Destination")
 EndTextCommandSetBlipName(missionBlip)
end

-- /trucking 
RegisterCommand('trucking', function(source, args, rawCommand)
 if args[1] == 'tacho' then 
  local tachoTime = DecorGetInt(GetPlayerPed(-1), "Tacho")
  if tachoTime >= 25 then 
   TriggerEvent('chatMessage', '^5Tacómetro: ^1'..tachoTime.."^5 Minutos | Usted está por encima del límite legal, busque un lugar donde detenerse")
  else 
   TriggerEvent('chatMessage', '^5Tacómetro: ^3'..tachoTime.."^5 Minutos | Estás dentro del límite legal")
  end
 elseif args[1] == 'time' then 
  TriggerEvent('chatMessage', '^5El tiempo de entrega: ^3'..runningMission['Time'].." Minutos")
 elseif args[1] == 'reset' then 
  DeleteEntity(missionTrailer)
  isTrailerAttached = false 
  onMission = false 
  RemoveBlip(missionBlip)
  runningMission = nil
  trailerSpawned = false
  TriggerEvent('chatMessage', '^1Tu misión actual ha sido restablecida')
 end
end)

RegisterCommand('showtacho', function(source, args, rawCommand)
 local tachoTime = DecorGetInt(GetPlayerPed(-1), "Tacho")
 if tachoTime >= 25 then 
  ExecuteCommand('Yo he superado el límite legal de su medidor de tacómetro')
 else 
  ExecuteCommand('yo esta dentro de su limite legal')
 end
end)
 
-- Mission Timing
Citizen.CreateThread(function()
 local currentTime = 0
 while true do
  Citizen.Wait(1000)
  if onDuty then
   if onMission then 
    if runningMission['Time'] > 0 then 
     currentTime = currentTime+1
     if math.floor(currentTime/60) == 1 then 
      runningMission['Time'] = runningMission['Time'] - 1
      currentTime = 0
     end
    end 
   end
  end
 end
end)

-- Timeout Timing
Citizen.CreateThread(function()
 local currentTime = 0
 while true do
  Citizen.Wait(1000)
  if onDuty then
   currentTime = currentTime+1
   if math.floor(currentTime/60) == 1 then 
    for i=1, #truckingJobs do 
     if truckingJobs[i]['Timeout'] > 0 then 
      truckingJobs[i]['Timeout'] = truckingJobs[i]['Timeout'] - 1
     end
    end
    currentTime = 0
   end
  end
 end
end)

-- Tacho Shit
DecorRegister("Tacho", 3)
DecorSetInt(GetPlayerPed(-1), "Tacho", 0)


-- Timeout Timing
Citizen.CreateThread(function()
 local currentTime = 0
 while true do
  Citizen.Wait(1000)
  local tacho = DecorGetInt(GetPlayerPed(-1), "Tacho")
  if onDuty then
   currentTime = currentTime+1
   if math.floor(currentTime/60) == 1 then 
    if isPedDriving(GetPlayerPed(-1)) then
     DecorSetInt(GetPlayerPed(-1), "Tacho", tacho+1)	
    else
     if tacho > 0 then
      for i=1, #truckingStops do 
       if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1), false), truckingStops['x'], truckingStops['y'], truckingStops['z'], true) < 25) then
        DecorSetInt(GetPlayerPed(-1), "Tacho", tacho-1)	
       end
      end
      DecorSetInt(GetPlayerPed(-1), "Tacho", tacho-1)	 
     end
    end
    currentTime = 0
   end
  end
 end
end)

function isPedDriving(ped) 
 if IsPedInAnyVehicle(ped, false) then
  local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
  --local speed = math.floor(GetEntitySpeed(vehicle) * 2.236936)
  local speed = math.floor(GetEntitySpeed(vehicle) * 3.6)  
  if speed >= 1 then 
   return true
  else
   return false
  end
 else 
  return false 
 end
end

function getTruckingMissions()
 return truckingJobs
end

AddEventHandler('trucking:new', function(id)
 local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1))
 if IsVehicleModel(vehicle, GetHashKey('phantom')) or IsVehicleModel(vehicle, GetHashKey('phantom3')) or IsVehicleModel(vehicle, GetHashKey('hauler')) or IsVehicleModel(vehicle, GetHashKey('packer')) then
  if exports['clrp_garage']:HasKey(GetVehicleNumberPlateText(vehicle)) then 
   if truckingJobs[id]['Timeout'] == 0 then  
    TriggerEvent('chatMessage', '^5Trabajo de transporte seleccionado iniciado')
    beginMission(truckingJobs[id])
   else 
    TriggerEvent('chatMessage', '^1Trabajo no disponible | '..truckingJobs[id]['Timeout']..' Minutos restantes')
   end
  else 
  TriggerEvent('chatMessage', '^1Usted debe poseer el camión!')
  end
 else 
  TriggerEvent('chatMessage', '^1Debes estar en tu propio camión antes de seleccionar una misión')
 end
end)


RegisterNetEvent('hud:updatepresence')
AddEventHandler('hud:updatepresence', function(copss)
 currentPolice = copss
end)
