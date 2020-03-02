local mPrecio = 0.010
local mDist = 20
local teletransportandose = false
local creador = false
local pxu = 0
local pyu = 0
local pzu = 0

--PARADAS DE AUTOBUS

local paradas = {
	{ name = "Hospital", x = 1826.56, y = 3653.56, z = 34.2 },
	{ name = "Aeropuerto Shandy", x = 1777.44, y = 3350.32, z = 40.44 },
	{ name = "Cárcel", x = 1999.8, y = 2672.48, z = 46.68 },
	{ name = "Bar de Trevor", x = 1423.96, y = 3606.72, z = 34.84 },
	{ name = "Tienda de armas", x = 1719.12, y = 3750.72, z = 33.76 },
	{ name = "Puerto", x = 1981.8, y = 3885.96, z = 32.4 },
	{ name = "Autopista", x = 2741.72, y = 4401.2, z = 48.68 },
	{ name = "Alamo Sea", x = 2505.28, y = 4103.52, z = 38.24 },
	{ name = "Grapeseed", x = 2553.56, y = 4696.6, z = 33.6 },
	{ name = "Aeropuerto Grapeseed", x = 2165.92, y = 4761.72, z = 41.08 },
	{ name = "Tienda de armas de Paleto Bay" , x = -361.32, y = 6033.76, z = 31.24 },
	{ name = "Comisaria Paleto Bay", x = -439.0, y = 6053.84, z = 31.48 },
	{ name = "Hospital Paleto Bay", x = -228.24, y = 6317.6, z = 31.44 }
}
--PARADAS PARA USARLA PARA COGER COORDENADAS

local paradas1 = {
	parada1 = {x = 1826.56, y = 3653.56, z = 34.2 },
	parada2 = {x = 1777.44, y = 3350.32, z = 40.44 },
	parada3 = {x = 1999.8, y = 2672.48, z = 46.68 },
	parada4 = {x = 1423.96, y = 3606.72, z = 34.84 },
	parada5 = {x = 1719.12, y = 3750.72, z = 33.76 },
	parada6 = {x = 1981.8, y = 3885.96, z = 32.4 },
	parada7 = {x = 2741.72, y = 4401.2, z = 48.68 },
	parada8 = {x = 2505.28, y = 4103.52, z = 38.24 },
	parada9 = {x = 2553.56, y = 4696.6, z = 33.6 },
	parada10 = {x = 2165.92, y = 4761.72, z = 41.08 },
	parada11 = {x = -361.32, y = 6033.76, z = 31.24 },
	parada12 = {x = -439.0, y = 6053.84, z = 31.48 },
	parada13 = {x = -228.24, y = 6317.6, z = 31.44 }
}

--GUI

local vehshop = {
	identifier = nil,
	opened = false,
	title = "Paradas de autobus",
	currentmenu = "main",
	lastmenu = nil,
	currentpos = nil,
	selectedbutton = 0,
	marker = { r = 0, g = 155, b = 255, a = 200, type = 1 },
	menu = {
		x = 0.9,
		y = 0.08,
		width = 0.2,
		height = 0.04,
		buttons = 10,
		from = 1,
		to = 10,
		scale = 0.4,
		font = 0,
		["main"] = {
			title = "Estaciones",
			name = "Estaciones",
			buttons = {
				{name = "Hospital", description = ""},
				{name = "Aeropuerto Shandy", description = ""},
				{name = "Cárcel", description = ""},
				{name = "Bar de Trevor", description = ""},
				{name = "Tienda de armas", description = ""},
				{name = "Puerto", description = ""},
				{name = "Autopista", description = ""},
				{name = "Alamo Sea", description = ""},
				{name = "Grapeseed", description = ""},
				{name = "Aeropuerto Grapeseed", description = ""},
				{name = "Tienda de armas de Paleto Bay", description = ""},
				{name = "Comisaria Paleto Bay", description = ""},
				{name = "Hospital Paleto Bay", description = ""}
			}
		}
	}
	
}

--CICLO PARA PONER LOS SIGNOS

Citizen.CreateThread(function()
    for _, info in pairs(paradas) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, 198)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.9)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString("Parada de autobus")
      EndTextCommandSetBlipName(info.blip)
    end
end)

--FUNCIONES PARA EL TELETRANSPORTE

function propiedadeson(ped)
	
end

function propiedadesoff(ped)

end

function round(num, numDecimalPlaces)
	local mult = 5^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

function tiempo_espera()
Citizen.CreateThread(function()
while true do
	if teletransportandose then
		Citizen.Wait(0)
		drawTxt("VIAJANDO...",1, 1, 0.45, 0.03, 0.80,255,0,0,255)
	else
		break
	end
end
end)
end

function animacionon()

end

