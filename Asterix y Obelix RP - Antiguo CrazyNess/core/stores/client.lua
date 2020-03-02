local hasLicense = false

local ownedWeapon = {}

local myCharacterID = 0

local currentStation = {}

local weapon_stores = {

  [1] = {name="Ammu-Nation", x= -661.626, y = -934.924, z = 21.829, purchase = {x = -661.866, y = -933.391, z = 21.829}, price = 2500000}, 

  [2] = {name="Ammu-Nation", x= 809.557, y = -2157.675, z = 29.619, purchase = {x = 810.224, y = -2159.517, z = 29.619}, price = 2500000},

  [3] = {name="Ammu-Nation", x= 1693.703, y = 3760.534, z = 34.705, purchase = {x = 1692.187, y = 3761.726, z = 34.705}, price = 2500000},

  [4] = {name="Ammu-Nation", x= -330.197, y = 6084.477, z = 31.455, purchase = {x = -332.033, y = 6085.001, z = 31.455}, price = 2500000},

  [5] = {name="Ammu-Nation", x= 252.356, y = -50.746, z = 69.941, purchase = {x = 254.242, y = -50.494, z = 69.941}, price = 2500000},

  [6] = {name="Ammu-Nation", x= 22.759, y = -1107.001, z = 29.797, purchase = {x = 22.980, y = -1105.402, z = 29.797}, price = 3500000}, -- Main Legion (3)

  [7] = {name="Ammu-Nation", x= 2567.282, y = 293.952, z = 108.735, purchase = {x = 2567.809, y = 292.287, z = 108.735}, price = 2500000},

  [8] = {name="Ammu-Nation", x= -1117.581, y = 2699.193, z = 18.554, purchase = {x = -1118.923, y = 2700.076, z = 18.554}, price = 2500000},

  [9] = {name="Ammu-Nation", x= 841.753, y = -1033.938, z = 28.195, purchase = {x = -3172.079, y = 1085.865, z = 20.839}, price = 2500000},

}





local weapons = {

 [1] = {name = 'Martillo', price = 45, amount = 1, id = 214, license = false}, 

 [3] = {name = 'Bate de béisbol', price = 70, amount = 1, id = 215, license = false},

 [4] = {name = 'Extintor de incendios', price = 110, amount = 1, id = 230, license = false},

 [5] = {name = 'Linterna', price = 35, amount = 1, id = 197, license = false},

 --[6] = {name = 'Brass Knuckles', price = 1100, amount = 1, id = 202, license = false},

 [7] = {name = 'Cuchillo', price = 90, amount = 1, id = 212, license = false},

 --[8] = {name = 'Switchblade', price = 1100, amount = 1, id = 201, license = false},

 [9] = {name = 'SNS Pistol', price = 1900, amount = 1, id = 232, license = true},

 [10] = {name = 'Pistol', price = 2250, amount = 1, id = 186, license = true},

 [11] = {name = 'Combat Pistol', price = 3000, amount = 1, id = 187, license = true},

 --[12] = {name = 'Pipe Wrench', price = 1100, amount = 1, id = 192, license = false},

 [13] = {name = 'Hunting Rifle', price = 4750, amount = 1, id = 238, license = true},

}



local player_weapons = {}

local currentweapon = ''



Citizen.CreateThread(function()

 for k,v in ipairs(weapon_stores)do

  local blip = AddBlipForCoord(v.x, v.y, v.z)

  SetBlipSprite (blip, 110)

  SetBlipDisplay(blip, 4)

  SetBlipScale  (blip, 0.6)

  SetBlipColour (blip, 75)

  SetBlipAsShortRange(blip, true)

  BeginTextCommandSetBlipName("STRING")

  AddTextComponentString(v.name)

  EndTextCommandSetBlipName(blip)

 end

 WarMenu.CreateLongMenu('weaponstore', 'Ammu Nation')

 while true do

  Wait(5)

  local coords = GetEntityCoords(GetPlayerPed(-1))

  for k,v in pairs(weapon_stores) do

  --if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 50 then

    --DrawMarker(27, v.x, v.y, v.z+0.10, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 91, 144, 252, 150, 0, 0, 2, 0, 0, 0, 0)

    if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.2 then

      DrawText3Ds(v.x, v.y, v.z,'~c~[~g~E~c~] to shop for weapons')

     if IsControlJustPressed(0, 38) then

      TriggerServerEvent('gun:checkLicense')

      WarMenu.OpenMenu('weaponstore')

     end

    end

   

  end

  if WarMenu.IsMenuOpened('weaponstore') then

   for ind, v in pairs(weapons) do

    local price = math.floor(v.price*getVat(2))

    if not v.license then

      if WarMenu.Button(v.name, "~g~$"..price) then

       TriggerServerEvent('shops:purchase', v.name, price, v.amount, v.id)

       TriggerServerEvent('bank:intoSharedBank', v.price, 7)

      end

    elseif v.license and hasLicense then      

      if WarMenu.Button(v.name, "~g~$"..price) then

       TriggerServerEvent('shops:purchase', v.name, price, v.amount, v.id)

       TriggerServerEvent('bank:intoSharedBank', v.price, 7)

      end

    end

   end

   WarMenu.Display()

  end

 end

end)



RegisterNetEvent("weapon:updateitems")

AddEventHandler("weapon:updateitems", function(inv)

    player_weapons = {}

    player_weapons = inv

end)



RegisterNetEvent("law:gunLicense")

AddEventHandler("law:gunLicense", function(status)

  hasLicense = status

end)



function getWeapons()

 return player_weapons

end





RegisterNetEvent('weaponstores:updateStations')

AddEventHandler('weaponstores:updateStations', function(owned, id)

 ownedWeapon = owned

 myCharacterID = id

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
  local factor = (string.len(text)) / 370
  --DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end