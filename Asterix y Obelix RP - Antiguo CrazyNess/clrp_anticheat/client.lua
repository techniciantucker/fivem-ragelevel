local isAdmin = false 
local banned = false
local BannedVehicles = {
  "rhino",
  "apc",
  "oppressor",
  "tampa3",
  "insurgent3",
  "technical3",
  "halftrack",
  "nightshark",
  "dune4",
  "dune5",
  "phantom2",
  "ruiner2",
  "technical2",
  "voltic2",
  "hydra",
  "jet",
  "blimp",
  "cargoplane",
  "titan",
  "buzzard",
  "valkyrie",
  "savage",
  "dune3",
  "insurgent",
  "insurgent2"
}

local BannedWeapons = {
	"WEAPON_RAILGUN",
	"WEAPON_GRENADELAUNCHER",
	"WEAPON_RPG",
	"WEAPON_PASSENGER_ROCKET",
	"WEAPON_AIRSTRIKE_ROCKET",
	"WEAPON_STINGER",
	"WEAPON_MINIGUN",
	"WEAPON_VEHICLE_ROCKET"
}

DecorRegister("isAdmin", 2)
DecorSetBool(GetPlayerPed(-1), "isAdmin", false)

RegisterNetEvent('es_admin:setGroup')
AddEventHandler('es_admin:setGroup', function(g)
 if g ~= 'user' then
  isAdmin = true
  print('You Are A Staff Member :)')
  DecorSetBool(GetPlayerPed(-1), "isAdmin", true)
 end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(60000)
        if not isAdmin then
            if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
                local veh = GetVehiclePedIsUsing(GetPlayerPed(-1), false)
                for i = 1, #BannedVehicles do
                    local vehicle_name = BannedVehicles[i]
                    local vehicle = GetHashKey(vehicle_name)
                    if GetEntityModel(veh) == vehicle then
                        if not banned then
                            banned = true
                            SetEntityAsMissionEntity(veh, true, true)
                            Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))
                            TriggerServerEvent('anticheat:ban')
                        end
                    end
                end
                if GetVehicleNumberPlateText(veh) == 'FIVE M' or GetVehicleNumberPlateText(veh) == 'FiveM' then 
                	SetEntityAsMissionEntity(veh, true, true)
               		Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))
                	TriggerServerEvent('anticheat:ban')
                end
            end 
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(60000)
        if not isAdmin then
            for i = 1, #BannedWeapons do
                local weapon_t = BannedWeapons[i]
                local weapon = GetHashKey(weapon_t)
                if HasPedGotWeapon(GetPlayerPed(-1), weapon, false) then
                    if not banned then
                        banned = true
                        TriggerServerEvent('anticheat:kick')
                    end
                end
            end
        end
    end
end)