function teletransporte(ped)
	--INDICA VARIABLES
	local distancia = 0
	local precio = 0
	local tiempo_de_espera = 0
	local tiene_dinero = nil

	--PROCESO DE CALCULOS
	distancia = GetDistanceBetweenCoords(px,py,pz, GetEntityCoords(GetPlayerPed(-1),true)) --CALCULA DISTANCIA
	precio = distancia * mPrecio --CALCULA PRECIO
	precio = round(precio) --REDONDEO
	tiempo_de_espera = distancia * mDist --CALCULA TIEMPO DE ESPERA
	tiene_dinero = TriggerServerEvent("bus:cobrarDinero", precio) --COBRA EL DINERO Y DEVUELVE SI TIENE O NO
	local tiespera = tiempo_de_espera / 1000 --LO PASA A SEGUNDOS
	tiespera = round(tiespera) --REDONDEA LOS SEGUNDOS
	TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "El viaje durara "..tiespera.."s y le cobraremos "..precio) --INFORMACION AL CLIENTE

	--PROCESO DE TELETRANSPORTE
	if tiene_dinero then
		teletransportandose = true
		CloseCreator() --CIERRA LA GUI
		FreezeEntityPosition(ped,true)
		SetEntityInvincible(ped,true)
		SetEntityVisible(ped, false, false)
		TaskStartScenarioInPlace(ped, "WORLD_HUMAN_PICNIC", 0, true)
		tiempo_espera()
		StartScreenEffect("DMT_flight_intro", 0, 0) --EFECTO DE BORRACHO
		Wait(math.ceil(tiempo_de_espera)) --TIEMPO DE ESPERA
		SetEntityCoords(ped, px, py, pz) --TELETRANSPORTE
		StopScreenEffect("DMT_flight_intro") --DESACTIVAR EFECTO DE BORRACHO
		ClearPedTasks(ped)
		SetEntityVisible(ped, true, false)
		FreezeEntityPosition(ped,false)
		SetEntityInvincible(ped,false)
		teletransportandose = false --PONE EN FALSE LA VARIABLE DE TELETRANSPORTANDO
	else
		TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, 'Lo siento señor pero usted no tiene dinero suficiente') --EN CASO DE QUE NO TENGA DINERO SUFICIENTE
	end
end

--FUNCIONES GUI

function LocalPed()
	return GetPlayerPed(-1)
end

function OpenCreator()
	Citizen.Wait(0)
	creador = true
	local ped = LocalPed()
	vehshop.currentmenu = "main"
	vehshop.opened = true
	vehshop.selectedbutton = 0
end

function CloseCreator(name, veh, price)
	Citizen.CreateThread(function()
		Wait(0)
		creador = false
		local ped = LocalPed()
		vehshop.opened = false
		vehshop.menu.from = 1
		vehshop.menu.to = 10
	end)
end

function drawMenuButton(button,x,y,selected)
	local menu = vehshop.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(menu.scale, menu.scale)
	if selected then
		SetTextColour(0, 0, 0, 255)
	else
		SetTextColour(255, 255, 255, 255)
	end
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(button.name)
	if selected then
		DrawRect(x,y,menu.width,menu.height,255,255,255,255)
	else
		DrawRect(x,y,menu.width,menu.height,0,0,0,150)
	end
	DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)
end

function drawMenuInfo(text)
	local menu = vehshop.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(0.45, 0.45)
	SetTextColour(255, 255, 255, 255)
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawRect(0.675, 0.95,0.65,0.050,0,0,0,150)
	DrawText(0.365, 0.934)
end

function drawMenuRight(txt,x,y,selected)
	local menu = vehshop.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(menu.scale, menu.scale)
	SetTextRightJustify(1)
	if selected then
		SetTextColour(0, 0, 0, 255)
	else
		SetTextColour(255, 255, 255, 255)
	end
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawText(x + menu.width/2 - 0.03, y - menu.height/2 + 0.0028)
end

function drawMenuTitle(txt,x,y)
	local menu = vehshop.menu
	SetTextFont(2)
	SetTextProportional(0)
	SetTextScale(0.5, 0.5)
	SetTextColour(255, 255, 255, 255)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawRect(x,y,menu.width,menu.height,0,0,0,150)
	DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function drawNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

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

