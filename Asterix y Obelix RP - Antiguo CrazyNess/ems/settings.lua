-- EMS Vehicles
currentgarage = {}

vehicles = {
 [1] = {name = 'Mercedes Ambulance', vehicle = 'ambulance', rank = 'Cadet'},
 [2] = {name = 'Ambulance', vehicle = 'ambo', rank = 'Cadet'},
 [3] = {name = 'Explorer', vehicle = 'emssuv2', rank = 'Paramedic'},
 [4] = {name = 'Off-Road', vehicle = 'sheriff2', rank = 'Lt'},
 [7] = {name = 'Lexus', vehicle = 'emscar3', rank = 'Lt'},
 [8] = {name = 'Jeep', vehicle = 'cprotection', rank = 'Doctor'},
 [9] = {name = 'Life Flight', vehicle = 'Annihilator', rank = 'ASU'},
 [10] = {name = 'Life Flight 2', vehicle = 'supervolito', rank = 'ASU'},
 [11] = {name = 'ems 2', vehicle = 'emscar2', rank = 'Cadet'},
 [12] = {name = 'ems 4', vehicle = 'emscar4', rank = 'Cadet'},
}

-- Locations
hospitals = {
  {x= 340.278, y= -1396.029, z= 32.509},
  {x= 338.85, y= -1394.56, z= 31.53},
  {x= -449.67, y= -340.83, z= 33.52},
  {x= 360.864, y= -585.171, z= 27.84},
  {x= 1156.74, y= -1529.11, z= 33.86},
  {x= -247.01, y= 6331.45, z= 31.44},
  {x= 1826.98, y= 3693.34, z= 34.24},
  {x= 298.44, y= -584.28, z= 42.28},
  {x= 308.111, y= -595.298, z= 43.292},
}

duty = {
  {x = 311.081, y = -597.306, z = 43.284},
}

garage = {
  {x = 288.756, y = -608.080, z = 42.345},
}

-- Spawn Vehicle Function
function SpawnVehicle(vehicle2)
 if vehicle2 ~= 'Annihilator' and vehicle2 ~= 'supervolito' and vehicle2 ~= 'annihilator' then
   local vehiclehash = GetHashKey(vehicle2)
   RequestModel(vehiclehash)
   while not HasModelLoaded(vehiclehash) do
    Citizen.Wait(0)
   end
   vehicle = CreateVehicle(vehiclehash, 278.762, -605.170, 43.047, GetEntityHeading(PlayerPedId()), true, false)
   local id = NetworkGetNetworkIdFromEntity(vehicle)
   SetNetworkIdCanMigrate(id, true)
   SetNetworkIdExistsOnAllMachines(id, true)
   SetVehicleDirtLevel(vehicle, 0)
   TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
   SetVehicleHasBeenOwnedByPlayer(vehicle, true)
   SetEntityAsMissionEntity(vehicle, true, true)
   SetVehicleMod(vehicle,16, 20)
   SetVehicleEngineOn(vehicle, true)
   DecorSetInt(vehicle, "_Max_Fuel_Level", 150000)
   DecorSetInt(vehicle, "_Fuel_Level", 75000)
   SetVehicleColours(vehicle, 131, 131)
 else
  vehiclehash = GetHashKey(vehicle2)
  RequestModel(vehiclehash)
  Citizen.CreateThread(function() 
   while not HasModelLoaded(vehiclehash) do  
    Citizen.Wait(0)  
   end
   local spawned = CreateVehicle(vehiclehash, 352.276, -587.966, 74.166, GetEntityHeading(PlayerPedId()), 1, 0)
   TaskWarpPedIntoVehicle(GetPlayerPed(-1), spawned, -1)
   SetVehicleEngineOn(spawned, true, true)  
   SetVehicleIsConsideredByPlayer(spawned, true)
   SetVehicleColours(spawned, 131, 131)
   DecorSetInt(vehicle, "_Max_Fuel_Level", 150000)
   DecorSetInt(vehicle, "_Fuel_Level", 75000)
  end)
 end
end

RegisterNetEvent('ems:dutystatus')
AddEventHandler('ems:dutystatus', function() 
 isInService = not isInService
 if isInService then 
  OnDuty()
 else
  OffDuty() 
 end
end)

