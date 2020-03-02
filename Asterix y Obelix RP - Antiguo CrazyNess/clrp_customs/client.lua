customsVat = 0
local inside = false
local currentpos = nil
local currentgarage = 0 
local ownedCustoms = {}
local currentStation = {}
local myCharacterID = 0
local garageID = 0
local garages = { 
 [1] = {locked = false, camera = {x = -330.945, y = -135.471, z = 39.01, heading = 102.213}, inside = {x = -337.3863,y = -136.9247,z = 38.5737, heading = 269.455}, id = 1, purchase = {x = -346.686, y = -133.657, z = 39.010}, price = 8000000},
 [2] = {locked = false, camera = {x = 737.09, y = -1085.721, z = 22.169, heading = 114.86},  inside = {x = 733.69,y = -1088.74, z = 21.733, heading = 270.528}, id = 2, purchase = {x = 732.823, y = -1081.942, z = 22.169}, price = 8000000},
 [3] = {locked = false, camera = {x = -1154.902, y = -2011.438, z = 13.18, heading = 95.49}, inside = {x = -1155.077,y = -2006.61, z = 12.465, heading = 162.58}, id = 3, purchase = {x = -1148.941, y = -1999.737, z = 13.180}, price = 8000000},
 [4] = {locked = false, camera = {x = 1177.98, y = 2636.059, z = 37.754, heading = 37.082}, inside = {x = 1174.823,y = 2637.807, z = 37.045, heading = 181.19}, id = 4, purchase = {x = 1171.767, y = 2637.609, z = 37.801}, price = 8000000},
 [5] = {locked = false, camera = {x = 105.825, y = 6627.562, z = 31.787, heading = 266.692}, inside = {x = 108.842,y = 6628.447, z = 31.072, heading = 45.504}, id = 5, purchase = {x = 111.005, y = 6630.786, z = 31.787}, price = 8000000},
 [6] = {locked = false, camera = {x = -215.518, y = -1329.135, z = 30.89, heading = 329.092}, inside = {x = -212.368,y = -1325.486, z = 30.176, heading = 141.107}, id = 6, purchase = {x = -213.936, y = -1333.380, z = 30.890}, price = 8000000},
 [7] = {locked = false, camera = {x = 1028.478, y = -2398.677, z = 0.315, heading = 329.092}, inside = {x = 1018.126, y = -2397.115, z = 0.875, heading = 141.107}, id = 7, purchase = {x = 1031.881, y = -2395.839, z = 1.230}, price = 1200000},  
 [8] = {locked = false, camera = {x = -2044.331, y = -269.134, z = 3.479, heading = 329.092}, inside = {x = -2044.331, y = -269.134, z = 3.479, heading = 141.107}, id = 8, purchase = {x = -2035.287, y = -269.544, z = 3.833}, price = 1200000},  
 [9] = {locked = false, camera = {x = 1730.716, y = 3690.619, z = 3.478, heading = 329.092}, inside = {x = 1730.716, y = 3690.619, z = 0.875, heading = 141.107}, id = 9, purchase = {x = 1741.077, y = 3690.998, z = 3.833}, price = 1200000}, 
 [10] = {locked = false, camera = {x = -197.614, y = -1384.274, z = 31.250, heading = 329.092}, inside = {x = -197.614, y = -1384.274, z = 31.250, heading = 141.107}, id = 10}, 
}


local Menu = SetMenu()
local myveh = {}
local gameplaycam = nil
local cam = nil

local function f(n)
	return (n + 0.00001)
end

local function LocalPed()
	return GetPlayerPed(-1)
end

local function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

function myveh.repair() 
	SetVehicleFixed(myveh.vehicle)
	SetVehicleUndriveable(myveh.vehicle, false)
end

local function round(num, idp)
  if idp and idp>0 then
    local mult = 10^idp
    return math.floor(num * mult + 0.5) / mult
  end
  return math.floor(num + 0.5)
end

local LSCMenu = Menu.new("Los Santos Customs","CATEGORIES", 0.16,0.13,0.24,0.36,0,{255,255,255,255})
LSCMenu.config.pcontrol = false

local function AddMod(mod,parent,header,name,info,stock)
	local veh = myveh.vehicle
	SetVehicleModKit(veh,0)	
	if (GetNumVehicleMods(veh,mod) ~= nil and GetNumVehicleMods(veh,mod) > 0) or mod == 18 or mod == 22 then
		local m = parent:addSubMenu(header, name, info,true)
		if stock then
			local btn = m:addPurchase("Stock")
			btn.modtype = mod
			btn.mod = -1
		end
		if LSC_Config.prices.mods[mod].startprice then
			local price = LSC_Config.prices.mods[mod].startprice
			for i = 0,   tonumber(GetNumVehicleMods(veh,mod)) -1 do
				local lbl = GetModTextLabel(veh,mod,i)
				if lbl ~= nil then
					local mname = tostring(GetLabelText(lbl))
					if mname ~= "NULL" then
						local btn = m:addPurchase(mname,math.floor(price+customsVat))
						btn.modtype = mod
						btn.mod = i
						price = price + LSC_Config.prices.mods[mod].increaseby
					end
				end
			end		
		else
			for n, v in pairs(LSC_Config.prices.mods[mod]) do
				btn = m:addPurchase(v.name,math.floor(v.price+customsVat))btn.modtype = mod
				btn.mod = v.mod
			end
		end
	end
end

local function SetupInsideCam()
	local ped = LocalPed()
	local coords = currentpos.camera
	cam = CreateCam("DEFAULT_SCRIPTED_CAMERA",true,2)
	SetCamCoord(cam, coords.x, coords.y, coords.z + 1.0)
	coords = currentpos.inside
	PointCamAtCoord(cam, coords.x, coords.y, coords.z)
	SetCamActive(cam, true)
	RenderScriptCams( 1, 0, cam, 0, 0)
end

