local guiEnabled = false
local player_weapons = {}
local allWeapons = {}
local weaponSelection = {}
local listWeapons = {{weapon = "WEAPON_KNIFE", name = "Knife"},{weapon = "WEAPON_KNUCKLE", name = "Knuckle Dusters"},{weapon = "WEAPON_NIGHTSTICK", name = "Nightstick"},{weapon = "WEAPON_HAMMER", name = "Hammer"},{weapon = "WEAPON_BAT", name = "Bat"},{weapon = "WEAPON_GOLFCLUB", name = "Golf Club"},{weapon = "WEAPON_CROWBAR", name = "Crowbar"},{weapon = "WEAPON_BOTTLE", name = "Bottle"},{weapon = "WEAPON_DAGGER", name = "Dagger"},{weapon = "WEAPON_HATCHET", name = "Hatchet"},{weapon = "WEAPON_MACHETE", name = "Machete"},{weapon = "WEAPON_FLASHLIGHT", name = "Flashlight"},{weapon = "WEAPON_SWITCHBLADE", name = "Switchblade"},{weapon = "WEAPON_PISTOL", name = "Pistol"},{weapon = "WEAPON_COMBATPISTOL", name = "Combat Pistol"},{weapon = "WEAPON_APPISTOL", name = "AP Pistol"},{weapon = "WEAPON_PISTOL50", name = "Pistol .50"},{weapon = "WEAPON_SNSPISTOL", name = "SNS Pistol"},{weapon = "WEAPON_HEAVYPISTOL", name = "Heavy Pistol"},{weapon = "WEAPON_VINTAGEPISTOL", name = "Vintage Pistol"},{weapon = "WEAPON_STUNGUN", name = "Tazer"},{weapon = "WEAPON_FLAREGUN", name = "Flare Gun"},{weapon = "WEAPON_MARKSMANPISTOL", name = "Marksman Pistol"},{weapon = "WEAPON_REVOLVER", name = "Revolver"},{weapon = "WEAPON_MICROSMG", name = "Micro SMG"},{weapon = "WEAPON_SMG", name = "SMG"},{weapon = "WEAPON_ASSAULTSMG", name = "Assault SMG"},{weapon = "WEAPON_MG", name = "MG"},{weapon = "WEAPON_COMBATMG", name = "Combat MG"},{weapon = "WEAPON_COMBATPDW", name = "Combat PDW"},{weapon = "WEAPON_GUSENBERG", name = "Gusenberg"},{weapon = "WEAPON_MACHINEPISTOL", name = "Machine Pistol"},{weapon = "WEAPON_ASSAULTRIFLE", name = "Assault Rifle"},{weapon = "WEAPON_CARBINERIFLE", name = "Carbine Rifle"},{weapon = "WEAPON_ADVANCEDRIFLE", name = "Advanced Rifle"},{weapon = "WEAPON_SPECIALCARBINE", name = "Special Carbine"},{weapon = "WEAPON_BULLPUPRIFLE", name = "Bullpup Rifle"},{weapon = "WEAPON_COMPACTRIFLE", name = "Compact Rifle"},{weapon = "WEAPON_PUMPSHOTGUN", name = "Pump Shotgun"},{weapon = "WEAPON_SAWNOFFSHOTGUN", name = "Sawnoff Shotgun"},{weapon = "WEAPON_BULLPUPSHOTGUN", name = "Bullpup Shotgun"},{weapon = "WEAPON_ASSAULTSHOTGUN", name = "Assault Shotgun"},{weapon = "WEAPON_MUSKET", name = "Hunting Rifle"},{weapon = "WEAPON_HEAVYSHOTGUN", name = "Heavy Shotgun"},{weapon = "WEAPON_DBSHOTGUN", name = "DB Shotgun"},{weapon = "WEAPON_SNIPERRIFLE", name = "Sniper"},{weapon = "WEAPON_HEAVYSNIPER", name = "Heavy Sniper"},{weapon = "WEAPON_MARKSMANRIFLE", name = "Marksman Rifle"},{weapon = "WEAPON_GRENADELAUNCHER", name = "Grenade Launcher"},{weapon = "WEAPON_GRENADELAUNCHER_SMOKE", name = ""},{weapon = "WEAPON_RPG", name = "RPG"},{weapon = "WEAPON_STINGER", name = ""},{weapon = "WEAPON_MINIGUN", name = "Minigun"},{weapon = "WEAPON_FIREWORK", name = "Firework Launcher"},{weapon = "WEAPON_RAILGUN", name = "Railgun"},{weapon = "WEAPON_HOMINGLAUNCHER", name = "Homing Launcher"},{weapon = "WEAPON_GRENADE", name = "Grenade"},{weapon = "WEAPON_STICKYBOMB", name = "Sticky Bomb"},{weapon = "WEAPON_PROXMINE", name = "Proxmine"},{weapon = "WEAPON_BZGAS", name = "BZGas"},{weapon = "WEAPON_SMOKEGRENADE", name = "Smoke Grenade"},{weapon = "WEAPON_MOLOTOV", name = "Molotov"},{weapon = "WEAPON_FIREEXTINGUISHER", name = "Extinguisher"},{weapon = "WEAPON_PETROLCAN", name = "Jerry Can"},{weapon = "WEAPON_SNOWBALL", name = "Snowball"},{weapon = "WEAPON_FLARE", name = "Flare"},{weapon = "WEAPON_BALL", name = "Ball"}}

