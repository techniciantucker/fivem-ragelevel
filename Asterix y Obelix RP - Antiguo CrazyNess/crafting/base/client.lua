local inGUI = false
local recipies = {
    [1] = {id = 1, name = "Blunt", amount = 2, requirements = "1 x Gram of Weed/Skunk, 2 x Blunt Wraps", rep = 10},
    [2] = {id = 2, name = "Joint", amount = 4, requirements = "1 x Gram of Weed/Skunk, 1 x Cigarette, 1 x Skin", rep = 0},
    [3] = {id = 3, name = "Gram of Weed", amount = 28, requirements = "1 x Bundle of Baggies, 1 x Oz of Weed and Digital Scales", rep = 0},
    [4] = {id = 4, name = "Gram of SuperSkunk", amount = 28, requirements = "1 x Bundle of Baggies, 1 x Oz of SuperSkunk and Digital Scales", rep = 0},
    [5] = {id = 5, name = "Gram of Cocaine", amount = 28, requirements = "1 x Bundle of Baggies, 1 x Oz of Cocaine, 1 x Digitial Scales", rep = 50},
    [6] = {id = 6, name = "Oz of Weed", amount = 36, requirements = "1 x Brick of Weed, 1 x Kitchen Scales and Shrink Wrap", rep = 100},
    [7] = {id = 7, name = "Oz of SuperSkunk", amount = 36, requirements = "1 x Brick of SuperSkunk, 1 x Kitchen Scales and Shrink Wrap", rep = 100},     
    --[8] = {id = 8, name = "Oz of Cocaine", amount = 9, requirements = "1 x Bar of Cocaine, 1 x Kitchen Scales and Shrink Wrap", rep = 150},
    --[9] = {id = 9, name = "Bar of Cocaine", amount = 4, requirements = "1 x Brick of Cocaine, 1 x Stanley Knife, 1 x Kitchen Scales and shrink wrap", rep = 250},
    --[25] = {id = 25, name = "Bar of Cocaine", amount = 1, requirements = "9 Oz of Cocaine, 1 x Kitchen Scales and shrink wrap", rep = 250},
    [26] = {id = 26, name = "Crack", amount = 8, requirements = "1 Bar Of Coke, Pyrex Jug, 6x Water and Kitchen Scales", rep = 1000}, 
    --[27] = {id = 27, name = "Brick of Cocaine", amount = 1, requirements = "36x Oz of Cocaine, 1 x Kitchen Scales and 5x shrink wrap", rep = 250},
    --[28] = {id = 28, name = "Oz of Heroin", amount = 9, requirements = "1 x Bar of Heroin, 1 x Kitchen Scales and Shrink Wrap", rep = 150},
    [29] = {id = 29, name = "Bags Of Heroin", amount = 42, requirements = "Oz Of Heroin, Digital scales and 1x Bundle Of Baggies", rep = 100},
    [11] = {id = 11, name = "Homemade SNS Pistol", amount = 1, requirements = "1 x Metal Spring, 1 x Pistol Casing, 1 x Hand Grip, 1 x Empty Magazine", rep = 75},    
    [10] = {id = 10, name = "GunKit", amount = 1, requirements = "30 x Rings, 5 x Necklaces", rep = 150},
    [12] = {id = 12, name = "Molotov", amount = 2, requirements = "2 x Glass Bottle, 1 x Old Rag, 1 x Lighter Fluid and a lighter", rep = 175},
    --[13] = {id = 13, name = "Oz's of Crack", amount = 30, requirements = "10 Pure Coke, Pyrex Jug, 10x Water and Kitchen Scales", rep = 1000},
    [14] = {id = 14, name = "Bags Of Crack", amount = 40, requirements = "Oz Of Crack, Digital scales and 1x Bundle Of Baggies", rep = 150},
    [30] = {id = 30, name = "Gram of Purple Haze", amount = 28, requirements = "1 x Bundle of Baggies, 1 x Oz of Purple Haze and Digital Scales", rep = 25},
    [31] = {id = 31, name = "Gram of Lemon Haze", amount = 28, requirements = "1 x Bundle of Baggies, 1 x Oz of Lemon Haze and Digital Scales", rep = 25},
    --[15] = {id = 15, name = "1k in an Envelope", amount = 1, requirements = "1k Cash + 1 Envelope", rep = 25},
    --[16] = {id = 16, name = "5k in an Envelope", amount = 1, requirements = "5k Cash + 2 Envelopes", rep = 50},
    --[17] = {id = 17, name = "10k in an Envelope", amount = 1, requirements = "10k Cash + 3 Envelopes", rep = 100},    
    --[18] = {id = 18, name = "1k Cash Stack", amount = 1, requirements = "1k Dirty Cash + 1 Rubber Bands", rep = 250},
    --[19] = {id = 19, name = "5k Cash Stack", amount = 1, requirements = "5k Dirty Cash + 2 Rubber Bands", rep = 350},
    --[20] = {id = 20, name = "10k Cash Stack", amount = 1, requirements = "10k Dirty Cash + 3 Rubber Bands", rep = 500},
    --[23] = {id = 23, name = "$50k Suitcase", amount = 1, requirements = "$50k Dirty Cash + Briefcase", rep = 500},
    --[23] = {id = 13, name = "Grams of Crystal Meth", amount = 28, requirements = "1 x Oz of Crystal Meth, 1 x Bundle of Baggies, 1 x Digital Scales", rep = 5000},
    --[24] = {id = 14, name = "Grams of Heroin", amount = 28, requirements = "1 x Oz of Heroin, 1 x Bundle of Baggies, 1 x Digital Scales", rep = 5000},
    [32] = {id = 32, name = "Oz's of Purple Haze", amount = 36, requirements = "1 x Brick of Purple Haze, 1 x Kitchen Scales and Shrink Wrap", rep = 50},
    [33] = {id = 33, name = "Pack of Meth", amount = 1, requirements = "25 x Bag of Meth, 1 x Kitchen Scales and Shrink Wrap", rep = 75},
    [34] = {id = 34, name = "Bag of Meth", amount = 25, requirements = "1 Pack of Meth, 1 x Kitchen Scales and 1x Bundle of Baggies", rep = 75},
    [35] = {id = 35, name = "Bar of Heroin", amount = 1, requirements = "Oz Of Heroin, Digital scales and 1x Shrink Wrap", rep = 150},
    [36] = {id = 36, name = "Ounces of Heroin", amount = 9, requirements = "Bar Of Heroin, Digital scales and 1x Bundle of Baggies", rep = 125},
}

