isInService = false
IsDead = false
mission_list = {}

-- Menus
Citizen.CreateThread(function()
 WarMenu.CreateLongMenu('ems_toolkit', 'Paramedic')
 WarMenu.CreateSubMenu('ems_garage', 'ems_toolkit', 'ems_garage')
 WarMenu.CreateSubMenu('ems_missions', 'ems_toolkit', 'ems_missions')
 local currentvehicle = 1
 local selectedvehicle = 1
 local currentmechanic = 1
 local selectedmechanic = 1
 while true do
  Wait(5)
  if DecorGetBool(GetPlayerPed(-1), "isParamedic") then
   if isInService then if not IsPedInAnyVehicle(GetPlayerPed(-1)) then drawUI(0.514, 1.375, 1.0, 1.0, 0.45, MissionInformation, 89, 194, 255, 255, false) else drawUI(0.514, 1.275, 1.0, 1.0, 0.45, MissionInformation, 89, 194, 255, 255, false) end end
   -- Main Menu
   if WarMenu.IsMenuOpened('ems_toolkit') then
    if WarMenu.Button('Revive') then
     local t, distance = GetClosestPlayer()
     if(distance ~= -1 and distance < 5) then
      TaskStartScenarioInPlace(GetPlayerPed(-1), 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
	  local finished = exports["clrp-taskbar"]:taskBar(5000,"Reviving")	  
      if finished == 100 then	  
     -- if exports['clrp-taskbar']:progressBar(5000, 'Reviving') == 100 then
       ClearPedTasks(GetPlayerPed(-1))
       TriggerServerEvent('ems:revive', GetPlayerServerId(t))
      end
     else
      TriggerEvent("pNotify:SendNotification", {text = "No Player Near"})
     end
    elseif WarMenu.Button('Examine') then
     local t, distance = GetClosestPlayer()
     if(distance ~= -1 and distance < 5) then
      TaskStartScenarioInPlace(GetPlayerPed(-1), 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
	  local finished = exports["clrp-taskbar"]:taskBar(5000,"Examining")	  
      if finished == 100 then		  
      --if exports['clrp-taskbar']:progressBar(5000, 'Examining') == 100 then
       ClearPedTasks(GetPlayerPed(-1))
       TriggerServerEvent('medical:showMedical', GetPlayerServerId(t))
      end
     else
      TriggerEvent("pNotify:SendNotification", {text = "No Player Near"})
     end
    elseif WarMenu.Button('Escort') then
     local t, distance = GetClosestPlayer()
     if(distance ~= -1 and distance < 3) then
      TriggerServerEvent('police:drag', GetPlayerServerId(t))
     else
      TriggerEvent("pNotify:SendNotification", {text = "No Player Near"})
     end
    elseif WarMenu.Button('Medbag') then
     Medbag()
    elseif WarMenu.Button('Panic') then
     local pos = GetEntityCoords(GetPlayerPed(-1))
     TriggerServerEvent('ems:panic', pos.x, pos.y, pos.z)
    elseif WarMenu.ComboBox('Vehicle', {"Put In", "Take Out"}, currentvehicle, selectedvehicle, function(vehicle)
     currentvehicle = vehicle selectedvehicle = vehicle
    end) then
     local t, distance = GetClosestPlayer()
     if(distance ~= -1 and distance < 5) then
      if selectedvehicle == 2 then
       TriggerServerEvent('police:vehicleout', GetPlayerServerId(t))
      elseif selectedvehicle == 1 then
       TriggerServerEvent('police:vehiclein', GetPlayerServerId(t))
      end
     else
      TriggerEvent("pNotify:SendNotification", {text = "No Player Near"})
     end
    elseif WarMenu.ComboBox('Mechanic', {"Repair", "Tow", "Unlock", "Clean"}, currentmechanic, selectedmechanic, function(mechanic)
     currentmechanic = mechanic
     selectedmechanic = mechanic
    end) then
    if selectedmechanic == 1 then
     local coords = GetEntityCoords(GetPlayerPed(-1))
     if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
      local vehicle = nil
      if IsPedInAnyVehicle(GetPlayerPed(-1), false) then vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false) else vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71) end
      if DoesEntityExist(vehicle) then
       TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_BUM_BIN", 0, true)
	  local finished = exports["clrp-taskbar"]:taskBar(5500,"Repairing")	  
      if finished == 100 then		   
       --if exports['clrp-taskbar']:progressBar(5500, 'Repairing') == 100 then
        ClearPedTasks(GetPlayerPed(-1))
        TriggerEvent('vehice:repair', false, vehicle)
       end
      end
     end
    elseif selectedmechanic == 2 then
     if IsPedInAnyVehicle(GetPlayerPed(-1)) then
      local veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
      SetEntityAsMissionEntity(veh,  false,  true)
	  local finished = exports["clrp-taskbar"]:taskBar(20000,"Waiting for Tow")	  
      if finished == 100 then		  
     -- if exports['clrp-taskbar']:progressBar(20000, 'Waiting for Tow') == 100 then
       DeleteVehicle(veh)
      end
      TriggerEvent("pNotify:SendNotification", {text = "Vehicle Has Been Towed...."})
     else
      local coords = GetEntityCoords(GetPlayerPed(-1))
      local veh = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
      SetEntityAsMissionEntity(veh,  false,  true)
	  local finished = exports["clrp-taskbar"]:taskBar(20000,"Waiting for Tow")	  
      if finished == 100 then		  
      --if exports['clrp-taskbar']:progressBar(20000, 'Waiting for Tow') == 100 then
       DeleteVehicle(veh)
      end
      TriggerEvent("pNotify:SendNotification", {text = "Vehicle Has Been Towed...."})
     end
    elseif selectedmechanic == 3 then
     local coords    = GetEntityCoords(GetPlayerPed(-1))
     if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
      local vehicle = nil
      if IsPedInAnyVehicle(playerPed, false) then vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false) else vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71) end
      if DoesEntityExist(vehicle) then
       TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_WELDING", 0, true)
       Citizen.CreateThread(function()
        Citizen.Wait(10000)
        SetVehicleDoorsLocked(vehicle, 1)
        SetVehicleDoorsLockedForAllPlayers(vehicle, false)
        ClearPedTasksImmediately(GetPlayerPed(-1))
        TriggerEvent("pNotify:SendNotification", {text = "Vehicle Unlocked"})
       end)
      end
     end
    elseif selectedmechanic == 4 then
     local coords    = GetEntityCoords(GetPlayerPed(-1))
     if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
      local vehicle = nil
      if IsPedInAnyVehicle(GetPlayerPed(-1), false) then vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false) else vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71) end
      if DoesEntityExist(vehicle) then
       TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_MAID_CLEAN", 0, true)
       Citizen.CreateThread(function()
        Citizen.Wait(8000)
        SetVehicleDirtLevel(vehicle, 0)
        ClearPedTasksImmediately(GetPlayerPed(-1))
        TriggerEvent("pNotify:SendNotification", {text = "Vehicle Cleaned"})
       end)
      end
     end
    end
    elseif WarMenu.Button('Revive NPC') then
     TriggerEvent('npc:revive')
    elseif WarMenu.MenuButton('Missions', 'ems_missions') then
    end
    WarMenu.Display()
   -- Garage Menu
   elseif WarMenu.IsMenuOpened('ems_garage') then
    for _,v in pairs(vehicles) do
     if WarMenu.Button(v.name, v.rank) then
	  local finished = exports["clrp-taskbar"]:taskBar(10000,"Fetching Vehicle")	  
      if finished == 100 then	 
      --if exports['clrp-taskbar']:progressBar(10000, 'Fetching Vehicle') == 100 then
       SpawnVehicle(v.vehicle)
      end
      WarMenu.CloseMenu()
     end
    end
    WarMenu.Display()
   -- Mission Menu
   elseif WarMenu.IsMenuOpened('ems_missions') then
    for i,v in pairs(mission_list) do
     if v.name ~= "Finish Mission" then
      if WarMenu.Button(v.name, v.callerID) then
       v.f(v.mission)
       TriggerEvent("pNotify:SendNotification", {text = "Call Information: "..v.info})
      end
     else
      if WarMenu.Button(v.name) then
       v.f()
      end
     end
    end
    WarMenu.Display()
   end
  end
 end
