local guiEnabled = false
local contacts = {}
local recentMessages = ''
local recentMessagesContacts = {}
local allMessages = {}
local myStockMarket = {}
local inCall = false 
local notificationsMuted = false
local reputation = 0

RegisterNetEvent('phone:load')
AddEventHandler('phone:load', function(number, conts, allcontacts, rep)
 local contactshtml = ''
 contacts = allcontacts
 for _,v in pairs(conts) do 
  if v.online then 
   html = '<div class="contact"><h5 style="color: green;">'..v.name..'</h5><h6 style="color: #595959;">'..v.number..'<a class="icons" onclick="openMessages('..v.number..')"><i class="fa fa-envelope"></i></a><a class="icons" onclick="callContact('..v.number..')"><i class="fa fa-phone"></i></a><a class="icons" onclick="deleteContact('..v.number..')"><i class="fa fa-trash-alt"></i></a></h6></div>'
  else
   html = '<div class="contact"><h5>'..v.name..'</h5><h6 style="color: #595959;">'..v.number..'<a class="icons" onclick="openMessages('..v.number..')"><i class="fa fa-envelope"></i></a><a class="icons" onclick="callContact('..v.number..')"><i class="fa fa-phone"></i></a><a class="icons" onclick="deleteContact('..v.number..')"><i class="fa fa-trash-alt"></i></a></h6></div>'
  end
  contactshtml = contactshtml..html
 end
 SendNUIMessage({type = 'phoneData', number = number, contacts = contactshtml})
 reputation = tonumber(rep)
 if reputation > 25 then SendNUIMessage({type = 'updateDeepDark', tweets = ''}) end
end)

RegisterNUICallback('newMessage', function(data, cb) 
 local name = 'Unknown'
 if contacts[data.number] ~= nil then name = contacts[data.number].name end
 if not allMessages[data.number] then allMessages[data.number] = '' end
 if not recentMessagesContacts[data.number] then 
  recentMessages = '<div class="message" onclick="openMessages('..data.number..')"><h6>'..name..'<font style="float: right;">'..data.number..'</font></div>'..recentMessages
  recentMessagesContacts[data.number] = true
 end
 allMessages[data.number] = allMessages[data.number]..'<div class="messageFrom">'..data.message..'</div>'
 SendNUIMessage({type = 'updateMessages', recent = recentMessages, all = allMessages})
 TriggerServerEvent("phone:sendMessage", data)
 cb('ok')
end)

RegisterNetEvent('phone:onMessage')
AddEventHandler('phone:onMessage', function(number, message)
 PlaySoundFrontend(-1, 'CHALLENGE_UNLOCKED', 'HUD_AWARDS')
 local name = 'Unknown'
 if contacts[number] ~= nil then name = contacts[number].name end
 if not allMessages[number] then allMessages[number] = '' end
 if not recentMessagesContacts[number] then 
  recentMessages = '<div class="message" onclick="openMessages('..number..')"><h6>'..name..'<font style="float: right;">'..number..'</font></div>'..recentMessages
  recentMessagesContacts[number] = true
 end
 allMessages[number] = allMessages[number]..'<div class="messageTo">'..message..'</div>'
 SendNUIMessage({type = 'updateMessages', recent = recentMessages, all = allMessages})
 TriggerEvent('phone:notification', 'New Message From '..number)
end)


AddEventHandler('phone:open', function()
 if not DecorGetBool(GetPlayerPed(-1), 'inJail') then 
  guiEnabled = not guiEnabled
  EnableGui(guiEnabled)
 end
end)

RegisterNUICallback('escape', function(data, cb) 
 if guiEnabled then 
  EnableGui(false)
  cb('ok')
 end
end)

RegisterCommand('phone', function(source, args, rawCommand)
 guiEnabled = not guiEnabled
 EnableGui(guiEnabled)
end)

function EnableGui(enable)
 SetNuiFocus(enable, enable)
 guiEnabled = enable
 SendNUIMessage({type = "enableui", enable = enable})
 SendNUIMessage({type = "updateHomeScreen", time = getTime(), date = getDate(), location = getLocation()})
 if enable then 
  PhonePlayAnim('text')
 else 
  PhonePlayAnim('out')
 end
