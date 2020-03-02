-- Blips 
local blips = {
  {title="Court House", colour=74, id=188, x=233.20599365234, y=-410.57699584961, z=48.117725372314},
  {title="Bahama Mamas", colour=8, id=136, x=-1387.009, y=-589.225, z=29.319},
  {title="Centro de trabajo", colour=18, id=408, x = 162.371, y = -1103.952, z = 29.313},
  {title="Hospital", colour=69, id=61, x=308.111, y = -595.298, z = 43.292},
  {title="Gimnasio", colour=39, id=311, x= -1201.973, y= -1567.054, z= 4.611},
  {title="Mecanico", colour=17, id=402, x = 474.026, y = -1311.539, z = 29.226},
  --{title="Train Station", colour=47, id=280, x = -487.521, y = 5260.139, z = 87.011},
  --{title="Train Station", colour=47, id=280, x = 2620.431, y = 2930.545, z = 40.423},
  --{title="Vip Autos", colour=74, id=225, x = -146.324, y = -583.313, z = 32.424},  
  {title="NightClubs Galaxy", colour=74, id=614, x = -247.918, y = -328.958, z = 66.049},  
  --{title="Recycle Center", colour=47, id=467, x = 2357.720, y = 3138.358, z = 48.209},
  {title="Swanns Luxury Autos", colour=46, id=225, x = -803.536, y = -224.350, z = 37.224},
  {title="Stephen's Motorworks", colour=8, id=225, x = -176.819, y = -1158.620, z = 26.814},
  {title="Wheels In Motion", colour=9, id=226, x = 267.940, y = -1155.270, z = 29.291},
  {title="Parson's", colour=59, id=398, x = -1504.176, y = 861.042, z = 181.595},
  {title="Doctor's Office", colour=59, id=498, x = -1897.919, y = -572.039, z = 11.843},
  {title="Bar", colour=8, id=93, x = -3.581, y = -982.068, z = 29.357},
  {title="Policia", colour=4, id=60, x = 436.777, y = -976.961, z = 30.723},  
  {title="Burger Shot", colour=12, id=52, x = -1193.142, y = -891.700, z = 13.995}, 
  {title="Renta de barco", colour=4, id=427, x = 2835.675, y = -667.071, z = 0.944},
  {title="Mina de Oro", colour=4, id=78, x = -595.894, y = 2089.059, z = 131.413},  
  {title="Fundicion", colour=4, id=78, x = 1083.408, y = -1973.239, z = 31.015},  
  {title="Joyeria", colour=4, id=78, x = -630.716, y = -229.695, z = 38.057}, 
  {title="Venta de Carbon", colour=4, id=78, x = 2702.719, y = 1483.630, z = 24.501},
}

