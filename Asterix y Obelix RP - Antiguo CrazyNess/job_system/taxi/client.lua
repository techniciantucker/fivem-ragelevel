local mission_list = {}

-- Citizen.CreateThread(function()
 -- while true do
  -- Citizen.Wait(5)
  -- local coords = GetEntityCoords(GetPlayerPed(-1))
  -- if(GetDistanceBetweenCoords(coords, 895.376, -179.315, 73.710, true) < 50) and DecorGetInt(GetPlayerPed(-1), "Job") == 4 then
   -- DrawMarker(27, 895.376, -179.315, 73.710, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 2.0, 252, 252, 58, 200, 0, 0, 2, 0, 0, 0, 0)
   -- if(GetDistanceBetweenCoords(coords, 895.376, -179.315, 73.710, true) < 1.3) then
   	-- drawTxt('~b~Press ~g~E~b~ To Get Taxi')
    -- if IsControlJustReleased(0, 38) then
     -- SpawnJobVehicle('taxi', 904.363, -183.962, 73.993)
    -- end
   -- end
  -- end
 -- end
-- end)

Citizen.CreateThread(function()
 WarMenu.CreateLongMenu('taxi_missions', 'Missions')
 while true do 
  Wait(5)
  if DecorGetInt(GetPlayerPed(-1), "Job") == 4 then
   if IsControlJustPressed(0, 167) or IsDisabledControlPressed(0, 167) then WarMenu.OpenMenu('taxi_missions') end
   if WarMenu.IsMenuOpened('taxi_missions') then
    for i,v in pairs(mission_list) do
     if v.name ~= "Finish the mission" then
      if WarMenu.Button(v.name) then
       v.f(v.mission)
       exports.pNotify:SendNotification({text = "Call Information: "..v.info})
      end
     else
      if WarMenu.Button(v.name) then
       v.f()
      end
     end 
    end
   end
    WarMenu.Display()
  end
 end
end)

----------------------------------------------------------------------------------------------------------
---------------------------- New Mission System ----------------------------------------------------------
----------------------------------------------------------------------------------------------------------
local currentMissionBlip = nil 
local availableMissions = {}
local currentMissions = nil
local MissionInformation = '~g~NO CALLS WAITING'
local TaxiCallStatus = 0
local activeTaxis = 0
local availableTaxis = 0

RegisterNetEvent("taxi:notifyallTaxis")
AddEventHandler("taxi:notifyallTaxis",function(message)
  if DecorGetInt(GetPlayerPed(-1), "Job") == 4 then
    TriggerEvent("pNotify:SendNotification", {text= message})
  end
end)

RegisterNetEvent("taxi:notifyClient")
AddEventHandler("taxi:notifyClient",function(message)
  TriggerEvent("pNotify:SendNotification", {text= message})
end)

function acceptMissiontaxi(data) 
    TriggerServerEvent('taxi:acceptMission', data.id)
end

function finishCurrentMissiontaxi()
    if currentMissions ~= nil then
        TriggerServerEvent('taxi:finishMission', currentMissions.id)
    end
    currentMissions = nil
    if currentMissionBlip ~= nil then
        RemoveBlip(currentMissionBlip)
    end
  WarMenu.OpenMenu('taxi_missions')
end

function updateMissionMenu() 
    local cmissions = {}
    for k,v in pairs(availableMissions) do
        Citizen.Trace('==>' .. k )
    end
    for _,m in pairs(availableMissions) do 
        local data = {
            name = '' .. m.name,
            mission = m,
            info = m.type,
            f = acceptMissiontaxi
        }
        if #m.acceptBy ~= 0 then
            data.name = data.name .. ' (' .. #m.acceptBy ..' Unit)'
        end
        table.insert(cmissions, data)
    end

    if currentMissions ~= nil then
        table.insert(cmissions, {name = 'Finish the mission', f = finishCurrentMissiontaxi})
    end
    mission_list = cmissions
    if curMenu ~= nil then
        if curMenu == "missions_menu" then
            WarMenu.OpenMenu('taxi_missions')
        end
    end
end

function calltaxi(type)
    local callerPos = GetEntityCoords(GetPlayerPed(-1))
    TriggerServerEvent('taxi:Call', callerPos.x, callerPos.y, callerPos.z, type)
end

RegisterNetEvent('taxi:acceptMission')
AddEventHandler('taxi:acceptMission',function(mission)
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

RegisterNetEvent('taxi:cancelMission')
AddEventHandler('taxi:cancelMission', function ()
    currentMissions = nil
    if currentMissionBlip ~= nil then
        RemoveBlip(currentMissionBlip)
    end
    if curMenu ~= nil then
        if curMenu == "missions_menu" then
          WarMenu.OpenMenu('taxi_missions')
        end
    end
end)

RegisterNetEvent('taxi:changeMission')
AddEventHandler('taxi:changeMission', function (missions)
    availableMissions = missions
    local MissionsOnHold = 0
    for _,m in pairs(availableMissions) do
        if #m.acceptBy == 0 then
            MissionsOnHold = MissionsOnHold + 1
        end
    end
    if MissionsOnHold == 0 then 
        MissionInformation = '~g~No Call Waiting'
    else
        MissionInformation = '~g~'..MissionsOnHold..' ~w~Call waiting'
    end  
    updateMissionMenu()
end)

RegisterNetEvent('taxi:calltaxi')
AddEventHandler('taxi:calltaxi',function(data)
    calltaxi(data.type)
end)

RegisterNetEvent('Taxi:callTaxiCustom')
AddEventHandler('Taxi:callTaxiCustom',function()
    local reason = openTextInput()
    if reason ~= nil and reason ~= '' then
        calltaxi(reason)
    end
end)

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

RegisterNetEvent('taxi:callStatus')
AddEventHandler('taxi:callStatus',function(status)
    TaxiCallStatus = status
end)

RegisterNetEvent('taxi:updateactiveTaxis')
AddEventHandler('taxi:updateactiveTaxis',function(activeCount, availableCount)
    activeTaxis = activeCount
    availableTaxis = availableCount
end)

RegisterNetEvent('Taxi:cancelCall')
AddEventHandler('Taxi:cancelCall',function(data)
    TriggerServerEvent('taxi:cancelCall')
end)


TriggerServerEvent('taxi:getactiveTaxis') -- Initilized on startup


RegisterNetEvent('Taxi:callTaxiCustom')
AddEventHandler('Taxi:callTaxiCustom',function()
    local reason = openTextInput()
    if reason ~= nil and reason ~= '' then
        calltaxi(reason)
    end
end)
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
 
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if DecorGetInt(GetPlayerPed(-1), "Job") == 4 then
            if currentMissions == nil then
                if currentMissionBlip ~= nil then
                    RemoveBlip(currentMissionBlip)
                end
            end
        end
    end
end)