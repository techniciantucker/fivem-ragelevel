local myDecorators = {}
local jobs = {}
local scopedWeapons = {
 100416529,  -- WEAPON_SNIPERRIFLE
 205991906,  -- WEAPON_HEAVYSNIPER
 3342088282, -- WEAPON_MARKSMANRIFLE
 317205821   -- WEAPON_AUTOSHOTGUN
}

DecorRegister('Faction', 3)
DecorRegister('Job', 3)
DecorRegister('isParamedic', 2)
DecorRegister('isOfficer', 2)
DecorRegister('isSeguridad', 2)

DecorSetInt(GetPlayerPed(-1), "Faction", 0)
DecorSetBool(GetPlayerPed(-1), "isParamedic", false)   
DecorSetBool(GetPlayerPed(-1), "isOfficer", false)
DecorSetBool(GetPlayerPed(-1), "isSeguridad", false)
DecorSetInt(GetPlayerPed(-1), "Job", 0)

RegisterNetEvent("core:setPlayerDecorator")
AddEventHandler("core:setPlayerDecorator", function(key, value, doNow)
 myDecorators[key] = value
 DecorRegister(key, 3)
 if(doNow)then
  DecorSetInt(GetPlayerPed(-1), key, value)
 end
end)

AddEventHandler('playerSpawned', function(spawn)
 TriggerServerEvent('core:checkuser')
 for k,v in pairs(myDecorators)do
  DecorSetInt(GetPlayerPed(-1), k, v)
 end
end)

RegisterNetEvent("core:setjob")
AddEventHandler("core:setjob", function(jobid, jobbs)
 local jobid = tonumber(jobid)
 jobs = jobbs

 if jobid == 1 then
  DecorSetBool(GetPlayerPed(-1), "isParamedic", false)   
  DecorSetBool(GetPlayerPed(-1), "isOfficer", true)
     DecorSetBool(GetPlayerPed(-1), "isSeguridad", false) 
 elseif jobid == 2 then
  DecorSetBool(GetPlayerPed(-1), "isParamedic", true)   
  DecorSetBool(GetPlayerPed(-1), "isOfficer", false)
    DecorSetBool(GetPlayerPed(-1), "isSeguridad", false)
 elseif jobid == 8 then
  DecorSetBool(GetPlayerPed(-1), "isParamedic", false)   
  DecorSetBool(GetPlayerPed(-1), "isOfficer", false)
  DecorSetBool(GetPlayerPed(-1), "isSeguridad", true)   
 else
  DecorSetBool(GetPlayerPed(-1), "isParamedic", false)   
  DecorSetBool(GetPlayerPed(-1), "isOfficer", false)
 end
 DecorSetInt(GetPlayerPed(-1), "Job", jobid)
 SetJobBlips(jobid)
end)

RegisterNetEvent("core:setfac")
AddEventHandler("core:setfac", function(facid)
 local facid = tonumber(facid)
 DecorSetInt(GetPlayerPed(-1), "Faction", facid)
end)

---------------------------------------------------------------------------
-- Removes features that need to be called every tick
---------------------------------------------------------------------------
Citizen.CreateThread(function()
 while true do
  DisableHealthRegen()
  EnablePVP()
  RemoveSeatShuffle() 
  --DisableCrossHair()
  DisableVehicleRewards()
  Citizen.Wait(0)
 end
end)

Citizen.CreateThread(function()
 while true do
  Wait(0)
  SetPlayerWantedLevel(PlayerId(), 0, false)
  SetPlayerWantedLevelNow(PlayerId(), false)
  SetPlayerWantedLevelNoDrop(PlayerId(), 0, false) 
 end
end)

function SetWeaponDrops()
    local handle, ped = FindFirstPed()
    local finished = false 

    repeat 
        if not IsEntityDead(ped) then
            SetPedDropsWeaponsWhenDead(ped, false) 
        end
        finished, ped = FindNextPed(handle)
    until not finished

    EndFindPed(handle)
end

Citizen.CreateThread(function()
    while true do
        SetWeaponDrops()
        Citizen.Wait(500)
    end
end)

function DisableHealthRegen()
 SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
end

function EnablePVP()
 SetCanAttackFriendly(GetPlayerPed(PlayerId()), true, false)
 NetworkSetFriendlyFireOption(true)
end

function RemoveSeatShuffle()
 if IsPedInAnyVehicle(GetPlayerPed(PlayerId())) then
  if GetIsTaskActive(GetPlayerPed(PlayerId()), 165) then
   local vehicle = GetVehiclePedIsIn(GetPlayerPed(PlayerId()), false)
   local pedSeat = GetPedVehicleSeat(GetPlayerPed(PlayerId()), vehicle)
   SetPedIntoVehicle(GetPlayerPed(PlayerId()), vehicle, pedSeat)
  end
 end 
end

function DisableCrossHair()
 local hash = GetSelectedPedWeapon(GetPlayerPed(-1))
 if not HashInTable(hash) then 
  HideHudComponentThisFrame(14)
 end 
end 

function DisableVehicleRewards()
 DisablePlayerVehicleRewards(PlayerId())
