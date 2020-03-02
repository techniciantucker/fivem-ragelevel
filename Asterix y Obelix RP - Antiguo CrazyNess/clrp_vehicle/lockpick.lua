local hasBeenUnlocked = {}
local vehicleHotwire = false

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(5)

  if not IsPedInAnyVehicle(PlayerPedId(), false) then
   local vehicle = GetVehiclePedIsTryingToEnter(PlayerPedId())
   local plate = GetVehicleNumberPlateText(vehicle)
   if DoesEntityExist(vehicle) and not IsVehiclePreviouslyOwnedByPlayer(vehicle) and not exports['clrp_garage']:HasKey(plate) and not exports['clrp_garage']:hasVehicleKey(plate) then
    local driver = GetPedInVehicleSeat(vehicle, -1)
    if DoesEntityExist(driver) then
     if not IsPedAPlayer(driver) then
      SetPedCanBeDraggedOut(driver, false)
      SetVehicleDoorsLocked(vehicle, 2)
     end
    end
   end


   -- Exiting
   local aiming, targetPed = GetEntityPlayerIsFreeAimingAt(PlayerId(-1))
   if aiming then
    if not IsPedAPlayer(targetPed) and IsPedInAnyVehicle(targetPed, false) and IsPedArmed(PlayerPedId(), 7) then
     local vehicle = GetVehiclePedIsIn(targetPed, false)
     local plate = GetVehicleNumberPlateText(vehicle)
     local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), GetEntityCoords(vehicle, true), false)

     if distance < 15 then

      if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_FLASHLIGHT') then
       return
      end

      hasBeenUnlocked[plate] = false

      while GetEntitySpeed(vehicle) > 10 do
       Citizen.Wait(5)
       SetVehicleForwardSpeed(vehicle, GetEntitySpeed(vehicle)-5)
      end

      TaskLeaveVehicle(targetPed, vehicle, 256)

      while IsPedInAnyVehicle(targetPed, false) do
       Citizen.Wait(5)
      end

      RequestAnimDict('random@mugging3')
      while not HasAnimDictLoaded('random@mugging3') do
       Citizen.Wait(10)
      end

      SetPedFleeAttributes(targetPed, 0, 0)
      TaskPlayAnim(targetPed, "random@mugging3", "handsup_standing_base", 8.0, -8, -1, 12, 1, 0, 0, 0)

      --local progress = exports['clrp_progressBar']:progressBar(10000, 'Claves exigentes')
      --if progress == 100 then
	  local finished = exports["clrp-taskbar"]:taskBar(10000,"Claves exigentes")	  
      if finished == 100 then		  
       hasBeenUnlocked[plate] = true
      -- TriggerEvent('newNotification', 'Te han dado las llaves')
       --TriggerEvent('chatMessage', '^2Te han dado las llaves')	
       TriggerEvent('chatMessage', "", {255, 0, 0}, "^1Te han dado las llaves!")	 
       TriggerServerEvent('garage:addKeys', plate)
       ClearPedTasks(targetPed)
       TaskReactAndFleePed(targetPed, PlayerPedId())
	   TriggerEvent("dispatch:robbery") 
      end
     end
    end
   end
  else
   Citizen.Wait(1000)
  end
 end
end)