function EnableGui(enable, chars)
    SetNuiFocus(enable, enable)
    guiEnabled = enable
    inGUI = true
    SendNUIMessage({type = "enableui",  enable = enable, characters = chars})
end

RegisterNetEvent("crafting:loadrecipies")
AddEventHandler("crafting:loadrecipies", function()
 local html = ''
 local rep = DecorGetInt(GetPlayerPed(-1), "Reputation")
 if rep < 0 then
  rep = 0
 end
 for id,v in pairs(recipies) do
  if rep >= v.rep then
   local char = string.format('<div class="character" id="%s"><p>%s<span class="date">Crafts: %s</span></p><p>%s</p></div>', v.id, v.name, v.amount, tostring(v.requirements))
   html = html..char
  end
 end
 EnableGui(true, html)
end)

-- NUI Callback Events

-- NUI Callback Events
RegisterNUICallback('selectrecipe', function(data, cb)
  EnableGui(false,false)
  cb('ok')
    TriggerEvent("mythic_progbar:client:progress", {
        name = "crafting_item",
        duration = 10000,
        label = "Crafting item",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
    }, function(status)
        if not status then
          TriggerEvent('crafting:trigger:'..data.id)
          inGUI = false
        end
    end)
end)

--[[RegisterNUICallback('selectrecipe', function(data, cb)
  EnableGui(false,false)
  cb('ok')
  API_ProgressBar('Crafting Item', 100)
  Wait(10000)
  TriggerEvent('crafting:trigger:'..data.id)
  inGUI = false
end)]]--