end)

-- Blips And Locations
Citizen.CreateThread(function()
 while true do
  Wait(5)
  -- Duty Blip
  if DecorGetBool(GetPlayerPed(-1), "isParamedic") then
   for k,v in pairs(duty) do
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 50) then
     DrawMarker(27, v.x, v.y, v.z, 0, 0, 0, 0, 0, 0, 1.2,1.2,0.5, 0, 82, 165, 240, 0, 0, 2, 0, 0, 0, 0)
     if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 2.2) then
      if isInService then
       drawTxt('~b~Pulse ~g~E~b~ Ir fuera de servicio')
       if IsControlJustPressed(0, 38) then
        OffDuty()
        isInService = false
       end
      else
       drawTxt('~b~Pulse ~g~E~b~ Para ir de servicio')
       if IsControlJustPressed(0, 38) then
        OnDuty()
        isInService = true
       end
      end
     end
    end
   end

   if isInService then
    for k,v in pairs(garage) do
     if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 50) then
      DrawMarker(27, v.x, v.y, v.z, 0, 0, 0, 0, 0, 0, 1.5,1.5,0.5, 0, 82, 165, 240, 0, 0, 2, 0, 0, 0, 0)
      if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 4.0) then
       drawTxt('~b~Pulse ~g~E~b~ Para acceder al garaje')
       if IsControlJustPressed(0, 38) then
        if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
         local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1))
         SetEntityAsMissionEntity(vehicle, true, true)
         Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle))
        else
         currentgarage = {x=v.x, y=v.y, z=v.z}
         WarMenu.OpenMenu('ems_garage')
        end
       end
      end
     end
    end
    if isInService and IsControlJustPressed(0, 167) or isInService and IsDisabledControlJustReleased(0, 167) then 
     WarMenu.OpenMenu('ems_toolkit') 
    end
   end
  end
 end
