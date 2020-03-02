currentHouse = {}
allHouses = {}
local isReloading = false 
local ownedHouses = {}
local instance = {}
local iplidx = {"ipl1", "ipl2", "ipl3", "ipl4", "ipl5", "ipl6", "ipl8", "ipl9"}
local ipllist = {
  ["ipl1"] = {
      position = {x = 343.85, y = -999.08, z = -99.198}, -- first floor house
      telepos = {x = 346.4, y = -1011.702, z = -99.196},
      item_storage = {x = 343.661, y = -1003.204, z = -99.196},
      weapon_storage = {x = 351.616, y = -998.791, z = -99.196}
    },
  ["ipl2"] = {
      position = {x = 343.85, y = -999.08, z = -99.198}, -- nice house
      telepos = {x = 346.535, y = -1011.702, z = -99.196},
      item_storage = {x = 343.661, y = -1003.204, z = -99.196},
      weapon_storage = {x = 351.616, y = -998.791, z = -99.196}
    },
  ["ipl3"] = {
      position = {x = 263.86999, y = -998.78002, z = -99.010002},   -- low end apartment
      telepos = {x = 265.968, y = -1006.969, z = -100.884},
      item_storage = {x = 263.739, y = -995.882, z = -99.009},
      weapon_storage = {x = 262.552, y = -1002.781, z = -99.009}
    },
  ["ipl4"] = {
      position = {x = -169.852, y = 487.648, z = 137.443},   -- White interior good view
      telepos = {x = -174.2545, y = 497.3608, z = 137.666},
      item_storage = {x = -176.295, y = 492.351, z = 130.044},
      weapon_storage = {x = -168.360, y = 493.855, z = 137.654}
    },
  ["ipl5"] = {
      position = {x = 334.588, y = 431.330, z = 149.171},   -- White interior
      telepos = {x = 341.601, y = 437.529, z = 149.394},
      item_storage = {x = 340.018, y = 431.200, z = 149.381},
      weapon_storage = {x = 337.739, y = 437.002, z = 141.771}
    },
  ["ipl6"] = {
      position = {x = 372.207, y = 411.395, z = 145.700},   -- Red interior
      telepos = {x = 373.561, y = 423.298, z = 145.908},
      item_storage = {x = 376.367, y = 417.352, z = 145.900},
      weapon_storage = {x = 377.414, y = 428.991, z = 138.300}
    },
  ["ipl8"] = {
      position = {x = 1250.276, y = -493.896, z = 69.907},   -- Red interior
      telepos = {x = 1241.143, y = -496.248, z = 69.706},
      item_storage = {x = 1246.125, y = -496.597, z = 69.706},
      weapon_storage = {x = 1242.358, y = -491.413, z = 69.706}
    },	
  ["iplapart1"] = {
      position = {x = -786.8663, y = 315.7642, z = 217.6385},   -- Apartment 1
      telepos = {x = -786.8663, y = 315.7642, z = 217.6385},
      item_storage = {x = -795.93, y = 327.25, z = 217.04},
      weapon_storage = {x = -795.93, y = 327.25, z = 217.04}, 
      ipl = 'apa_v_mp_h_06_a'
    },
}

local exit_locations = {
 {x = 346.535, y = -1011.702, z = -99.196},
 {x = 265.968, y = -1006.969, z = -100.884},
 {x = -174.2545, y = 497.3608, z = 137.666},
 {x = 341.601, y = 437.529, z = 149.394},
 {x = 373.561, y = 423.298, z = 145.908},
}

local firstLoad = true

RegisterNetEvent('housing:update')
AddEventHandler('housing:update', function(all, owned, id)
 if firstLoad then 
  TriggerEvent('phone:houses', all, owned)
  allHouses = all
  firstLoad = false
 end
 myCharacterID = id 
 ownedHouses = owned
end)


local isNearArea = false 
local currentArea = {}

Citizen.CreateThread(function()
 while true do 
  Citizen.Wait(2000)
  isNearArea = false 
  currentArea = {}

  for _,v in pairs(allHouses) do
   if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.pos.x, v.pos.y, v.pos.z, true) < 10 then
    isNearArea = true 
    currentArea = v
   end
  end
 end 
end)