RegisterNUICallback('escape', function(data, cb)
  _GuiEnabled = false
  SetNuiFocus(false, false)
  SendNUIMessage({open = false})
  inGUI = false
end)

Citizen.CreateThread(function()
 while true do
  Wait(1)
  if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 153.926, -1006.835, -99.000, true) < 0.5 and not inGUI then
   DrawText3Ds(153.926, -1006.835, -99.000)
   if IsControlJustPressed(0, 38) then
    TriggerEvent('crafting:loadrecipies')
   end
  end
 end
end)

Citizen.CreateThread(function()
  while true do
   Wait(1)
   if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 262.540, -999.875, -99.009, true) < 0.5 and not inGUI then
    DrawText3Ds(262.540, -999.875, -99.009)
    if IsControlJustPressed(0, 38) then
     TriggerEvent('crafting:loadrecipies')
    end
   end
  end
end)


Citizen.CreateThread(function()
  while true do
   Wait(1)
   if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 1109.873, -3150.525, -37.519, true) < 0.5 and not inGUI then
    DrawText3Ds(1109.873, -3150.525, -37.519)
    if IsControlJustPressed(0, 38) then
     TriggerEvent('crafting:loadrecipies')
    end
   end
  end
end)


Citizen.CreateThread(function()
  while true do
   Wait(1)
   if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 339.664, -1000.335, -99.196, true) < 0.5 and not inGUI then 
    DrawText3Ds(339.664, -1000.335, -99.196)
    if IsControlJustPressed(0, 38) then
     TriggerEvent('crafting:loadrecipies')
    end
   end
  end
end)

Citizen.CreateThread(function()
  while true do
   Wait(1)
   if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 1087.242, -3195.484, -38.993, true) < 0.5 and not inGUI then  
    DrawText3Ds(1087.242, -3195.484, -38.993)
    if IsControlJustPressed(0, 38) then
     TriggerEvent('crafting:loadrecipies')
    end
   end
  end
end)

Citizen.CreateThread(function()
  while true do
   Wait(1)
   if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1145.375, -1514.435, 10.633, true) < 0.5 and not inGUI then 
    DrawText3Ds(-1145.375, -1514.435, 10.633)
    if IsControlJustPressed(0, 38) then
     TriggerEvent('crafting:loadrecipies')
    end
   end
  end
end)

Citizen.CreateThread(function()
  while true do
   Wait(1)
   if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -9.845, -1433.478, 31.102, true) < 0.5 and not inGUI then 
    DrawText3Ds(-9.845, -1433.478, 31.102)
    if IsControlJustPressed(0, 38) then
     TriggerEvent('crafting:loadrecipies')
    end
   end
  end
end)

Citizen.CreateThread(function()
  while true do
   Wait(1)
   if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -804.545, 177.509, 72.835, true) < 0.5 and not inGUI then 
    DrawText3Ds(-804.545, 177.509, 72.835)
    if IsControlJustPressed(0, 38) then
     TriggerEvent('crafting:loadrecipies')
    end
   end
  end
end)

Citizen.CreateThread(function()
  while true do
   Wait(1)
   if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -112.500, -11.840, 70.520, true) < 0.5 and not inGUI then 
    DrawText3Ds(-112.500, -11.840, 70.520)
    if IsControlJustPressed(0, 38) then
     TriggerEvent('crafting:loadrecipies')
    end
   end
  end
end)

