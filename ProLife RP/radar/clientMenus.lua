local text1 = ""
local text2 = ""

local sub = ""
local subSelected = ""

local askRender = false

local limitationSelected = 0

function mainMenu()

	ped = GetPlayerPed(-1);
	inSubMenu = false
	askRender = false
	options.width = 0.4
	if(lang == "fr") then
		options.width = 0.6
	end
	options.x = 0.9
	options.menu_subtitle = "Categorias :"
    ClearMenu()
    Menu.addButton(text[lang].menuOnOff, "setPower", nil)
    Menu.addButton(text[lang].menuDeplacementMultiplier, "multiplier",nil)
    Menu.addButton(text[lang].menuSetLimitation, "setLimitation", nil)
    Menu.addButton(text[lang].menuSetModelPriority, "addModel", nil)
    Menu.addButton(text[lang].menuSetPlatePriority, "addPlate", nil)
    Menu.addButton(text[lang].menuSetOnlyShowModel, "onlyShowModels", nil)
    Menu.addButton(text[lang].menuSetOnlyShowPlate, "onlyShowPlates", nil)
end


function multiplier()
	options.menu_subtitle = text[lang].menuDeplacementMultiplier.." :"
    ClearMenu()
    Menu.addButton("x1", "setMultiplier", 1)
    Menu.addButton("x2", "setMultiplier", 2)
    Menu.addButton("x3", "setMultiplier", 3)
    Menu.addButton("x4", "setMultiplier", 4)
    Menu.addButton("x5", "setMultiplier", 5)
    Menu.addButton("x6", "setMultiplier", 6)
    Menu.addButton("x7", "setMultiplier", 7)
    Menu.addButton("x8", "setMultiplier", 8)
    Menu.addButton("x9", "setMultiplier", 9)
    Menu.addButton("x10", "setMultiplier", 10)
end


function addModel()
	inSubMenu = true
	ped = GetPlayerPed(-1);
	askRender = true
	options.x = 0.1
	options.width = 0.2
	options.menu_subtitle = text[lang].menuSetModelPriority
    ClearMenu()
    Menu.addButton(text[lang].menuSetLabel, "setModel", nil)
    Menu.addButton(text[lang].menuValideLabel, "ValiderModel", nil)
    text1 = text[lang].HUDAddModel1
    text2 = text[lang].HUDAddModel2
    sub = "Model : "
    subSelected = 0
end


function addPlate()
	inSubMenu = true
	ped = GetPlayerPed(-1);
	askRender = true
	options.x = 0.1
	options.width = 0.2
	options.menu_subtitle = text[lang].menuSetPlatePriority
    ClearMenu()
    Menu.addButton(text[lang].menuSetLabel, "setModel", nil)
    Menu.addButton(text[lang].menuValideLabel, "ValiderPlate", nil)
    text1 = text[lang].HUDAddPlate1
    text2 = text[lang].HUDAddPlate2
    sub = "Plate : "
    subSelected = 0
end



function setLimitation()
	inSubMenu = true
	ped = GetPlayerPed(-1);
	askRender = true
	options.x = 0.1
	options.width = 0.2
	options.menu_subtitle = text[lang].menuSetLimitation
    ClearMenu()
    Menu.addButton(text[lang].menuSetLabel, "ChangeLimitation", nil)
    Menu.addButton(text[lang].menuValideLabel, "ValiderLimitation", nil)
    text1 = text[lang].HUDSetLimitation1
    text2 = text[lang].HUDSetLimitation2
    sub = "Limitation : "
    subSelected = 0
end



