local rentedHotels = {}
local currentHotel = {}
local instance = {}
local myCharacterID = 0
local hotelDoors = {
 [1] = {x = 312.868, y = -218.617, z = 54.226}, 
 [2] = {x = 310.957, y = -217.917, z = 54.226}, 
 [3] = {x = 307.326, y = -216.515, z = 54.226},
 [4] = {x = 307.686, y = -213.429, z = 54.226}, 
 [5] = {x = 313.659, y = -198.251, z = 54.226}, 
 [6] = {x = 311.532, y = -203.454, z = 54.226}, 
 [7] = {x = 309.784, y = -208.084, z = 54.226}, 
 [8] = {x = 321.258, y = -197.288, z = 54.226}, 
 [9] = {x = 319.185, y = -196.463, z = 54.226}, 
 [10] = {x = 315.682, y = -195.126, z = 54.226},  
 [11] = {x = 312.868, y = -218.617, z = 58.016}, 
 [12] = {x = 310.957, y = -217.917, z = 58.016}, 
 [13] = {x = 307.326, y = -216.515, z = 58.016},
 [14] = {x = 307.686, y = -213.429, z = 58.016}, 
 [15] = {x = 313.659, y = -198.251, z = 58.016}, 
 [16] = {x = 311.532, y = -203.454, z = 58.016}, 
 [17] = {x = 309.784, y = -208.084, z = 58.016}, 
 [18] = {x = 321.258, y = -197.288, z = 58.016}, 
 [19] = {x = 319.185, y = -196.463, z = 58.016}, 
 [20] = {x = 315.682, y = -195.126, z = 58.016},  
 [21] = {x = 346.500, y = -199.653, z = 54.222}, 
 [22] = {x = 344.355, y = -204.913, z = 54.222}, 
 [23] = {x = 342.606, y = -209.471, z = 54.222}, 
 [24] = {x = 340.507, y = -214.799, z = 54.222}, 
 [25] = {x = 338.813, y = -219.178, z = 54.222}, 
 [26] = {x = 336.789, y = -224.431, z = 54.222}, 
 [27] = {x = 335.081, y = -227.139, z = 54.222}, 
 [28] = {x = 331.492, y = -225.645, z = 54.222}, 
 [29] = {x = 329.413, y = -224.925, z = 54.222}, 
 [30] = {x = 346.500, y = -199.653, z = 58.016}, 
 [31] = {x = 344.355, y = -204.913, z = 58.016}, 
 [32] = {x = 342.606, y = -209.471, z = 58.016}, 
 [33] = {x = 340.507, y = -214.799, z = 58.016}, 
 [34] = {x = 338.813, y = -219.178, z = 58.016}, 
 [35] = {x = 336.789, y = -224.431, z = 58.016}, 
 [36] = {x = 335.081, y = -227.139, z = 58.016}, 
 [37] = {x = 331.492, y = -225.645, z = 58.016}, 
 [38] = {x = 329.413, y = -224.925, z = 58.016}, 
}