end

function GetPedVehicleSeat()
 local seatCount = GetVehicleModelNumberOfSeats(GetHashKey(GetEntityModel(vehicle)))
 for a = -1, seatCount do
  local pedInSeat = GetPedInVehicleSeat(vehicle, a)
  if pedInSeat == ped then
   return a
  end
 end
end

function HashInTable( hash )
 for k, v in pairs( scopedWeapons ) do 
  if ( hash == v ) then 
   return true 
  end 
 end 
 return false 
end 

function globalObject(object)
 SetEntityAsMissionEntity(object, true, true)
end

RegisterNetEvent("core:removeweapon")
AddEventHandler("core:removeweapon", function(weapon, allweapons)
    if allweapons then 
        RemoveAllPedWeapons(GetPlayerPed(-1), true)
    else
        RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey(weapon))
    end
end)

RegisterNetEvent("core:addweapon")
AddEventHandler("core:addweapon", function(weapon)
  GiveWeaponToPed(GetPlayerPed(-1), GetHashKey(weapon), 5000, false, false)
end)

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(5)
  if IsPedInAnyVehicle(GetPlayerPed(-1)) then
   if vehicleClass ~= 15 and 16 then
   -- local speed = math.floor(GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) * 2.236936)
    local speed = math.floor(GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) * 3.6)	
    if speed > 40 then 
     SetPlayerCanDoDriveBy(PlayerId(), false)
    else
     SetPlayerCanDoDriveBy(PlayerId(), true)
    end
   end
  else
   Citizen.Wait(1000)
  end
 end
end)

-- local jobLocations = {

    -- {x =-265.036, y=-963.630, z=31.223},

-- }

Citizen.CreateThread(function()
 WarMenu.CreateLongMenu('job_center', "Job Center")
 while true do
  Wait(5)
  if WarMenu.IsMenuOpened('job_center') then
   for ind, v in pairs(jobs) do
    if v.whitelisted == 0 and WarMenu.Button(v.name, '~g~Pay: $'..v.pay) then
     WarMenu.CloseMenu('job_center')
     TriggerServerEvent('jobs:setjob', v.id)
    end
   end
   WarMenu.Display()
  end
  --for ind, v in pairs(jobLocations) do 
  if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 162.27, -1103.96, 29.31, true) < 3) then
    --DrawText3Ds(-265.036, -963.630, 30.223,'~y~[E]~w~ Si busca trabajo (aqui es)') 
                        if not showing then
						TriggerEvent('pw_drawtext:showNotification', { title = "CENTRO TRABAJO", message = "Pulse [ <span class='text-danger'>E</span> ] Buscar trabajo", icon = "fas fa-shopping-basket" })
                            showing = k
                        end	
   if IsControlJustPressed(0, 38) then
    TriggerServerEvent('core:checkjob')
    WarMenu.OpenMenu('job_center')
   end
  else
                        if showing == k then
                            TriggerEvent('pw_drawtext:hideNotification')
                            showing = false
                            -- if inShop then
                                -- TriggerEvent('pw_interact:closeMenu')
                                -- inShop = false
                            -- end
                        end  
   Citizen.Wait(2500)
  end
 --end
 end
end) 


function SetJobBlips(id)
 if id == 5 then 
  SetWorkPlace(3866.848, 4464.227, 1.736)
 elseif id == 35 then
  SetWorkPlace(2281.504, 4904.479, 40.928)  
 elseif id == 6 then
  SetWorkPlace(-406.925, 6172.887, 31.497)
 elseif id == 7 then 
  SetWorkPlace(-552.879, 5348.669, 73.743)
 elseif id == 4 then 
  SetWorkPlace(895.376, -179.315, 73.710)  
 elseif id == 22 then 
  SetWorkPlace(432.646, -645.989, 28.727)
 elseif id == 10 then 
  SetWorkPlace(-354.999, -1513.897, 27.717)
 elseif id == 11 then 
  TriggerEvent('phone:truckingJob')
 elseif id == 14 then 
  SetWorkPlace(732.549, 131.619, 80.755)
 end
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
 AddTextComponentString("Lugar de trabajo")
 EndTextCommandSetBlipName(blip)
end 

Citizen.CreateThread(function()
 while true do
  SetDiscordAppId(171028952272338945)
  SetDiscordRichPresenceAsset('backgroundlogo')
  SetDiscordRichPresenceAssetText('ASTERIX AND OBELIX RP')
  SetDiscordRichPresenceAssetSmall('fivemlogo')
  SetDiscordRichPresenceAssetSmallText('Unase a nosotros en FiveM hoy')
  Citizen.Wait(60000)
 end
end)

function DrawText3Ds(x,y,z, text)

  local onScreen,_x,_y=World3dToScreen2d(x,y,z)

  local px,py,pz=table.unpack(GetGameplayCamCoords())

  

  SetTextScale(0.35, 0.35)

  SetTextFont(4)

  SetTextProportional(1)

  SetTextColour(255, 255, 255, 215)

  SetTextEntry("STRING")

  SetTextCentre(1)

  AddTextComponentString(text)

  DrawText(_x,_y)

end