local function DriveInGarage()
	TriggerServerEvent('lockGarage',true,currentgarage)
	SetPlayerControl(PlayerId(),false,256)

	local ped = LocalPed()
	local veh = GetVehiclePedIsUsing(ped)
	LSCMenu.buttons = {}

	DisplayRadar(false)
	if DoesEntityExist(veh) then
		--Set menu title
		if currentgarage == 4 or currentgarage == 5 then
			LSCMenu:setTitle("Beeker's Garage")
			LSCMenu.title_sprite = "shopui_title_carmod2"
		elseif currentgarage == 6 then
			LSCMenu:setTitle("Benny's Motorworks")
			LSCMenu.title_sprite = "shopui_title_supermod"
		else
			LSCMenu:setTitle("Los Santos Customs")
			LSCMenu.title_sprite = "shopui_title_carmod"
		end
		
		-------------------------------Load some settings-----------------------------------
		
		--Controls
		LSCMenu.config.controls = LSC_Config.menu.controls
		SetIbuttons({
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_back, 0),"Back"},
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_select, 0),"Select"},
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_up, 0),"Up"},
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_down, 0),"Down"},
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_left, 0),"Left"},
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_right, 0),"Right"},
		 },0)
		 
		 --Max buttons
		LSCMenu:setMaxButtons(LSC_Config.menu.maxbuttons)
		
		--Width, height of menu
		LSCMenu.config.size.width = f(LSC_Config.menu.width) or 0.24;
		LSCMenu.config.size.height = f(LSC_Config.menu.height) or 0.36;
		
		--Position
		if type(LSC_Config.menu.position) == 'table' then
			LSCMenu.config.position = { x = LSC_Config.menu.position.x, y = LSC_Config.menu.position.y}
		elseif type(LSC_Config.menu.position) == 'string' then
			if LSC_Config.menu.position == "left" then
				LSCMenu.config.position = { x = 0.16, y = 0.13}
			elseif  LSC_Config.menu.position == "right" then
				LSCMenu.config.position = { x = 1-0.16, y = 0.13}
			end
		end
		
		--Theme
		if type(LSC_Config.menu.theme) == "table" then
			LSCMenu:setColors(LSC_Config.menu.theme.text_color,LSC_Config.menu.theme.stext_color,LSC_Config.menu.theme.bg_color,LSC_Config.menu.theme.sbg_color)
		elseif	type(LSC_Config.menu.theme) == "string" then
			if LSC_Config.menu.theme == "light" then
				--text_color,stext_color,bg_color,sbg_color
				LSCMenu:setColors({ r = 255,g = 255, b = 255, a = 255},{ r = 0,g = 0, b = 0, a = 255},{ r = 0,g = 0, b = 0, a = 155},{ r = 255,g = 255, b = 255, a = 255})
			elseif LSC_Config.menu.theme == "darkred" then
				LSCMenu:setColors({ r = 255,g = 255, b = 255, a = 255},{ r = 0,g = 0, b = 0, a = 255},{ r = 0,g = 0, b = 0, a = 155},{ r = 200,g = 15, b = 15, a = 200})
			elseif LSC_Config.menu.theme == "bluish" then	
				LSCMenu:setColors({ r = 255,g = 255, b = 255, a = 255},{ r = 255,g = 255, b = 255, a = 255},{ r = 0,g = 0, b = 0, a = 100},{ r = 0,g = 100, b = 255, a = 200})
			elseif LSC_Config.menu.theme == "greenish" then	
				LSCMenu:setColors({ r = 255,g = 255, b = 255, a = 255},{ r = 0,g = 0, b = 0, a = 255},{ r = 0,g = 0, b = 0, a = 100},{ r = 0,g = 200, b = 0, a = 200})
			end
		end
		
		LSCMenu:addSubMenu("CATEGORIES", "categories",nil, false)
		LSCMenu.categories.buttons = {}
		--Calculate price for vehicle repair and add repair  button

		local maxvehhp = 1000
		local damage = 0 
		local enginedamage = 0
		local price = 0
		
		damage = (maxvehhp - GetVehicleBodyHealth(veh))/100
		enginedamage = (maxvehhp - GetVehicleEngineHealth(veh))
		if enginedamage < 900 then 
		 price = round(damage+enginedamage+customsVat,0)
		end

		LSCMenu:addPurchase("Repair Vehicle", price, "Full body repair and engine service.")
		
		--Setup table for vehicle with all mods, colors etc.
		SetVehicleModKit(veh,0)	
		myveh.vehicle = veh
		myveh.model = GetDisplayNameFromVehicleModel(GetEntityModel(veh)):lower()
		myveh.color =  table.pack(GetVehicleColours(veh))
		myveh.extracolor = table.pack(GetVehicleExtraColours(veh))
		myveh.neoncolor = table.pack(GetVehicleNeonLightsColour(veh))
		myveh.smokecolor = table.pack(GetVehicleTyreSmokeColor(veh))
		myveh.plateindex = GetVehicleNumberPlateTextIndex(veh)
		myveh.mods = {}
		for i = 0, 48 do
			myveh.mods[i] = {mod = nil}
		end
		for i,t in pairs(myveh.mods) do 
			if i == 22 or i == 18 then
				if IsToggleModOn(veh,i) then
				t.mod = 1
				else
				t.mod = 0
				end
			elseif i == 23 or i == 24 then
				t.mod = GetVehicleMod(veh,i)
				t.variation = GetVehicleModVariation(veh, i)
			else
				t.mod = GetVehicleMod(veh,i)
			end
		end
		if GetVehicleWindowTint(veh) == -1 or GetVehicleWindowTint(veh) == 0 then
			myveh.windowtint = false
		else
			myveh.windowtint = GetVehicleWindowTint(veh)
		end
		myveh.wheeltype = GetVehicleWheelType(veh)
		myveh.bulletProofTyres = GetVehicleTyresCanBurst(veh)
		
		--Menu stuff 
		local chassis,interior,bumper,fbumper,rbumper = false,false,false,false
		
		for i = 0,48 do
			if GetNumVehicleMods(veh,i) ~= nil and GetNumVehicleMods(veh,i) ~= false and GetNumVehicleMods(veh,i) > 0 then
				if i == 1 then
					bumper = true
					fbumper = true
				elseif i == 2 then
					bumper = true
					rbumper = true
				elseif (i >= 42 and i <= 46) or i == 5 then --If any chassis mod exist then add chassis menu
					chassis = true
				elseif i >= 27 and i <= 37 then --If any interior mod exist then add interior menu
					interior = true
				end
			end
		end
		
		AddMod(0,LSCMenu.categories,"SPOILER", "Spoiler", "Increase downforce.",true)
		AddMod(3,LSCMenu.categories,"SKIRTS", "Skirts", "Enhance your vehicle's look with custom side skirts.",true)
		AddMod(4,LSCMenu.categories,"EXHAUST", "Exhausts", "Customized sports exhausts.",true)
		AddMod(6,LSCMenu.categories,"GRILLE", "Grille", "Improved engine cooling.",true)
		AddMod(7,LSCMenu.categories,"HOOD", "Hood", "Enhance car engine cooling.",true)
		AddMod(8,LSCMenu.categories,"FENDERS", "Fenders", "Enhance body paneling with custom fenders.",true)
		AddMod(10,LSCMenu.categories,"ROOF", "Roof", "Lower your center of gravity with lightweight roof panels.",true)
		AddMod(12,LSCMenu.categories,"BRAKES", "Brakes", "Increase stopping power and eliminate brake fade.",true)
		AddMod(13,LSCMenu.categories,"TRANSMISSION", "Transmission", "Improved acceleration with close ratio transmission.",true)
		AddMod(14,LSCMenu.categories,"HORN", "Horn", "Custom air horns.",true)
		AddMod(15,LSCMenu.categories,"SUSPENSION","Suspension","Upgrade to a sports oriented suspension setup.",true)
		AddMod(16,LSCMenu.categories,"ARMOR","Armor","Protect your car's occupants with military spec composite body panels.",true)
		AddMod(18, LSCMenu.categories, "TURBO", "Turbo", "Reduced lag turbocharger.",false)
		
		if chassis then
			LSCMenu.categories:addSubMenu("CHASSIS", "Chassis",nil, true)
			AddMod(42, LSCMenu.categories.Chassis, "ARCH COVER", "Arch cover", "",true) --headlight trim
			AddMod(43, LSCMenu.categories.Chassis, "AERIALS", "Aerials", "",true) --foglights
			AddMod(44, LSCMenu.categories.Chassis, "ROOF SCOOPS", "Roof Scoops", "",true) --roof scoops
			AddMod(45, LSCMenu.categories.Chassis, "Tank", "Tank", "",true)
			AddMod(46, LSCMenu.categories.Chassis, "DOORS", "Doors", "",true)-- windows
			AddMod(5,LSCMenu.categories.Chassis,"ROLL CAGE", "Roll cage", "Stiffen your chassis with a rollcage.",true)
		end
		
		LSCMenu.categories:addSubMenu("ENGINE", "Engine",nil, true)
		AddMod(39, LSCMenu.categories.Engine, "ENGINE BLOCK", "Engine Block", "Custom engine block casings.",true)
		AddMod(40, LSCMenu.categories.Engine, "CAM COVER", "Cam Cover", "Optional cam covers.",true)
		AddMod(41, LSCMenu.categories.Engine, "STRUT BRACE", "Strut Brace", "A selection of support struts.",true)
		AddMod(11,LSCMenu.categories.Engine,"ENGINE TUNES", "Engine Tunes", "Increases horsepower.",true)
		
		if interior then
			LSCMenu.categories:addSubMenu("INTERIOR", "Interior","Products for maximum style and comfort.", true)
			AddMod(27, LSCMenu.categories.Interior, "TRIM DESIGN", "Trim Design", "",true)
			AddMod(28, LSCMenu.categories.Interior, "ORNAMENTS", "Ornaments", "Add decorative items to your dash.",true)
			AddMod(29, LSCMenu.categories.Interior, "DASHBOARD", "Dashboard", "Custom control panel designs.",true)
			AddMod(30, LSCMenu.categories.Interior, "DIAL DESIGN", "Dials", "Customize the look of your dials.",true)
			AddMod(31, LSCMenu.categories.Interior, "DOORS", "Doors", "Install door upgrades.",true)
			AddMod(32, LSCMenu.categories.Interior, "SEATS", "Seats", "Options where style meets comfort.",true)
			AddMod(33, LSCMenu.categories.Interior, "STEERING WHEELS", "Steering Wheels", "Customize the link between you and your vehicle.",true)
			AddMod(34, LSCMenu.categories.Interior, "Shifter leavers", "Shifter leavers", "",true)
			AddMod(35, LSCMenu.categories.Interior, "Plaques", "Plaques", "",true)
			AddMod(36, LSCMenu.categories.Interior, "Speakers", "Speakers", "",true)
			AddMod(37, LSCMenu.categories.Interior, "Trunk", "Trunk", "",true)
		end
		
		LSCMenu.categories:addSubMenu("PLATES", "Plates","Decorative identification.", true)
		LSCMenu.categories.Plates:addSubMenu("LICENSE", "License", "",true)
		for n, mod in pairs(LSC_Config.prices.plates) do
			local btn = LSCMenu.categories.Plates.License:addPurchase(mod.name,math.floor(mod.price+customsVat))btn.plateindex = mod.plateindex
		end
		--Customize license plates
		AddMod(25, LSCMenu.categories.Plates, "Plate holder", "Plate holder", "",true) --
		AddMod(26, LSCMenu.categories.Plates, "Vanity plates", "Vanity plates", "",true) --
		AddMod(38,LSCMenu.categories,"HYDRAULICS","Hydraulics","",true)
		AddMod(48,LSCMenu.categories,"Liveries", "Liveries", "A selection of decals for your vehicle.",true)
		
		if bumper then
			LSCMenu.categories:addSubMenu("BUMPERS", "Bumpers", "Custom front and rear bumpers.",true)
			if fbumper then
				AddMod(1,LSCMenu.categories.Bumpers,"FRONT BUMPERS", "Front bumpers", "Custom front bumpers.",true)
			end
			if rbumper then
				AddMod(2,LSCMenu.categories.Bumpers,"REAR BUMPERS", "Rear bumpers", "Custom rear bumpers.",true)
			end
		end
		
		local m = LSCMenu.categories:addSubMenu("LIGHTS", "Lights", "Improved night time visibility.",true)
		AddMod(22,LSCMenu.categories.Lights,"HEADLIGHTS", "Headlights", nil, false)
		if not IsThisModelABike(GetEntityModel(veh)) then
			m = m:addSubMenu("NEON KITS", "Neon kits", nil, true)
				m:addSubMenu("NEON LAYOUT", "Neon layout", nil, true)
					local btn = m["Neon layout"]:addPurchase("None")
					for n, mod in pairs(LSC_Config.prices.neonlayout) do
						local btn = m["Neon layout"]:addPurchase(mod.name,math.floor(mod.price+customsVat))
					end
			
			m = m:addSubMenu("NEON COLOR", "Neon color", nil, true)
				for n, mod in pairs(LSC_Config.prices.neoncolor) do
					local btn = m:addPurchase(mod.name,math.floor(mod.price+customsVat))btn.neon = mod.neon
				end
		end

		
		respray = LSCMenu.categories:addSubMenu("RESPRAY", "Respray", "Transforms vehicle appearance.",true)
			pcol = respray:addSubMenu("PRIMARY COLORS", "Primary color",  nil,true)
				pcol:addSubMenu("CHROME", "Chrome", nil,true)
				for n, c in pairs(LSC_Config.prices.chrome.colors) do
					local btn = pcol.Chrome:addPurchase(c.name,math.floor(LSC_Config.prices.chrome.price+customsVat))btn.colorindex = c.colorindex
					if btn.colorindex == myveh.color[1] then
						btn.purchased = true
					end
				end
				pcol:addSubMenu("CLASSIC", "Classic", nil,true)
				for n, c in pairs(LSC_Config.prices.classic.colors) do
					local btn = pcol.Classic:addPurchase(c.name,math.floor(LSC_Config.prices.classic.price+customsVat))btn.colorindex = c.colorindex
					if btn.colorindex == myveh.color[1] then
						btn.purchased = true
					end
				end
				pcol:addSubMenu("MATTE", "Matte", nil,true)
				for n, c in pairs(LSC_Config.prices.matte.colors) do
					local btn = pcol.Matte:addPurchase(c.name,math.floor(LSC_Config.prices.matte.price+customsVat))btn.colorindex = c.colorindex
					if btn.colorindex == myveh.color[1] then
						btn.purchased = true
					end
				end
				pcol:addSubMenu("METALLIC", "Metallic", nil,true)
				for n, c in pairs(LSC_Config.prices.metallic.colors) do
					local btn = pcol.Metallic:addPurchase(c.name,math.floor(LSC_Config.prices.metallic.price+customsVat))btn.colorindex = c.colorindex
					if btn.colorindex == myveh.color[1] and myveh.extracolor[1] == myveh.color[2] then
						btn.purchased = true
					end
				end
				pcol:addSubMenu("METALS", "Metals", nil,true)
				for n, c in pairs(LSC_Config.prices.metal.colors) do
					local btn = pcol.Metals:addPurchase(c.name,math.floor(LSC_Config.prices.metal.price+customsVat))btn.colorindex = c.colorindex
					if btn.colorindex == myveh.color[1] then
						btn.purchased = true
					end
				end
			scol = respray:addSubMenu("SECONDARY COLORS", "Secondary color", nil,true)
				scol:addSubMenu("CHROME", "Chrome", nil,true)
				for n, c in pairs(LSC_Config.prices.chrome2.colors) do
					local btn = scol.Chrome:addPurchase(c.name,math.floor(LSC_Config.prices.chrome2.price+customsVat))btn.colorindex = c.colorindex
					if btn.colorindex == myveh.color[2] then
						btn.purchased = true
					end
				end
				scol:addSubMenu("CLASSIC", "Classic", nil,true)
				for n, c in pairs(LSC_Config.prices.classic2.colors) do
					local btn = scol.Classic:addPurchase(c.name,math.floor(LSC_Config.prices.classic2.price+customsVat))btn.colorindex = c.colorindex
					if btn.colorindex == myveh.color[2] then
						btn.purchased = true
					end
				end
				scol:addSubMenu("MATTE", "Matte", nil,true)
				for n, c in pairs(LSC_Config.prices.chrome2.colors) do
					local btn = scol.Matte:addPurchase(c.name,LSC_Config.prices.matte2.price)btn.colorindex = c.colorindex
					if btn.colorindex == myveh.color[2] then
						btn.purchased = true
					end
				end
				scol:addSubMenu("METALLIC", "Metallic", nil,true)
				for n, c in pairs(LSC_Config.prices.metallic2.colors) do
					local btn = scol.Metallic:addPurchase(c.name,LSC_Config.prices.metallic2.price)btn.colorindex = c.colorindex
					if btn.colorindex == myveh.color[2] and myveh.extracolor[1] == btn.colorindex then
						btn.purchased = true
					end
				end
				scol:addSubMenu("METALS", "Metals", nil,true)
				for n, c in pairs(LSC_Config.prices.metal2.colors) do
					local btn = scol.Metals:addPurchase(c.name,LSC_Config.prices.metal2.price)btn.colorindex = c.colorindex
					if btn.colorindex == myveh.color[2] then
						btn.purchased = true
					end
				end
		
		
		LSCMenu.categories:addSubMenu("WHEELS", "Wheels", "Custom rims, tires and colors.",true)
			wtype = LSCMenu.categories.Wheels:addSubMenu("WHEEL TYPE", "Wheel type", "Custom rims in all styles and sizes.",true)
				if IsThisModelABike(GetEntityModel(veh)) then
					fwheels = wtype:addSubMenu("FRONT WHEEL", "Front wheel", nil,true)
						for n, w in pairs(LSC_Config.prices.frontwheel) do
							btn = fwheels:addPurchase(w.name,math.floor(w.price+customsVat))btn.wtype = w.wtype btn.modtype = 23 btn.mod = w.mod
						end
					bwheels = wtype:addSubMenu("BACK WHEEL", "Back wheel", nil,true)
						for n, w in pairs(LSC_Config.prices.backwheel) do
							btn = bwheels:addPurchase(w.name,math.floor(w.price+customsVat))btn.wtype = w.wtype btn.modtype = 24 btn.mod = w.mod
						end
				else
					sportw = wtype:addSubMenu("SPORT WHEELS", "Sport", nil,true)
						for n, w in pairs(LSC_Config.prices.sportwheels) do
							local btn = sportw:addPurchase(w.name,math.floor(w.price+customsVat))btn.wtype = w.wtype btn.modtype = 23 btn.mod = w.mod
						end
					musclew = wtype:addSubMenu("MUSCLE WHEELS", "Muscle", nil,true)
						for n, w in pairs(LSC_Config.prices.musclewheels) do
							local btn = musclew:addPurchase(w.name,math.floor(w.price+customsVat))btn.wtype =  w.wtype btn.modtype = 23 btn.mod = w.mod
						end
					lowriderw = wtype:addSubMenu("LOWRIDER WHEELS", "Lowrider", nil,true)
						for n, w in pairs(LSC_Config.prices.lowriderwheels) do
							local btn = lowriderw:addPurchase(w.name,math.floor(w.price+customsVat))btn.wtype =  w.wtype btn.modtype = 23 btn.mod = w.mod
						end
					suvw = wtype:addSubMenu("SUV WHEELS", "Suv", nil,true)
						for n, w in pairs(LSC_Config.prices.suvwheels) do
							local btn = suvw:addPurchase(w.name,math.floor(w.price+customsVat))btn.wtype = w.wtype btn.modtype = 23 btn.mod = w.mod
						end
					offroadw = wtype:addSubMenu("OFFROAD WHEELS", "Offroad", nil,true)
						for n, w in pairs(LSC_Config.prices.offroadwheels) do
							local btn = offroadw:addPurchase(w.name,math.floor(w.price+customsVat))btn.wtype = w.wtype btn.modtype = 23 btn.mod = w.mod
						end
					tunerw = wtype:addSubMenu("TUNER WHEELS", "Tuner", nil,true)
						for n, w in pairs(LSC_Config.prices.tunerwheels) do
							local btn = tunerw:addPurchase(w.name,math.floor(w.price+customsVat))btn.wtype = w.wtype btn.modtype = 23 btn.mod = w.mod
						end
					hughendw = wtype:addSubMenu("HIGHEND WHEELS", "Highend", nil,true)
						for n, w in pairs(LSC_Config.prices.highendwheels) do
							local btn = hughendw:addPurchase(w.name,math.floor(w.price+customsVat))btn.wtype = w.wtype btn.modtype = 23 btn.mod = w.mod
						end
				end
					
		m = LSCMenu.categories.Wheels:addSubMenu("WHEEL COLOR", "Wheel color", "Custom wheel colors.",true)
			for n, c in pairs(LSC_Config.prices.wheelcolor.colors) do
				local btn = m:addPurchase(c.name,math.floor(LSC_Config.prices.wheelcolor.price+customsVat))btn.colorindex = c.colorindex
			end
		
		m = LSCMenu.categories.Wheels:addSubMenu("WHEEL ACCESSORIES", "Wheel accessories", "Bulletproof tires and custom burnout smoke.",true)
			for n, mod in pairs(LSC_Config.prices.wheelaccessories) do
				local btn = m:addPurchase(mod.name,math.floor(mod.price+customsVat))btn.smokecolor = mod.smokecolor
			end
		
		m = LSCMenu.categories:addSubMenu("WINDOWS", "Windows", "A selection of tinted windows.",true)	
			btn = m:addPurchase("None")btn.tint = false
			for n, tint in pairs(LSC_Config.prices.windowtint) do
				btn = m:addPurchase(tint.name,math.floor(tint.price+customsVat))btn.tint = tint.tint
			end
		Citizen.CreateThread(function()
			SetCamCoord(cam,GetGameplayCamCoords())
			SetCamRot(cam, GetGameplayCamRot(2), 2)
			RenderScriptCams( 1, 1, 0, 0, 0)
			RenderScriptCams( 0, 1, 1000, 0, 0)
			SetCamActive(gameplaycam, true)
			EnableGameplayCam(true)
			SetCamActive(cam, false)
			LSCMenu:Open("main")
			SetupInsideCam()
			FreezeEntityPosition(veh, true)
			SetEntityCollision(veh,false,false)
			SetPlayerControl(PlayerId(),true)
		end)
	end