Citizen.CreateThread(function()
 local currentItemIndex = 1
 local days = 1 
 WarMenu.CreateLongMenu('hotel_rent', "Hotel")
 WarMenu.CreateLongMenu('hotel_management', "Hotel")
 while true do
  local coords = GetEntityCoords(GetPlayerPed(-1))
  Citizen.Wait(5)
  if not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
   for id,v in pairs(hotelDoors) do
    if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 25.0) then
     if rentedHotels[id] then
      DrawMarker(25, v.x, v.y, v.z-0.95, 0, 0, 0, 0, 0, 0, 0.8,0.8,0.5, 255, 15, 15, 200, 0, true, 2, 0, 0, 0, 0)
      if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.2) then
       if rentedHotels[id].char_id == myCharacterID then
        drawTxt('~b~Press ~g~E~b~ To Manage Hotel Room')
        if IsControlJustPressed(0, 38) then
         currentHotel = {pos = v, id = id, days = rentedHotels[id].days_left}
         WarMenu.OpenMenu('hotel_management')
        end
       end
      end
     else
      DrawMarker(25, v.x, v.y, v.z-0.99, 0, 0, 0, 0, 0, 0, 0.8,0.8,0.5, 15, 255, 15, 200, 0, true, 2, 0, 0, 0, 0)
      if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.2) then
       drawTxt('~b~Press ~g~E~b~ To Rent This Hotel Room')
       if IsControlJustPressed(0, 38) then 
        currentHotel = {pos = v, id = id}
        WarMenu.OpenMenu('hotel_rent')
       end
      end
     end
    end 
   end
  end
  if WarMenu.IsMenuOpened('hotel_rent') then
   if WarMenu.ComboBox('Days To Rent', {1,2,3,4,5,6,7}, currentItemIndex, days, function(currentIndex)
     currentItemIndex = currentIndex 
     days = currentIndex
    end) then
   elseif WarMenu.Button('Rent '..days.." Days", '~g~$'..math.floor(575*exports['core']:getVat(5)*days)) then
    TriggerServerEvent('hotel:rentRoom', currentHotel.id, days, math.floor(575*exports['core']:getVat(5)*days))
    WarMenu.CloseMenu()
   end
   WarMenu.Display()
  elseif WarMenu.IsMenuOpened('hotel_management') then
   if WarMenu.Button('Enter Hotel Room') then 
    TriggerServerEvent("hotel:createInstance", currentHotel)
   elseif WarMenu.Button('Add Extra Day', "~g~$"..math.floor(575*exports['core']:getVat(5))) then
    TriggerServerEvent('hotel:addExtraDays', currentHotel.id, 1, math.floor(575*exports['core']:getVat(5)))
   elseif WarMenu.Button('Stop Renting') then
    TriggerServerEvent('hotel:stopRenting', currentHotel.id)
   elseif WarMenu.Button('Days Remaining', currentHotel.days) then
   end
   WarMenu.Display()
  end
  if(GetDistanceBetweenCoords(coords, 151.428, -1007.758, -99.00, true) < 1.5) then 
   drawTxt("~b~Press ~g~E~b~ To Exit Property")
   if (IsControlJustReleased(1, 38)) then
    RequestCollisionAtCoord(currentHotel.pos.x, currentHotel.pos.y, currentHotel.pos.z)
    while not HasCollisionLoadedAroundEntity(GetPlayerPed(-1)) do
     RequestCollisionAtCoord(currentHotel.pos.x, currentHotel.pos.y, currentHotel.pos.z)
     Wait(0)
    end
    SetEntityCoords(GetPlayerPed(-1), currentHotel.pos.x, currentHotel.pos.y, currentHotel.pos.z)
    Citizen.InvokeNative(0xE036A705F989E049)
    instance.hotelid = 0
    SetEntityCollision(GetPlayerPed(-1), true)
    TriggerServerEvent("hotel:removeFromInstance", currentHotel)
    currentHotel = nil
   end
  end
 end
end)

RegisterNetEvent('hotels:update')
AddEventHandler('hotels:update', function(hotels, id)
 rentedHotels = hotels 
 myCharacterID = id
end)

RegisterNetEvent("hotel:sendToInstance")
AddEventHandler("hotel:sendToInstance", function(inst, hotel)
  instance = inst 
  currentHotel = hotel
  NetworkSetVoiceChannel(instance.vchan)
  RequestCollisionAtCoord(151.428, -1007.758, -99.000)
  while not HasCollisionLoadedAroundEntity(GetPlayerPed(-1)) do
    RequestCollisionAtCoord(151.428, -1007.758, -99.000)
    Wait(0)
  end
  SetEntityCoords(GetPlayerPed(-1), 151.428, -1007.758, -99.000)
  SetEntityCollision(GetPlayerPed(-1), true)
end)

RegisterNetEvent("hotel:updateInstanceMembers")
AddEventHandler("hotel:updateInstanceMembers", function(inst)
  instance = inst
end)


Citizen.CreateThread(function()
  while true do
   local playerPed = GetPlayerPed(-1)
   Citizen.Wait(0)
   if (instance and instance.hotelid and instance.hotelid > 0) then
    if instance.hotelid then
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

