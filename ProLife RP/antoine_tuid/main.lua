--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

--===============--
--== Variables ==--
--===============--

local showId    = true 
local MiId      = GetPlayerServerId(PlayerId())

--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

--==========--
--== Main ==--
--==========--

Citizen.CreateThread(function()
    while true do 
        if showId == true then 
            SetTextFont(4)
            SetTextProportional(1)
            SetTextScale(0.0, 0.5)
            SetTextColour(128, 128, 128, 255)
            SetTextDropshadow(2, 0, 0, 0, 255)
            SetTextEdge(2, 0, 0, 0, 255)
            SetTextDropShadow()
            SetTextOutline()
            SetTextEntry("STRING")
            AddTextComponentString("~g~Tu ID es:~w~ " .. MiId)
            DrawText(0.175, 0.922)
        end 
        Citizen.Wait(0)
    end 
end)

--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

--==============--
--== Comandos ==--
--==============--

RegisterCommand("id", function()
    if showId == true then 
        showId = false 
    elseif showId == false then 
        showId = true 
    end 
end)

--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////