end

local function DriveOutOfGarage(pos)
 local ped = LocalPed()
 local veh = GetVehiclePedIsUsing(ped)
 Citizen.CreateThread(function()
  inside = false
  TriggerServerEvent('lockGarage',false,currentgarage)
  currentgarage = 0
  garageID = 0
  DisplayRadar(true)
  SetPlayerControl(PlayerId(),true)
  SetCamActive(cam, false)
  DestroyCam(cam, true)
  SetEntityCollision(veh,true,true)
  FreezeEntityPosition(ped, false)
  FreezeEntityPosition(veh, false)
  SetPlayerInvincible(GetPlayerIndex(),false)
  SetEntityInvincible(veh,false)
  SetEntityHeading(veh, GetEntityHeading(veh)-180)
  plate = GetVehicleNumberPlateText(veh)
  vehProps = GetVehProps(veh)
  TriggerServerEvent("LSC:finished", plate, vehProps)
 end)
end

--Get the length of table
local function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

--Check if table contains value
local function tableContains(t,val)
	for k,v in pairs(t) do
		if v == val then
			return true
		end
	end
	return false
end

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(5)
   if inside == false then
    local ped = LocalPed()
    if IsPedSittingInAnyVehicle(ped) then
     local veh = GetVehiclePedIsUsing(ped)
     if DoesEntityExist(veh) and GetPedInVehicleSeat(veh, -1) == ped and (IsThisModelACar(GetEntityModel(veh)) or IsThisModelABike(GetEntityModel(veh))) then
      for i,pos in ipairs(garages) do
	   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), pos.inside.x,pos.inside.y,pos.inside.z, true) < 5) then
		if exports['clrp_garage']:HasKey(GetVehicleNumberPlateText(veh)) then
		 if not pos.locked then
		  if IsControlJustPressed(1,201) then
		   Wait(100)
           inside = true
           currentpos = pos
           currentgarage = i
           garageID = i
           if ownedCustoms[pos.id] then 
            customsVat = ownedCustoms[pos.id].vat
           end
           DriveInGarage()
          else
           drawTxt("~b~Press ~b~ENTER~b~ To Enter ~b~Los Santos Customs")
          end
         else
          drawTxt("~r~Locked, Please Wait")
         end
        else
         drawTxt("~r~This Vehicle Can't Be Upgraded")
        end
      end
     end
    end
   end
  end
 end
