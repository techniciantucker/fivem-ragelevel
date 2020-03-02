--local voipRange = 2
local isTalking = false
local level = 2
DecorRegister('currentCallID', 3)
DecorRegister("isInCall", 2)
DecorRegister("isInService", 2)

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(500)
  for i = 0, 255 do
   if NetworkIsPlayerActive(i) then
    local otherPed, serverID = GetPlayerPed(i), GetPlayerServerId(i)
    if GetDistanceBetweenCoords(GetEntityCoords(otherPed), GetEntityCoords(PlayerPedId()), true) <= level then
     SendVoiceToPlayer(i, true)
    elseif DecorGetBool(PlayerPedId(), 'isInCall') then
     if DecorGetInt(PlayerPedId(), 'currentCallID') == DecorGetInt(otherPed, 'currentCallID') then
      SendVoiceToPlayer(i, true)
     end
    else
     SendVoiceToPlayer(i, false)
    end
   end
  end
 end
end)


function SendVoiceToPlayer(intPlayer, boolSend)
 Citizen.InvokeNative(0x97DD4C5944CC2E6A, intPlayer, boolSend)
 NetworkOverrideSendRestrictions(intPlayer, boolSend)
end



-- AddEventHandler('onClientMapStart', function()
	-- level = 2
	-- NetworkSetTalkerProximity(5.0)
-- end)

function ShowNotif(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString("La intensidad de tu voz se ha establecido en " .. text .. ".")
	DrawNotification(true, false)
end

local pressed = false
local once = true
Citizen.CreateThread(function()
	while true do
		Wait(0)
		if once then
			once = false
			NetworkSetVoiceActive(1)
		end

		while IsControlPressed(1, 21) and IsControlJustPressed(1, 74) and pressed do
			Wait(10)
		end
		if IsControlPressed(1, 21) and IsControlJustPressed(1, 74) and not pressed then
			pressed = true
			level = level + 1
			if level > 3 then
				level = 1
			end
			if level == 1 then
				NetworkSetTalkerProximity(3.0)
				ShowNotif("~b~muy bajo~w~")
			elseif level == 2 then
				NetworkSetTalkerProximity(5.0)
				ShowNotif("~g~normal~w~")
			elseif level == 3 then
				NetworkSetTalkerProximity(12.0)
				ShowNotif("~o~muy alto~w~")
			end
			Wait(200)
		elseif not IsControlPressed(1, 21) and IsControlJustPressed(1, 74) and pressed then
			pressed = false
		end
	end
end)

AddEventHandler('playerSpawned', function()
 for i = 0, 255 do
  SendVoiceToPlayer(i, false)
 end

 Wait(1000)
 DecorSetInt(PlayerPedId(), 'level', 2)
 local level = 2
 DecorSetBool(PlayerPedId(), "isInService", false)
 DecorSetBool(PlayerPedId(), "isInCall", false)
 DecorSetBool(PlayerPedId(), "hudStatus", true)
 NetworkSetTalkerProximity(5.0)
end)


RegisterCommand('voip', function(source)
 print('attempting voip reset')
 DecorSetInt(PlayerPedId(), 'level', 2)
 local level = 2
 DecorSetBool(PlayerPedId(), "isInCall", false)
 DecorSetBool(PlayerPedId(), "hudStatus", true)
 NetworkSetTalkerProximity(5.0)
 for i = 0, 255 do
  SendVoiceToPlayer(i, false)
 end
end)
