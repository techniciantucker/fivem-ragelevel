local needspayment = false
local trailer = 0
local isInService = false
local harvesting = false
local trees = {}
local hatchetarmed = false
local treeBlips = {}

Citizen.CreateThread(function()
 WarMenu.CreateMenu('lumberjack_boss', 'Lumberjack')
 while true do
  Citizen.Wait(1)
  if DecorGetInt(GetPlayerPed(-1), "Job") == 7 then
   -- Lumberjack | Get Hatchet
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -552.879, 5348.669, 73.843, true) < 50) then
    DrawMarker(25, -552.879, 5348.669, 73.743, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 100, 252, 255, 200, 0, 0, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -552.879, 5348.669, 73.843, true) < 1.5) then
     drawTxt('~b~Press ~g~E~b~ To Speak To Your Boss')
     if IsControlJustPressed(0, 38) then
      WarMenu.OpenMenu('lumberjack_boss')
     end
    end
   end
  -- End
   -- Lumberjack | Load Logs Onto The Trailer For Delivery
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -599.592, 5354.819, 69.499, true) < 50) then
    DrawMarker(25, -599.592, 5354.819, 69.499, 0, 0, 0, 0, 0, 0, 1.2, 1.2, 1.2, 50, 102, 255, 200, 0, 0, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -599.592, 5354.819, 69.499, true) < 1.4) then
     drawTxt('~b~Press ~g~E~b~ To Load Logs')
     if IsControlJustPressed(0, 38) then
      TriggerServerEvent('lumberjack:load')
     end
    end
   end
   -- Lumberjack | Delivery Of Logs
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 1206.432, -1265.043, 35.226, true) < 40) and IsPedInAnyVehicle(GetPlayerPed(-1)) then
     drawTxt('~b~Park The Trailer & Press ~g~E~b~ To Drop It Off')
     if IsControlJustPressed(0, 38) then
      LogsDelivered()
     end
   end
   -- Lumberjack | Trucking Drop Off
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -573.238, 5373.555, 70.232, true) < 40) and IsPedInAnyVehicle(GetPlayerPed(-1)) then
    DrawMarker(1, -573.238, 5373.555, 69.132, 0, 0, 0, 0, 0, 0, 3.0, 3.0, 3.0, 50, 102, 255, 200, 0, 0, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -573.238, 5373.555, 70.232, true) < 3.2) then
     drawTxt('~b~Press ~g~E~b~ To Return Truck')
     if IsControlJustPressed(0, 38) then
     PaymentNeeded() 
     end
    end
   end
  end
  -- Boss Menu
  if WarMenu.IsMenuOpened('lumberjack_boss') then
   if WarMenu.Button('Go On Duty') then
    isInService = true
    TriggerServerEvent('lumberjack:gettrees')
    Notify("You Are Now On Duty As A Lumberjack")
   elseif WarMenu.Button('Go Off Duty') then
    Notify("You Are Now Off Duty")
    isInService = false 
    for _,v in pairs(treeBlips) do
      RemoveBlip(v)
    end
    RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey('WEAPON_HATCHET'))
   elseif WarMenu.Button('Rent A Hatchet') then
    hatchetarmed = true
	TriggerEvent("inventory:addQty", 203, 1)
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey('WEAPON_HATCHET'), 5000, false, true)
    Notify("Remember To Return The Hatchet Before Going Home")
   elseif WarMenu.Button('Give Back Hatchet') then
    hatchetarmed = true
    RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey('WEAPON_HATCHET'))
    Notify("Thanks For Returning The Hatchet")
   end
   WarMenu.Display()
  end

  if isInService then 
   local pos = GetEntityCoords(GetPlayerPed(-1))
   if (not harvesting) then
    for i,v in ipairs(trees) do
     local dist = Vdist(pos.x, pos.y, pos.z, v.pos.x, v.pos.y, v.pos.z)
     if (dist < 1.2) then
      if (hatchetarmed) then
       drawTreeCutText("~w~Press ~b~E~w~ to harvest this tree.")
       if (IsControlJustReleased(1, 38) or IsDisabledControlJustReleased(1, 38)) then
        SetEntityInvincible(GetPlayerPed(-1), true)
        TaskPlayAnim(GetPlayerPed(-1), "melee@hatchet@streamed_core", "plyr_rear_takedown_b", 4.0, -8, 0.01, 0, 0, 0, 0, 0)
        Wait(5000)
        TaskPlayAnim(GetPlayerPed(-1), "melee@hatchet@streamed_core", "plyr_rear_takedown_b", 4.0, -8, 0.01, 0, 0, 0, 0, 0)
        Wait(5000)
        TaskPlayAnim(GetPlayerPed(-1), "melee@hatchet@streamed_core", "plyr_rear_takedown_b", 4.0, -8, 0.01, 0, 0, 0, 0, 0)
        Wait(5000)
        TaskPlayAnim(GetPlayerPed(-1), "melee@hatchet@streamed_core", "plyr_rear_takedown_b", 4.0, -8, 0.01, 0, 0, 0, 0, 0)
        Wait(5000)
        TaskPlayAnim(GetPlayerPed(-1), "melee@hatchet@streamed_core", "plyr_rear_takedown_b", 4.0, -8, 0.01, 0, 0, 0, 0, 0)
        Wait(5000)
        TaskPlayAnim(GetPlayerPed(-1), "melee@hatchet@streamed_core", "plyr_rear_takedown_b", 4.0, -8, 0.01, 0, 0, 0, 0, 0)
        Wait(5000)
        SetEntityInvincible(GetPlayerPed(-1), false)
        TriggerServerEvent('lumberjack:harvest', i)
       end
      else
       drawTreeCutText("You must have a hatchet")
       harvesting = false
      end
     end
    end
   end
  end
 end