RegisterNUICallback('escape', function(data, cb)
 if data.melee ~= 0 then weaponSelection[1] = allWeapons[data.melee].weapon end
 if data.pistol ~= 0 then weaponSelection[2] = allWeapons[data.pistol].weapon end
 if data.rifle ~= 0 then weaponSelection[3] = allWeapons[data.rifle].weapon end
 if data.other ~= 0 then weaponSelection[4] = allWeapons[data.other].weapon end
 SendNUIMessage({type = "enableui", enable = false})
 SetNuiFocus(false, false)
 guiEnabled = false
 cb('ok')
 SendNUIMessage({type = "enableui", enable = false})
end)

function EnableGui(enable)
 SendNUIMessage({type = "resetUI"})
 allWeapons = {}
 for id,v in pairs(listWeapons) do 
  if HasPedGotWeapon(GetPlayerPed(-1), GetHashKey(v.weapon), false) then
   allWeapons[id] = {weapon = v.weapon, name = v.name}
  end
 end
 Wait(100)
 SetNuiFocus(enable, enable)
 SendNUIMessage({type = "enableui", enable = enable, melee = getMelee(), pistol = getPistol(), rifle = getRifle(), other = getOther()})
end 

function getMelee()
 local melee = ''
 for id,v in pairs(allWeapons) do 
  if GetWeapontypeGroup(GetHashKey(v.weapon)) == -728555052 then
   if v.weapon ~= 'WEAPON_STUNGUN' then  
    melee = '<div class="newWeapon" id="'..id..'" onclick="selectMelee('..id..')"><h5>'..v.name..'</h5><p>Ammunation: 0</p><p>Identifier: '..id..'</p></div>'..melee
   end
  elseif v.weapon == 'WEAPON_KNUCKLE' then 
   melee = '<div class="newWeapon" id="'..id..'" onclick="selectMelee('..id..')"><h5>'..v.name..'</h5><p>Ammunation: 0</p><p>Identifier: '..id..'</p></div>'..melee
  end
 end
 return melee
end

function getPistol()
 local melee = ''
 for id,v in pairs(allWeapons) do 
  if GetWeapontypeGroup(GetHashKey(v.weapon)) == 416676503 then 
   melee = '<div class="newWeapon" id="'..id..'" onclick="selectPistol('..id..')"><h5>'..v.name..'</h5><p>Ammunation: '..GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(v.weapon))..'</p><p>Identifier: '..id..'</p></div>'..melee
  end
 end
 return melee
end

function getRifle()
 local melee = ''
 for id,v in pairs(allWeapons) do 
  if GetWeapontypeGroup(GetHashKey(v.weapon)) == -957766203 or GetWeapontypeGroup(GetHashKey(v.weapon)) == 1159398588 or GetWeapontypeGroup(GetHashKey(v.weapon)) == 860033945 or GetWeapontypeGroup(GetHashKey(v.weapon)) == -1212426201 or GetWeapontypeGroup(GetHashKey(v.weapon)) == 970310034 then 
   melee = '<div class="newWeapon" id="'..id..'" onclick="selectRifle('..id..')"><h5>'..v.name..'</h5><p>Ammunation: '..GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(v.weapon))..'</p><p>Identifier: '..id..'</p></div>'..melee
  end
 end
 return melee
end

function getOther()
 local melee = ''
 for id,v in pairs(allWeapons) do 
  if GetWeapontypeGroup(GetHashKey(v.weapon)) == 1548507267 then 
   melee = '<div class="newWeapon" id="'..id..'" onclick="selectOther('..id..')"><h5>'..v.name..'</h5><p>Ammunation: '..GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(v.weapon))..'</p><p>Identifier: '..id..'</p></div>'..melee
  elseif v.weapon == 'WEAPON_STUNGUN' or v.weapon == 'WEAPON_PETROLCAN' or v.weapon == 'WEAPON_FIREEXTINGUISHER' then 
   melee = '<div class="newWeapon" id="'..id..'" onclick="selectOther('..id..')"><h5>'..v.name..'</h5><p>Ammunation: '..GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(v.weapon))..'</p><p>Identifier: '..id..'</p></div>'..melee
  end
 end
 return melee