-- Citizen.CreateThread(function()
 -- while true do 
  -- Citizen.Wait(5)
  
  -- if not IsPedInAnyVehicle(PlayerPedId(), false) then 
   -- local vehicle = GetVehiclePedIsTryingToEnter(PlayerPedId())
   -- local plate = GetVehicleNumberPlateText(vehicle)
   -- if DoesEntityExist(vehicle) and hasBeenUnlocked[plate] and not IsVehiclePreviouslyOwnedByPlayer(vehicle) and not exports['clrp_garage']:HasKey(plate) and not exports['clrp_garage']:hasVehicleKey(plate) then
    -- while not IsPedInAnyVehicle(PlayerPedId(), false) do 
     -- Citizen.Wait(5)
    -- end

    -- vehicleHotwire = false
    -- SetVehicleUndriveable(vehicle, true)
    -- SetVehicleEngineOn(vehicle, false, false)

    -- while not vehicleHotwire do 
     -- Citizen.Wait(1)
     -- drawTxt('~b~Press ~g~H~b~ To Hotwire Vehicle')
     
     -- if IsControlJustPressed(0, 74) then
      -- if ProgressBar('Hodwtwiring Vehicle', 100) then 
       -- SetVehicleEngineOn(vehicle, true, true)
       -- SetVehicleUndriveable(vehicle, false)
       -- vehicleHotwire = true
      -- end
     -- end

     -- if not IsPedInAnyVehicle(PlayerPedId(), false) then 
      -- break 
     -- end
    -- end
   -- elseif DoesEntityExist(vehicle) and not hasBeenUnlocked[GetVehicleNumberPlateText(vehicle)] and not IsVehiclePreviouslyOwnedByPlayer(vehicle) and not exports['clrp_garage']:HasKey(plate) and not exports['clrp_garage']:hasVehicleKey(plate) then
    -- SetVehicleDoorsLocked(vehicle, 2)
   -- end
  -- else 
   -- Citizen.Wait(1000)
  -- end
 -- end 
-- end)

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(5)

  if not IsPedInAnyVehicle(PlayerPedId(), false) then
   local vehicle = GetVehiclePedIsTryingToEnter(PlayerPedId())
   local plate = GetVehicleNumberPlateText(vehicle)
   if DoesEntityExist(vehicle) and hasBeenUnlocked[plate] and not IsVehiclePreviouslyOwnedByPlayer(vehicle) and not exports['clrp_garage']:HasKey(plate) and not exports['clrp_garage']:hasVehicleKey(plate) then
    while not IsPedInAnyVehicle(PlayerPedId(), false) do
     Citizen.Wait(5)
    end

    vehicleHotwire = false

    while not vehicleHotwire do
     Citizen.Wait(1)

     SetVehicleUndriveable(vehicle, true)
     SetVehicleEngineOn(vehicle, false, false)

     local pos = GetOffsetFromEntityInWorldCoords(vehicle, 0.0, 2.0, 1.0)
     DrawText3Ds(pos["x"], pos["y"], pos["z"], "[Y] Search / [H] Hacer Puente" )

     if IsControlJustPressed(0, 74) then
     -- local progress = exports['clrp_progressBar']:progressBar(15000, 'Hotwiring Vehicle')
      --if progress == 100 then
	  local finished = exports["clrp-taskbar"]:taskBar(15000,"Puente Vehicle")	  
      if finished == 100 then	  
       vehicleHotwire = true
       SetVehicleUndriveable(vehicle, false)
       SetVehicleEngineOn(vehicle, true, true)
      end
     end

     if not IsPedInAnyVehicle(PlayerPedId(), false) then
      break
     end
    end
   elseif DoesEntityExist(vehicle) and not hasBeenUnlocked[plate] and not IsVehiclePreviouslyOwnedByPlayer(vehicle) and not exports['clrp_garage']:HasKey(plate) and not exports['clrp_garage']:hasVehicleKey(plate) then
    SetVehicleDoorsLocked(vehicle, 2)
   end
  else
   Citizen.Wait(1000)
  end
 end
end)

local progress_time = 0.20
local progress_bar = false
local progress_bar_duration = 20
local progress_bar_text = ''

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(progress_bar_duration)
  if(progress_time > 0)then
   progress_time = progress_time - 0.002
  else 
   Citizen.Wait(500)
  end
 end
end)

function ProgressBar(text, time)
 progress_bar_text = text
 progress_bar_duration = time
 progress_time = 0.20
 progress_bar = true
 while progress_bar do
  Citizen.Wait(0)
  DrawRect(0.50, 0.90, 0.20, 0.05, 0, 0, 0, 100)
  drawUI(0.910, 1.375, 1.0, 1.0, 0.55, progress_bar_text, 255, 255, 255, 255, false)
  if progress_time > 0 then
   DrawRect(0.50, 0.90, 0.20-progress_time, 0.05, 75, 156, 237, 225)
  elseif progress_time < 1 and progress_bar then 
   progress_bar = false
   return true
  end
 end