end)

RegisterNetEvent('lumberjack:loadlogs')
AddEventHandler('lumberjack:loadlogs', function()
  local ped = GetPlayerPed(-1)
  vehiclehash = GetHashKey('phantom')
  RequestModel(vehiclehash)
  Citizen.CreateThread(function() 
   while not HasModelLoaded(vehiclehash) do  
    Citizen.Wait(0)  
   end
   local spawned = CreateVehicle(vehiclehash, -578.318, 5268.565, 70.464, 115, true, false)
   TaskWarpPedIntoVehicle(GetPlayerPed(-1), spawned, -1)
   SetVehicleEngineOn(spawned, true, true)
   SetVehicleIsConsideredByPlayer(spawned, true)
   SetVehicleNumberPlateText(spawned, 'JOB')
   DecorSetInt(spawned, "_Fuel_Level", 75000)
  end)

  -- Trailer
  vehiclehash2 = GetHashKey('trailerlogs')
  RequestModel(vehiclehash2)
  Citizen.CreateThread(function() 
   while not HasModelLoaded(vehiclehash2) do  
    Citizen.Wait(0)  
   end
   trailer = CreateVehicle(vehiclehash2, -584.099, 5244.945, 70.469, 115, true, false)
   SetVehicleOnGroundProperly(trailer)
  end)
  Notify("Hook The Truck To The Logging Trailer Then Drive It To The Delivery Point") 
  SetJobBlip(1203.024, -1299.885, 35.224)
end)

function LogsDelivered()
 local ped = GetPlayerPed(-1)
 if IsVehicleAttachedToTrailer(GetVehiclePedIsIn(ped)) then
  DetachVehicleFromTrailer(GetVehiclePedIsIn(ped, false))
  SetJobBlip(-573.238, 5373.555, 69.132)
  Notify("The Trailer Has Been Delivered, Return The Truck To Get Payed")
  needspayment = true
  DeleteVehicle(trailer)
 else
  Notify("You Have No Trailer")
 end
end

function PaymentNeeded()
	local ped = GetPlayerPed(-1)
	if IsPedInAnyVehicle(ped) and IsVehicleModel(GetVehiclePedIsIn(ped, false), GetHashKey("phantom")) and needspayment then
		local lumberPay = math.random(7500,10000)
		TriggerServerEvent('jobs:addmoney', lumberPay)
		DeleteVehicle(GetVehiclePedIsIn(ped, false))
		needspayment = false
        RemoveJobBlip()
	else
		Notify("You Have To Complete The Job First")
	end
end

RegisterNetEvent('lumberjack:trees')
AddEventHandler('lumberjack:trees', function(tree)
 for _,v in pairs(treeBlips) do
  RemoveBlip(v)
 end

 treeBlips = {}
 trees = {}
 trees = tree
 Wait(500)
 updateTreeBlips()
end)

function updateTreeBlips()
  for _,v in pairs(trees) do
    local blip = AddBlipForCoord(v.pos.x, v.pos.y, v.pos.z)
    
    SetBlipSprite(blip, 467)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.5)
    SetBlipColour(blip, 38)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Harvestable Tree")
    EndTextCommandSetBlipName(blip)

    table.insert(treeBlips, blip)
  end
end
function drawTreeCutText(text)
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
  DrawText(0.475, 0.88)
end