Citizen.CreateThread(function()
  while true do
   Wait(1)
   if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1326.215, -926.140 ,-52.662, true) < 0.5 and not inGUI then 
    DrawText3Ds(-1326.215, -926.140 ,-52.662)
    if IsControlJustPressed(0, 38) then
     TriggerEvent('crafting:loadrecipies')
    end
   end
  end
end)

Citizen.CreateThread(function()
  while true do
   Wait(1)
   if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 34.410, -2656.208, 12.045, true) < 0.5 and not inGUI then 
    DrawText3Ds(34.410, -2656.208, 12.045)
    if IsControlJustPressed(0, 38) then
     TriggerEvent('crafting:loadrecipies')
    end
   end
  end
end)

Citizen.CreateThread(function()
  while true do
   Wait(1)
   if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -796.400, 184.758, 72.606, true) < 0.5 and not inGUI then 
    DrawText3Ds(-796.400, 184.758, 72.606)
    if IsControlJustPressed(0, 38) then
     TriggerEvent('crafting:loadrecipies')
    end
   end
  end
end)

Citizen.CreateThread(function()
  while true do
   Wait(1)
   if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -421.556, -2178.481, 10.493, true) < 0.5 and not inGUI then 
    DrawText3Ds(-421.556, -2178.481, 10.493)
    if IsControlJustPressed(0, 38) then
     TriggerEvent('crafting:loadrecipies')
    end
   end
  end
end)

Citizen.CreateThread(function()
  while true do
   Wait(1)
   if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1326.215, -926.140 ,-52.662, true) < 0.5 and not inGUI then 
    DrawText3Ds(-1326.215, -926.140 ,-52.662)
    if IsControlJustPressed(0, 38) then
     TriggerEvent('crafting:loadrecipies')
    end
   end
  end
end)

Citizen.CreateThread(function()
  while true do
   Wait(1)
   if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 562.375, -1769.840, -30.902, true) < 0.5 and not inGUI then 
    DrawText3Ds(562.375, -1769.840, -30.902)
    if IsControlJustPressed(0, 38) then
     TriggerEvent('crafting:loadrecipies')
    end
   end
  end
end)

Citizen.CreateThread(function()
  while true do
   Wait(1)
   if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -798.566, 327.704, 217.038, true) < 0.5 and not inGUI then 
    DrawText3Ds(-798.566, 327.704, 217.038)
    if IsControlJustPressed(0, 38) then
     TriggerEvent('crafting:loadrecipies')
    end
   end
  end
end)

Citizen.CreateThread(function()
  while true do
   Wait(1)
   if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -772.326, 328.945, 223.261, true) < 0.5 and not inGUI then 
    DrawText3Ds(-772.326, 328.945, 223.261)
    if IsControlJustPressed(0, 38) then
     TriggerEvent('crafting:loadrecipies')
    end
   end
  end
end)

Citizen.CreateThread(function()
  while true do
   Wait(1)
   if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 988.724, -138.206, 73.090, true) < 0.5 and not inGUI then 
    DrawText3Ds(988.724, -138.206, 73.090)
    if IsControlJustPressed(0, 38) then
     TriggerEvent('crafting:loadrecipies')
    end
   end
  end
end)

Citizen.CreateThread(function()
  while true do
   Wait(1)
   if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 1976.736, 3819.388, 33.450, true) < 0.5 and not inGUI then 
    DrawText3Ds(1976.736, 3819.388, 33.450)
    if IsControlJustPressed(0, 38) then
     TriggerEvent('crafting:loadrecipies')
    end
   end
  end
end)


Citizen.CreateThread(function()
  while true do
   Wait(1)
   if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 1016.929, -3194.963, -38.993, true) < 0.5 and not inGUI then 
    DrawText3Ds(1016.929, -3194.963, -38.993)
    if IsControlJustPressed(0, 38) then
     TriggerEvent('crafting:loadrecipies')
    end
   end
  end
end)




function DrawText3Ds(x,y,z)
	local text = "~c~[~g~E~c~] Crafting Table"
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