end

function drawUI(x,y ,width,height,scale, text, r,g,b,a, center)
 SetTextFont(4)
 SetTextProportional(0)
 SetTextScale(scale, scale)
 SetTextColour(r, g, b, a)
 SetTextDropShadow(0, 0, 0, 0,255)
 SetTextEdge(2, 0, 0, 0, 255)
 SetTextDropShadow()
 SetTextOutline()
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

RegisterNetEvent('items:lockpick')
AddEventHandler('items:lockpick', function()
 local coords = GetEntityCoords(GetPlayerPed(-1))
 if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
  local vehicle = nil
  if IsPedInAnyVehicle(playerPed, false) then
   vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
  else
   vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
  end

  if DoesEntityExist(vehicle) then
   RequestAnimDict("mini@repair")
   while not HasAnimDictLoaded("mini@repair") do
   	Citizen.Wait(0)
   end

   TaskPlayAnim(PlayerPedId(), "mini@repair", "fixing_a_player", 8.0, -8, -1, 16, 0, 0, 0, 0)

   Citizen.CreateThread(function()
    --local progress = exports['clrp_progressBar']:progressBar(9000, 'Attempting Lockpick')
    --if progress == 100 then
	  local finished = exports["clrp-taskbar"]:taskBar(9000,"Attempting Lockpick")	  
      if finished == 100 then		
     SetVehicleDoorsLocked(vehicle, 1)
     SetVehicleDoorsLockedForAllPlayers(vehicle, false)
     hasBeenUnlocked[GetVehicleNumberPlateText(vehicle)] = true
     ClearPedTasksImmediately(GetPlayerPed(-1))
	 TriggerEvent("dispatch:robbery") 
	 TriggerServerEvent('dispatch:vehicle', suspectLocation, suspectSex, vehicleName, vehiclePlate, vehicleColour)
    end
   end)
  end
 end
end)