end)

--Lets drive out of the garage 
function LSCMenu:OnMenuClose(m)
 DriveOutOfGarage(currentpos.inside)
 while IsCamActive(cam) do 
  Citizen.Wait(1)
  print('camera')
  RenderScriptCams(0, 0, cam, 0, 0)
  SetCamActive(cam, false)
  DestroyCam(cam, true)
 end
end

function LSCMenu:onSelectedIndexChanged(name, button)
	name = name:lower()
	local m = LSCMenu.currentmenu
	local price = button.price or 0
	local veh = myveh.vehicle
	p = m.parent or self.name
	if m == "main" then
		m = self
	end
	CheckPurchases(m)
	m = m.name:lower()
	p = p:lower()
	if m == "chrome" or m ==  "classic" or m ==  "matte" or m ==  "metals" then
		if p == "primary color" then
			SetVehicleColours(veh,button.colorindex,myveh.color[2])
		else
			SetVehicleColours(veh,myveh.color[1],button.colorindex)	
		end
		
	elseif m == "metallic" then
		if p == "primary color" then
			SetVehicleColours(veh,button.colorindex,myveh.color[2])
			SetVehicleExtraColours(veh, myveh.color[2], myveh.extracolor[2])
		else
			SetVehicleColours(veh,myveh.color[1],button.colorindex)
			SetVehicleExtraColours(veh, button.colorindex, myveh.extracolor[2])				
		end
	elseif m == "wheel color" then
		SetVehicleExtraColours(veh,myveh.extracolor[1], button.colorindex)
	elseif button.modtype and button.mod then
		if button.modtype ~= 18 and button.modtype ~= 22 then
			if button.wtype then
				SetVehicleWheelType(veh,button.wtype)
			end
			SetVehicleMod(veh,button.modtype, button.mod)	
		elseif button.modtype == 22 then
			ToggleVehicleMod(veh,button.modtype, button.mod)
		elseif button.modtype == 18 then
		end
	elseif m == "license" then
		SetVehicleNumberPlateTextIndex(veh,button.plateindex)
	elseif m == "neon color" then
		SetVehicleNeonLightsColour(veh,button.neon[1], button.neon[2], button.neon[3])
	elseif m == "windows" then
		SetVehicleWindowTint(veh, button.tint)
	else
	end
	if m == "horn" then
		--Maybe some way of playing the horn?
		OverrideVehHorn(veh,false,0)
		if IsHornActive(veh) or IsControlPressed(1,86) then
			StartVehicleHorn(veh, 10000, "HELDDOWN", 1)
		end
	end
