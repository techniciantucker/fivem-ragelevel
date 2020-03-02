-----------------------------
----PIDIENDO INFORMACIÓN-----
-----------------------------
AddEventHandler('playerSpawned', function(spawn)
	TriggerServerEvent('pop_university:getInfo')
end)
TriggerServerEvent('pop_university:getInfo')

----------------------
------VARIABLES-------
----------------------
ESX  = nil
mySkills = {}
local guiEnabled = false
local gandhiActive = false
------------------------------------
-------RefreshTheCallsBacks---------
------------------------------------
function RefreshSkills()
	for v,i in pairs(mySkills) do
		if i == 'live' then
			live()
		elseif i == 'carbon' or i == 'hierro' or i == 'plata' or i == 'oro' then
			TriggerServerEvent('pop_university:setMineLevel',mySkills)
		elseif i == 'plant' then
			TriggerServerEvent('pop_university:setKown')
		elseif i == 'recoger' then
			TriggerServerEvent('pop_university:setCatch')
		elseif i == "businessman" then
			TriggerServerEvent('pop_university:setBussinesMan')
		elseif i == "buyWeapons" or i == "buySMGs" or i == "buyRifles" then
			TriggerServerEvent('pop_university:setWeaponLicense',mySkills)
		elseif i == 'transport' or i == 'bus' or i == 'taxi' or i == 'pilot' or i == 'trucker' then
			TriggerServerEvent('pop_university:setJobs',mySkills)
		elseif i == "gandhi" and gandhiActive == false then
			gandhiActive = true
			gandhi()
		elseif i == "palabra" then
			TriggerEvent('pop_university:donDePalabra')
		end
	end
end

-----------------------
-------EVENTOS---------
-----------------------
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getShtoniaredObjtoniect', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('pop_university:setInfo')
AddEventHandler('pop_university:setInfo',function(skills)
	mySkills = skills
	RefreshSkills()
end)

RegisterNetEvent('pop_university:medite')
AddEventHandler('pop_university:medite',function()
	Citizen.CreateThread(function()
		startAnim("amb@world_human_yoga@male@base", "base_a")
		Citizen.Wait(20000)
		ClearPedTasks(GetPlayerPed(-1))
		SetEntityHealth(GetPlayerPed(-1), 200)
	end)
end)

RegisterNUICallback('escape', function(data, cb)
    EnableGui(false)
end)

RegisterNUICallback('register', function(data, cb)
    local completeData = {data.necesarySP, data.skillName,data.isNeededLevel,data.isNeededAnHability,data.money}
    TriggerServerEvent('pop_university:buySkill',completeData)
    EnableGui(false)
end)
---------------------------
-------Habilidades---------
---------------------------
function live()
	Citizen.Trace("Vivo")
end

function gandhi()
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(10000)
			TriggerEvent('esx_status:add', 'hunger', 500)
			TriggerEvent('esx_status:add', 'thirst', 500)
		end
	end)
end

function startAnim(lib, anim)
	Citizen.CreateThread(function()
	  RequestAnimDict(lib)  
	  while not HasAnimDictLoaded( lib) do
	    Citizen.Wait(0)
	  end
	  TaskPlayAnim(GetPlayerPed(-1), lib ,anim ,8.0, -8.0, -1, 0, 0, false, false, false )
	end)
end
---------------------------
-------Universidad---------
---------------------------
function openSkillBuy(title,description,necesarySp,skillName,levelNeeded,skillNeeded,money)
	SendNUIMessage({
        type = "requestAccept",
        title = title,
        description = description,
        sp = necesarySp,
        metaData = {necesarySp,skillName,levelNeeded,skillNeeded,money}
    })
    EnableGui(true)
end

function putInGreen(elements)
	for i,v in pairs(elements) do
		for a,b in pairs(mySkills) do
			if v.skillName == b then
				v.label = '<span style="color: cyan;">'..v.label..'</span>'
			end
		end
	end
	return elements
end

function openUniversityMenu()

	local elements = {
		{label = "Minería" ,value = "mine"},
		{label = "Habilidades" ,value = "skills"},
		{label = "Licencias" ,value = "licenses"},
		{label = "Profesiones" ,value = "jobs"}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'university',
		{
			title  = "Universidad",
			elements = elements
		},
		function(data, menu)
			if data.current.value == "mine" then
				menu.close()
				openMineMenu()
			elseif data.current.value == "skills" then
				menu.close()
				openSkillMenu()
			elseif data.current.value == "licenses" then
				menu.close()
				openLicenseMenu()
			elseif data.current.value == "jobs" then
				menu.close()
				openJobsMenu()
			else
				menu.close()
			end
		end,
		function(data, menu)
			menu.close()
		end
	)
end