end)

-- String string
function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end

local timer = 4 * 60 * 1000
local respawnPrice = 250

function Respawn()
  Citizen.Wait(250)
  Citizen.CreateThread(function()
    local shortestDistance = 100000
    local closestHospital = {}
    for _,v in pairs(hospitals) do
      local currentDistance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true)
      if currentDistance < shortestDistance then
        shortestDistance = currentDistance
        closestHospital["x"] = v.x
        closestHospital["y"] = v.y
        closestHospital["z"] = v.z
      end
    end

    NetworkResurrectLocalPlayer(closestHospital["x"], closestHospital["y"], closestHospital["z"], true, true, false)
    ClearPedBloodDamage(GetPlayerPed(-1))
    ResetPedMovementClipset(GetPlayerPed(-1), true)
    SetPlayerInvincible(GetPlayerPed(-1), false)
    TriggerServerEvent('ems:respawn', respawnPrice)
  end)
end

Citizen.CreateThread(function()
  while true do
    Wait(5)
    if IsEntityDead(GetPlayerPed(-1)) then
      while timer > 0 and IsEntityDead(GetPlayerPed(-1)) do
        raw_seconds = timer/1000
        raw_minutes = raw_seconds/60
        minutes = stringsplit(raw_minutes, ".")[1]
        seconds = stringsplit(raw_seconds-(minutes*60), ".")[1]
        drawTxt("~b~Use su teléfono para llamar por atención médica o espere " .. minutes .. " Minutos " .. seconds .. " Segundos para reaparecer")
        timer = timer - 15
        Citizen.Wait(5)
      end

      while timer <= 0 and IsEntityDead(GetPlayerPed(-1)) do
        drawTxt("~b~Pulse ~y~E ~b~Para reaparecer [~g~$"..respawnPrice..'~b~]')
        Citizen.Wait(0)
        if IsControlJustReleased(0, 38) then
          Respawn()
        end
      end
    end
  end
end)

