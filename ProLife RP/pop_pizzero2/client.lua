-----------------------------------------------------------------------------------------------
--SCRIPT CREADO PARA EL SERVIDOR DE FIVEM DE PLATA O PLOMO COMUNIDAD GAMER.
--SCRIPT CREADO TOTALMENTE POR THEMAYKELLLL1 [ MIGUEL ANGEL LOPEZ REYES ].
--PLATA O PLOMO COMUNIDAD GAMER ACEPTA NO VENDER / REGALAR / PASAR ESTOS SCRIPTS A OTRAS PERSONAS O COMUNIDADES.
-----------------------------------------------------------------------------------------------


-------------------------------------------
------------------VARIABLES----------------
-------------------------------------------
ESX                           = nil


Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getShtoniaredObjtoniect', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)


local pizzeria = { x = 1756.95, y = 3871.56, z = 33.57}
local spawnfaggio = { x = 1763.26, y = 3861.01, z = 34.35 }

local propina = 0
local posibilidad = 0

local casas = {
    [1] = {name = "Shandy1",x = 1623.58, y = 3657.43 , z = 34.76},
    [2] = {name = "Shandy2",x = 1841.49, y = 3777.62 , z = 33.16},
    [3] = {name = "Shandy3",x = 1691.56, y = 3865.86 , z = 34.90},
    [4] = {name = "Shandy4",x = 1413.31, y = 3664.07 , z = 34.40},
}

local isInJobPizz = false
local sigcasa = 0
local plateab = "POPJOBS"
local isToHouse = false
local isToPizzaria = false
local multiplicador_De_dinero = 2.03 
local paga = 0
local px = 0
local py = 0
local pz = 0
local job = nil

AddEventHandler('playerSpawned', function(spawn)
	TriggerServerEvent('pop_pizzero:getJob')
end)
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  	TriggerServerEvent('pop_pizzero:getJob')
end)

local blips = {
	{title="Pizzeria", colour=66, id=267, x = 1756.95, y = 3871.56, z = 33.57}, 
}

-------------------------------------------
--------------------BLIPS------------------
-------------------------------------------

Citizen.CreateThread(function()
    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x,info.y,info.z)
      SetBlipSprite(info.blip, 267)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.9)
      SetBlipColour(info.blip, 66)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)

function Iracasa(casas,sigcasa)
	blip_casa = AddBlipForCoord(casas[sigcasa].x,casas[sigcasa].y, casas[sigcasa].z)
	SetBlipSprite(blip_casa, 1)
	SetNewWaypoint(casas[sigcasa].x,casas[sigcasa].y)
end

