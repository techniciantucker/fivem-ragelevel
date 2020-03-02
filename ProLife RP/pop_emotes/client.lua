------------------------------------------------------------------------------------------------------------------------------------
--Creditos de uso cedidos a Plata o Plomo Comunidad Gamer
--Creadores: Themaykellll1 & Mofli
--Si lees esto y no eres del equipo de Plata o Plomo, felicidades as conseguido un script que no te pertenece robando a otra
--comunidad, espero que estés orgulloso.
------------------------------------------------------------------------------------------------------------------------------------

local isInAnimation = 0

---------------------------------------------------
---------------------------------------------------
--MENU
---------------------------------------------------
---------------------------------------------------

local vehshop = {
	identifier = nil,
	opened = false,
	title = "Animaciones",
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
			title = "CATEGORIAS",
			name = "main",
			buttons = {
				{name = "Celebrar", description = ""},
				{name = "Saludar", description = ""},
				{name = "Trabajar", description = ""},
				{name = "Humor", description = ""},
				{name = "Otros", description = ""},
				{name = "Cancelar accion", description = ""},
				{name = "Cerrar", description = ""}
			}
		},
		["Celebrar"] = {
			title = "Celebrar",
			name = "Celebrar",
			buttons = {
				{name = "Tocar la guitarra", description = ''},
				{name = "Bailar", description = ''},
				{name = "Beber una cerveza", description = ''},
				{name = "Tocar musica", description = ''},
				{name = "Cerrar", description = ''}
			}
		},
		["Saludar"] = {
			title = "Saludar",
			name = "Saludar",
			buttons = {
				{name = "Saludar", description = '' },
				{name = "Apreton de manos", description = '' },
				{name = "Chocar los 5", description = '' },
				{name = "Saludo militar", description = '' },
				{name = "Cerrar", description = '' }

			}
		},
		["Trabajar"] = {
			title = "Trabajar",
			name = "Trabajar",
			buttons = {
				{name = "Pescar", description = '' },
				{name = "Agricultura", description = '' },
				{name = "Mecanica", description = '' },
				{name = "Tomar notas", description = '' },
				{name = "Cerrar", description = '' }

			}
		},
		["Humor"] = {
			title = "Humor",
			name = "Humor",
			buttons = {
				{name = "Felicitar", description = '' },
				{name = "Super", description = '' },
				{name = "Calmarse", description = '' },
				{name = "Tener miedo", description = '' },
				{name = "No es posible", description = '' },
				{name = "Abrazar", description = '' },
				{name = "Gilipollas", description = '' },
				{name = "Disparo a la cabeza", description = '' },
				{name = "Cerrar", description = '' }
			}
		},
		["Otros"] = {
			title = "Otros",
			name = "Otros",

			buttons = {
				{name = "Fumar un cigarro", description = '' },
				{name = "Sentarse", description = '' },
				{name = "Sentarse en el suelo", description = '' },
				{name = "Esperar", description = '' },
				{name = "Limpiar algo", description = '' },
				{name = "Posicion de excavacion", description = '' },
				{name = "Rascarse la p****", description = '' },
				{name = "Hacerse un selfie", description = '' },
				{name = "Cerrar", description = '' }

			}
		}
	}
	
}

---------------------------------------------------
---------------------------------------------------
--FIN MENU
---------------------------------------------------
---------------------------------------------------

---------------------------------------------------
---------------------------------------------------
--FUNCIONES DE GUI
---------------------------------------------------
---------------------------------------------------

function LocalPed()
	return GetPlayerPed(-1)
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

function OpenCreator()
	Citizen.Wait(0)
	local ped = LocalPed()
	vehshop.currentmenu = "main"
	vehshop.opened = true
	vehshop.selectedbutton = 0
end

