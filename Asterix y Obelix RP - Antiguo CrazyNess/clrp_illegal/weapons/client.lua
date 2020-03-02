local player_weapons = {}

local weapons = {
 [453432689] = true, -- PISTOL
 [3219281620] = true, -- PISTOL MK2
 [1593441988] = true, -- COMBAT PISTOL
 [584646201] = true, -- AP PISTOL
 [2578377531] = true, -- PISTOL .50
 [324215364] = true, -- MICRO SMG
 [736523883] = true, -- SMG
 [2024373456] = true, -- SMG MK2
 [4024951519] = true, -- ASSAULT SMG
 [3220176749] = true, -- ASSAULT RIFLE
 [961495388] = true, -- ASSAULT RIFLE MK2
 [2210333304] = true, -- CARBINE RIFLE
 [4208062921] = true, -- CARBINE RIFLE MK2
 [2937143193] = true, -- ADVANCED RIFLE
 [2634544996] = true, -- MG
 [2144741730] = true, -- COMBAT MG
 [3686625920] = true, -- COMBAT MG MK2
 [487013001] = true, -- PUMP SHOTGUN
 [1432025498] = true, -- PUMP SHOTGUN MK2
 [2017895192] = true, -- SAWNOFF SHOTGUN
 [3800352039] = true, -- ASSAULT SHOTGUN
 [2640438543] = true, -- BULLPUP SHOTGUN
 [100416529] = true, -- SNIPER RIFLE
 [205991906] = true, -- HEAVY SNIPER
 [177293209] = true, -- HEAVY SNIPER MK2
 [856002082] = true, -- REMOTE SNIPER
 [2726580491] = true, -- GRENADE LAUNCHER
 [1305664598] = true, -- GRENADE LAUNCHER SMOKE
 [2982836145] = true, -- RPG
 [1752584910] = true, -- STINGER
 [1119849093] = true, -- MINIGUN
 [3218215474] = true, -- SNS PISTOL
 [2009644972] = true, -- SNS PISTOL MK2
 [1627465347] = true, -- GUSENBERG
 [3231910285] = true, -- SPECIAL CARBINE
 [-1768145561] = true, -- SPECIAL CARBINE MK2
 [3523564046] = true, -- HEAVY PISTOL
 [2132975508] = true, -- BULLPUP RIFLE
 [-2066285827] = true, -- BULLPUP RIFLE MK2
 [137902532] = true, -- VINTAGE PISTOL
 [-1746263880] = true, -- DOUBLE ACTION REVOLVER
 [2828843422] = true, -- MUSKET
 [984333226] = true, -- HEAVY SHOTGUN
 [3342088282] = true, -- MARKSMAN RIFLE
 [1785463520] = true, -- MARKSMAN RIFLE MK2
 [1198879012] = true, -- FLARE GUN
 [171789620] = true, -- COMBAT PDW
 [3696079510] = true, -- MARKSMAN PISTOL
 [1834241177] = true, -- RAILGUN
 [3675956304] = true, -- MACHINE PISTOL
 [3249783761] = true, -- REVOLVER
 [-879347409] = true, -- REVOLVER MK2
 [4019527611] = true, -- DOUBLE BARREL SHOTGUN
 [1649403952] = true, -- COMPACT RIFLE
 [317205821] = true, -- AUTO SHOTGUN
 [125959754] = true, -- COMPACT LAUNCHER
 [3173288789] = true, -- MINI SMG     
}

RegisterNetEvent("weapon:updateitems")
AddEventHandler("weapon:updateitems", function(inv)
    player_weapons = {}
    player_weapons = inv
end)


Citizen.CreateThread(function()
 while true do
  Citizen.Wait(100)
  if IsPedShooting(GetPlayerPed(-1)) and not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
   local _, weapon = GetCurrentPedWeapon(PlayerPedId())
   if weapons[weapon] == true then
    if getSerialNumber() then 
     local pos = GetEntityCoords(GetPlayerPed(-1), false)    
     TriggerServerEvent('weapons:dropShell', getSerialNumber(), {x = pos.x, y = pos.y, z = pos.z})
     Wait(50)
    end
   end
  end
 end
end)