end 

Citizen.CreateThread(function()
 EnableGui(false)
 while true do
  if guiEnabled then
   SendNUIMessage({type = "updateHomeScreen", time = getTime(), date = getDate(), location = getLocation()})
   DisableControlAction(0, 1, guiEnabled) -- LookLeftRight
   DisableControlAction(0, 2, guiEnabled) -- LookUpDown
   DisableControlAction(0, 142, guiEnabled) -- MeleeAttackAlternate
   DisableControlAction(0, 106, guiEnabled) -- VehicleMouseControlOverride
   DisableAllControlActions(0)
   if IsDisabledControlJustReleased(0, 142) then -- MeleeAttackAlternate
    SendNUIMessage({type = "click"})
   end
  end
  Citizen.Wait(0)
 end
end)

RegisterNUICallback('newContact', function(data, cb) 
  TriggerServerEvent("phone:addContact", data)
  cb('ok')
end)

RegisterNUICallback('removeContact', function(data, cb) 
  TriggerServerEvent("phone:removeContact", data.id)
  cb('ok')
end)


--- Calling 
local callInfo = {}

RegisterNUICallback('startCall', function (data, cb)
 TriggerServerEvent('phone:startCall', data.number)
 cb()
end)

RegisterNetEvent("phone:waitingCall")
AddEventHandler("phone:waitingCall", function(callInfo, initiator)
 callInfo = callInfo
 if not initiator then  
  PlaySoundFrontend(-1, 'DOOR_BUZZ', 'MP_PLAYER_APARTMENT')
  Wait(750)
  SendNUIMessage({type = 'callWaiting', callInfo = callInfo})
  PlaySoundFrontend(-1, 'DOOR_BUZZ', 'MP_PLAYER_APARTMENT')
  Wait(750)
  PlaySoundFrontend(-1, 'DOOR_BUZZ', 'MP_PLAYER_APARTMENT')
 end
end)

RegisterNUICallback('answerCall', function (data, cb)
 TriggerServerEvent('phone:answerCall', data.callInfo)
 cb() 
end)

RegisterNetEvent("phone:answerCall")
AddEventHandler("phone:answerCall", function(callInfo, initiator)
 if contacts[number] ~= nil then 
  callInfo.displayName = contacts[number].name
 else 
  callInfo.displayName = callInfo.receiver_num 
 end
 SendNUIMessage({type = 'callInProgress', callInfo = callInfo})
 EnableGui(false)
 if inCall == false then
  inCall = true
  DecorSetFloat(GetPlayerPed(-1), "Phone", 2.0)
  DecorSetBool(GetPlayerPed(-1), "isInCall", true)
  DecorSetInt(GetPlayerPed(-1), "currentCallID", callInfo.id + 100) 
  NetworkSetTalkerProximity(0.0)
  Wait(500) 
  PhonePlayAnim('call')
 end
end)

RegisterNUICallback('rejectCall', function(data, cb)
 TriggerServerEvent('phone:rejectCall', data.callInfo)
 cb()
end)

RegisterNetEvent("phone:rejectCall")
AddEventHandler("phone:rejectCall", function()
 if inCall == true then
  inCall = false
  PhonePlayAnim('out')
  DecorSetFloat(GetPlayerPed(-1), "Phone", 1.0)
  DecorSetInt(GetPlayerPed(-1), "currentCallID", 0)
  DecorSetBool(GetPlayerPed(-1), "isInCall", false)
  NetworkSetTalkerProximity(5.0)
  
 end
end)

-- Tweets
local tweetAllowed = true

RegisterNUICallback('newTweet', function(data, cb) 
 if tweetAllowed then
  tweetAllowed = false
  TriggerServerEvent("phone:newTweet", data.message, getTime())
  cb('ok')
  Wait(7000)
  tweetAllowed = true
 else 
  TriggerEvent('chatMessage', '10 Second Cooldown')
 end
end)

RegisterNetEvent('phone:updateTweets')
AddEventHandler('phone:updateTweets', function(tweets)
 SendNUIMessage({type = 'updateTweets', tweets = tweets})
end)

local lastCall = nil