RegisterNetEvent('hud:updatepresence')
AddEventHandler('hud:updatepresence', function(cops, ems, mech)
 if not IsEntityDead(GetPlayerPed(-1)) then
  if ems == 0 and cops == 0 then
   timer = 4 * 60 * 1000
   respawnPrice = 100
  elseif ems == 0 and cops > 0 then 
   timer = 8 * 60 * 1000
   respawnPrice = 100
  elseif ems > 0 and cops > 0 then 
   timer = 10 * 60 * 1000
   respawnPrice = 150
  end
 end 
end)

----------------------------------------------------------------------------------------------------------
---------------------------- New Mission System ----------------------------------------------------------
----------------------------------------------------------------------------------------------------------

currentMissionBlip = nil 
availableMissions = {}
currentMissions = nil
MissionInformation = '~g~NO HAY LLAMADAS'
MedicCallStatus = 0
activeMedics = 0
availableMedics = 0


RegisterNetEvent("paramedic:notifyallMedics")
AddEventHandler("paramedic:notifyallMedics",function(message)
 if isInService then
  PlaySoundFrontend(-1, "HACKING_SUCCESS", 0, 1);
  exports.pNotify:SendNotification({text = "Dispatch: "..message, timeout = 20000})
  Wait(750)
  PlaySoundFrontend(-1, "HACKING_SUCCESS", 0, 1);
 end
end)

RegisterNetEvent("paramedic:notifyClient")
AddEventHandler("paramedic:notifyClient",function(message)
    exports.pNotify:SendNotification({text = "Emergency: "..message})
end)

function acceptMissionEmergency(data) 
    TriggerServerEvent('paramedic:acceptMission', data.id)
end

function finishCurrentMissionEmergency()
    if currentMissions ~= nil then
        TriggerServerEvent('paramedic:finishMission', currentMissions.id)
    end
    currentMissions = nil
    if currentMissionBlip ~= nil then
        RemoveBlip(currentMissionBlip)
    end
    WarMenu.OpenMenu('ems_missions')
end

function updateMissionMenu() 
    local cmissions = {}
    for _,m in pairs(availableMissions) do 
        local data = {
            name = m.name,
            callerID = m.id,
            info = m.type,
            mission = m,
            f = acceptMissionEmergency
        }
        if #m.acceptBy ~= 0 then
            data.name = data.name .. ' (' .. #m.acceptBy ..' Unit/s)'
        end
        table.insert(cmissions, data)
    end

    if currentMissions ~= nil then
        table.insert(cmissions, {name = 'Finish Mission', f = finishCurrentMissionEmergency})
    end
    mission_list = cmissions
    if curMenu ~= nil then
        if curMenu == "missions_menu" then
            WarMenu.OpenMenu('ems_missions')
        end
    end
end

function callAmbulance(reason)
    local pos = GetEntityCoords(GetPlayerPed(-1))
    TriggerServerEvent('paramedic:Call', pos.x, pos.y, pos.z, reason)
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