function openMineMenu()
	local elements = {
		{
		label = "Picar carbón" ,
		title = "Picar carbón",
		description = "Se tiene que empezar por abajo… Empezarás a aprender picando carbón, como un puto esclavo.",
		necesarySp = 2,
		money = 50000,
		skillName = "carbon",
		levelNeeded = nil,
		skillNeeded = nil
		},
		{
		label = "Picar hierro" ,
		title = "Picar hierro",
		description = "Ahora que tienes algo más de experiencia, es hora de que hagas algo de dinero real con algo que valga la pena.",
		necesarySp = 2,
		money = 50000,
		skillName = "hierro",
		levelNeeded = nil,
		skillNeeded = "carbon"
		},
		{
		label = "Picar plata" ,
		title = "Picar plata",
		description = "¿No llegas a final de mes? Intenta aprender esto…",
		necesarySp = 3,
		money = 100000,
		skillName = "plata",
		levelNeeded = nil,
		skillNeeded = "hierro"
		},
		{
		label = "Picar oro" ,
		title = "Picar oro",
		description = "Aprendiendo esto podrás vender el mineral más caro de la ciudad… tu madre estará muy orgullosa del empresario en el que te has convertido.",
		necesarySp = 3,
		money = 110000,
		skillName = "oro",
		levelNeeded = nil,
		skillNeeded = "plata"
		}
	}

	elements = putInGreen(elements)

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'mine_university',
		{
			title  = "Minería",
			align    = 'bottom-right',
			elements = elements
		},
		function(data, menu)
			openSkillBuy(data.current.title,data.current.description,data.current.necesarySp,data.current.skillName,data.current.levelNeeded,data.current.skillNeeded,data.current.money)
			menu.close()
		end,
		function(data, menu)
			menu.close()
		end
	)
end

function openSkillMenu()
	local elements = {
		{
		label = "Plantar" ,
		title = "Plantar",
		description = "Si estudias esto aprenderás a plantar comida para sobrevivir. Comida y unas cuantas mierdas más…",
		necesarySp = 4,
		money = 145000,
		skillName = "plant",
		levelNeeded = nil,
		skillNeeded = nil
		},
		{
		label = "Recoger el doble" ,
		title = "Recoger el doble",
		description = "A ver jovencito, mi abuelo me enseñó cuando estabamos en la guerra un par de trucos para recoger el 100% de la planta, si quieres te puedo enseñar...",
		necesarySp = 5,
		money = 185000,
		skillName = "recoger",
		levelNeeded = nil,
		skillNeeded = "plant"
		},
		{
		label = "Hombre de negocios" ,
		title = "Hombre de negocios",
		description = "Podrás vender todo tipo de material a todos los empresarios honestos de la ciudad...",
		necesarySp = 8,
		money = 240000,
		skillName = "businessman",
		levelNeeded = nil,
		skillNeeded = nil
		},
		{
		label = "Gandhi" ,
		title = "Gandhi",
		description = "No serás más inteligente, tu retraso no tiene cura, solo que ahora tus células regeneraran algo de comida y agua.",
		necesarySp = 3,
		money = 30000,
		skillName = "gandhi",
		levelNeeded = nil,
		skillNeeded = nil
		},
		{
		label = "Meditación de un monje" ,
		title = "Meditación de un monje",
		description = "Después de este entrenamiento físico y psicológico, podrás meditar y recuperar toda tu salud. Solo tienes que pensar en /meditar",
		necesarySp = 5,
		money = 80000,
		skillName = "meditacion",
		levelNeeded = nil,
		skillNeeded = nil
		},
		{
		label = "Don de palabra" ,
		title = "Don de palabra",
		description = "¿Te has dado cuenta que puedes negociar? Pero con esa labia no creo que llegues a ningún lado... Si quieres te puedo enseñar un par de trucos para que puedas comprar coches mas baratos",
		necesarySp = 5,
		money = 80000,
		skillName = "palabra",
		levelNeeded = nil,
		skillNeeded = nil
		}
	}

	elements = putInGreen(elements)

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'habilitys_university',
		{
			title  = "Habilidades",
			align    = 'bottom-right',
			elements = elements
		},
		function(data, menu)
			openSkillBuy(data.current.title,data.current.description,data.current.necesarySp,data.current.skillName,data.current.levelNeeded,data.current.skillNeeded,data.current.money)
			menu.close()
		end,
		function(data, menu)
			menu.close()
		end
	)
end

