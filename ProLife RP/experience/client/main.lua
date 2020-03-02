--CREAR USUARIO
local interface = 1
local exp = 0
local level = 0
local sp = 0
AddEventHandler('playerSpawned', function(spawn)
	TriggerServerEvent('exp:initEXP')
end)
TriggerServerEvent('exp:initEXP')

--ACTUALIZAR NUI
RegisterNetEvent('exp:refreshNUI')
AddEventHandler('exp:refreshNUI',function(levela,points,percents)
if interface == 1 then
    SendNUIMessage({
        type = "changeLvl",
        level = levela,
        points = points,
        percent = percents
    })
else
    exp = percents
    level = levela 
    sp = points
end
end)

RegisterNetEvent('exp:playSound')
AddEventHandler('exp:playSound',function(sound,volume)
SendNUIMessage({
    type = "playSound",
    mp3 = sound
})
end)

RegisterNetEvent('exp:putOffInterface')
AddEventHandler('exp:putOffInterface',function()
    if interface == 1 then
        interface = 2
        SendNUIMessage({
            type = "off"
        })
        activeDrawTxt()
    end
end)

RegisterNetEvent('exp:Notificate')
AddEventHandler('exp:Notificate',function(msg,time)
TriggerEvent("pNotify:SetQueueMax", "center", 2)
TriggerEvent("pNotify:SendNotification", {
    text = msg,
    type = "success",
    timeout = 3000,
    layout = "centerRight",
    queue = "center"
})
end)

RegisterNetEvent('exp:NotificateError')
AddEventHandler('exp:NotificateError',function(msg,time)
TriggerEvent("pNotify:SetQueueMax", "center", 2)
TriggerEvent("pNotify:SendNotification", {
    text = msg,
    type = "error",
    timeout = 3000,
    layout = "centerRight",
    queue = "center"
})
end)

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(centre)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x , y)
end

function activeDrawTxt()
    Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        drawTxt(" ~p~LVL "..tostring(level).." ~r~UP "..tostring(round(exp,2)).." ~p~SP "..tostring(sp),1, 1, 0.063, 0.736, 0.50,255,255,255,255)
    end
    end)
end

function round(num, numDecimalPlaces)
    local mult = 5^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end