RegisterNetEvent('paramedic:acceptMission')
AddEventHandler('paramedic:acceptMission',function(mission)
    currentMissions = mission
    SetNewWaypoint(mission.pos[1], mission.pos[2])
    currentMissionBlip = AddBlipForCoord(mission.pos[1], mission.pos[2], mission.pos[3])
    SetBlipSprite(currentMissionBlip, 58)
    SetBlipColour(currentMissionBlip, 5)
    SetBlipAsShortRange(currentMissionBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Mission in progress')
    EndTextCommandSetBlipName(currentMissionBlip)
    SetBlipAsMissionCreatorBlip(currentMissionBlip, true)
end)

RegisterNetEvent('paramedic:cancelMission')
AddEventHandler('paramedic:cancelMission', function ()
    currentMissions = nil
    if currentMissionBlip ~= nil then
        RemoveBlip(currentMissionBlip)
    end
    if curMenu ~= nil then
        if curMenu == "missions_menu" then
            MissionMenu()
        end
    end
end)

RegisterNetEvent('paramedic:changeMission')
AddEventHandler('paramedic:changeMission', function (missions)
    if not isInService then
        return
    end 
    
    availableMissions = missions
    local MissionsOnHold = 0
    for _,m in pairs(availableMissions) do
        if #m.acceptBy == 0 then
            MissionsOnHold = MissionsOnHold + 1
        end
    end
    if MissionsOnHold == 0 then 
        MissionInformation = '~g~NO HAY LLAMADAS'
    else
        MissionInformation = '~w~'..MissionsOnHold..' ~b~LLAMADAS/S EN ESPERA'
    end  
    updateMissionMenu()
end)

RegisterNetEvent('paramedic:callAmbulanceCustom')
AddEventHandler('paramedic:callAmbulanceCustom',function()
    local reason = openTextInput()
    if reason ~= nil and reason ~= '' then
        callAmbulance(reason)
    end
end)

RegisterNetEvent('paramedic:callStatus')
AddEventHandler('paramedic:callStatus',function(status)
    MedicCallStatus = status
end)

RegisterNetEvent('paramedic:updateactiveMedics')
AddEventHandler('paramedic:updateactiveMedics',function(activeCount, availableCount)
    activeMedics = activeCount
    availableMedics = availableCount
end)

RegisterNetEvent('paramedic:cancelCall')
AddEventHandler('paramedic:cancelCall',function(data)
    TriggerServerEvent('paramedic:cancelCall')
end)

TriggerServerEvent('paramedic:getactiveMedics') 

function openTextInput()
    DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 200)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        return GetOnscreenKeyboardResult()
    end
    return nil
end

function dht(message)
    Citizen.CreateThread(function()
        Wait(10)
        SetNotificationTextEntry("STRING")
        AddTextComponentString(message)
        DrawNotification(false, false)
    end)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if DecorGetBool(GetPlayerPed(-1), "isParamedic") then
            if(isInService) then
                if currentMissions ~= nil then
                    if currentMissionBlip ~= nil then
                        RemoveBlip(currentMissionBlip)
                    end
                    local patient = GetPlayerPed(GetPlayerFromServerId(currentMissions.id))
                    local pos = {x=currentMissions.pos[1],y=currentMissions.pos[2],z=currentMissions.pos[3]}

                    if patient ~= nil and patient ~= 0 and patient ~= GetPlayerPed(-1) then
                        pos = GetEntityCoords(patient)
                    end

                    local distance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), pos.x, pos.y, pos.z, false)

                    if distance < 500.0 then
                     DrawMarker(1, pos.x, pos.y, pos.z-5, 0, 0, 0, 0, 0, 0, 2.5, 2.5, 255.0, 0, 155, 255, 64, 0, 0, 0, 0)
                    end
                    if distance < 4.0 then
                      drawTxt('~b~Pulse ~g~E ~b~Revivir jugador')
                      if IsControlJustPressed(1, 38) then
                          TaskStartScenarioInPlace(GetPlayerPed(-1), 'CODE_HUMAN_MEDIC_KNEEL', 0, true)
                          Citizen.Wait(15000)
                          ClearPedTasksImmediately(GetPlayerPed(-1))
                          TriggerServerEvent("ems:revive", currentMissions.id)
                          finishCurrentMissionEmergency()
                      else
                       if distance < 2.0 then finishCurrentMissionEmergency() end
                        end
                    end
                else
                    if currentMissionBlip ~= nil then
                        RemoveBlip(currentMissionBlip)
                    end
                end
            end
        end
    end
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

