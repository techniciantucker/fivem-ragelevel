local polis = 0
local ems = 0
local mecanos = 0

RegisterNetEvent('pop_info:poln')
AddEventHandler('pop_info:poln',function(cant,cant2,cant3)
		polis = cant
		ems = cant2
		mecanos = cant3
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


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		drawTxt("~g~GC "..polis.." ~r~EMS "..ems.." ~y~MEC "..mecanos,2, 1, 0.085, 0.767, 0.50,255,255,255,255)
	end
end)