function getSerialNumber()
 local q, weapon = GetCurrentPedWeapon(PlayerPedId())
 for _,v in pairs(player_weapons) do 
  if GetHashKey(v.name) == weapon then 
   return {serial = tostring('WSN'..v.id), name = v.label, noserial = v.blackmarket}
  end
 end
end

local droppedShells = {}

RegisterNetEvent("weapons:updateShells")
AddEventHandler("weapons:updateShells", function(shells)
 droppedShells = shells
end)

Citizen.CreateThread(function()
 while true do
  Wait(5)
  local coords = GetEntityCoords(GetPlayerPed(-1))
  for k,v in pairs(droppedShells) do
   if(GetDistanceBetweenCoords(coords, v.pos.x, v.pos.y, v.pos.z, true) < 10.0) and not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
    DrawMarker(27, v.pos.x, v.pos.y, v.pos.z-0.96, 0, 0, 0, 0, 0, 0, 0.1,0.1,0.5, 247, 215, 239,250, 0, 0, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(coords, v.pos.x, v.pos.y, v.pos.z, true) < 0.8) and not DecorGetBool(GetPlayerPed(-1), "isOfficer") then
     drawTxt('~b~Press ~g~E~b~ To Police The Brass')
     if IsControlJustPressed(0, 38) then
      TaskPlayAnim(GetPlayerPed(-1), "anim@mp_snowball", "pickup_snowball", 8.0, -1, -1, false, 1, 0, 0, 0)
      TriggerServerEvent("weapons:removeShell", k)
     end
    elseif(GetDistanceBetweenCoords(coords, v.pos.x, v.pos.y, v.pos.z, true) < 0.8) and DecorGetBool(GetPlayerPed(-1), "isOfficer") and not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
     drawTxt('~b~Press ~g~E~b~ To Collect Evidence')
     if IsControlJustPressed(0, 38) then
      local s1, s2 = Citizen.InvokeNative(0x2EB41072B4C1E4C0, coords.x, coords.y, coords.z, Citizen.PointerValueInt(), Citizen.PointerValueInt())
      local location = GetStreetNameFromHashKey(s1)
      TaskPlayAnim(GetPlayerPed(-1), "anim@mp_snowball", "pickup_snowball", 8.0, -1, -1, false, 1, 0, 0, 0)	
      TriggerServerEvent("weapons:collectShell", k, location)
     end
    end
   end
  end
 end
end)




------------------------------------------------------
---------------------- Blackmarket -------------------
------------------------------------------------------
local blackmarket = {
 [1] = {x = 2556.115, y = 4661.599, z = 34.075},
 --[1] = {x = 12.758, y = -1110.403, z = 29.797},
 --[2] = {x = 977.000, y = -104.293, z = 74.845},
 --[3] = {x = -1618.532, y = -3007.454, z = -75.205},
}

-- local mafia2 = {
 -- [1] = {label = 'Burundanga', name = 'Item', price = 5000, id = 112},
 -- [2] = {label = 'Maletin', name = 'Item', price = 50, id = 113},  
-- }

local blackmarket_weapons = {

 [1] = {label = 'AP Pistol', name = 'Item', price = 30000, id = 218},

 [2] = {label = 'Micro SMG', name = 'Item', price = 250000, id = 190},

 [3] = {label = 'Assault SMG', name = 'Item', price = 350000, id = 221},

 [4] = {label = 'Assault Rifle', name = 'Item', price = 400000, id = 206},

 [5] = {label = 'Double Barrel', name = 'Item', price = 250000, id = 208},

 [6] = {label = 'Machine Pistol', name = 'Item', price = 200000, id = 242},

 [7] = {label = 'Tommy Gun', name = 'Item', price = 350000, id = 209},

 [8] = {label = 'Compact Rifle', name = 'Item', price = 350000, id = 244},

 [9] = {label = 'Sawn Off Shotgun', name = 'Item', price = 350000, id = 207},

 [10] = {label = 'Advanced Rifle', name = 'Item', price = 350000, id = 223},

 [11] = {label = 'MG', name = 'Item', price = 400000, id = 224},

 [12] = {label = 'Heavy Pistol', name = 'Item', price = 185000, id = 234},

 [13] = {label = 'Pistol .50', name = 'Item', price = 150000, id = 219},

 [14] = {label = 'Machete', name = 'Item', price = 3500, id = 210},

 [15] = {label = 'Hatchet', name = 'Item', price = 500, id = 203},

 [16] = {label = 'Bulletproof Vest', name = 'Item', price = 10000, id = 42},

 [17] = {label = 'Combat Pistol', name = 'Item', price = 165000, id = 187},

 [18] = {label = 'Vintage Pistol', name = 'Item', price = 6000, id = 236},
 
 [19] = {label = 'C4', name = 'Item', price = 60000, id = 185},
 
 [20] = {label = 'USB 2GB', name = 'Item', price = 50, id = 95},
}