end

function LSCMenu:OnMenuOpen(menu)
end

function LSCMenu:onButtonSelected(name, button)
	TriggerServerEvent("LSC:buttonSelected", name, button, garageID)
end

RegisterNetEvent("LSC:buttonSelected")
AddEventHandler("LSC:buttonSelected", function(name, button, canpurchase)
	name = name:lower()
	local m = LSCMenu.currentmenu
	local price = button.price or 0
	local veh = myveh.vehicle
	if m == "main" then
		m = LSCMenu
	end
	
	mname = m.name:lower()
	--Bunch of button shitt, that gets executed if button is selected + goes through checks
	if mname == "chrome" or mname ==  "classic" or mname ==  "matte" or mname ==  "metals" then
		if m.parent == "Primary color" then
			if button.name == "Stock" or button.purchased or CanPurchase(price, canpurchase) then
				myveh.color[1] = button.colorindex
			end
		else
			if button.name == "Stock" or button.purchased or CanPurchase(price, canpurchase) then
				myveh.color[2] = button.colorindex
			end
		end
	elseif mname == "metallic" then
		if m.parent == "Primary color" then
			if button.name == "Stock" or button.purchased or CanPurchase(price, canpurchase)then
				myveh.color[1] = button.colorindex
				myveh.extracolor[1] = myveh.color[2]
			end
		else
			if button.name == "Stock" or button.purchased or CanPurchase(price, canpurchase)then
				myveh.extracolor[1] = button.colorindex
				myveh.color[2] = button.colorindex
			end
		end	
	elseif mname == "liveries" or mname == "hydraulics" or mname == "horn" or mname == "tank" or mname == "ornaments" or  mname == "arch cover" or mname == "aerials" or mname == "roof scoops" or mname == "doors" or mname == "roll cage" or mname == "engine block" or mname == "cam cover" or mname == "strut brace" or mname == "trim design" or mname == "ormnametns" or mname == "dashboard" or mname == "dials" or mname == "seats" or mname == "steering wheels" or mname == "plate holder" or mname == "vanity plates" or mname == "shifter leavers" or mname == "plaques" or mname == "speakers" or mname == "trunk" or mname == "armor" or mname == "suspension" or mname == "transmission" or mname == "brakes" or mname == "engine tunes" or mname == "roof" or mname == "hood" or mname == "grille" or mname == "roll cage" or mname == "exhausts" or mname == "skirts" or mname == "rear bumpers" or mname == "front bumpers" or mname == "spoiler" then
		if button.name == "Stock" or button.purchased or CanPurchase(price, canpurchase)then
			myveh.mods[button.modtype].mod = button.mod
			SetVehicleMod(veh,button.modtype,button.mod)
		end
	elseif mname == "fenders" then
		if button.name == "Stock" or button.purchased or CanPurchase(price, canpurchase)then
			if button.name == "Stock" then
				myveh.mods[8].mod = button.mod
				myveh.mods[9].mod = button.mod
				SetVehicleMod(veh,9,button.mod)
				SetVehicleMod(veh,8,button.mod)
			else
				myveh.mods[button.modtype].mod = button.mod
				SetVehicleMod(veh,button.modtype,button.mod)
			end
		end
	elseif mname == "turbo" or mname == "headlights" then
		if button.name == "None" or button.name == "Stock Lights" or button.purchased or CanPurchase(price, canpurchase) then
			myveh.mods[button.modtype].mod = button.mod
			ToggleVehicleMod(veh, button.modtype, button.mod)
		end
	elseif mname == "neon layout" then
		if button.name == "None"  then
			SetVehicleNeonLightEnabled(veh,0,false)
			SetVehicleNeonLightEnabled(veh,1,false)
			SetVehicleNeonLightEnabled(veh,2,false)
			SetVehicleNeonLightEnabled(veh,3,false)
			myveh.neoncolor[1] = 255
			myveh.neoncolor[2] = 255
			myveh.neoncolor[3] = 255
			SetVehicleNeonLightsColour(veh,255,255,255)
		elseif button.purchased or CanPurchase(price, canpurchase) then
			if not myveh.neoncolor[1] then
				myveh.neoncolor[1] = 255
				myveh.neoncolor[2] = 255
				myveh.neoncolor[3] = 255
			end
			SetVehicleNeonLightsColour(veh,myveh.neoncolor[1],myveh.neoncolor[2],myveh.neoncolor[3])
			SetVehicleNeonLightEnabled(veh,0,true)
			SetVehicleNeonLightEnabled(veh,1,true)
			SetVehicleNeonLightEnabled(veh,2,true)
			SetVehicleNeonLightEnabled(veh,3,true)
		end
	elseif mname == "neon color" then
		if button.purchased or CanPurchase(price, canpurchase) then
			myveh.neoncolor[1] = button.neon[1]
			myveh.neoncolor[2] = button.neon[2]
			myveh.neoncolor[3] = button.neon[3]
			SetVehicleNeonLightsColour(veh,button.neon[1],button.neon[2],button.neon[3])
		end
	elseif mname == "windows" then
		if button.name == "None" or button.purchased or CanPurchase(price, canpurchase) then
			myveh.windowtint = button.tint
			SetVehicleWindowTint(veh, button.tint)
		end
	elseif mname == "sport" or mname == "muscle" or mname == "lowrider" or mname == "back wheel" or mname == "front wheel" or mname == "highend" or mname == "suv" or mname == "offroad" or mname == "tuner" then
		if button.purchased or CanPurchase(price, canpurchase) then
			myveh.wheeltype = button.wtype
			myveh.mods[button.modtype].mod = button.mod
			SetVehicleWheelType(veh,button.wtype)
			SetVehicleMod(veh,button.modtype,button.mod)
		end
	elseif mname == "wheel color" then
		if button.purchased or CanPurchase(price, canpurchase) then
			myveh.extracolor[2] = button.colorindex
			SetVehicleExtraColours(veh, myveh.extracolor[1], button.colorindex)
		end
	elseif mname == "wheel accessories" then
		if button.name == "Stock Tires" then
			SetVehicleModKit(veh,0)
			SetVehicleMod(veh,23,myveh.mods[23].mod,false)
			myveh.mods[23].variation = false
			if IsThisModelABike(GetEntityModel(veh)) then
				SetVehicleModKit(veh,0)
				SetVehicleMod(veh,24,myveh.mods[24].mod,false)
				myveh.mods[24].variation = false
			end
		elseif button.name == "Custom Tires" and  (button.purchased or CanPurchase(price, canpurchase)) then
			SetVehicleModKit(veh,0)
			SetVehicleMod(veh,23,myveh.mods[23].mod,true)
			myveh.mods[23].variation = true
			if IsThisModelABike(GetEntityModel(veh)) then
				SetVehicleModKit(veh,0)
				SetVehicleMod(veh,24,myveh.mods[24].mod,true)
				myveh.mods[24].variation = true
			end
		elseif button.name == "Bulletproof Tires" and  (button.purchased or CanPurchase(price, canpurchase)) then
			if GetVehicleTyresCanBurst(myveh.vehicle) then
				myveh.bulletProofTyres = false
				SetVehicleTyresCanBurst(veh,false)
			else
				myveh.bulletProofTyres = true
				SetVehicleTyresCanBurst(veh,true)
			end
		elseif button.smokecolor ~= nil  and  (button.purchased or CanPurchase(price, canpurchase)) then
			SetVehicleModKit(veh,0)
			myveh.mods[20].mod = true
			ToggleVehicleMod(veh,20,true)
			myveh.smokecolor = button.smokecolor
			SetVehicleTyreSmokeColor(veh,button.smokecolor[1],button.smokecolor[2],button.smokecolor[3])
		end
	elseif mname == "license" then
		if button.purchased or CanPurchase(price, canpurchase) then
			myveh.plateindex = button.plateindex
			SetVehicleNumberPlateTextIndex(veh,button.plateindex)
		end
	elseif mname == "main" then
		if name == "repair vehicle" then
			if CanPurchase(price, canpurchase) then 
				myveh.repair()
				LSCMenu:ChangeMenu("categories")
			end
		end
	end
	CheckPurchases(m)
end)

