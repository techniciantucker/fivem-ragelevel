			
function RGBRainbow(frequency)
    local result = {}
    local curtime = GetGameTimer() / 1000

    result.r = math.floor(math.sin(curtime * frequency + 0) * 127 + 128)
    result.g = math.floor(math.sin(curtime * frequency + 2) * 127 + 128)
    result.b = math.floor(math.sin(curtime * frequency + 4) * 127 + 128)

    return result
end


local fontId

Citizen.CreateThread(function()
	RegisterFontFile('out')
	fontId = RegisterFontId('Funny')
end)



function drawScreenText(x,y ,width,height,scale, text, r,g,b,a, outline, font, center)
    SetTextFont(fontId)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
	SetTextCentre(center)
    if(outline)then
	    SetTextOutline()
	end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

function CalculateDayOfWeekToDisplay()
	if dayOfWeek == 1 then
		dayOfWeek = "Domingo"
	elseif dayOfWeek == 2 then
		dayOfWeek = "Lunes"
	elseif dayOfWeek == 3 then
		dayOfWeek = "Martes"
	elseif dayOfWeek == 4 then
		dayOfWeek = "Miercoles"
	elseif dayOfWeek == 5 then
		dayOfWeek = "Jueves"
	elseif dayOfWeek == 6 then
		dayOfWeek = "Viernes"
	elseif dayOfWeek == 7 then
		dayOfWeek = "Sabado"
	end
end

function CalculateDateToDisplay()
	if month == 1 then
		month = "Enero"
	elseif month == 2 then
		month = "Febrero"
	elseif month == 3 then
		month = "Marzo"
	elseif month == 4 then
		month = "Abril"
	elseif month == 5 then
		month = "Mayo"
	elseif month == 6 then
		month = "Iunio"
	elseif month == 7 then
		month = "Iulio"
	elseif month == 8 then
		month = "Agosto"
	elseif month == 9 then
		month = "Septiembre"
	elseif month == 10 then
		month = "Octubre"
	elseif month == 11 then
		month = "Noviembre"
	elseif month == 12 then
		month = "Dicembre"
	end
end

function CalculateTimeToDisplay()
	if hour < 10 then
		hour = tostring("0" .. hour)
	end
	if minute < 10 then
		minute = tostring("0" .. minute)
	end
end

function RGBRainbow(frequency)
    local result = {}
    local curtime = GetGameTimer() / 1000

    result.r = math.floor(math.sin(curtime * frequency + 0) * 127 + 128)
    result.g = math.floor(math.sin(curtime * frequency + 2) * 127 + 128)
    result.b = math.floor(math.sin(curtime * frequency + 4) * 127 + 128)

    return result
end

waterMarkState = 0
WatermarkText = "~p~✨ ~w~Bastardos Roleplay"
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1100)
		if(waterMarkState == 0)then
			WatermarkText = "~w~discord.io/BastardosRP"
			waterMarkState = 1
		elseif(waterMarkState == 1)then
			WatermarkText = "~p~discord.io/BastardosRP"
			waterMarkState = 2
		elseif(waterMarkState == 2)then
			WatermarkText = "~w~discord.io/BastardosRP"
			waterMarkState = 3
		elseif(waterMarkState == 3)then
			WatermarkText = "~p~✨ ~w~Bastardos Roleplay"
			waterMarkState = 4
		elseif(waterMarkState == 4)then
			WatermarkText = "~w~✨ ~p~Bastardos Roleplay"
			waterMarkState = 5
		elseif(waterMarkState == 5)then
			WatermarkText = "~p~✨ ~w~Bastardos Roleplay"
			waterMarkState = 0
		end
	end
end)

function drawWatermark(r, g, b)
	SetTextColour(r, g, b, 255)
	SetTextFont(4)
	SetTextScale(0.4, 0.4)
	SetTextWrap(0.0, 1.0)
	SetTextCentre(false)
	SetTextDropshadow(2, 2, 0, 0, 0)
	SetTextEdge(1, 0, 0, 0, 205)
	SetTextEntry("STRING")
	DrawText(0.005, 0.001)
end

Citizen.CreateThread(function()
	while true do
		Wait(1)		
			rgb = RGBRainbow(2)
			rgb2 = RGBRainbow(1)
			year, month, dayOfWeek, hour, minute = GetLocalTime()
			timeAndDateString = "~w~|"
			jucatori = "~r~Online: ~g~"..#GetActivePlayers()
			
			CalculateTimeToDisplay()
			timeAndDateString = timeAndDateString .. " ~y~" .. hour .. ":" .. minute .. " ~w~|"
			CalculateDateToDisplay()
			timeAndDateString = timeAndDateString .. " ~b~" .. dayOfWeek .. " " .. month .. " " .. year .. " ~w~|"
			timeAndDateString = "~g~".. jucatori .. " " .. timeAndDateString
			
			drawScreenText(0.52, 0.04, 0.0, 0.0, 0.32, timeAndDateString, 255, 255, 255, 255, 1, 7, 1)
			drawScreenText(0.52, -0.005, 0.0, -0.015, 0.50, WatermarkText, 255, 255, 255, 255, 1, 7, 1, 1)	
			drawWatermark(rgb2.r, rgb2.g, rgb2.b)
	end
end)