RegisterNUICallback('contactServices', function(data)
 if string.len(data.message) > 15 then
  local pos = GetEntityCoords(GetPlayerPed(-1))
  if data.id == 1 then
   lastCall = 'police'
   TriggerServerEvent('police:Call', pos.x, pos.y, pos.z, data.message)
  elseif data.id == 2 then
   lastCall = 'paramedic'
   TriggerServerEvent('paramedic:Call', pos.x, pos.y, pos.z, data.message)
  elseif data.id == 3 then
   lastCall = 'mechanic'
   TriggerServerEvent('mechanic:Call', pos.x, pos.y, pos.z, data.message)
  elseif data.id == 4 then
   lastCall = 'taxi'
   TriggerServerEvent('taxi:Call', pos.x, pos.y, pos.z, data.message)
  end
 else 
  TriggerEvent('chatMessage', '^115 Letters Required')
 end
end)

RegisterCommand("cancelCall", function(source, args, rawCommand)
 if lastCall ~= nil then 
  TriggerServerEvent(lastCall..':cancelCall')
 end
end)

-- Fancy Banking App
local bankActivity = ''
local bankBalance = 0

RegisterNetEvent('banking:updateBalance')
AddEventHandler('banking:updateBalance', function(bank)
 bankBalance = bank
 SendNUIMessage({type = 'updateBanking', bankBalance = bank, bankActivity = bankActivity})
end)

RegisterNetEvent('banking:activity')
AddEventHandler('banking:activity', function(name, amount, income)
 if income then 
  bankActivity = '<div class="payment"><p>'..name..'<font style="float: right; padding-right: 8px; color: #0fb729">+ $'..amount..'</font></p></div>'..bankActivity
 else 
  bankActivity = '<div class="payment"><p>'..name..'<font style="float: right; padding-right: 8px; color: #b71010">- $'..amount..'</font></p></div>'..bankActivity
 end 
 SendNUIMessage({type = 'updateBanking', bankBalance = bank, bankActivity = activity})
end)

RegisterNUICallback('getBills', function()
 TriggerServerEvent('phone:getBills')
end)

RegisterNUICallback('payBills', function()
 TriggerServerEvent('phone:payBills')
end)

RegisterNUICallback('sendMoney', function(data, cb) 
  TriggerServerEvent('bank:transfer', tonumber(data.id), tonumber(data.amount))
end)

-- Deep Dark Webbsss
RegisterNUICallback('newDeepDark', function(data, cb) 
  TriggerServerEvent("phone:newDeepDark", data.message, getTime())
  cb('ok')
end)

RegisterNetEvent('phone:updateDeepDark')
AddEventHandler('phone:updateDeepDark', function(tweets)
 if reputation > 25 then
  SendNUIMessage({type = 'updateDeepDark', tweets = tweets})
  TriggerEvent('phone:notification', 'Nuevo Dark Tweet Publicado')
 end
end) 

-- Housing
AddEventHandler('phone:houses', function(allHouses, owned)
 Wait(1000)
 local housingList = ''
 for _,v in pairs(allHouses) do
  local rent = math.floor(v.price/8)
  if not owned[v.id] then 
   housingList = '<div class="newHouse"><h6>'..v.address..' - $'..rent..'<font style="float: right;"><button type="button" onclick="setLocation('..v.pos.x..', '..v.pos.y..')" class="btn btn-success btn-sm">GPS</button></font></h6><h6 style="color: #595959;">Rentable House</h6></div>'..housingList
  else
   housingList = '<div class="newHouse"><h6>'..v.address..' - $'..rent..'<font style="float: right;"><button type="button" onclick="setLocation('..v.pos.x..', '..v.pos.y..')" class="btn btn-success btn-sm">GPS</button></font></h6><h6 style="color: #595959;">Tenant: '..owned[v.id].owner..'</h6></div>'..housingList
  end
 end
 SendNUIMessage({type = 'updateHousing', housingList = housingList})
end)

RegisterNUICallback('setLocation', function (data, cb)
 SetNewWaypoint(data.x, data.y)
 cb()
end)

