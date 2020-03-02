 local guiEnabled = false

RegisterNUICallback('escape', function()
 EnableGui(false)
 guiEnabled = false
end)

function EnableGui(enable)
 SetNuiFocus(enable, enable)
 SendNUIMessage({type = "enableui", enable = enable})
end 

RegisterCommand('mdt', function(source, args, rawCommand)
 if DecorGetBool(GetPlayerPed(-1), 'isOfficer') or DecorGetBool(GetPlayerPed(-1), 'isParamedic') then
  updateCallLog()
  guiEnabled = not guiEnabled  
  EnableGui(guiEnabled)
 end
end)

local firstLoad = true

RegisterNetEvent('mdt:initalize')
AddEventHandler('mdt:initalize', function(charges, warrants, brass)
 if firstLoad then 
  SendNUIMessage({type = "initalizeSystem", chargeList = charges, warrantList = warrants, weaponBrass = brass})
  firstLoad = false
 else
  SendNUIMessage({type = "loadWarrants", warrantList = warrants, weaponBrass = brass})
 end
end)

RegisterNUICallback('processSuspect', function(data, cb)
 if data.isWarning then 
  TriggerServerEvent('mdt:newWarning', tonumber(data.id), tostring('Warned For '..data.charges))
 else 
  if DecorGetBool(GetPlayerPed(-1), 'isOfficer') or DecorGetBool(GetPlayerPed(-1), 'isParamedic') then
   if tonumber(data.time) > 0 then
    TriggerServerEvent('prison:jailplayer', tonumber(data.id), data.time) 
    TriggerServerEvent('setReputation', 0)
   end
   if tonumber(data.fine) > 0 then 
    TriggerServerEvent('prison:fineplayer', tonumber(data.id), data.fine) 
   end 
   TriggerServerEvent('prison:history', tonumber(data.id), tostring('Charges: '..data.charges), data.fine, data.time)
   cb('ok')
  else 
   TriggerServerEvent('anticheat:ban')
  end
 end 
end)

RegisterNUICallback('newWarrant', function(data, cb)
 TriggerServerEvent('mdt:newWarrant', data)
 cb('ok')
end)

RegisterNUICallback('deleteWarrant', function(data, cb)
 TriggerServerEvent('mdt:deleteWarrant', data.id)
 cb('ok')
end)


-- Warnings
RegisterNUICallback('searchNCIC', function(data, cb)
 if data.id == 1 then 
  TriggerServerEvent('mdt:searchNCIC', 'Person', data)
 elseif data.id == 2 then 
  TriggerServerEvent('mdt:searchNCIC', 'Vehicle', data)
 elseif data.id == 3 then 
  TriggerServerEvent('mdt:searchNCIC', 'Firearm', data)
 elseif data.id == 4 then 
  TriggerServerEvent('mdt:searchNCIC', 'License', data)
 end
 cb('ok')
end)

local characterID = 0

RegisterNetEvent('mdt:ncicData')
AddEventHandler('mdt:ncicData', function(searchData, cid)
 characterID = cid
 SendNUIMessage({type = "ncicResult", info = searchData['info'], arrest = searchData['arrest'], vehicle = searchData['vehicle'], weapons = searchData['weapons'], homes = searchData['homes'], warnings = searchData['warnings'], cautionCodes =  searchData['cautionCodes']})
end)

RegisterNUICallback('updateTags', function(data, cb)
 TriggerServerEvent('mdt:updateTags', characterID, data.id, data.status)
 cb('ok')
end)



RegisterNUICallback('newCallReport', function(data, cb)
 TriggerServerEvent('mdt:newCallReport', data)
 cb('ok')
end)


----------------------------------------------------------------------------------------------------------
---------------------------- New Mission System ----------------------------------------------------------
----------------------------------------------------------------------------------------------------------
local currentMissionBlip = nil 
local availableMissions = {}

RegisterNUICallback('acceptCall', function(data, cb)
 TriggerServerEvent('police:acceptMission', tonumber(data.id))
 cb('ok')
end)

RegisterNUICallback('finishCall', function(data, cb)
 TriggerServerEvent('police:finishMission', tonumber(data.id))
 cb('ok')
end)

Citizen.CreateThread(function()
 while true do 
  Wait(5)
  if DecorGetBool(GetPlayerPed(-1), "isOfficer") then 
   drawUI(1.460, 0.530, 1.0, 1.0, 0.42, '~r~'..#availableMissions..' Calls', 89, 194, 255, 255, false)
  end
 end
end)

RegisterNetEvent("police:notifyallCops")
AddEventHandler("police:notifyallCops",function(message)
 if DecorGetBool(GetPlayerPed(-1), 'isOfficer') then
  PlaySoundFrontend(-1, "HACKING_SUCCESS", 0, 1);
  exports.pNotify:SendNotification({text = "Dispatch: "..message, timeout = 20000})
  Wait(750)
  PlaySoundFrontend(-1, "HACKING_SUCCESS", 0, 1);
 end
end)

RegisterNetEvent("police:notifyClient")
AddEventHandler("police:notifyClient",function(message)
 exports.pNotify:SendNotification({text = "Emergency: "..message})
end)

RegisterNetEvent('police:acceptMission')
AddEventHandler('police:acceptMission',function(mission)
 SetNewWaypoint(mission.pos[1], mission.pos[2])
end)

RegisterNetEvent('police:cancelCall')
AddEventHandler('police:cancelCall',function(data)
 TriggerServerEvent('police:cancelCall')
end)

RegisterNetEvent('police:updateMissions')
AddEventHandler('police:updateMissions',function(data)
 availableMissions = data
 local callList = ''
 local responders = {}
 for id, v in pairs(availableMissions) do 
  responders[id] = ''
  for s, d in pairs(v.acceptBy) do 
   responders[id] = d.name..", "..responders[id]
  end
  if responders[id] == '' then responders[id] = 'No Officers' end
  callList = '<div class="warrant" onclick="viewCall(`'..id..'`, `'..v.name..'`,`'..v.id..'`,`'..v.type..'`, `'..getDistance(v.pos)..'`, `'..v.timestamp..'`, `'..responders[id]..'`)""><h4>'..v.name..'</h4></div>'..callList
 end
 SendNUIMessage({type = 'updateCalls', callList = callList})
end)

function updateCallLog()
 local callList = ''
 local responders = {}
 for id, v in pairs(availableMissions) do 
  responders[id] = ''
  for s, d in pairs(v.acceptBy) do 
   responders[id] = d.name..", "..responders[id]
  end
  if responders[id] == '' then responders[id] = 'No Officers' end
  callList = '<div class="warrant" onclick="viewCall(`'..id..'`, `'..v.name..'`,`'..v.id..'`,`'..v.type..'`, `'..getDistance(v.pos)..'`, `'..v.timestamp..'`, `'..responders[id]..'`)""><h4>'..v.name..'</h4></div>'..callList
 end
 SendNUIMessage({type = 'updateCalls', callList = callList})
end

function getDistance(pos)
 local coords = GetEntityCoords(PlayerPedId(), true)
 local distance = GetDistanceBetweenCoords(coords, pos[1], pos[2], pos[3], true)
 return distance.." Meters Away"
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