Citizen.CreateThread(function()
 while true do
  local coords = GetEntityCoords(GetPlayerPed(-1))
  Citizen.Wait(5)
  if not IsPedInAnyVehicle(GetPlayerPed(-1), false) and isNearArea then
   local v = currentArea
   if(GetDistanceBetweenCoords(coords, v.pos.x, v.pos.y, v.pos.z, true) < 10.0) and not ownedHouses[v.id] then
    DrawMarker(27, v.pos.x, v.pos.y, v.pos.z-0.95, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 0, 82, 165, 240, 0, 0, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(coords, v.pos.x, v.pos.y, v.pos.z, true) < 1.2) then
     local rent = math.floor(v.price/4)
     drawTxt('~b~Press ~g~E~b~ To Rent Property For ~g~$'..rent..' ~b~Per Week \n~b~[~y~'..v.address..'~b~]')
     if IsControlJustPressed(0, 38) then
      TriggerServerEvent('housing:rentProperty', rent, v.id)
     end
    end 
   end
   -- Owned
   for _,v in pairs(ownedHouses) do
    if(GetDistanceBetweenCoords(coords, allHouses[v.id].pos.x, allHouses[v.id].pos.y, allHouses[v.id].pos.z, true) < 10.0) then
     DrawMarker(27, allHouses[v.id].pos.x, allHouses[v.id].pos.y, allHouses[v.id].pos.z-0.95, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 0, 82, 165, 240, 0, 0, 2, 0, 0, 0, 0)
     if(GetDistanceBetweenCoords(coords, allHouses[v.id].pos.x, allHouses[v.id].pos.y, allHouses[v.id].pos.z, true) < 1.2) then
      if v.char_id == myCharacterID then 
       drawTxt('~b~Press ~g~E~b~ To Manage Property')
       if IsControlJustPressed(0, 38) then
        currentHouse = v
        WarMenu.OpenMenu('housing_manage')
       end
      elseif hasHouseKey(v.id) then
       drawTxt('~b~Press ~g~E~b~ To Enter Property')
       if IsControlJustPressed(0, 38) then
        TriggerServerEvent("housing:createInstance", v) 
        currentHouse = v
       end
      else
       drawTxt("~b~[Address: ~y~"..allHouses[v.id].address.."~b~]\n[Owner: ~y~"..v.owner.."~b~]")
      end
     end
    end 
   end
  else 
   Wait(1000)
  end
 end
end)

function hasHouseKey(id)
 if DecorGetBool(GetPlayerPed(-1), "isOfficer") then
  return true 
 else
  if ownedHouses[id].keys ~= 'No Keys' then 
   local keys = json.decode(ownedHouses[id].keys)
   for _,v in pairs(keys) do 
    if v.id == myCharacterID then 
     return true
    end
   end
  end
 end
end