Citizen.CreateThread(function()
 for _, info in pairs(blips) do
  info.blip = AddBlipForCoord(info.x, info.y, info.z)
  SetBlipSprite(info.blip, info.id)
  SetBlipDisplay(info.blip, 4)
  SetBlipScale(info.blip, 0.6)
  SetBlipColour(info.blip, info.colour)
  SetBlipAsShortRange(info.blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString(info.title)
  EndTextCommandSetBlipName(info.blip)
 end
end)

local proned = false

Citizen.CreateThread( function()
	while true do 
		Citizen.Wait(5)
		if DoesEntityExist(GetPlayerPed(-1)) and not IsEntityDead(GetPlayerPed(-1)) then 
			ProneMovement()
			DisableControlAction(0, 288, true) 
			if ( not IsPauseMenuActive() ) then 
				if ( IsDisabledControlJustPressed(0, 288) and not IsPedInAnyVehicle(GetPlayerPed(-1), true) and not IsPedFalling(GetPlayerPed(-1)) and not IsPedDiving(GetPlayerPed(-1)) and not IsPedInCover(GetPlayerPed(-1), false) and not IsPedInParachuteFreeFall(GetPlayerPed(-1)) and (GetPedParachuteState(GetPlayerPed(-1)) == 0 or GetPedParachuteState(GetPlayerPed(-1)) == -1) ) then
					if proned then
						ClearPedTasksImmediately(GetPlayerPed(-1))
						proned = false
					else
						RequestAnimSet( "move_crawl" )
						while ( not HasAnimSetLoaded( "move_crawl" ) ) do 
							Citizen.Wait( 100 )
						end 
						ClearPedTasksImmediately(GetPlayerPed(-1))
						proned = true
						if IsPedSprinting(GetPlayerPed(-1)) or IsPedRunning(GetPlayerPed(-1)) or GetEntitySpeed(GetPlayerPed(-1)) > 5 then
							TaskPlayAnim(GetPlayerPed(-1), "move_jump", "dive_start_run", 8.0, 1.0, -1, 0, 0.0, 0, 0, 0)
							Wait(1000)
						end
						SetProned()
					end
				end
			end
		else
			proned = false
		end
	end
end)

function SetProned()
	ped = PlayerPedId()
	ClearPedTasksImmediately(ped)
	TaskPlayAnim(ped,"move_crawl","onfront_bwd",0.0,0.0,0,0,0.0,false,false,false)
end

function ProneMovement()
	if proned then
		ped = PlayerPedId()
		if IsControlPressed(0, 34) then
			SetEntityHeading(ped, GetEntityHeading(ped)+2.0 )
		elseif IsControlPressed(0, 35) then
			SetEntityHeading(ped, GetEntityHeading(ped)-2.0 )
		elseif IsControlPressed(0, 32) and not IsEntityPlayingAnim(ped, "move_crawl", "onfront_fwd", 3) then
			TaskPlayAnim(ped,"move_crawl","onfront_fwd",8.0,-4.0,-1,9,0.0,false,false,false)
		elseif IsControlPressed(0, 33) and not IsEntityPlayingAnim(ped, "move_crawl", "onfront_bwd", 3) then
			TaskPlayAnim(ped,"move_crawl","onfront_bwd",8.0,-4.0,-1,9,0.0,false,false,false)
			TaskPlayAnim(ped, animDictionary, animationName, speed, speedMultiplier, duration, flag, playbackRate, lockX, lockY, lockZ)
		elseif IsControlJustReleased(0, 32) or IsControlJustReleased(0, 33) then 
			TaskPlayAnim(ped,"move_crawl","onfront_bwd",0.0,0.0,0,9,0.0,false,false,false)
		end
	end
end

local crouched = false 

Citizen.CreateThread( function()
 while true do 
  Citizen.Wait(5)
  if IsControlJustPressed(0, 289) and not IsPedInAnyVehicle(GetPlayerPed(-1)) then
   RequestAnimSet( "move_ped_crouched" )
   while not HasAnimSetLoaded("move_ped_crouched") do 
    Citizen.Wait(100)
   end 

   if crouched then 
    ResetPedMovementClipset(GetPlayerPed(-1), 0)
    crouched = false 
   else
    SetPedMovementClipset(GetPlayerPed(-1), "move_ped_crouched", 0.25)
    crouched = true 
   end
  end
 end
end)

------------------------------------------------------
---------------------- Tackling -------------------
------------------------------------------------------
-- Citizen.CreateThread(function()
 -- while true do
  -- Citizen.Wait(10)
  -- --Tackling
  -- if IsPedRunning(GetPlayerPed(-1)) and IsControlPressed(0, 38) then
   -- local t, distance = GetClosestPlayer()
   -- if distance ~= -1 and distance <= 3.0 then
    -- TriggerServerEvent('power:tackle', GetPlayerServerId(t))
    -- SetPedToRagdoll(GetPlayerPed(-1), 1500, 1500, 0, 0, 0, 0)
    -- Wait(15000)
   -- end
  -- end
  -- if IsPedJumping(GetPlayerPed(-1)) and IsPedRunning(GetPlayerPed(-1)) then
   -- if math.random(1,100) > 90 then
    -- SetPedToRagdoll(GetPlayerPed(-1), 250, 250, 0, 0, 0, 0)
   -- end
  -- end
 -- end
-- end)

RegisterNetEvent('power:toggletackle')
AddEventHandler('power:toggletackle', function(target)
  if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
    SetPedToRagdoll(GetPlayerPed(-1), 2000, 2000, 0, 0, 0, 0)
  end
end)
 
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


------------------------------------------------------
---------------------- Searching Cars ----------------
------------------------------------------------------
local searched = {}
local lockpicked = false

Citizen.CreateThread(function()
 while true do
  local ped = GetPlayerPed(-1)
  local vehicle = GetVehiclePedIsIn(ped, false)
  Citizen.Wait(5)
  if IsPedInAnyVehicle(ped, false) then
   local plate = GetVehicleNumberPlateText(vehicle)
   if IsControlJustPressed(0, 246) and not Searched(plate) and not exports['clrp_garage']:HasKey(plate) then 
    ProgressBar('Searching Vehicle', 25)
    Wait(3750)
    getRandomReward(plate)
   end
  else
   Wait(5000)
  end
 end
end)

function Searched(plate)
 for _,v in pairs(searched) do 
  if v.plate == plate then 
   return true
  end
 end
end

function getRandomReward(plate)
 local random = math.random(1,8)
 if random == 1 then 
  exports.pNotify:SendNotification({text = "You Found Nothing"})
 elseif random == 2 then 
  exports.pNotify:SendNotification({text = "You Found 2 Cheese Burgers & 2 Bottles Of Water"})
  TriggerEvent("inventory:addQty", 14, 2)
  TriggerEvent("inventory:addQty", 13, 2)
 elseif random == 3 then 
  local money = math.random(10,25)
  exports.pNotify:SendNotification({text = "You Found $"..money.." In The Glove Box"})
  TriggerServerEvent('jobs:addmoney', money)
 elseif random == 4 then 
  exports.pNotify:SendNotification({text = "You Found 2 Cleaning Kits & A Repair Kit"})
  TriggerEvent("inventory:addQty", 6, 1)
  TriggerEvent("inventory:addQty", 11, 2)
 elseif random == 5 then
  exports.pNotify:SendNotification({text = "You Found A Used Condom"})
 elseif random == 6 then
  exports.pNotify:SendNotification({text = "You Found A Large Pink Dildo"})
 elseif random == 7 then 
  exports.pNotify:SendNotification({text = "You Found 2 Can's Of Redbull"})
  TriggerEvent("inventory:addQty", 26, 2)
 elseif random == 8 then
  exports.pNotify:SendNotification({text = "You Found An Umbrella "})
  TriggerEvent("inventory:addQty", 12, 1)
 end
 table.insert(searched, {plate = plate, player = PlayerId()})
end

--========================================================================================--
--================================== No Car Spawns ========================================--
--========================================================================================--
local rempoints = {

  {x = -326.891, y = -137.737, z = 39.010, radius = 50.0}, -- legion

  {x = 405.144, y = -852.109, z = 29.341, radius = 50.0}, -- legion

  {x = 981.376, y = -3169.650, z = 5.901, radius = 200.0}, -- Go Karting

  {x = 152.846, y = -1004.446, z = -99.000, radius = 10.0, peds = true}, -- Motel Interior

}



Citizen.CreateThread(function()

  while true do

    Wait(1000)

    for _,v in pairs(rempoints) do

     if not v.peds then

      ClearAreaOfVehicles(v.x, v.y, v.z, v.radius, 0, 0, 0, 0, 0)

     end

    end

  end

end)



Citizen.CreateThread(function()

  while true do

    Wait(10)

    for _,v in pairs(rempoints) do

     if v.peds then

      ClearAreaOfPeds(v.x, v.y, v.z, v.radius, 0, 0, 0, 0, 0)

     end

    end

  end

end)





local nearObject = false 

local isNearObject = false

local objectLoc1 = {}

local clostestProp = nil

local searchedTrash = {}

local models = {

  [1] = 1437508529,

  [2] = 1329570871,

  [3] = 1143474856,

  [4] = -468629664,

  [5] = -130812911,

  [6] = -93819890,

  [7] = -1426008804

}



Citizen.CreateThread(function()

 while true do

  Citizen.Wait(1500)

  nearObject = false

  isNearObject = false

  local myCoords = GetEntityCoords(GetPlayerPed(-1))

   

  for i = 1, #models do

   clostestProp = GetClosestObjectOfType(myCoords.x, myCoords.y, myCoords.z, 2.5, models[i], false, false)

   if clostestProp ~= nil and clostestProp ~= 0 then

    local coords = GetEntityCoords(clostestProp)

    isNearObject = true

    objectLoc1 = {['x'] = coords.x, ['y'] = coords.y, ['z'] = coords.z + 1.2}

    break

   end

  end

 end

end)



Citizen.CreateThread(function()

 --WarMenu.CreateMenu('trash', 'Trash Can')

 while true do

  Wait(5)

  if isNearObject then 

   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), objectLoc1.x, objectLoc1.y, objectLoc1.z, true) < 1.4) then

    DrawText3Ds(objectLoc1.x, objectLoc1.y, objectLoc1.z,'~y~[E]~w~ Trash Can')

    if IsControlJustPressed(0, 38) then

      TriggerEvent("inventory:openTrash")

      -- WarMenu.OpenMenu('trash')

    elseif IsControlJustPressed(0, 246) and not SearchedTrash(clostestProp) then

      TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_BUM_BIN", 0, true)

      ProgressBar('Searching Trash Can', 25)

      Wait(3750)

      ClearPedTasksImmediately(GetPlayerPed(-1))

      getRandomTrashReward(clostestProp)

    end

   end

  end

  if WarMenu.IsMenuOpened('trash') then

   local inventory = exports['core']:getInventory()

   for i = 1,#inventory do

    if (inventory[i].q > 0) then

     if WarMenu.Button(tostring(inventory[i].name), tonumber(inventory[i].q)) then

      TrashItem(inventory[i].id, inventory[i].name, inventory[i].q) 

     end

    end

   end

   WarMenu.Display()

  end

 end