end


Citizen.CreateThread(function()
 EnableGui(false)
 while true do
  Citizen.Wait(5)
   DisableControlAction(26, 37, true) -- TAB
   DisableControlAction(26, 157, true) -- 1
   DisableControlAction(26, 158, true) -- 2
   DisableControlAction(26, 160, true) -- 3
   DisableControlAction(26, 164, true) -- 4
   DisableControlAction(26, 165, true) -- 5
   DisableControlAction(26, 159, true) -- 6
   DisableControlAction(26, 161, true) -- 7
   DisableControlAction(26, 162, true) -- 8
 end
end)

Citizen.CreateThread(function()
 while true do
  local ped = GetPlayerPed(-1)
  Citizen.Wait(5)
  if IsDisabledControlJustPressed(26, 37) and not guiEnabled and not IsPauseMenuActive() and not IsPedRunning(ped) and not IsPedJumping(ped) and not IsEntityDead(ped) and not IsPedCuffed(ped) then 
   guiEnabled = not guiEnabled
   EnableGui(guiEnabled)
  elseif IsDisabledControlJustPressed(26, 157) and not IsEntityDead(ped) and not IsPedCuffed(ped) then 
   -- Melee
   loadAnimation("melee@holster")
   if GetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey(weaponSelection[1]), false) then 
    -- Outro
    TaskPlayAnim(GetPlayerPed(-1), "melee@holster", "holster", 8.0, 2.0, -1, 48, 10, 0, 0, 0)
    Wait(500)
    SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey('WEAPON_UNARMED'), true)
   else
    TaskPlayAnim(GetPlayerPed(-1), "melee@holster", "unholster", 8.0, 2.0, -1, 48, 10, 0, 0, 0)
    Wait(500)
    SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey(weaponSelection[1]), true)
    ClearPedTasks(GetPlayerPed(-1))
   end
  elseif IsDisabledControlJustPressed(26, 158) and not IsEntityDead(ped) and not IsPedCuffed(ped) then  
    -- Pistol
   loadAnimation("reaction@intimidation@1h")
   if GetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey(weaponSelection[2]), false) then 
    TaskPlayAnim(GetPlayerPed(-1), "reaction@intimidation@1h", "outro", 8.0, 2.0, -1, 48, 10, 0, 0, 0)
    Wait(1800)
    SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey('WEAPON_UNARMED'), true)
   else
    TaskPlayAnim(GetPlayerPed(-1), "reaction@intimidation@1h", "intro", 8.0, 2.0, -1, 48, 10, 0, 0, 0)
    Wait(1800)
    SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey(weaponSelection[2]), true)
    ClearPedTasks(GetPlayerPed(-1))
   end
  elseif IsDisabledControlJustPressed(26, 160) and not IsEntityDead(ped) and not IsPedCuffed(ped) then  
   -- Rifles
   loadAnimation("reaction@intimidation@1h")
   if GetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey(weaponSelection[3]), false) then 
    TaskPlayAnim(GetPlayerPed(-1), "reaction@intimidation@1h", "outro", 8.0, 2.0, -1, 48, 10, 0, 0, 0)
    Wait(1800)
    SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey('WEAPON_UNARMED'), true)
   else
    TaskPlayAnim(GetPlayerPed(-1), "reaction@intimidation@1h", "intro", 8.0, 2.0, -1, 48, 10, 0, 0, 0)
    Wait(1800)
    SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey(weaponSelection[3]), true)
    ClearPedTasks(GetPlayerPed(-1))
   end
  elseif IsDisabledControlJustPressed(26, 164) and not IsEntityDead(ped) and not IsPedCuffed(ped) then  
   if GetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey(weaponSelection[4]), false) then 
    -- Outro
    TaskPlayAnim(GetPlayerPed(-1), "melee@holster", "holster", 8.0, 2.0, -1, 48, 10, 0, 0, 0)
    Wait(500)
    SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey('WEAPON_UNARMED'), true)
   else
    TaskPlayAnim(GetPlayerPed(-1), "melee@holster", "unholster", 8.0, 2.0, -1, 48, 10, 0, 0, 0)
    Wait(500)
    SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey(weaponSelection[4]), true)
    ClearPedTasks(GetPlayerPed(-1))
   end
  end
 end
end)

function loadAnimation(animation)
 RequestAnimDict(animation)
 while not HasAnimDictLoaded(animation) do
  Citizen.Wait(10)
 end
end

RegisterCommand('weapons', function(source, args, rawCommand)
 guiEnabled = not guiEnabled
 EnableGui(guiEnabled)
 SendNUIMessage({type = "enableui", enable = false})
end)