Citizen.CreateThread(function()

 WarMenu.CreateMenu('blackmarket', 'Black Market')

 while true do

  Wait(0)

  for k,v in pairs(blackmarket) do
   if DecorGetInt(GetPlayerPed(-1), 'Faction') == 234 or DecorGetInt(GetPlayerPed(-1), 'Faction') == 229 or DecorGetInt(GetPlayerPed(-1), 'Faction') == 212 then

   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 10) then

    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 1.2) then

      DrawText3Ds(v.x, v.y, v.z,'~c~[E] Hablar de negocios')

     if IsControlPressed(0, 38) and not WarMenu.IsMenuOpened('blackmarket') then

      WarMenu.OpenMenu('blackmarket')

     end

    end

   end

  end
  
  end

  if WarMenu.IsMenuOpened('blackmarket') then

   for ind, v in pairs(blackmarket_weapons) do

    if WarMenu.Button(v.label, "~r~$"..v.price) then

     if v.name ~= 'Item' then 

      TriggerServerEvent('blackmarket:purchase', v.name, v.label, v.price)

     else

      TriggerServerEvent('shops:purchase', v.name, v.price, 1, v.id)

     end

    end 

   end

   WarMenu.Display()

  end

 end

end)

-- Citizen.CreateThread(function()
 -- WarMenu.CreateMenu('blackmarket', 'Black Market')
 -- while true do
  -- Wait(1)
  -- for k,v in pairs(blackmarket) do
	  -- if DecorGetInt(GetPlayerPed(-1), 'Faction') == 234 or DecorGetInt(GetPlayerPed(-1), 'Faction') == 229 then
      -- if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 1.2) then 
      -- DrawText3Ds(v.x, v.y, v.z,'~y~[E]~w~ hablar de negocios')
      -- if IsControlPressed(0, 38) and not WarMenu.IsMenuOpened('blackmarket14') then
      -- WarMenu.OpenMenu('blackmarket') 	  
     -- end
	 -- end
   -- end
  -- end
  -- if WarMenu.IsMenuOpened('blackmarket') then
   -- for ind, v in pairs(blackmarket_weapons) do
    -- if WarMenu.Button(v.label, "~g~$"..v.price) then
     -- if v.name ~= 'Item' then 
      -- TriggerServerEvent('blackmarket:purchase', v.name, v.label, v.price)
     -- else
      -- TriggerServerEvent('shops:purchase', v.name, v.price, 1, v.id)
     -- end
    -- end 
   -- end
   -- WarMenu.Display()
  -- end
 -- end
-- end)

-- Citizen.CreateThread(function()
 -- WarMenu.CreateMenu('blackmarket', 'Black Market')
 -- while true do
  -- Wait(1)
  -- for k,v in pairs(blackmarket) do
      -- if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 1.2) then
      -- DrawText3Ds(v.x, v.y, v.z,'~y~[E]~w~ to talk business')
      -- if IsControlPressed(0, 38) and not WarMenu.IsMenuOpened('blackmarket14') then
      -- WarMenu.OpenMenu('blackmarket14') 
     -- end
    -- end
   -- end
  -- end
  -- if WarMenu.IsMenuOpened('blackmarket') then
   -- for ind, v in pairs(mafia2) do
    -- if WarMenu.Button(v.label, "~g~$"..v.price) then
     -- if v.name ~= 'Item' then 
      -- TriggerServerEvent('blackmarket:purchase', v.name, v.label, v.price)
     -- else
      -- TriggerServerEvent('shops:purchase', v.name, v.price, 1, v.id)
     -- end
    -- end 
   -- end
   -- WarMenu.Display()
  -- end
 -- end
-- end)

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