end)



function TrashItem(item, name, quantity)

 local amount = "xxsdrtghyuujhdjsjenenfjfjtjtjtj"

 if(amount == "xxsdrtghyuujhdjsjenenfjfjtjtjtj") then

  showLoadingPrompt("Enter Quantity", 3)

  DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8S", "", "", "", "", "", 20)

  while (UpdateOnscreenKeyboard() == 0) do

   DisableAllControlActions(0);

   Wait(0);

  end

  if (GetOnscreenKeyboardResult()) then

   local option = tonumber(GetOnscreenKeyboardResult())

   if(option ~= nil and option ~= 0) then

    amount = ""..option

   end

  end

 end

 stopLoadingPrompt()

 if (amount ~= "xxsdrtghyuujhdjsjenenfjfjtjtjtj" and tonumber(amount) > 0) then

  TriggerServerEvent('trash:additems', item, amount)

 end

end



function showLoadingPrompt(showText, showType)

    Citizen.CreateThread(function()

        Citizen.Wait(0)

        N_0xaba17d7ce615adbf("STRING") -- set type

        AddTextComponentString(showText) -- sets the text

        N_0xbd12f8228410d9b4(showType) -- show promt (types = 3)

    end)

end



function stopLoadingPrompt()

    Citizen.CreateThread(function()

        Citizen.Wait(0)

        N_0x10d373323e5b9c0d()

    end)