-- Trucking 
AddEventHandler('phone:truckingJob', function()
 local trucking = exports['clrp_jobs']:getTruckingMissions()
 local truckingList = ''
 for id,v in pairs(trucking) do 
  truckingList = '<div class="addJob"><h6>'..v.Name..' - $'..math.floor(v.Pay)..'<font style="float: right;"><button type="button" onclick="truckingMission('..id..')" class="btn btn-success btn-sm">Start Job</button></font></h6><h6 style="color: #595959;">Job Duration: '..v.Time..'</h6></div>'..truckingList
 end 
 SendNUIMessage({type = 'updateTruckingJob', truckingList = truckingList})
end)

RegisterNUICallback('truckingMission', function (data, cb)
 TriggerEvent('trucking:new', data.id)
 cb()
end)

RegisterNetEvent('tablet:updateEmails')
AddEventHandler('tablet:updateEmails', function(emails)
 SendNUIMessage({type = 'updateEmails', emails = emails})
end)

function getTime()
 local hour = GetClockHours()
 local minute = GetClockMinutes()

 if hour <= 9 then
  hour = "0" .. hour
 end
 if minute <= 9 then
  minute = "0" .. minute
 end
 return hour..":"..minute
end

function getLocation()
 local pos = GetEntityCoords(GetPlayerPed(-1))
 local zone = GetNameOfZone(pos.x, pos.y, pos.z)
 return zone
end

function getDate()
 local month = GetClockMonth()
 local dayOfMonth = GetClockDayOfMonth()
 local dayOfWeek = GetClockDayOfWeek()
  
  if dayOfWeek == 0 then
    dayOfWeek = "Domingo"
  elseif dayOfWeek == 1 then
    dayOfWeek = "Lunes"
  elseif dayOfWeek == 2 then
    dayOfWeek = "Martes"
  elseif dayOfWeek == 3 then
    dayOfWeek = "Miercoles"
  elseif dayOfWeek == 4 then
    dayOfWeek = "Jueves"
  elseif dayOfWeek == 5 then
    dayOfWeek = "Viernes"
  elseif dayOfWeek == 6 then
    dayOfWeek = "Sabado"
  end


  if month == 0 then
    month = "Enero"
  elseif month == 1 then
    month = "Febrero"
  elseif month == 2 then
    month = "Marzo"
  elseif month == 3 then
    month = "Abril"
  elseif month == 4 then
    month = "Mayo"
  elseif month == 5 then
    month = "Junio"
  elseif month == 6 then
    month = "Julio"
  elseif month == 7 then
    month = "Agosto"
  elseif month == 8 then
    month = "Septiembre"
  elseif month == 9 then
    month = "Octobre"
  elseif month == 10 then
    month = "Noviembre"
  elseif month == 11 then
    month = "Diciembre"
  end

 return dayOfWeek.." "..dayOfMonth.." "..month
end



-- Animations
local phoneProp =  0
local currentStatus = 'out'
local lastDict = nil
local lastAnim = nil
local animations = {
 ['cellphone@'] = {
  ['out'] = {['text'] = 'cellphone_text_in', ['call'] = 'cellphone_call_listen_base'},
  ['text'] = {['out'] = 'cellphone_text_out', ['call'] = 'cellphone_text_to_call'},
  ['call'] = {['out'] = 'cellphone_call_out', ['text'] = 'cellphone_call_to_text'}
 },
 ['anim@cellphone@in_car@ps'] = {
  ['out'] = {['text'] = 'cellphone_text_in', ['call'] = 'cellphone_call_in'},
  ['text'] = {['out'] = 'cellphone_text_out',['call'] = 'cellphone_text_to_call'},
  ['call'] = {['out'] = 'cellphone_horizontal_exit',['text'] = 'cellphone_call_to_text'}
 }
}