RegisterNetEvent('ems:panic')
AddEventHandler('ems:panic', function(x,y,z)
 if DecorGetBool(GetPlayerPed(-1), "isOfficer") then
  TriggerEvent("pNotify:SendNotification", {text= "EMT En Angustia. Código de respuesta de todas las unidades disponibles 3."})
  local transG = 250
  local location = AddBlipForCoord(x,y,z)
  SetBlipSprite(location,  161)
  SetBlipScale(location , 1.4)
  SetBlipColour(location,  75)
  SetBlipAlpha(location,  transG)
  SetBlipAsShortRange(location,  1)
  PulseBlip(location)
  PlaySoundFrontend(-1, "HACKING_FAILURE", 0, 1);
  Wait(1000)
  PlaySoundFrontend(-1, "HACKING_FAILURE", 0, 1);
  Wait(1000)
  PlaySoundFrontend(-1, "HACKING_FAILURE", 0, 1);
  Wait(1000)
  PlaySoundFrontend(-1, "HACKING_FAILURE", 0, 1);
  Wait(1000)
  PlaySoundFrontend(-1, "HACKING_FAILURE", 0, 1);
  Wait(1000)
  PlaySoundFrontend(-1, "HACKING_FAILURE", 0, 1);
  Wait(1000)
  PlaySoundFrontend(-1, "HACKING_FAILURE", 0, 1);
  Wait(1000)
  PlaySoundFrontend(-1, "HACKING_FAILURE", 0, 1);
  Wait(1000)
  PlaySoundFrontend(-1, "HACKING_FAILURE", 0, 1);
  while transG ~= 0 do
    Wait(240 * 4)
    transG = transG - 1
    SetBlipAlpha(location,  transG)
    if transG == 0 then
      SetBlipSprite(location,  2)
      return
    end
  end
 end
end)

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
  Citizen.Wait(0)
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

-----------------------------------------------------------------------------------
--                                  v2 Updates                                   --
-----------------------------------------------------------------------------------

local medbag = nil

function Medbag()
 if not IsPedInAnyVehicle(PlayerPedId(), false) then
  TaskPlayAnim(PlayerPedId(), 'anim@mp_snowball', 'pickup_snowball', 8.0, -1, -1, 0, 1, 0, 0, 0)
  Wait(1500)
  ClearPedTasksImmediately(GetPlayerPed(-1))
  if medbag == nil then
   RequestModel(-502202673)
   while not HasModelLoaded(-502202673) do
    Citizen.Wait(0)
   end

   offset = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.75, 0.0)
   z, worldZ = GetGroundZFor_3dCoord(offset.x, offset.y, offset.z)
   medbag = CreateObject(-502202673, offset.x, offset.y, worldZ+0.1, 1, 1, 1)

   local netid = NetworkGetNetworkIdFromEntity(medbag)
   SetNetworkIdExistsOnAllMachines(netid, true)
   SetNetworkIdCanMigrate(netid, false)
   SetEntityHeading(medbag, GetEntityHeading(GetPlayerPed(PlayerId())))
   PlaceObjectOnGroundProperly(medbag)
   ExecuteCommand('me places down Medical Bag')
  else
   DeleteObject(medbag)
   medbag = nil
   ExecuteCommand('me picks up Medical Bag')
  end
 end
end

local nearObject = false
local isNearObject = false
local objectLoc = {}
local clostestProp = nil
local models = {
  [1] = -502202673,
}

local emsbag = {
 [1] = {name = 'Bandage', price = 0, amount = 3, id = 10},
 [2] = {name = 'Medkit', price = 0, amount = 3, id = 9},
 [3] = {name = 'Blood Bag', price = 0, amount = 3, id = 258},
 [4] = {name = 'Condom', id = 60, amount = 3, price = 0},
 [5] = {name = 'Paracetamol', id = 43, amount = 3, price = 0},
 [6] = {name = 'Ibuprofen', id = 61, amount = 3, price = 0},
}