--CREACION DE MARKERS, ACTIVACION DEL MENU

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		for _, parada in pairs(paradas) do
			DrawMarker(1, parada.x, parada.y, parada.z - 1, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 1.0001, 0, 155, 255, 200, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(parada.x, parada.y, parada.z, GetEntityCoords(GetPlayerPed(-1),true)) < 1.5 then
				drawTxt("PULSA E PARA ABRIR EL MENU DE AUTOBUSES",1, 1, 0.45, 0.03, 0.80,255,0,0,255)
					if IsControlJustPressed(1,38) then
						pxu = parada.x
						pyu = parada.y
						pzu = parada.z
						OpenCreator()
						Citizen.Wait(0)
					end
				elseif creador == true and GetDistanceBetweenCoords(pxu, pyu, pzu, GetEntityCoords(GetPlayerPed(-1),true)) > 1.5 then
					CloseCreator()
				end	
		end
		if vehshop.opened then
			local ped = LocalPed()
			local menu = vehshop.menu[vehshop.currentmenu]
			drawTxt(vehshop.title,1,1,vehshop.menu.x,vehshop.menu.y,1.0, 255,255,255,255)
			drawMenuTitle(menu.title, vehshop.menu.x,vehshop.menu.y + 0.08)
			drawTxt(vehshop.selectedbutton.."/"..tablelength(menu.buttons),0,0,vehshop.menu.x + vehshop.menu.width/2 - 0.0385,vehshop.menu.y + 0.067,0.4, 255,255,255,255)
			local y = vehshop.menu.y + 0.12
			buttoncount = tablelength(menu.buttons)
			local selected = false

			for i,button in pairs(menu.buttons) do
				if i >= vehshop.menu.from and i <= vehshop.menu.to then

					if i == vehshop.selectedbutton then
						selected = true
					else
						selected = false
					end
					drawMenuButton(button,vehshop.menu.x,y,selected)
					
					y = y + 0.04
					
					if selected and IsControlJustPressed(1,201) then
						ButtonSelected(button)
					end
				end
			end
		end
		if vehshop.opened then
			if IsControlJustPressed(1,202) then
				Back()
			end
			if IsControlJustReleased(1,202) then
				backlock = false
			end
			if IsControlJustPressed(1,188) then
				if vehshop.selectedbutton > 1 then
					vehshop.selectedbutton = vehshop.selectedbutton -1
					if buttoncount > 10 and vehshop.selectedbutton < vehshop.menu.from then
						vehshop.menu.from = vehshop.menu.from -1
						vehshop.menu.to = vehshop.menu.to - 1
					end
				end
			end
			if IsControlJustPressed(1,187)then
				if vehshop.selectedbutton < buttoncount then
					vehshop.selectedbutton = vehshop.selectedbutton +1
					if buttoncount > 10 and vehshop.selectedbutton > vehshop.menu.to then
						vehshop.menu.to = vehshop.menu.to + 1
						vehshop.menu.from = vehshop.menu.from + 1
					end
				end
			end
		end
	end
end)

--FUNCIONES DE BOTONES

function ButtonSelected(button)
	local ped = GetPlayerPed(-1)
	local this = vehshop.currentmenu
	local btn = button.name
	Citizen.Wait(0)
	if this == "main" then
		if btn == "Hospital" then
			px,py,pz = paradas1.parada1.x,paradas1.parada1.y,paradas1.parada1.z
			teletransporte(ped)
		elseif btn == "Aeropuerto Shandy" then
			px,py,pz = paradas1.parada2.x,paradas1.parada2.y,paradas1.parada2.z
			teletransporte(ped)
		elseif btn == "Cárcel" then
			px,py,pz = paradas1.parada3.x,paradas1.parada3.y,paradas1.parada3.z
			teletransporte(ped)
		elseif btn == "Bar de Trevor" then
			px,py,pz = paradas1.parada4.x,paradas1.parada4.y,paradas1.parada4.z
			teletransporte(ped)
		elseif btn == "Tienda de armas" then
			px,py,pz = paradas1.parada5.x,paradas1.parada5.y,paradas1.parada5.z
			teletransporte(ped)
		elseif btn == "Puerto" then
			px,py,pz = paradas1.parada6.x,paradas1.parada6.y,paradas1.parada6.z
			teletransporte(ped)
		elseif btn == "Autopista" then
			px,py,pz = paradas1.parada7.x,paradas1.parada7.y,paradas1.parada7.z
			teletransporte(ped)
		elseif btn == "Alamo Sea" then
			px,py,pz = paradas1.parada8.x,paradas1.parada8.y,paradas1.parada8.z
			teletransporte(ped)
		elseif btn == "Grapeseed" then
			px,py,pz = paradas1.parada9.x,paradas1.parada9.y,paradas1.parada9.z
			teletransporte(ped)
		elseif btn == "Aeropuerto Grapeseed" then
			px,py,pz = paradas1.parada10.x,paradas1.parada10.y,paradas1.parada10.z
			teletransporte(ped)
		elseif btn == "Tienda de armas de Paleto Bay" then
			px,py,pz = paradas1.parada11.x,paradas1.parada11.y,paradas1.parada11.z
			teletransporte(ped)
		elseif btn == "Comisaria Paleto Bay" then
			px,py,pz = paradas1.parada12.x,paradas1.parada12.y,paradas1.parada12.z
			teletransporte(ped)
		elseif btn == "Hospital Paleto Bay" then
			px,py,pz = paradas1.parada13.x,paradas1.parada13.y,paradas1.parada13.z
			teletransporte(ped)
		elseif btn == "Cerrar" then
			CloseCreator()
		end
	end
end

