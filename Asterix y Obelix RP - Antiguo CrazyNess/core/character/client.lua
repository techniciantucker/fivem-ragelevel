local guiEnabled = true
local firstSpawn = true
local character = {}
local permission_level = 0

function EnableGui(enable, chars)
 SetNuiFocus(enable, enable)
 guiEnabled = enable
 SendNUIMessage({type = "enableui",  enable = enable, characters = chars})
end 

RegisterCommand('debug', function(source, args, rawCommand)
 if guiEnabled then 
  TriggerServerEvent("core:getCharacters")
 end
end)

AddEventHandler('playerSpawned', function(spawn)
 TriggerEvent("core:startSkyCamera")
 Wait(500)
 TriggerServerEvent("core:getCharacters")
end)

RegisterNetEvent('core:spawncharacter')
AddEventHandler('core:spawncharacter', function()
 EnableGui(false ,false)
 guiEnabled = false
 Wait(3000)
 DoScreenFadeIn(50)
 SetEntityMaxHealth(PlayerPedId(), 2000)
 SetPedMaxHealth(PlayerPedId(), 2000)
 SetEntityHealth(PlayerPedId(), 2000)
 RemoveAllPedWeapons(PlayerPedId(), true)
  Wait(30000)
 TriggerEvent('ems:heal')
   Wait(30000)
 TriggerEvent('ems:heal')
end)

RegisterNetEvent("core:switchcharacter")
AddEventHandler("core:switchcharacter", function()
 TriggerServerEvent('core:characterDisconnect')
 TriggerEvent("core:startSkyCamera")
 TriggerServerEvent("core:getCharacters")
end)

RegisterNetEvent("core:characterscreen")
AddEventHandler("core:characterscreen", function(characters, perm)
 permission_level = perm
 local html = ''
 character = characters
 for id,v in pairs(characters) do 
  local char = string.format('<div class="character" id="%s" onclick="currentCharacter(%s)"><p style="font-weight: bolder;">%s<font style="float: right">%s</font></font></p><p style="font-weight: normal;">Cash: $%s | Bank: $%s</p><p style="font-weight: normal;">Playtime: %s Hours</p></div>', id, id, v.name, v.dob, v.cash, v.bank, math.floor(v.playtime/60))
  html = html..char
 end
 EnableGui(true, html)
end)

-- NUI Callback Events
RegisterNUICallback('selectcharacter', function(data, cb)
 DoScreenFadeOut(50)
 EnableGui(false,false)
 TriggerServerEvent("core:loadcharacter", character[data.id])
 Wait(1000)
 TriggerServerEvent('skinCreation:load', character[data.id].gender)
 TriggerEvent("core:stopSkyCamera")
 local coords = json.decode(character[data.id].position)
 Teleport(coords.x, coords.y, coords.z)
 cb('ok')
end)

RegisterNUICallback('deletecharacter', function(data, cb)
  if character[data.id].jailtime == 0 then
    EnableGui(false,false) 
    TriggerServerEvent("core:deletecharacter", character[data.id].id)
  end
end)

RegisterNUICallback('create', function(data, cb) 
  EnableGui(false,false)
  Wait(10)
  TriggerServerEvent("core:createcharacter", data)
  cb('ok')
end)

--Updating Position Of Player
Citizen.CreateThread(function()
 while true do
  Wait(7500)
  if not guiEnabled then
   local pos = GetEntityCoords(GetPlayerPed(-1))
   TriggerServerEvent('core:updateposition', pos.x, pos.y, pos.z)
  end
 end
end)

function Teleport(x,y,z)
 Citizen.CreateThread(function()
  RequestCollisionAtCoord(x, y, z)
  while not HasCollisionLoadedAroundEntity(GetPlayerPed(-1)) do
   RequestCollisionAtCoord(x, y, z)
   Citizen.Wait(1)
  end
  if x ~= 0.0 and y ~= 0.0 and z ~= 0.0 then
   SetEntityCoords(GetPlayerPed(-1), x, y, z)
  else
   SetEntityCoords(GetPlayerPed(-1), -220.744, -1053.473, 29.540)
  end
 end)
end

--==========================
--==== Character Switch ====
--==========================
local logout = {
 [1] = {x = 1699.973, y = 2521.186, z = -121.740} -- Inside Prison Cell Block
 --[2] = {x = 429.9541, y = -811.517, z = 28.541}, 
 --[3] = {x = 1929.163, y = 3732.566, z = 31.864}
 --[4] = {x = 3.835, y = 6505.733, z = 30.897}
}

Citizen.CreateThread(function()
 while true do
  local coords = GetEntityCoords(GetPlayerPed(-1))
  Wait(5)
  for k,v in pairs(logout) do
   if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 25) then
    DrawMarker(27, v.x, v.y, v.z+0.05, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 66,197,244, 200, 0, 0, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.5) then
     drawTxt('~b~Press ~g~E~b~ To Switch Character')
     if IsControlJustPressed(0, 38) then
      TriggerEvent('prison:switchcharacter')
      TriggerServerEvent('core:characterDisconnect')
      TriggerEvent("core:startSkyCamera")
      TriggerServerEvent("core:getCharacters")
     end
    end
   end
  end
 end
end)

RegisterNetEvent("core:startSkyCamera")
AddEventHandler("core:startSkyCamera", function()
 SetEntityCoords(GetPlayerPed(-1), -1808.336, -1076.676, 48.290)
 SetEntityHeading(GetPlayerPed(-1), 265.598)
 FreezeEntityPosition(GetPlayerPed(-1), true)
 SetEntityVisible(GetPlayerPed(-1), false) 
 SetPlayerInvincible(PlayerId(), true)
end)

RegisterNetEvent("core:stopSkyCamera")
AddEventHandler("core:stopSkyCamera", function()
 FreezeEntityPosition(GetPlayerPed(-1), false)
 SetEntityVisible(GetPlayerPed(-1), true)
 SetPlayerInvincible(PlayerId(), false)
end)