Citizen.CreateThread(function()
 WarMenu.CreateLongMenu('housing_manage', "Housing")
 WarMenu.CreateLongMenu('housing_key_manage', "Housing")
 WarMenu.CreateLongMenu('housing_key_manage_manage', "Housing")
 WarMenu.CreateLongMenu('housing_key_revoke', "Housing")
 local MenuAction = ''
 local revokehouse = nil
 while true do
  Citizen.Wait(5)
  if WarMenu.IsMenuOpened('housing_manage') then
   if currentHouse.rent_due == 0 and WarMenu.Button('Enter House')  then
    TriggerServerEvent("housing:createInstance", currentHouse)
    WarMenu.CloseMenu()
   elseif currentHouse.rent_due == 0 and WarMenu.Button('Enter House With Guests') then
    local pedids = GetPlayersInArea()
    if (pedids and #pedids > 0) then
      TriggerServerEvent("housing:enterallowfriends", pedids, currentHouse)
    else
      exports.pNotify:SendNotification({text = "No Players Nearby"})
    end
    WarMenu.CloseMenu()
   elseif WarMenu.Button('Pay Rent', '~g~$'..currentHouse.rent_due) then
    TriggerServerEvent("housing:payRent", currentHouse.id, currentHouse.rent_due)
    WarMenu.CloseMenu()
   elseif WarMenu.Button('Stop Renting') then
    TriggerServerEvent("housing:stopRenting", currentHouse.id)
    WarMenu.CloseMenu()
   end
   WarMenu.Display()
  elseif WarMenu.IsMenuOpened('housing_key_manage') then
   if WarMenu.Button('Give Key') then
    MenuAction = 'Give'
    WarMenu.OpenMenu('housing_key_manage_manage')
   elseif WarMenu.Button('Change Locks') then
    MenuAction = 'Change'
    WarMenu.OpenMenu('housing_key_manage_manage')
   elseif WarMenu.Button('Revoke Key') then
    MenuAction = 'Revoke'
    WarMenu.OpenMenu('housing_key_manage_manage')
   end
   WarMenu.Display()
  elseif WarMenu.IsMenuOpened('housing_key_manage_manage') then
   for _,v in pairs(ownedHouses) do
    if v.char_id == myCharacterID then
     if WarMenu.Button(allHouses[v.id].address) then
      if MenuAction == 'Give' then
       local t, distance = GetClosestPlayer()
       if(distance ~= -1 and distance < 5) then
        TriggerServerEvent("housing:givekey", v, GetPlayerServerId(t))
        WarMenu.CloseMenu()
       end
      elseif MenuAction == 'Change' then
       TriggerServerEvent("housing:changelocks", v.id)
      elseif MenuAction == 'Revoke' then
       revokehouse = v
       WarMenu.OpenMenu('housing_key_revoke')
      end
     end
    end
   end
   WarMenu.Display()
  elseif WarMenu.IsMenuOpened('housing_key_revoke') then
   local keys = json.decode(getKeysById(revokehouse))
   for _,k in pairs(keys) do
    if WarMenu.Button(k.name) then
     TriggerServerEvent("housing:takekey", revokehouse, k.id)
    end
   end
   WarMenu.Display()
  end
 end 
end)


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

RegisterNetEvent('housing:keys')
AddEventHandler('housing:keys', function()
 WarMenu.OpenMenu('housing_key_manage')
end)

RegisterNetEvent("housing:updateInstanceMembers")
AddEventHandler("housing:updateInstanceMembers", function(inst)
  instance = inst
end)

RegisterNetEvent("housing:sendToInstance")
AddEventHandler("housing:sendToInstance", function(inst, house)
  instance = inst 
  currentHouse = house
  teleportToInterior(GetPlayerPed(-1), house)
  NetworkSetVoiceChannel(instance.vchan)
end)

Citizen.CreateThread(function()
  while true do
   local playerPed = GetPlayerPed(-1)
   Citizen.Wait(0)
   if (instance and instance.houseid and instance.houseid > 0) then
    if instance.houseid then
      for i=0, 256, 1 do
        local found = false
        for _,p in pairs(instance.participants) do
          instancePlayer = GetPlayerFromServerId(p)
          if i == instancePlayer then
            found = true
          end
        end
        if not found then
          local otherPlayerPed = GetPlayerPed(i)
          SetEntityLocallyInvisible(otherPlayerPed)
          SetEntityNoCollisionEntity(playerPed, otherPlayerPed, true)
        end
      end
    else
      for i=0, 256, 1 do
        local found = false
        for _,p in pairs(instance.participants) do
         instancePlayer = GetPlayerFromServerId(p)
         if i == instancePlayer then
          found = true
         end
        end
        if found then
         local otherPlayerPed = GetPlayerPed(i)
         SetEntityLocallyInvisible(otherPlayerPed)
         SetEntityNoCollisionEntity(playerPed, otherPlayerPed, true)
        end
      end
    end
   end
  end
end)

Citizen.CreateThread(function()
 while true do
  local ped = GetPlayerPed(-1)
  local pos = GetEntityCoords(ped)
  Citizen.Wait(5)
  for _,v in pairs(exit_locations) do
   if(GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 1.5) then 
    drawTxt("~b~Press ~g~E~b~ To Exit Property")
    if (IsControlJustReleased(1, 38)) then
     if currentHouse.id ~= nil then
      teleportPlayerToHouse(allHouses[currentHouse.id].pos.x, allHouses[currentHouse.id].pos.y, allHouses[currentHouse.id].pos.z)
      Citizen.InvokeNative(0xE036A705F989E049)
      disableInterior()
      instance.houseid = 0
      TriggerServerEvent("housing:removeFromInstance", currentHouse)
      renderExitMarker = false
      currentHouse = nil
     else 
      TriggerEvent('chatMessage', '^1You have logged out inside your house, please do not logout inside a house - you have been teleported to south ls garage')
      teleportPlayerToHouse(342.218, -1691.629, 32.530)
      renderExitMarker = false
      currentHouse = nil
     end
    end
   end
  end
 end
end)

function GetPlayersInArea()
  local peds
  local pedids = {}
  
  peds = GetPedNearbyPeds(GetPlayerPed(-1), -1)
  
  for id = 0, 256 do
    local ped = GetPlayerPed(-1)
    local rped = GetPlayerPed(id)
    
    if (NetworkIsPlayerActive(id) and rped ~= ped) then
      local pos = GetEntityCoords(ped)
      local rpos = GetEntityCoords(rped)
      local dist = Vdist(pos.x, pos.y, pos.z, rpos.x, rpos.y, rpos.z)
      
      if (dist < 5) then
        table.insert(pedids, GetPlayerServerId(id))
      end
    end
  end
  table.insert(pedids, GetPlayerServerId(PlayerId()))
  return pedids
end

function teleportToInterior(house)
  Citizen.CreateThread(function()
   lastipl = ipllist[allHouses[currentHouse.id].ipl]

   if lastipl ~= nil then 
    interior = GetInteriorAtCoords(lastipl.position.x, lastipl.position.y, lastipl.position.z)
    
    Citizen.InvokeNative(0x2CA429C029CCF247, interior)
    SetInteriorActive(interior, true)
    DisableInterior(interior, false)
    
    if (interior) then          
      while (not (IsInteriorReady(interior))) do
        Wait(1)
      end

      teleportPlayerToHouse(lastipl.telepos.x, lastipl.telepos.y, lastipl.telepos.z, lastipl.ipl)
      renderExitMarker = true
    end
   end
  end)
end

function disableInterior()
  if (interior) then
    Citizen.InvokeNative(0x2CA429C029CCF247, interior)
    SetInteriorActive(interior, false)
    DisableInterior(interior, true)
  end
end

function teleportPlayerToHouse(x, y, z, ipl)
  Citizen.CreateThread(function()
    local ped = GetPlayerPed(-1)

    if ipl ~= nil then 
      if (not IsIplActive(ipl)) then
        RequestIpl(ipl)
      end
    end

    RequestCollisionAtCoord(x, y, z)
    
    while (not HasCollisionLoadedAroundEntity(ped)) do
      RequestCollisionAtCoord(x, y, z)
      Wait(0)
    end
    
    SetEntityCoords(ped, x, y, z)

  end)
end

