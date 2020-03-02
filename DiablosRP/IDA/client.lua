-- This script is created by ZerefGG from alttabgamig.com
-- Discord: ZerefGG#4819

local HUD = {	
	Plate	= false, -- false if you want to disable display Plate
	ID	= true  -- false if you want to disable display ID
}

local UI = { 
	x		=  0.009,
	y		= -0.02
}

-- Diplay Plate and ID function
Citizen.CreateThread(function()
	while true do Citizen.Wait(1)

		local pd = GetPlayerPed(-1)

		if(IsPedInAnyVehicle(pd, false))then

			local pdv = GetVehiclePedIsIn(GetPlayerPed(-1),false)
			local PlateNum = GetVehicleNumberPlateText(pdv)

			if HUD.Plate then
				drawTxt(UI.x + 0.52, 	UI.y + 1.260, 1.0,1.0,0.55, "~w~" .. PlateNum, 255, 255, 255, 255)
			end	
		end		
		
		if HUD.ID then
			local playerID = GetPlayerServerId(PlayerId())
			drawTxt(UI.x + 0.666, 	UI.y + 1.460, 1.0,1.0,0.55, "~y~ID", 255, 255, 255, 255)
			drawTxt(UI.x + 0.685, 	UI.y + 1.460, 1.0,1.0,0.55, "~w~" .. playerID, 255, 255, 255, 255)

		end		
		
	end
end)


-- DrawText function
function drawTxt(x,y ,width,height,scale, text, r,g,b,a)
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