function setModel()

	local edmenu = { show = 0, row = 0, input = 0, name = "", inp = 0, cur = 0 }
	local Ed = { id = {}, x = {}, y = {}, x1 = {}, y1 = {}, scale = {}, r = {}, g = {}, b = {}, a = {}, text = {}, font = {}, jus = {} }

	if edmenu.inp > 0 then
		edmenu.show = 2
		edmenu.row = 0
	else
		edmenu.input = 1
		edmenu.row = 1
		DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 64)
		PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)

	end

	local stop = false
	while stop == false do
			Citizen.Wait(0)



		if edmenu.input == 1 then
			if UpdateOnscreenKeyboard() == 3 then
				edmenu.input = 0
				edmenu.show = 1
				edmenu.row = 0
			elseif UpdateOnscreenKeyboard() == 1 then
				local inputText = GetOnscreenKeyboardResult()
						edmenu.inp = 1
						edmenu.cur = 0
						edmenu.name = inputText
						edmenu.show = 2
						edmenu.row = 0
						edmenu.input = 0
						subSelected = inputText
						stop = true
			elseif UpdateOnscreenKeyboard() == 2 then
				edmenu.input = 0
				if edmenu.show == 1 and edmenu.row == 1 then
					edmenu.show = 1
					edmenu.row = 0
				end
			end

		else 
			stop = true
		end
	end

end


function ChangeLimitation()

	local edmenu = { show = 0, row = 0, input = 0, name = "", inp = 0, cur = 0 }
	local Ed = { id = {}, x = {}, y = {}, x1 = {}, y1 = {}, scale = {}, r = {}, g = {}, b = {}, a = {}, text = {}, font = {}, jus = {} }

	if edmenu.inp > 0 then
		edmenu.show = 2
		edmenu.row = 0
	else
		edmenu.input = 1
		edmenu.row = 1
		DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 64)
		PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)

	end

	local stop = false
	while stop == false do
			Citizen.Wait(0)



		if edmenu.input == 1 then
			if UpdateOnscreenKeyboard() == 3 then
				edmenu.input = 0
				edmenu.show = 1
				edmenu.row = 0
			elseif UpdateOnscreenKeyboard() == 1 then
				local inputText = GetOnscreenKeyboardResult()

					if string.len(inputText) >= 1  then
						edmenu.inp = 1
						edmenu.cur = 0
						edmenu.name = inputText
						edmenu.show = 2
						edmenu.row = 0
						edmenu.input = 0
						limitationSelected = tonumber(inputText)
						subSelected = inputText
						stop = true
					else
						stop = true
					end
			elseif UpdateOnscreenKeyboard() == 2 then
				edmenu.input = 0
				if edmenu.show == 1 and edmenu.row == 1 then
					edmenu.show = 1
					edmenu.row = 0
				end
			end

		else 
			stop = true
		end
	end

end


function ValiderLimitation()
	inSubMenu = false
	limitSpeed = limitationSelected
	Menu.hidden = true
	askRender = false
	text1 = ""
	text2 = ""
	sub = ""
	subSelected = ""
	askRender = false
	limitationSelected = 0
	options.x = 0.8
end

function ValiderModel()
	inSubMenu = false
	addModelToArray(subSelected)
	Menu.hidden = true
	askRender = false
	text1 = ""
	text2 = ""
	sub = ""
	subSelected = ""
	askRender = false
	limitationSelected = 0
	options.x = 0.8
end



function ValiderPlate()
	inSubMenu = false
	addPlateToArray(subSelected)
	Menu.hidden = true
	askRender = false
	text1 = ""
	text2 = ""
	sub = ""
	subSelected = ""
	askRender = false
	limitationSelected = 0
	options.x = 0.8
end



function renderMenuHUD()
	if(askRender) then
		DrawAdvancedText(0.528, 0.145, 0.005, 0.0028, 0.85, text1, 255, 255, 255, 255, 1, 0)
		DrawAdvancedText(0.618, 0.181, 0.005, 0.0028, 1.08, text2, 255, 255, 255, 255, 1, 0)
		DrawRect(0.521, 0.218, 0.106, 0.00499999999999994, 50, 100, 140, 255)
		DrawRect(0.421, 0.176, 0.096, 0.00499999999999994, 50, 100, 140, 255)
		DrawRect(0.0849999999999999, 0.721, 0.136, 0.0789999999999999, 0, 0, 0, 150)
		DrawAdvancedText(0.117, 0.722, 0.005, 0.0028, 0.4, sub..subSelected, 255, 255, 255, 255, 0, 1)
	end
end



function DrawAdvancedText(x,y ,w,h,sc, text, r,g,b,a,font,jus)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(sc, sc)
	N_0x4e096588b13ffeca(jus)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
	DrawText(x - 0.1+w, y - 0.02+h)
end