function OnDuty()
 if GetEntityModel(GetPlayerPed(-1)) == -1667301416 then
  -- Female
  SetPedComponentVariation(GetPlayerPed(-1), 3, 109, 0, 0)
  SetPedComponentVariation(GetPlayerPed(-1), 4, 6, 2, 0)
  SetPedComponentVariation(GetPlayerPed(-1), 6, 72, 0, 0)
  SetPedComponentVariation(GetPlayerPed(-1), 7, 97, 0, 0)
  SetPedComponentVariation(GetPlayerPed(-1), 8, 159, 0, 0)
  SetPedComponentVariation(GetPlayerPed(-1), 10, 66, 0, 0)
  SetPedComponentVariation(GetPlayerPed(-1), 11, 258, 0, 0)
 else
  -- Male
  SetPedComponentVariation(GetPlayerPed(-1), 3, 85, 0, 2)
  SetPedComponentVariation(GetPlayerPed(-1), 4, 96, 0, 2)
  SetPedComponentVariation(GetPlayerPed(-1), 6, 12, 6, 2)
  SetPedComponentVariation(GetPlayerPed(-1), 10, 58, 0, 2)
  SetPedComponentVariation(GetPlayerPed(-1), 8, 129, 0, 2)
  SetPedComponentVariation(GetPlayerPed(-1), 11, 250, 0, 2)
 end
 DecorSetBool(GetPlayerPed(-1), 'isInService', true)
 DecorSetInt(GetPlayerPed(-1), "currentRadioChannel", 911)
 GiveWeaponToPed(GetPlayerPed(-1), GetHashKey('WEAPON_STUNGUN'), 1000, false, true)
 TriggerServerEvent('blips:activate', 'ems')
 TriggerServerEvent('police:duty', true)
end

function OffDuty()
 ExecuteCommand('clothes')
 DecorSetBool(GetPlayerPed(-1), 'isInService', false)
 DecorSetInt(GetPlayerPed(-1), "currentRadioChannel", 1)
 SetPedComponentVariation(GetPlayerPed(-1), 10, 0, 0, 2) -- Decals
 SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) -- Chains
 RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey('WEAPON_STUNGUN'))
 TriggerServerEvent('blips:deactivate')
 TriggerServerEvent('police:duty', false)
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

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(0)
  if IsDead then
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
  end
 end
end)

