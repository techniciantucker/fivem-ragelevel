local chatInputActive = false
local chatInputActivating = false
local oocEnabled = true

-- internal events
RegisterNetEvent('__cfx_internal:serverPrint')

RegisterNetEvent('_chat:messageEntered')

RegisterNetEvent('chatMessage')
AddEventHandler('chatMessage', function(author, color, text2)
  local args = { text2 }
  if author ~= "" then
    table.insert(args, 1, author)
  end

  SendNUIMessage({
    type = 'ON_MESSAGE',
    message = {
      color = color,
      multiline = true,
      args = args
    }
  })
end)

AddEventHandler('__cfx_internal:serverPrint', function(msg)
  print(msg)
  SendNUIMessage({
    type = 'ON_MESSAGE',
    message = {
      color = { 0, 0, 0 },
      multiline = true,
      args = { msg }
    }
  })
end)

RegisterNetEvent('chat:addMessage')
AddEventHandler('chat:addMessage', function(message)
  SendNUIMessage({
    type = 'ON_MESSAGE',
    message = message
  })
end)

RegisterNetEvent('chat:addSuggestion')
AddEventHandler('chat:addSuggestion', function(name, help, params)
  SendNUIMessage({
    type = 'ON_SUGGESTION_ADD',
    suggestion = {
      name = name,
      help = help,
      params = params or nil
    }
  })
end)

RegisterNetEvent('chat:removeSuggestion')
AddEventHandler('chat:removeSuggestion', function(name)
  SendNUIMessage({
    type = 'ON_SUGGESTION_REMOVE',
    name = name
  })
end)

RegisterNetEvent('chat:addTemplate')
AddEventHandler('chat:addTemplate', function(id, html)
  SendNUIMessage({
    type = 'ON_TEMPLATE_ADD',
    template = {
      id = id,
      html = html
    }
  })
end)

RegisterNetEvent('chat:clear')
AddEventHandler('chat:clear', function(name)
  SendNUIMessage({
    type = 'ON_CLEAR'
  })
end)

RegisterNUICallback('chatResult', function(data, cb)
  chatInputActive = false
  SetNuiFocus(false)

  if not data.canceled then
    local id = PlayerId()

    --deprecated
    local r, g, b = 0, 0x99, 255

    if data.message:sub(1, 1) == '/' then
      ExecuteCommand(data.message:sub(2))
    else
      TriggerServerEvent('_chat:messageEntered', GetPlayerName(id), { r, g, b }, data.message)
    end
  end

  cb('ok')
end)

RegisterNUICallback('loaded', function(data, cb)
  TriggerServerEvent('chat:init');

  cb('ok')
end)

Citizen.CreateThread(function()
  SetTextChatEnabled(false)
  SetNuiFocus(false)

  while true do
    Wait(0)

    if not chatInputActive then
      if IsControlPressed(0, 245) --[[ INPUT_MP_TEXT_CHAT_ALL ]] then
        chatInputActive = true
        chatInputActivating = true

        SendNUIMessage({
          type = 'ON_OPEN'
        })
      end
    end

    if chatInputActivating then
      if not IsControlPressed(0, 245) then
        SetNuiFocus(true)

        chatInputActivating = false
      end
    end
  end
end)

RegisterNetEvent('chat:me')
AddEventHandler('chat:me', function(id, name, message)
    local myId = PlayerId()
    local herId = GetPlayerFromServerId(id) 
    if herId == myId then
        TriggerEvent('chatMessage', "", {0, 128, 255}, "" .. name .." " .. message )
    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(herId)), true) < 19.999 then
        TriggerEvent('chatMessage', "", {0, 128, 255}, "" .. name .." " .. message )
    end
end)

RegisterNetEvent('chat:actionmessage')
AddEventHandler('chat:actionmessage', function(id, message)
    local myId = PlayerId()
    local herId = GetPlayerFromServerId(id) 
    if herId == myId then
        TriggerEvent('chatMessage', "", {0, 128, 255}, message)
    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(herId)), true) < 19.999 then
        TriggerEvent('chatMessage', "", {0, 128, 255}, message)
    end
end)

RegisterNetEvent('chat:do')
AddEventHandler('chat:do', function(id, name, message)
    local myId = PlayerId()
    local herId = GetPlayerFromServerId(id)
    if herId == myId then
        TriggerEvent('chatMessage', "", {255, 0, 0}, " ^0* " .. name .."^0 " .. message)
    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(herId)), true) < 19.999 then
        TriggerEvent('chatMessage', "", {255, 0, 0}, " ^0* " .. name .."^0 " .. message)
    end
end)


RegisterNetEvent('911:setBlip')
AddEventHandler('911:setBlip', function(name, x, y, z)
    blip = AddBlipForCoord(x, y, z)
    SetBlipSprite(blip, 487)
    SetBlipScale(blip, 1.0)
    SetBlipColour(blip, 3)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('911 Call - ' .. name)
    EndTextCommandSetBlipName(blip)
    table.insert(blips, blip)
    Wait(displayTime * 1000)
    for i, blip in pairs(blips) do 
        RemoveBlip(blip)
    end
end)

RegisterNetEvent('chat:localooc')
AddEventHandler('chat:localooc', function(id, name, message)
    local myId = PlayerId()
    local herId = GetPlayerFromServerId(id)
    if herId == myId then
        TriggerEvent('chatMessage', "", {156, 156, 156}, name .."^0: " .. message)
    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(herId)), true) < 19.999 then
        TriggerEvent('chatMessage', "", {156, 156, 156}, name .."^0: " .. message)
    end
end)

RegisterNetEvent('chat:ooc')
AddEventHandler('chat:ooc', function(title, message)
 if oocEnabled then 
  TriggerEvent('chatMessage', title, { 156, 156, 156 }, message)
 end
end)

AddEventHandler('chat:toggleooc', function()
 oocEnabled = not oocEnabled 
 if oocEnabled then
  TriggerEvent('chatMessage', "[OOC]", { 156, 156, 156 }, 'Now Enabled')
 else
  TriggerEvent('chatMessage', "[OOC]", { 156, 156, 156 }, 'Now Disabled') 
 end
end)