end



function getRandomTrashReward(id)

 local random = math.random(1,8)

 if random == 1 then 

  exports['clrp_notify']:DoHudText('inform', 'You Found Nothing')

 elseif random == 2 then 

  exports['clrp_notify']:DoHudText('inform', 'You Found A Mouldy Cheese Burger')

  TriggerEvent("inventory:addQty", 13, 1)

 elseif random == 3 then 

  local money = math.random(1,12)

  exports['clrp_notify']:DoHudText('inform', 'You Found $ '..money..' In A Burgershot Bag')

  TriggerServerEvent('jobs:addmoney', money)

 elseif random == 4 then

  exports['clrp_notify']:DoHudText('inform', 'You Found A Stale Garlic Bread')

 elseif random == 5 then

  exports['clrp_notify']:DoHudText('inform', 'You Found A Moldy Kebab')

 elseif random == 6 then 

  exports['clrp_notify']:DoHudText('inform', 'You Found 2 Cans Of Redbull')

  TriggerEvent("inventory:addQty", 26, 2)

 elseif random == 7 then

  exports['clrp_notify']:DoHudText('inform', 'You Found An Umbrella')

  TriggerEvent("inventory:addQty", 12, 1)

 elseif random == 8 then

  exports['clrp_notify']:DoHudText('inform', 'You Found 2 Water Bottles With Slightly Greasy Caps')

  TriggerEvent("inventory:addQty", 14, 2)

 elseif random == 9 then

  if math.random(1,2) == 2 then

    exports['clrp_notify']:DoHudText('inform', 'You Found An Illegal Pistol Casing')

    TriggerEvent("inventory:addQty", 115, 1)

  else

    exports['clrp_notify']:DoHudText('inform', 'You Found Nothing')

  end

 end

 if math.random(1,3) > 2 then 

  exports['clrp_notify']:DoHudText('inform', 'You Found A Plastic Bottle')

  TriggerEvent("inventory:addQty", 81, 1)

 else

  exports['clrp_notify']:DoHudText('inform', 'You Found A Metal Can')

  TriggerEvent("inventory:addQty", 82, 1)

 end

 table.insert(searchedTrash, {id = id, player = PlayerId()})