function CloseCreator(name, veh, price)
	Citizen.CreateThread(function()
		Wait(0)
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

function Back()
	if backlock then
		return
	end
	backlock = true
	if vehshop.currentmenu == "main" then
		CloseCreator()	
	else
		OpenMenu(vehshop.lastmenu)
	end
end

---------------------------------------------------
---------------------------------------------------
--FIN FUNCIONES DE GUI
---------------------------------------------------
---------------------------------------------------

---------------------------------------------------
---------------------------------------------------
--FUNCIONES DE LOS BOTONES
---------------------------------------------------
---------------------------------------------------

function ButtonSelected(button)
	local ped = GetPlayerPed(-1)
	local this = vehshop.currentmenu
	local btn = button.name
	Citizen.Wait(0)
	if this == "main" then
		if btn == "Celebrar" then
			OpenMenu('Celebrar')
		elseif btn == "Saludar" then
			OpenMenu('Saludar')
		elseif btn == "Trabajar" then
			OpenMenu('Trabajar')
		elseif btn == "Humor" then
			OpenMenu('Humor')
		elseif btn == "Otros" then
			OpenMenu('Otros')
		elseif btn == "Cancelar accion" then
			ClearPedTasks(ped)
			isInAnimation = 0
		elseif btn == "Cerrar" then
			CloseCreator()
		end
	elseif this == "Celebrar" then
		if btn == "Cerrar" then
			OpenMenu('main')
		elseif btn == "Tocar la guitarra" then
			--if isInAnimation == 0 then
				Action("anim@mp_player_intcelebrationfemale@air_guitar","air_guitar")
				isInAnimation = 1
			--end
		elseif btn == "Bailar" then
			--if isInAnimation == 0 then
				Action("amb@world_human_partying@female@partying_beer@base","base")
				isInAnimation = 1
			--end
		elseif btn == "Beber una cerveza" then
			--if isInAnimation == 0 then
				TaskStartScenarioInPlace(ped, "WORLD_HUMAN_DRINKING", 0, true)
				isInAnimation = 1
			--end
		elseif btn == "Tocar musica" then
			--if isInAnimation == 0 then
				TaskStartScenarioInPlace(ped, "WORLD_HUMAN_MUSICIAN", 0, true)
				isInAnimation = 1
			--end
		end
	elseif this == "Saludar" then
		if btn == "Cerrar" then
			OpenMenu('main')
		elseif btn == "Saludar" then
			--if isInAnimation == 0 then
				Action("gestures@m@standing@casual","gesture_hello")
				isInAnimation = 1
			--end
		elseif btn == "Apreton de manos" then
			--if isInAnimation == 0 then
				Action("mp_common","givetake1_a")
				isInAnimation = 1
			--end
		elseif btn == "Chocar los 5" then
			--if isInAnimation == 0 then
				Action("mp_ped_interaction","highfive_guy_a")
				isInAnimation = 1
			--end
		elseif btn == "Saludo militar" then
			--if isInAnimation == 0 then
				Action("mp_player_int_uppersalute","mp_player_int_salute")
				isInAnimation = 1
			--end
		end
	elseif this == "Trabajar" then
		if btn == "Cerrar" then
			OpenMenu('main')
		elseif btn == "Pescar" then
			--if isInAnimation == 0 then
				TaskStartScenarioInPlace(ped, "world_human_stand_fishing", 0, true)
				isInAnimation = 1
			--end
		elseif btn == "Agricultura" then
			--if isInAnimation == 0 then
				TaskStartScenarioInPlace(ped, "world_human_gardener_plant", 0, true)
				isInAnimation = 1
			--end
		elseif btn == "Solucionar problemas mecanicos" then
			--if isInAnimation == 0 then
				TaskStartScenarioInPlace(ped, "world_human_vehicle_mechanic", 0, true)
				isInAnimation = 1
			--end
		elseif btn == "Tomar notas" then
			--if isInAnimation == 0 then
				TaskStartScenarioInPlace(ped, "WORLD_HUMAN_CLIPBOARD", 0, true)
				isInAnimation = 1
			--end
		end
	elseif this == "Humor" then
		if btn == "Cerrar" then
			OpenMenu('main')
		elseif btn == "Felicitar" then
			--if isInAnimation == 0 then
				TaskStartScenarioInPlace(ped, "WORLD_HUMAN_CHEERING", 0, true)
				isInAnimation = 1
			--end
		elseif btn == "Super" then
			--if isInAnimation == 0 then
				Action("anim@mp_player_intcelebrationmale@thumbs_up","thumbs_up")
				isInAnimation = 1
			--end
		elseif btn == "Calmarse" then
			--if isInAnimation == 0 then
				Action("gestures@m@standing@casual","gesture_easy_now")
				isInAnimation = 1
			--end
		elseif btn == "Tener miedo" then
			--if isInAnimation == 0 then
				Action("amb@code_human_cower_stand@female@idle_a","idle_c")
				isInAnimation = 1
			--end
		elseif btn == "No es posible" then
			--if isInAnimation == 0 then
				Action("gestures@m@standing@casual","gesture_damn")
				isInAnimation = 1
			--end
		elseif btn == "Abrazar" then
			--if isInAnimation == 0 then
				Action("mp_ped_interaction","kisses_guy_a")
				isInAnimation = 1
			--end
		elseif btn == "Gilipollas" then
			--if isInAnimation == 0 then
				Action("mp_player_int_upperwank","mp_player_int_wank_01")
				isInAnimation = 1
			--end
		elseif btn == "Disparo a la cabeza" then
			--if isInAnimation == 0 then
				Action("mp_suicide","pistol")
				isInAnimation = 1
			--end
		end
	elseif this == "Otros" then
		if btn == "Cerrar" then
			OpenMenu('main')
		elseif btn == "Fumar un cigarro" then
			--if isInAnimation == 0 then
				TaskStartScenarioInPlace(ped, "WORLD_HUMAN_SMOKING", 0, true)
				isInAnimation = 1
			--end
		elseif btn == "Sentarse" then
			--if isInAnimation == 0 then
				Action("anim@heists@prison_heistunfinished_biztarget_idle","target_idle")
				isInAnimation = 1
			--end
		elseif btn == "Sentarse en el suelo" then
			--if isInAnimation == 0 then
				TaskStartScenarioInPlace(ped, "WORLD_HUMAN_PICNIC", 0, true)
				isInAnimation = 1
			--end
		elseif btn == "Esperar" then
			--if isInAnimation == 0 then
				TaskStartScenarioInPlace(ped, "world_human_leaning", 0, true)
				isInAnimation = 1
			--end
		elseif btn == "Limpiar algo" then
			--if isInAnimation == 0 then
				TaskStartScenarioInPlace(ped, "world_human_maid_clean", 0, true)
				isInAnimation = 1
			--end
		elseif btn == "Posicion de excavacion" then
			--if isInAnimation == 0 then
				Action("mini@prostitutes@sexlow_veh","low_car_bj_to_prop_female")
				isInAnimation = 1
			--end
		elseif btn == "Rascarse la p****" then
			--if isInAnimation == 0 then
				Action("mp_player_int_uppergrab_crotch","mp_player_int_grab_crotch")
				isInAnimation = 1
			--end
		elseif btn == "Hacerse un selfie" then
			--if isInAnimation == 0 then
				TaskStartScenarioInPlace(ped, "world_human_tourist_mobile", 0, true)
				isInAnimation = 1
			--end
		end
	end
end

function OpenMenu(menu)
	fakecar = {model = '', car = nil}
	vehshop.lastmenu = vehshop.currentmenu
	if menu == "Celebrar" then
		vehshop.lastmenu = "main"
	elseif menu == "Saludar"  then
		vehshop.lastmenu = "main"
	elseif menu == 'Trabajar' then
		vehshop.lastmenu = "main"
	elseif menu == "Humor" then
		vehshop.lastmenu = "main"
	elseif menu == "Otros" then
		vehshop.lastmenu = "main"
	end
	vehshop.menu.from = 1
	vehshop.menu.to = 10
	vehshop.selectedbutton = 0
	vehshop.currentmenu = menu
end

---------------------------------------------------
---------------------------------------------------
--FIN FUNCIONES DE LOS BOTONES
---------------------------------------------------
---------------------------------------------------

---------------------------------------------------
---------------------------------------------------
--FUNCIONES PARA ASIGNARLO A LOS BOTONES
---------------------------------------------------
---------------------------------------------------

function Action(animLib,animAnim)
    RequestAnimDict(animLib)
    while not HasAnimDictLoaded(animLib) do
        Citizen.Wait(0)
    end
    if HasAnimDictLoaded(animLib) then
        TaskPlayAnim(GetPlayerPed(-1), animLib , animAnim ,8.0, -8.0, -1, 0, 0, false, false, false)
    end
end

---------------------------------------------------
---------------------------------------------------
--FIN FUNCIONES PARA ASIGNARLO A LOS BOTONES
---------------------------------------------------
---------------------------------------------------

---------------------------------------------------
---------------------------------------------------
--MENU Y NAVEGACIÓN
---------------------------------------------------
---------------------------------------------------

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(1,166) then
			if vehshop.opened then
				CloseCreator()
			else
				OpenCreator()
				Citizen.Wait(0)
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

---------------------------------------------------
---------------------------------------------------
--FIN MENU Y NAVEGACIÓN
---------------------------------------------------
---------------------------------------------------