local function PointCamAtBone(bone,ox,oy,oz)
	SetIbuttons({
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_back, 0),"Back"},
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_select, 0),"Select"},
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_up, 0),"Up"},
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_down, 0),"Down"},
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_left, 0),"Left"},
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_right, 0),"Right"},
			{GetControlInstructionalButton(1,0, 0),"Free camera"}
	 },0)
	SetCamActive(cam, true)
	local veh = myveh.vehicle
	local b = GetEntityBoneIndexByName(veh, bone)
	local bx,by,bz = table.unpack(GetWorldPositionOfEntityBone(veh, b))
	local ox2,oy2,oz2 = table.unpack(GetOffsetFromEntityGivenWorldCoords(veh, bx, by, bz))
	local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(veh, ox2 + f(ox), oy2 + f(oy), oz2 +f(oz)))
	SetCamCoord(cam, x, y, z)
	PointCamAtCoord(cam,GetOffsetFromEntityInWorldCoords(veh, 0, oy2, oz2))
	RenderScriptCams( 1, 1, 1000, 0, 0)
end

local function MoveVehCam(pos,x,y,z)
	SetIbuttons({
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_back, 0),"Back"},
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_select, 0),"Select"},
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_up, 0),"Up"},
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_down, 0),"Down"},
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_left, 0),"Left"},
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_right, 0),"Right"},
			{GetControlInstructionalButton(1,0, 0),"Free camera"}
	 },0)
	SetCamActive(cam, true)
	local veh = myveh.vehicle
	local vx,vy,vz = table.unpack(GetEntityCoords(veh))
	local d = GetModelDimensions(GetEntityModel(veh))
	local length,width,height = d.y*-2, d.x*-2, d.z*-2
	local ox,oy,oz
	if pos == 'front' then
		ox,oy,oz= table.unpack(GetOffsetFromEntityInWorldCoords(veh, f(x), (length/2)+ f(y), f(z)))
	elseif pos == "front-top" then
		ox,oy,oz= table.unpack(GetOffsetFromEntityInWorldCoords(veh, f(x), (length/2) + f(y),(height) + f(z)))
	elseif pos == "back" then
		ox,oy,oz= table.unpack(GetOffsetFromEntityInWorldCoords(veh, f(x), -(length/2) + f(y),f(z)))
	elseif pos == "back-top" then
		ox,oy,oz= table.unpack(GetOffsetFromEntityInWorldCoords(veh, f(x), -(length/2) + f(y),(height/2) + f(z)))
	elseif pos == "left" then
		ox,oy,oz= table.unpack(GetOffsetFromEntityInWorldCoords(veh, -(width/2) + f(x), f(y), f(z)))
	elseif pos == "right" then
		ox,oy,oz= table.unpack(GetOffsetFromEntityInWorldCoords(veh, (width/2) + f(x), f(y), f(z)))
	elseif pos == "middle" then
		ox,oy,oz= table.unpack(GetOffsetFromEntityInWorldCoords(veh, f(x), f(y), (height/2) + f(z)))
	end
	SetCamCoord(cam, ox, oy, oz)
	PointCamAtCoord(cam,GetOffsetFromEntityInWorldCoords(veh, 0, 0, f(0)))
	RenderScriptCams( 1, 1, 1000, 0, 0)
end

function LSCMenu:OnMenuChange(last,current)
	UnfakeVeh()
	if last == "main" then
		last = self
	end
	if last.name == "categories" and current.name == "main" then
		LSCMenu:Close()
	end	
	c = current.name:lower()
	if c == "front bumpers" then
		MoveVehCam('front',-0.6,1.5,0.4)
	elseif  c == "rear bumpers" then
		MoveVehCam('back',-0.5,-1.5,0.2)
	elseif c == "Engine Tunes" then
	elseif c == "exhausts" then
	elseif c == "hood" then
		MoveVehCam('front-top',-0.5,1.3,1.0)
	elseif c == "headlights" then
		MoveVehCam('front',-0.6,1.3,0.6)
	elseif c == "license" or c == "plate holder" then
		MoveVehCam('back',0,-1,0.2)
	elseif c == "vanity plates" then
		MoveVehCam('front',-0.3,0.8,0.3)
	elseif c == "roof" then
	elseif c == "fenders" then
		MoveVehCam('left',-1.8,-1.3,0.7)
	elseif c == "grille" then
	elseif c == "skirts" then
		MoveVehCam('left',-1.8,-1.3,0.7)
	elseif c == "spoiler" then
		MoveVehCam('back',0.5,-1.6,1.3)
	elseif c == "back wheel" then
		PointCamAtBone("wheel_lr",-1.4,0,0.3)
	elseif c == "front wheel" or c == "wheel accessories" or  c == "wheel color" or c == "sport" or c == "muscle" or c == "lowrider"  or c == "highend" or c == "suv" or c == "offroad" or c == "tuner" then
		PointCamAtBone("wheel_lf",-1.4,0,0.3)
	elseif c == "neon color" then
		PointCamAtBone("neon_l",-2.0,2.0,0.4)
	elseif c == "shifter leavers" or c == "trim design" or c == "ornaments" or c == "dashboard" or c == "dials" or c == "seats" or c =="steering wheels" then
		SetFollowVehicleCamViewMode(4)
	elseif c == "doors" and last.name:lower() == "interior" then
		SetVehicleDoorOpen(myveh.vehicle, 0, 0, 0)
		SetVehicleDoorOpen(myveh.vehicle, 1, 0, 0)
	elseif c == "trunk" then
		SetVehicleDoorOpen(myveh.vehicle, 5, 0, 0)
	elseif c == "speakers" or  c == "engine block" or c == "air filter" or c == "strut brace" or c == "cam cover" then
		SetVehicleDoorOpen(myveh.vehicle, 5, 0, 0)
		SetVehicleDoorOpen(myveh.vehicle, 4, 0, 0)
	elseif IsCamActive(cam) then
		SetCamCoord(cam,GetGameplayCamCoords())
		SetCamRot(cam, GetGameplayCamRot(2), 2)
		RenderScriptCams( 1, 1, 0, 0, 0)
		RenderScriptCams( 0, 1, 1000, 0, 0)
		SetCamActive(gameplaycam, true)
		EnableGameplayCam(true)
		SetCamActive(cam, false)
		SetIbuttons({
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_back, 0),"Back"},
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_select, 0),"Select"},
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_up, 0),"Up"},
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_down, 0),"Down"},
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_left, 0),"Left"},
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_right, 0),"Right"}
		},0)
	else
		SetVehicleDoorShut(myveh.vehicle, 0, 0)
		SetVehicleDoorShut(myveh.vehicle, 1, 0)
		SetVehicleDoorShut(myveh.vehicle, 4, 0)
		SetVehicleDoorShut(myveh.vehicle, 5, 0)
		SetFollowVehicleCamViewMode(0)
	end
end