end



function SearchedTrash(id)

 for _,v in pairs(searchedTrash) do 

  if v.id == id then 

   return true

  end

 end

end

--========================================================================================--
--================================== Progress Bar ========================================--
--========================================================================================--
-- Default Progress Duration = 20, During Trigging Progress Bar, Wait 3750 Then Trigger The Event
local progress_time = 0.20
local progress_bar = false
local progress_bar_duration = 20
local progress_bar_text = ''

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(progress_bar_duration)
  if(progress_time > 0)then
   progress_time = progress_time - 0.002
  end
 end
end)

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(1)
  if progress_bar then 
   DrawRect(0.50, 0.90, 0.20, 0.05, 0, 0, 0, 100)
   drawUI(0.910, 1.375, 1.0, 1.0, 0.55, progress_bar_text, 255, 255, 255, 255, false)
   if progress_time > 0 then
    DrawRect(0.50, 0.90, 0.20-progress_time, 0.05, 75, 156, 237, 225)
   elseif progress_time < 1 and progress_bar then 
    progress_bar = false
   end
  end
 end
end)

-- local inTrain = false
-- local trainstations = {
 -- ['Innocence Blvd | LS'] = {x = -540.505, y = -1278.430, z = 26.901, price = 23, name = 'Innocence Blvd'},
 -- ['Strawberry Ave | LS'] = {x = 278.274, y = -1201.312, z = 38.899, price = 25, name = 'Strawberry Ave'},
 -- ['Alta Street | LS'] = {x = -216.964, y = -1038.245, z = 30.144, price = 23, name = 'Alta Street'},
 -- ['Davis Quartz | Sandy'] = {x = 2620.431, y = 2930.545, z = 40.423, price = 27, name = 'Davis Quartz'},
 -- ['LSIA | LS'] = {x = -1083.957, y = -2709.498, z = -7.410, price = 24, name = 'LSIA'},
 -- ['LSIA 2 | LS'] = {x = -884.825, y = -2313.427, z = -11.733, price = 22, name = 'LSIA 2'},
 -- ['San Vitus Blvd | LS'] = {x = -819.573, y = -134.744, z = 19.950, price = 26, name = 'San Vitus Blvd'},
 -- ['South Boulevard | LS'] = {x = -1356.867, y = -463.774, z = 15.045, price = 24, name = 'South Boulevard'},
 -- ['San Andreas Ave | LS'] = {x = -500.879, y = -668.453, z = 11.809, price = 22, name = 'San Andreas Ave'},
 -- ['Lumber Yard | Paleto'] = {x = -487.521, y = 5260.139, z = 87.011, price = 23, name = 'Lumber Yard'},
-- }