-------------------------------------------
------------------CITIZENS-----------------
-------------------------------------------

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if isInJobPizz == false then
			DrawMarker(1,pizzeria.x,pizzeria.y,pizzeria.z, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,255,255,51, 200, 0, 0, 0, 0)
			if GetDistanceBetweenCoords(pizzeria.x, pizzeria.y, pizzeria.z, GetEntityCoords(GetPlayerPed(-1),true)) < 1.5 then
				drawTxt("PULSA <E> PARA COMENZAR A TRABAJAR DE PIZZERO",2, 1, 0.45, 0.03, 0.80,255,255,51,255)
				if IsControlJustPressed(1,38) and job == "pizza" then

					ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
			          if skin.sex == 0 then
			            TriggerEvent('skinchanger:change', 'tshirt_1', 57)
                        TriggerEvent('skinchanger:change', 'tshirt_2', 0)
                        TriggerEvent('skinchanger:change', 'torso_1', 36)
                        TriggerEvent('skinchanger:change', 'torso_2', 1)
                        TriggerEvent('skinchanger:change', 'arms', 0)
                        TriggerEvent('skinchanger:change', 'pants_1', 27)
                        TriggerEvent('skinchanger:change', 'pants_2', 1)
                        TriggerEvent('skinchanger:change', 'shoes_1', 22)
                        TriggerEvent('skinchanger:change', 'shoes_2', 0)
                        TriggerEvent('skinchanger:change', 'chain_1', 0)
                        TriggerEvent('skinchanger:change', 'chain_2', 0)
                        TriggerEvent('skinchanger:change', 'helmet_1', -1)
                        TriggerEvent('skinchanger:change', 'helmet_2', 0)
                        TriggerEvent('skinchanger:change', 'mask_1', 0)
                        TriggerEvent('skinchanger:change', 'mask_2', 0)
                        TriggerEvent('skinchanger:change', 'decals_1', 0)
                        TriggerEvent('skinchanger:change', 'decals_2', 0)
                        TriggerEvent('skinchanger:change', 'bags_1', 0)
                        TriggerEvent('skinchanger:change', 'bags_2', 0)
                        TriggerEvent('skinchanger:change', 'glasses_1', 0)
                        TriggerEvent('skinchanger:change', 'glasses_2', 0)
                        TriggerEvent('skinchanger:change', 'bproof_1', 0)
                        TriggerEvent('skinchanger:change', 'bproof_2', 0)
			          else
			            TriggerEvent('skinchanger:change', 'tshirt_1', 26)
			          end
			        end)
					
					isInJobPizz = true
					isToHouse = true
					sigcasa = math.random(4, 18)
					-- [INFO] TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, sigcasa)
					px = casas[sigcasa].x
					py = casas[sigcasa].y
					pz = casas[sigcasa].z
					distancia = round(GetDistanceBetweenCoords(pizzeria.x, pizzeria.y, pizzeria.z, px,py,pz))
					paga = distancia * multiplicador_De_dinero
					-- [INFO] TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, distancia)
					spawn_faggio()

					Iracasa(casas,sigcasa)
					Citizen.Wait(1000)
				elseif IsControlJustPressed(1,38) and not(job == "pizza") then
					TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "No eres pizzero.")
				end
			end
		end
		if isToHouse == true then
			destinol = casas[sigcasa].name
			drawTxt("DIRIGETE A "..destinol.." PARA ENTREGAR LA PIZZA",4, 1, 0.45, 0.92, 0.70,255,255,255,255)
			DrawMarker(1,casas[sigcasa].x,casas[sigcasa].y,casas[sigcasa].z, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,255,255,51, 200, 0, 0, 0, 0)
			if GetDistanceBetweenCoords(px,py,pz, GetEntityCoords(GetPlayerPed(-1),true)) < 3 then
				drawTxt("PULSA <E> PARA ENTREGAR LA PIZZA",2, 1, 0.45, 0.03, 0.80,255,255,51,255)
				if IsControlJustPressed(1,38) then
					if IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), true), GetHashKey("faggio2"))  then
						posibilidad = math.random(1, 100)
						if (posibilidad > 70) and (posibilidad < 90) then
							propina = math.random(400, 500)
							TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0},"Toma de propina : "..propina.."€")
							TriggerServerEvent("pop_pizzero:propina", propina)
						end
						isToHouse = false
						isToPizzaria = true
						RemoveBlip(blip_casa)
						SetNewWaypoint(pizzeria.x,pizzeria.y)
					else
						TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0},"¿De qué vehículo sacas la pizza?")
					end
				end
			end
		end
		if isToPizzaria == true then
			drawTxt("DIRIGETE A LA PIZZERIA PARA COBRAR",4, 1, 0.45, 0.92, 0.70,255,255,255,255)
			DrawMarker(1,pizzeria.x,pizzeria.y,pizzeria.z, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,255,255,51, 200, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(pizzeria.x,pizzeria.y,pizzeria.z, GetEntityCoords(GetPlayerPed(-1),true)) < 3 then
					drawTxt("PULSA <E> PARA COBRAR",2, 1, 0.45, 0.03, 0.80,255,255,51,255)
					if IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), true), GetHashKey("faggio2"))  then
						if IsControlJustPressed(1,38) then
							if IsInVehicle() then
								ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
									local model = nil
						  
									if skin.sex == 0 then
									  model = GetHashKey("mp_m_freemode_01")
									else
									  model = GetHashKey("mp_f_freemode_01")
									end
						  
									RequestModel(model)
									while not HasModelLoaded(model) do
									  RequestModel(model)
									  Citizen.Wait(1)
									end
						  
									SetPlayerModel(PlayerId(), model)
									SetModelAsNoLongerNeeded(model)
						  
									TriggerEvent('skinchanger:loadSkin', skin)
									TriggerEvent('esx:restoreLoadout')
								  end)
								ESX.UI.Menu.CloseAll()
								TriggerServerEvent('exp:addExperience',45)
								TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0},"Gracias por hacer el reparto, toma la paga: "..paga.."€")
								TriggerServerEvent("pop_pizzero:propina", paga)
								isToHouse = false
								isToPizzaria = false
								isInJobPizz = false
								paga = 0
								px = 0
								py = 0
								pz = 0
								local vehicleu = GetVehiclePedIsIn(GetPlayerPed(-1), false)
								SetEntityAsMissionEntity( vehicleu, true, true )
			               		deleteCar( vehicleu )
							else
								TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0},"No te voy a pagar si no me entregas mi moto, lo siento.")
							end
						end
					else
						TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0},"No te voy a pagar si no me entregas mi moto, lo siento.")
					end
				end
		end
		if IsEntityDead(GetPlayerPed(-1)) then
			 isInJobPizz = false
			 sigcasa = 0
			 isToHouse = false
			 isToPizzaria = false
			 paga = 0
			 px = 0
			 py = 0
			 pz = 0
		end
	end
end)

-------------------------------------------
----------------FUNCIONES------------------
-------------------------------------------

function spawn_faggio()
	Citizen.Wait(0)

	local myPed = GetPlayerPed(-1)
	local player = PlayerId()
	local vehicle = GetHashKey('faggio2')

	RequestModel(vehicle)

	while not HasModelLoaded(vehicle) do
		Wait(1)
	end

	local plate = math.random(100, 900)
	local spawned_car = CreateVehicle(vehicle, spawnfaggio.x,spawnfaggio.y,spawnfaggio.z, 431.436, - 996.786, 25.1887, true, false)

	local plate = "CTZN"..math.random(100, 900)
    SetVehicleNumberPlateText(spawned_car, plate)
	SetVehicleOnGroundProperly(spawned_car)
	SetVehicleLivery(spawned_car, 2)
	SetPedIntoVehicle(myPed, spawned_car, - 1)
	SetModelAsNoLongerNeeded(vehicle)
	Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(spawned_car))
	TriggerEvent("advancedFuel:setEssence", 100, GetVehicleNumberPlateText(spawned_car), GetDisplayNameFromVehicleModel(GetEntityModel(spawned_car)))
end

function round(num, numDecimalPlaces)
	local mult = 5^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

function deleteCar( entity )
    Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) )
end

function IsInVehicle()
  local ply = GetPlayerPed(-1)
  if IsPedSittingInAnyVehicle(ply) then
    return true
  else
    return false
  end
end

-------------------------------------------
----------FUNCIONES ADICIONALES------------
-------------------------------------------

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

RegisterNetEvent('pop_pizzero:setJob')
AddEventHandler('pop_pizzero:setJob',function(jobu)
	job = jobu
end)