function openLicenseMenu()
	local elements = {
		{
		label = "Licencia de armas" ,
		title = "Licencia de armas",
		description = "Si estudias esto, a partir de ahora podrás comprar armas en las tiendas",
		necesarySp = 0,
		money = 30000,
		skillName = "buyWeapons",
		levelNeeded = nil,
		skillNeeded = nil
		},
		{
		label = "Comprar subfusiles en las sombras" ,
		title = "Comprar subfusiles en las sombras",
		description = "Si estudias esto, a partir de ahora en los recintos a los que estés autorizados, podrás comprar subfusiles.",
		necesarySp = 0,
		money = 40000,
		skillName = "buySMGs",
		levelNeeded = nil,
		skillNeeded = "buyWeapons"
		},
		{
		label = "Comprar fusiles en las sombras" ,
		title = "Comprar fusiles en las sombras",
		description = "Si estudias esto, a partir de ahora podrás comprar fusiles en los recintos autorizados",
		necesarySp = 0,
		money = 50000,
		skillName = "buyRifles",
		levelNeeded = nil,
		skillNeeded = "buySMGs"
		}
	}

	elements = putInGreen(elements)

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'licenses_university',
		{
			title  = "Licencias",
			align    = 'bottom-right',
			elements = elements
		},
		function(data, menu)
			openSkillBuy(data.current.title,data.current.description,data.current.necesarySp,data.current.skillName,data.current.levelNeeded,data.current.skillNeeded,data.current.money)
			menu.close()
		end,
		function(data, menu)
			menu.close()
		end
	)
end

function openJobsMenu()
	local elements = {
		{
		label = "Camionero" ,
		title = "Camionero",
		description = " ¿Te gustan los camiones? ¿Las carreteras? Estudia esto para poder ser transportista. Dicen que es el único trabajo donde los subnormales no van a atracarte...",
		necesarySp = 3,
		money = 30000,
		skillName = "trucker",
		levelNeeded = nil,
		skillNeeded = nil
		},
		{
		label = "Taxista" ,
		title = "Taxista",
		description = "Estudia esto para ser el chofer de los demás. No te harás millonario, pero puedes conocer gente y ganar buenas propinas… Un spoiler: no serás el taxista de deadpool.",
		necesarySp = 3,
		money = 30000,
		skillName = "taxi",
		levelNeeded = nil,
		skillNeeded = nil
		},
		{
		label = "UPS" ,
		title = "UPS",
		description = "Si haces este cursillo ganarás un título para poder entregar cartas. No acabarás como en las películas porno, pero al menos podrás ganarte un dinerito.",
		necesarySp = 3,
		money = 30000,
		skillName = "transport",
		levelNeeded = nil,
		skillNeeded = nil
		},
		{
		label = "Conductor de bus" ,
		title = "Conductor de bus",
		description = "Estudia esto para poder llevar a las viejas y a los pobres por la ciudad.",
		necesarySp = 3,
		money = 30000,
		skillName = "bus",
		levelNeeded = nil,
		skillNeeded = nil
		},
		{
		label = "Piloto" ,
		title = "Piloto",
		description = "Piloto o conductor de aviones, como quieras llamarlo. Ganas un pastón, pero los horarios de trabajo son una puta mierda.",
		necesarySp = 3,
		money = 60000,
		skillName = "pilot",
		levelNeeded = nil,
		skillNeeded = nil
		}
	}

	elements = putInGreen(elements)

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'licenses_university',
		{
			title  = "Licencias",
			align    = 'bottom-right',
			elements = elements
		},
		function(data, menu)
			openSkillBuy(data.current.title,data.current.description,data.current.necesarySp,data.current.skillName,data.current.levelNeeded,data.current.skillNeeded,data.current.money)
			menu.close()
		end,
		function(data, menu)
			menu.close()
		end
	)
end

function EnableGui(enable)
    SetNuiFocus(enable)
    guiEnabled = enable

    SendNUIMessage({
        type = "enableui",
        enable = enable
    })
end

local university = {x = -150.52, y = 6363.0, z = 31.88}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
		DrawMarker(1, university.x, university.y, university.z - 1 , 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,52,155,0, 200, 0, 0, 0, 0)
		if GetDistanceBetweenCoords(university.x, university.y, university.z - 1, x,y,z) < 1.5 then
			drawTxt("PULSE E PARA ABRIR LA UNIVERSIDAD",4, 1, 0.5, 0.835, 0.85,255,255,255,255)
			if IsControlJustPressed(1,38) then
				openUniversityMenu()
			end
		end
	end
end)

local blips = {
	{title="Universidad", colour=1, id=498, x = -150.52, y = 6363.0, z = 31.88}
}
Citizen.CreateThread(function()

    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, 498)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 1.2)
      SetBlipColour(info.blip, 1)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)

Citizen.CreateThread(function()
    while true do
        if guiEnabled then
            DisableControlAction(0, 1, guiEnabled) -- LookLeftRight
            DisableControlAction(0, 2, guiEnabled) -- LookUpDown

            DisableControlAction(0, 142, guiEnabled) -- MeleeAttackAlternate

            DisableControlAction(0, 106, guiEnabled) -- VehicleMouseControlOverride

            if IsDisabledControlJustReleased(0, 142) then -- MeleeAttackAlternate
                SendNUIMessage({
                    type = "click"
                })
            end
        end
        Citizen.Wait(0)
    end
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