-- Citizen.CreateThread(function()
  -- WarMenu.CreateMenu('trainmenu', 'Train Stations')
 -- while true do
  -- Wait(5)
 -- for k,v in pairs(trainstations) do
  -- if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 30) then
   -- DrawMarker(27, v.x, v.y, v.z-0.99, 0, 0, 0, 0, 0, 0, 1.2,1.2,1.0, 255,100,1, 200, 0, 0, 2, 0, 0, 0, 0)
   -- if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 1.2) and not inTrain then
    -- drawTxt("~b~Press ~g~E~w~ ~b~To View Train Stations")
    -- if IsControlPressed(0, 38) then
     -- WarMenu.OpenMenu('trainmenu')
    -- end
   -- end 
   -- if WarMenu.IsMenuOpened('trainmenu') then
    -- for ind,v in pairs(trainstations) do 
     -- if WarMenu.Button(''..ind, "~g~$"..v.price) then
      -- inTrain = true
      -- ClearPedTasksImmediately(GetPlayerPed(-1))
      -- TriggerServerEvent("train:removemoney", v.price)
      -- ExecuteCommand('me purchases ticket to '..v.name..' station.')
      -- WarMenu.CloseMenu('trainmenu')
      -- FreezeEntityPosition(GetPlayerPed(-1), true)
      -- SwitchOutPlayer(PlayerPedId(), 0, 1)
      -- exports.pNotify:SendNotification({text = "Boarding Your Train"})
      -- Citizen.Wait(4000)
      -- SetEntityCoords(GetPlayerPed(-1), v.x, v.y, v.z+0.75)
      -- Wait(4500)
      -- exports.pNotify:SendNotification({text = "You Have Arrived At Your Destination"})
      -- SwitchInPlayer(PlayerPedId())
      -- Citizen.Wait(4550)
      -- FreezeEntityPosition(GetPlayerPed(-1), false)
      -- inTrain = false
     -- end
    -- end
     -- WarMenu.Display()
    -- end
   -- end
  -- end
 -- end
-- end)

function ProgressBar(text, time)
 progress_bar_text = text
 progress_bar_duration = time
 progress_time = 0.20
 progress_bar = true
end

RegisterNetEvent('hud:progressbar')
AddEventHandler('hud:progressbar', function(text, time)
 ProgressBar(text, time)
end)

function drawUI(x,y ,width,height,scale, text, r,g,b,a, center)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextCentre(center)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

function drawTxt(text)
  SetTextFont(0)
  SetTextProportional(0)
  SetTextScale(0.32, 0.32)
  SetTextColour(0, 255, 255, 255)
  SetTextDropShadow(0, 0, 0, 0, 255)
  SetTextEdge(1, 0, 0, 0, 255)
  SetTextDropShadow()
  SetTextOutline()
  SetTextCentre(1)
  SetTextEntry("STRING")
  AddTextComponentString(text)
  DrawText(0.5, 0.93)
end

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