function CheckPurchases(m)
	name = m.name:lower()
	if name == "chrome" or name ==  "classic" or name ==  "matte" or name ==  "metals" then
		if m.parent == "Primary color" then
			for i,b in pairs(m.buttons) do
				if b.purchased and b.colorindex ~= myveh.color[1] then
					if b.purchased ~= nil then b.purchased = false end
					b.sprite = nil
				elseif b.purchased == false and b.colorindex == myveh.color[1] then
					if b.purchased ~= nil then b.purchased = true end
					b.sprite = "garage"
				end
			end
		else
			for i,b in pairs(m.buttons) do
				if b.purchased and (b.colorindex ~= myveh.color[1] or myveh.extracolor[1] ~= myveh.color[2]) then
					if b.purchased ~= nil then b.purchased = false end
					b.sprite = nil
				elseif b.purchased == false and b.colorindex == myveh.color[1] and myveh.extracolor[1] == myveh.color[2] then
					if b.purchased ~= nil then b.purchased = true end
					b.sprite = "garage"
				end
			end
		end
	elseif name == "metallic" then
		if m.parent == "Primary color" then
			for i,b in pairs(m.buttons) do
				if b.purchased and b.colorindex ~= myveh.color[1] then
					if b.purchased ~= nil then b.purchased = false end
					b.sprite = nil
				elseif b.purchased == false and b.colorindex == myveh.color[1] then
					if b.purchased ~= nil then b.purchased = true end
					b.sprite = "garage"
				end
			end
		else
			for i,b in pairs(m.buttons) do
				if b.purchased and (b.colorindex ~= myveh.color[2] or myveh.extracolor[1] ~= b.colorindex) then
					if b.purchased ~= nil then b.purchased = false end
					b.sprite = nil
				elseif b.purchased == false and b.colorindex == myveh.color[2] and myveh.extracolor[1] == b.colorindex then
					if b.purchased ~= nil then b.purchased = true end
					b.sprite = "garage"
				end
			end
		end
	elseif name == "armor" or name == "suspension" or name == "transmission" or name == "brakes" or name == "engine tunes" or name == "roof" or name == "fenders" or name == "hood" or name == "grille" or name == "roll cage" or name == "exhausts" or name == "skirts" or name == "rear bumpers" or name == "front bumpers" or name == "spoiler" then
		for i,b in pairs(m.buttons) do
			if b.mod == -1  then
				if myveh.mods[b.modtype].mod == -1 then
					if b.purchased ~= nil then b.purchased = true end
					b.sprite = "garage"
				else
					if b.purchased ~= nil then b.purchased = false end
					b.sprite = nil
				end
			elseif b.mod == 0 or b.mod == false then
				if myveh.mods[b.modtype].mod == false or myveh.mods[b.modtype].mod == 0 then
					if b.purchased ~= nil then b.purchased = true end
					b.sprite = "garage"
				else
					if b.purchased ~= nil then b.purchased = false end
					b.sprite = nil
				end
			else
				if myveh.mods[b.modtype].mod == b.mod then
					if b.purchased ~= nil then b.purchased = true end
					b.sprite = "garage"
				else
					if b.purchased ~= nil then b.purchased = false end
					b.sprite = nil
				end
			end
		end
	elseif name == "neon layout" then
		for i,b in pairs(m.buttons) do
			if b.name == "None" then
				if IsVehicleNeonLightEnabled(myveh.vehicle, 0) == false and IsVehicleNeonLightEnabled(myveh.vehicle, 1) == false  and IsVehicleNeonLightEnabled(myveh.vehicle, 2) == false and IsVehicleNeonLightEnabled(myveh.vehicle, 3) == false then
					b.sprite = "garage"
				else
					b.sprite =  nil
				end
			elseif b.name == "Front,Back and Sides" then
				if IsVehicleNeonLightEnabled(myveh.vehicle, 0)  and IsVehicleNeonLightEnabled(myveh.vehicle, 1)  and IsVehicleNeonLightEnabled(myveh.vehicle, 2)  and IsVehicleNeonLightEnabled(myveh.vehicle, 3)  then
					b.sprite = "garage"
				else
					b.sprite =  nil
				end
			end		
		end
	elseif name == "neon color" then
		for i,b in pairs(m.buttons) do
			if b.neon[1] == myveh.neoncolor[1] and b.neon[2] == myveh.neoncolor[2] and b.neon[3] == myveh.neoncolor[3] then
				b.sprite = "garage"
			else
				b.sprite = nil
			end
		end
	elseif name == "windows" then
		for i,b in pairs(m.buttons) do
			if myveh.windowtint == b.tint then
				b.sprite = "garage"
			else
				b.sprite = nil
			end
		end
	elseif name == "sport" or name == "muscle" or name == "lowrider" or name == "back wheel" or name == "front wheel" or name == "highend" or name == "suv" or name == "offroad" or name == "tuner" then
		for i,b in pairs(m.buttons) do
			if myveh.mods[b.modtype].mod == b.mod and myveh.wheeltype == b.wtype then
				b.sprite = "garage"
			else
				b.sprite = nil
			end
		end
	elseif name == "wheel color" then
		for i,b in pairs(m.buttons) do
			if b.colorindex == myveh.extracolor[2] then
				b.sprite = "garage"
			else
				b.sprite = nil
			end
		end
	elseif name == "wheel accessories" then
		for i,b in pairs(m.buttons) do
			if b.name == "Stock Tires" then
				if GetVehicleModVariation(myveh.vehicle,23) == false then
					b.sprite = "garage"
				else
					b.sprite = nil
				end
			elseif b.name == "Custom Tires" then
				if GetVehicleModVariation(myveh.vehicle,23) then
					b.sprite = "garage"
				else
					b.sprite = nil
				end
			elseif b.name == "Bulletproof Tires" then
				if GetVehicleTyresCanBurst(myveh.vehicle) == false then
					b.sprite = "garage"
				else
					b.sprite = nil
				end
			elseif b.smokecolor ~= nil then
				local col = table.pack(GetVehicleTyreSmokeColor(myveh.vehicle))
				if col[1] == b.smokecolor[1] and col[2] == b.smokecolor[2] and col[3] == b.smokecolor[3] then
					b.sprite = "garage"
				else
					b.sprite = nil
				end
			end
		end
	elseif name == "license" then
		for i,b in pairs(m.buttons) do
			if myveh.plateindex == b.plateindex then
				b.sprite = "garage"
			else
				b.sprite = nil
			end
		end
	elseif name == "tank" or name == "ornaments" or name == "arch cover" or name == "aerials" or name == "roof scoops" or name == "doors" or name == "roll cage" or name == "engine block" or name == "cam cover" or name == "strut brace" or name == "trim design" or name == "ornametns" or name == "dashboard" or name == "dials" or name == "seats" or name == "steering wheels" or name == "plate holder" or name == "vanity plates" or name == "shifter leavers" or name == "plaques" or name == "speakers" or name == "trunk" or name == "headlights" or name == "turbo" or  name == "hydraulics" or name == "liveries" or name == "horn" then
		for i,b in pairs(m.buttons) do
			if myveh.mods[b.modtype].mod == b.mod then
				b.sprite = "garage"
			else
				b.sprite = nil
			end
		end
	end
end

function CanPurchase(price, canpurchase)
	if canpurchase then
		if LSCMenu.currentmenu == "main" then
			LSCMenu:showNotification("Your vehicle has been repaired.")
		else
			LSCMenu:showNotification("Item purchased.")
		end
		return true
	else
		LSCMenu:showNotification("~r~You cannot afford this purchase.")
		return false
	end
end

function UnfakeVeh()
	local veh = myveh.vehicle
	SetVehicleModKit(veh,0)
	SetVehicleWheelType(veh, myveh.wheeltype)
	for i,m in pairs(myveh.mods) do
		if i == 22 or i == 18 then
			ToggleVehicleMod(veh,i,m.mod)
		elseif i == 23 or i == 24 then
			SetVehicleMod(veh,i,m.mod,m.variation)
		else
			SetVehicleMod(veh,i,m.mod)
		end
	end
	SetVehicleColours(veh,myveh.color[1], myveh.color[2])
	SetVehicleExtraColours(veh,myveh.extracolor[1], myveh.extracolor[2])
	SetVehicleNeonLightsColour(veh,myveh.neoncolor[1],myveh.neoncolor[2],myveh.neoncolor[3])
	SetVehicleNumberPlateTextIndex(veh, myveh.plateindex)
	SetVehicleWindowTint(veh, myveh.windowtint)
end

function AddBlips()
	for i,pos in ipairs(garages) do
		local blip = AddBlipForCoord(pos.inside.x,pos.inside.y,pos.inside.z)
		SetBlipSprite(blip, 72)
		SetBlipAsShortRange(blip,true)
		SetBlipScale(blip, 0.6)
		if i == 5 then
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Beeker's Garage")
			EndTextCommandSetBlipName(blip)
			SetBlipScale(blip, 0.6)
		elseif i == 6 then
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Benny's Motorworks")
			EndTextCommandSetBlipName(blip)
			SetBlipScale(blip, 0.6)
		end
	end