function newPhoneProp()
 deletePhone()
 RequestModel(GetHashKey('prop_npc_phone_02'))
 while not HasModelLoaded(GetHashKey('prop_npc_phone_02')) do
  Citizen.Wait(1)
 end
 phoneProp = CreateObject(GetHashKey('prop_npc_phone_02'), 1.0, 1.0, 1.0, 1, 1, 0)
 AttachEntityToEntity(phoneProp, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
end

function deletePhone()
 if phoneProp ~= 0 then
  Citizen.InvokeNative(0xAE3CBE5BF394C9C9, Citizen.PointerValueIntInitialized(phoneProp))
  phoneProp = 0
 end
end

function PhonePlayAnim(status)
 if currentStatus == status then
  return
 end
 local dict = "cellphone@"
 if IsPedInAnyVehicle(GetPlayerPed(-1), false) then dict = "anim@cellphone@in_car@ps" end
  loadAnimDict(dict)
  local anim = animations[dict][currentStatus][status]
  if currentStatus ~= 'out' then
   StopAnimTask(GetPlayerPed(-1), lastDict, lastAnim, 1.0)
  end
  
  TaskPlayAnim(GetPlayerPed(-1), dict, anim, 3.0, -1, -1, 50, 0, false, false, false)
  if status ~= 'out' and currentStatus == 'out' then
   Citizen.Wait(380)
   newPhoneProp()
  end

  lastDict = dict
  lastAnim = anim
  currentStatus = status
  if status == 'out' then
   Citizen.Wait(180)
   deletePhone()
   StopAnimTask(GetPlayerPed(-1), lastDict, lastAnim, 1.0)
  end
end

function loadAnimDict(dict)
 RequestAnimDict(dict)
 while not HasAnimDictLoaded(dict) do
  Citizen.Wait(1)
 end
end

-- Stock Market
AddEventHandler('phone:updateStockMarket', function(stockMarket, myStocks)
 myStockMarket = myStocks
 SendNUIMessage({type = 'updateStockMarket', myStock = stockMarket, myStockMarket = myStocks})
end)

RegisterNUICallback('buyStock', function(data, cb)
 TriggerServerEvent('stockMarket:buyStock', tonumber(data.id), tonumber(data.amount))
end)

RegisterNUICallback('sellStock', function(data, cb) 
 TriggerServerEvent('stockMarket:sellStock', tonumber(data.id), tonumber(data.amount))
end)


-- Weather APP
AddEventHandler('phone:weatherApp', function(weather, temp)
 SendNUIMessage({type = 'updateWeatherAPP', weather = weather, temp = temp})
end)

RegisterNetEvent('phone:tweetNotify')
AddEventHandler('phone:tweetNotify', function()
 PlaySoundFrontend(-1, 'CHALLENGE_UNLOCKED', 'HUD_AWARDS')
 TriggerEvent('phone:notification', 'Has sido mencionado en Twitter')
end)

-- TriggerEvent('phone:notification', 'New Email Received')
RegisterNetEvent('phone:notification')
AddEventHandler('phone:notification', function(msg)
 if not notificationsMuted then 
  exports.pNotify:SendNotification({text = msg, layout = "topRight", timeout=7000})
 end
end)

--- Settings
RegisterNUICallback('muteNotifications', function(data, cb)
 notificationsMuted = data.status
end)

-- Garages
AddEventHandler('phone:myVehicles', function(user_vehicles, garages, insured_vehicles)
 Wait(1000)
 local myVehicles = ''
 for i = 1, #user_vehicles do
  for k,v in pairs(garages) do
   if user_vehicles[i].garage == k then
    myVehicles = '<div class="newVehicle"><h6>'..user_vehicles[i].model..'<font style="float: right;">'..user_vehicles[i].plate..'</font></h6><h6 style="font-size: 15px; color: #595959;">Garage: '..v.name..'</h6><h6 style="font-size: 15px; color: #595959;">Insurance: $'..insured_vehicles[user_vehicles[i].plate].insurance..' Weekly</h6><h6 style="font-size: 15px; color: #595959;">Price: $'..user_vehicles[i].price..'</h6></div>'..myVehicles
   end
  end
 end
 SendNUIMessage({type = 'updateMyVehicles', myVehicles = myVehicles})
end)


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












-- New Stuff
RegisterNUICallback('sendMyNumber', function(data, cb)
 local t, distance = GetClosestPlayer()
 if(distance ~= -1 and distance < 5) then 
  TriggerServerEvent('phone:sendMyNumber', GetPlayerServerId(t))
 else
  TriggerEvent("pNotify:SendNotification", {text = "No hay jugador cerca"})
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