AddEventHandler('vehicle:setUnlocked', function(plate)
 hasBeenUnlocked[plate] = true
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
 DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

RegisterNetEvent('items:repair2')
AddEventHandler('items:repair2', function()      
  local ped = GetPlayerPed(-1)
  local coords = GetEntityCoords(ped)
  if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
    local vehicle = nil
    if IsPedInAnyVehicle(ped, false) then
      vehicle = GetVehiclePedIsIn(ped, false)
    else
      vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
    end
    if DoesEntityExist(vehicle) then
        toggleHood1()	
        RequestAnimDict("mini@repair")
        while not HasAnimDictLoaded("mini@repair") do
        	Citizen.Wait(100)
		end	
		TriggerEvent("mythic_progbar:client:progress", {
			name = "Lockpicking",
			duration = 15000,
			label = "Lockpicking [stage 1]",
			useWhileDead = false,
			canCancel = true,
			controlDisables = {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			},
			animation = {
				animDict = "mini@repair",
				anim = "fixing_a_player",
			}
		}, function(status)
			if not status then
				
				StopAnimTask(PlayerPedId(), 'mini@repair', 'fixing_a_player', 1.0)
			end
		end)	
      Citizen.CreateThread(function()
          Citizen.Wait(10000)
		  ClearPedTasks(GetPlayerPed(-1))
          SetVehicleUndriveable(vehicle,false)
          SetVehicleFixed(vehicle)
          SetVehicleEngineOn(vehicle, true, false)
		            Citizen.Wait(10000)
          --toggleHood1()		  
      end)
    end
  end
end)

RegisterNetEvent('veh:repairing')
AddEventHandler('veh:repairing', function()
    playerped = GetPlayerPed(-1)
    coordA = GetEntityCoords(playerped, 1)
    coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 100.0, 0.0)
    targetVehicle = getVehicleInDirection(coordA, coordB)

    if targetVehicle ~= 0 then

        local d1,d2 = GetModelDimensions(GetEntityModel(targetVehicle))
        local moveto = GetOffsetFromEntityInWorldCoords(targetVehicle, 0.0,d2["y"]+0.5,0.0)
        local dist = GetDistanceBetweenCoords(moveto["x"],moveto["y"],moveto["z"], GetEntityCoords(GetPlayerPed(-1)))
        local count = 1000

        while dist > 1.0 and count > 0 do
            dist = GetDistanceBetweenCoords(moveto["x"],moveto["y"],moveto["z"], GetEntityCoords(GetPlayerPed(-1)))
            Citizen.Wait(1)
            count = count - 1
            DrawText3Ds(moveto["x"],moveto["y"],moveto["z"],"Move here to repair.")
        end

        if dist < 1.0 then
            TriggerEvent("moveRepair",targetVehicle)
            fixingvehicle = true
            local repairlength = ((3500 - (GetVehicleEngineHealth(targetVehicle) * 3) - (GetVehicleBodyHealth(targetVehicle)) / 2) * 10) + 2000
            if repairlength < 1000 then
                repairlength = 1000
            end
            local finished = exports["np-taskbar"]:taskBar(repairlength,"Repairing")
            if finished == 100 then
                --TriggerEvent('veh.randomDegredation',30,targetVehicle,3)
                -- if math.random(100) > 95 then
                    -- TriggerServerEvent("inv:ModifyItem",20,"remove",1,inventoryName,slot)
                -- end

                if GetVehicleEngineHealth(targetVehicle) < 200.0 then
                    SetVehicleEngineHealth(targetVehicle, 200.0)
                end
                if GetVehicleBodyHealth(targetVehicle) < 945.0 then
                    SetVehicleBodyHealth(targetVehicle, 945.0)
                end

                if GetEntityModel(targetVehicle) == GetHashKey("BLAZER") then
                    SetVehicleEngineHealth(targetVehicle, 600.0)
                    SetVehicleBodyHealth(targetVehicle, 800.0)
                end

                for i = 0, 5 do
                    if IsVehicleTyreBurst(targetVehicle, i) then
                        SetVehicleTyreFixed(targetVehicle, i) 
                    end
                end
            end
            ClearPedTasks(playerped)
        end
        fixingvehicle = false
    end
end)

function getVehicleInDirection(coordFrom, coordTo)
    local offset = 0
    local rayHandle
    local vehicle

    for i = 0, 100 do
        rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset, 10, GetPlayerPed(-1), 0)   
        a, b, c, d, vehicle = GetRaycastResult(rayHandle)
        
        offset = offset - 1

        if vehicle ~= 0 then break end
    end
    
    local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))
    
    if distance > 25 then vehicle = nil end

    return vehicle ~= nil and vehicle or 0
end

RegisterNetEvent('moveRepair')
AddEventHandler('moveRepair', function(veh)

    SetVehicleDoorOpen(veh, 4, 0, 0)
    RequestAnimDict("mini@repair")
    while not HasAnimDictLoaded("mini@repair") do
        Citizen.Wait(0)
    end

    TaskTurnPedToFaceEntity(GetPlayerPed(-1), veh, 1.0)
    Citizen.Wait(1000)

    while fixingvehicle do
        local anim3 = IsEntityPlayingAnim(GetPlayerPed(-1), "mini@repair", "fixing_a_player", 3)
        if not anim3 then
           TaskPlayAnim(GetPlayerPed(-1), "mini@repair", "fixing_a_player", 8.0, -8, -1, 16, 0, 0, 0, 0)
        end
        Citizen.Wait(1)
    end   
    SetVehicleDoorShut(veh, 4, 1, 1) 
end)

function toggleHood1()
 local playerVeh = GetVehiclePedIsIn(GetPlayerPed(-1), true)
 if GetVehicleDoorAngleRatio(playerVeh, 4) > 0.0 then 
  SetVehicleDoorShut(playerVeh, 4, false)            
 else
  SetVehicleDoorOpen(playerVeh, 4, false)      
 end
end 	