end

RegisterNetEvent('lockGarage')
AddEventHandler('lockGarage', function(tbl)
	for i,garage in ipairs(tbl) do
		garages[i].locked = garage.locked
	end
end)

local Ibuttons = nil

function SetIbuttons(buttons, layout)
	Citizen.CreateThread(function()
		if not HasScaleformMovieLoaded(Ibuttons) then
			Ibuttons = RequestScaleformMovie("INSTRUCTIONAL_BUTTONS")
			while not HasScaleformMovieLoaded(Ibuttons) do
				Citizen.Wait(0)
			end
		else
			Ibuttons = RequestScaleformMovie("INSTRUCTIONAL_BUTTONS")
			while not HasScaleformMovieLoaded(Ibuttons) do
				Citizen.Wait(0)
			end
		end
		local sf = Ibuttons
		local w,h = GetScreenResolution()
		PushScaleformMovieFunction(sf,"CLEAR_ALL")
		PopScaleformMovieFunction()
		PushScaleformMovieFunction(sf,"SET_DISPLAY_CONFIG")
		PushScaleformMovieFunctionParameterInt(w)
		PushScaleformMovieFunctionParameterInt(h)
		PushScaleformMovieFunctionParameterFloat(0.03)
		PushScaleformMovieFunctionParameterFloat(0.98)
		PushScaleformMovieFunctionParameterFloat(0.01)
		PushScaleformMovieFunctionParameterFloat(0.95)
		PushScaleformMovieFunctionParameterBool(true)
		PushScaleformMovieFunctionParameterBool(false)
		PushScaleformMovieFunctionParameterBool(false)
		PushScaleformMovieFunctionParameterInt(w)
		PushScaleformMovieFunctionParameterInt(h)
		PopScaleformMovieFunction()
		PushScaleformMovieFunction(sf,"SET_MAX_WIDTH")
		PushScaleformMovieFunctionParameterInt(1)
		PopScaleformMovieFunction()
		
		for i,btn in pairs(buttons) do
			PushScaleformMovieFunction(sf,"SET_DATA_SLOT")
			PushScaleformMovieFunctionParameterInt(i-1)
			PushScaleformMovieFunctionParameterString(btn[1])
			PushScaleformMovieFunctionParameterString(btn[2])
			PopScaleformMovieFunction()
			
		end
		if layout ~= 1 then
			PushScaleformMovieFunction(sf,"SET_PADDING")
			PushScaleformMovieFunctionParameterInt(10)
			PopScaleformMovieFunction()
		end
		PushScaleformMovieFunction(sf,"DRAW_INSTRUCTIONAL_BUTTONS")
		PushScaleformMovieFunctionParameterInt(layout)
		PopScaleformMovieFunction()
	end)
end

function DrawIbuttons()
	if HasScaleformMovieLoaded(Ibuttons) then
		DrawScaleformMovie(Ibuttons, 0.5, 0.5, 1.0, 1.0, 255, 255, 255, 255)
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if inside then
			SetLocalPlayerVisibleLocally(1)
		end
		if LSCMenu:isVisible() then
			DrawIbuttons()
			if IsDisabledControlJustPressed(1,0) or IsControlJustPressed(1,0) then
				if cam and IsCamActive(cam) then 
					SetCamCoord(cam,GetGameplayCamCoords())
					SetCamRot(cam, GetGameplayCamRot(2), 2)
					RenderScriptCams( 1, 1, 0, 0, 0)
					RenderScriptCams( 0, 1, 1000, 0, 0)
					SetCamActive(gameplaycam, true)
					EnableGameplayCam(true)
					SetCamActive(cam, false)
					SetIbuttons({
						{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_back, 0),"Back"},
						{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_select, 0),"Select"},
						{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_up, 0),"Up"},
						{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_down, 0),"Down"},
						{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_left, 0),"Left"},
						{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_right, 0),"Right"}
					},0)
				end
			end
		end
	end
end)

function drawTxt(text)
  SetTextFont(0)
  SetTextProportional(0)
  SetTextScale(0.32, 0.32)
  SetTextColour(0, 255, 255, 255)
  SetTextDropShadow(0, 0, 0, 0, 255)
  SetTextEdge(1, 0, 0, 0, 255)
  SetTextDropShadow()
  SetTextOutline()
  SetTextCentre(1)
  SetTextEntry("STRING")
  AddTextComponentString(text)
  DrawText(0.5, 0.93)
end

RegisterNetEvent('customs:update')
AddEventHandler('customs:update', function(owned, id)
 ownedCustoms = owned
 myCharacterID = id
end)

Citizen.CreateThread(function()
 AddBlips()
 WarMenu.CreateLongMenu('manage_fuelstation', 'Customs')
 WarMenu.CreateLongMenu('manageEmployees', 'Customs')
 while true do
  Citizen.Wait(5)
  if not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
   for i,v in pairs(garages) do
   	local pos = v.purchase
   	if v.purchase ~= nil then 
     if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), pos.x, pos.y, pos.z, true) < 25) then
      DrawMarker(27, pos.x, pos.y, pos.z-0.95, 0, 0, 0, 0, 0, 0, 1.3,1.3,0.5, 155, 155, 155, 255, 0, 0, 2, 0, 0, 0, 0)	
      if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), pos.x, pos.y, pos.z, true) < 1.5) then
       if ownedCustoms[v.id] then
        if ownedCustoms[v.id].owner == myCharacterID or isEmployee(ownedCustoms[v.id].id) then 
         drawTxt('~b~Press ~g~E ~b~Manage Customs')
         if IsControlJustPressed(0, 38) then
          WarMenu.OpenMenu('manage_fuelstation')
          currentStation = ownedCustoms[v.id]
         end
        end
       else
        drawTxt('~b~Press ~g~E ~b~Purchase Los Santos Customs\n~w~[~g~$'..v.price.."~w~]")
        if IsControlJustPressed(0, 38) then
        	TriggerServerEvent('customs:purchase', i, v.price)
        end
       end
      end
     end
    end 
   end
  end

  -- Menu
  if WarMenu.IsMenuOpened('manage_fuelstation') then
   if WarMenu.Button('VAT', '~g~$'..currentStation.vat) then
    local newfuel = getResult()
    TriggerServerEvent('customs:updatevat', newfuel, currentStation.id) 
    WarMenu.CloseMenu()
   elseif WarMenu.Button('Bank', '~g~$'..currentStation.bank) then
    TriggerServerEvent('customs:takeBank', currentStation.bank, currentStation.id) 
    WarMenu.CloseMenu()
   elseif WarMenu.Button('Manage Employees') then 
    WarMenu.OpenMenu('manageEmployees')
   elseif WarMenu.Button('Price', '~g~$'..currentStation.price) then
   	TriggerServerEvent('customs:sell', currentStation.id, currentStation.price/2)
   end
   WarMenu.Display()
  elseif WarMenu.IsMenuOpened('manageEmployees') then
   if WarMenu.Button('Add New Employee') then 
    local char_id = getResult()
    TriggerServerEvent('customs:givekey', currentStation.id, char_id) 
    WarMenu.CloseMenu()
   end
   if currentStation.employees ~= 'No Keys' then
    local keys = json.decode(currentStation.employees)
    for _,k in pairs(keys) do
     if WarMenu.Button(k.name, 'Fire') then
      TriggerServerEvent("customs:takekey", currentStation.id, k.id)
     end
    end
   end
   WarMenu.Display()
  end
 end
end)

function isEmployee(id)
 if ownedCustoms[id].employees ~= 'No Keys' then 
  local keys = json.decode(ownedCustoms[id].employees)
  for _,v in pairs(keys) do 
   if v.id == myCharacterID then 
    return true
   end
  end
 end
end

function getResult()
 DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 6)
  while (UpdateOnscreenKeyboard() == 0) do
    DisableAllControlActions(0);
    Wait(0);
  end
  if (GetOnscreenKeyboardResult()) then
    local result = GetOnscreenKeyboardResult()
    return tonumber(result)
  end
end