Citizen.CreateThread(function()
 while true do
 Citizen.Wait(1500)
  if isInService then
   nearObject = false
   isNearObject = false
   local myCoords = GetEntityCoords(GetPlayerPed(-1))
   for i = 1, #models do
    clostestProp = GetClosestObjectOfType(myCoords.x, myCoords.y, myCoords.z, 2.5, models[i], false, false)
    if clostestProp ~= nil and clostestProp ~= 0 then
     local coords = GetEntityCoords(clostestProp)
     isNearObject = true
     objectLoc = {['x'] = coords.x, ['y'] = coords.y, ['z'] = coords.z + 1.2}
     break
    end
   end
  end
 end
end)

Citizen.CreateThread(function()
 WarMenu.CreateMenu('medb', 'Medbag')
 while true do
  Wait(5)
  if isNearObject then
   if isInService then
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), objectLoc.x, objectLoc.y, objectLoc.z, true) < 1.2) then
     drawTxt('~b~Press ~g~E~b~ To Open Medbag')
     if IsControlJustPressed(0, 38) then
      WarMenu.OpenMenu('medb')
     end
    end
   end
  end
  if WarMenu.IsMenuOpened('medb') then
   for ind, v in pairs(emsbag) do
    local price = math.floor(v.price)
    if WarMenu.Button(v.name) then
     TaskPlayAnim(PlayerPedId(), 'anim@mp_snowball', 'pickup_snowball', 8.0, -1, -1, 0, 1, 0, 0, 0)
     ExecuteCommand('me takes '..v.name..' from Medical Bag')
     Wait(1500)
     ClearPedTasksImmediately(GetPlayerPed(-1))
     TriggerServerEvent('ems:purchase', v.name, price, v.amount, v.id)
    end
   end
   WarMenu.Display()
  end
 end
end)


-- New Command
bedNames = { 'v_med_bed1', 'v_med_bed2', 'v_49_motelmp_bed', 'v_61_bd2_mesh_bed', 'p_lestersbed_s', 'p_mbbed_s', 'p_v_res_tt_bed_s', 'v_res_msonbed_s'}
bedHashes = {}
isOnBed = false

CreateThread(function()
 for k,v in ipairs(bedNames) do
  table.insert(bedHashes, GetHashKey(v))
 end
 table.insert(bedHashes, 1631638868)
 table.insert(bedHashes, -1091386327)
 table.insert(bedHashes, -1182962909)

end)

RegisterCommand('bed', function()
 Citizen.CreateThread(function()
  if isOnBed then
   ClearPedTasksImmediately(PlayerPedId())
   FreezeEntityPosition(PlayerPedId(), false)
   isOnBed = false
   return
  end

  local playerPos = GetEntityCoords(PlayerPedId(), true)
  local bed = nil

  for k,v in ipairs(bedHashes) do
   bed = GetClosestObjectOfType(playerPos.x, playerPos.y, playerPos.z, 3.0, v, false, false, false)
   if bed ~= 0 then
    break
   end
  end

  if bed ~= nil and DoesEntityExist(bed) then
   RequestAnimDict('dead')
   local bedCoords = GetEntityCoords(bed)
   SetEntityCoords(PlayerPedId(), bedCoords.x , bedCoords.y, bedCoords.z+0.10, 1, 1, 0, 0)
   SetEntityHeading(PlayerPedId(), GetEntityHeading(bed) + 180.0)
   TaskPlayAnim(PlayerPedId(),'dead', 'dead_a', 8.0, 1.0, -1, 45, 1.0, 0, 0, 0)
   FreezeEntityPosition(PlayerPedId(), true)
   isOnBed = true
  end
 end)
end)