local wepdescriptors = {
  {hash = "WEAPON_HEAVYPISTOL", desc = "small caliber gun shot wounds"},
  {hash = "WEAPON_STUNGUN", desc = "electrical burn wounds"},
  {hash = "WEAPON_NIGHTSTICK", desc = "long bruises with blunt force trauma"},
  {hash = "WEAPON_PUMPSHOTGUN", desc = "scattered small caliber gun shot wounds"},
  {hash = "WEAPON_CARBINERIFLE", desc = "large caliber automatic gun shot wounds"},
  {hash = "WEAPON_MICROSMG", desc = "small caliber automatic gun shot wounds"},
  {hash = "WEAPON_COMBATPDW", desc = "small caliber automatic gun shot wounds"},
  {hash = "WEAPON_FLASHLIGHT", desc = "medium bruising with blunt force trauma"},
  {hash = "WEAPON_FIREEXTINGUISHER", desc = "blunt force trauma"},
  {hash = "WEAPON_PETROLCAN", desc = "blunt force trauma with a strong gasoline smell"},
  {hash = "WEAPON_BZGAS", desc = "mild chemical burns"},
  {hash = "WEAPON_FLARE", desc = "moderate burn wounds"},
  {hash = "WEAPON_ASSAULTSMG", desc = "small caliber automatic gun shot wounds"},
  {hash = "WEAPON_SPECIALCARBINE", desc = "small caliber automatic gun shot wounds"},
  {hash = "WEAPON_ASSAULTSHOTGUN", desc = "scattered small caliber gun shot wounds"},
  {hash = "WEAPON_KNIFE", desc = "serrated stab and cut wounds"},
  {hash = "WEAPON_BAT", desc = "long cylindrical bruising with blunt force trauma"},
  {hash = "WEAPON_CROWBAR", desc = "blunt force trauma and long bruising with stab wounds at the end"},
  {hash = "WEAPON_GOLFCLUB", desc = "long thin bruises with blunt force trauma at the end"},
  {hash = "WEAPON_DAGGER", desc = "deep stab wounds"},
  {hash = "WEAPON_KNUCKLE", desc = "knuckle shaped bruising"},
  {hash = "WEAPON_MACHETE", desc = "large stab wound with long slashing wounds"},
  {hash = "WEAPON_WRENCH", desc = "large bruises with blunt force trauma"},
  {hash = "WEAPON_PISTOL", desc = "small caliber gun shot wounds"},
  {hash = "WEAPON_SNSPISTOL", desc = "small caliber gun shot wounds"},
  {hash = "WEAPON_COMBATPISTOL", desc = "small caliber gun shot wounds"},
  {hash = "WEAPON_HEAVYPISTOL", desc = "small caliber gun shot wounds"},
  {hash = "WEAPON_PISTOL50", desc = "small caliber gun shot wounds"},
  {hash = "WEAPON_SWITCHBLADE", desc = "moderately deep stab wounds with slashing wounds"},
  {hash = "WEAPON_REVOLVER", desc = "large caliber gun shot wounds"},
  {hash = "WEAPON_MARKSMANPISTOL", desc = "large caliber gun shot wounds"},
  {hash = "WEAPON_SAWNOFFSHOTGUN", desc = "scattered small caliber gun shot wounds"},
  {hash = "WEAPON_COMPACTRIFLE", desc = "large caliber gun shot wounds"},
  {hash = "WEAPON_SMG", desc = "small caliber automatic gun shot wounds"},
  {hash = "WEAPON_BULLPUPRIFLE", desc = "small caliber automatic gun shot wounds"},
  {hash = "WEAPON_CARBINERIFLE", desc = "large caliber automatic gun shot wounds"},
  {hash = "WEAPON_ASSAULTSMG", desc = "small caliber automatic gun shot wounds"},
  {hash = "WEAPON_MACHINEPISTOL", desc = "small caliber automatic gun shot wounds"},
  {hash = "WEAPON_MINISMG", desc = "small caliber automatic gun shot wounds"},
  {hash = "WEAPON_BATTLEAXE", desc = "long slashing and cutting wounds"},
  {hash = "WEAPON_POOLCUE", desc = "long bruises with traces of a blue chalky substance"},
  {hash = "WEAPON_BALL", desc = "large round bruise"},
  {hash = "WEAPON_DBSHOTGUN", desc = "scattered small caliber gun shot wounds"},
  {hash = "WEAPON_GUSENBERG", desc = "small caliber automatic gun shot wounds"},
  {hash = "WEAPON_ASSAULTRIFLE_MK2", desc = "large caliber automatic gun shot wounds"},
  {hash = "WEAPON_CARBINERIFLE_MK2", desc = "large caliber automatic gun shot wounds"},
  {hash = "WEAPON_COMBATMG_MK2", desc = "large caliber automatic gun shot wounds"},
  {hash = "WEAPON_PISTOL_MK2", desc = "small caliber gun shot wounds"},
  {hash = "WEAPON_SMG_MK2", desc = "small caliber automatic gun shot wounds"},
  {hash = "WEAPON_ASSAULTSHOTGUN", desc = "scattered small caliber gun shot wounds"},
  {hash = "WEAPON_FALL", desc = "brusing and fall damage"},
  {hash = "WEAPON_RUN_OVER_BY_CAR", desc = "signs of a broken leg and vehicle damage"},
  {hash = "WEAPON_FIRE", desc = "charged skins and burn marks"},
  {hash = "WEAPON_COUGAR", desc = "bite marks and teared clothing"},
}

function getWeaponDamageString(ped)
  local ped = ped
  local dmgstr = "Observas "

  for i,v in ipairs(wepdescriptors) do
    if (HasPedBeenDamagedByWeapon(ped, GetHashKey(v.hash), 0)) then
      dmgstr =  dmgstr .. v.desc..", "
    end
  end

  if (dmgstr == "Observas ") then
    dmgstr = "No se notan heridas de cuerpo a cuerpo o de arma de fuego visibles."
  end

  return dmgstr
end

RegisterNetEvent("ems:damage")
AddEventHandler("ems:damage", function(target)
  local ped = GetPlayerPed(GetPlayerFromServerId(target))
  TriggerEvent("pNotify:SendNotification", {text = ""..getWeaponDamageString(ped), timeout=25000})
end)