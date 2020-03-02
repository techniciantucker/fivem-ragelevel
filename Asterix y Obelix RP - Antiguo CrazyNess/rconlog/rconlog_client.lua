RegisterNetEvent('rlUpdateNames')

AddEventHandler('rlUpdateNames', function()
    local names = {}

    for i = 0, 256 do
        if NetworkIsPlayerActive(i) then
            names[GetPlayerServerId(i)] = { id = i, name = GetPlayerName(i) }
        end
    end

    TriggerServerEvent('rlUpdateNamesResult', names)
end)

Citizen.CreateThread(function()
	while true do
		Wait(0)

		if NetworkIsSessionStarted() then
			TriggerServerEvent('rlPlayerActivated')
			return
		end
	end
end)

function NdrawTxt(x,y ,width,height,scale, text, r,g,b,a, center)
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

local restarting = false

RegisterNetEvent('rcon:serverrestart')
AddEventHandler('rcon:serverrestart', function(status)
 restarting = status 
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

Citizen.CreateThread(function()
  while true do
    Wait(0)
    local timer = 10 * 60 * 1000

    if restarting then
      while timer > 0 and restarting do
        raw_seconds = timer/1000
        raw_minutes = raw_seconds/60
        minutes = stringsplit(raw_minutes, ".")[1]
        seconds = stringsplit(raw_seconds-(minutes*60), ".")[1]
        NdrawTxt(0.900, 0.502, 1.0, 1.0, 0.6, "~r~Server Restart In ~w~"..minutes.." ~r~Minutes ~w~"..seconds.." ~r~Seconds", 255, 255, 255, 255, false)
        timer = timer - 15
        Citizen.Wait(0)
      end
    end
  end
end)

