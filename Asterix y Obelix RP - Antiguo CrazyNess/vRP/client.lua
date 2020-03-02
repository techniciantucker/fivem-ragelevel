-- local Tunnel = module("vrp","lib/Tunnel")
-- local Proxy = module("vrp","lib/Proxy")
-- vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
-- local hour = 0
-- local minute = 0
-- local segundos = 0
-- local month = ""
-- local dayOfMonth = 0
local voice = 1
local voiceDisplay = "<span style='color:white'><img class='microfone' src='img/mic.png'>Normal</span>"
local proximity = 2
local sBuffer = {}
local vBuffer = {}
local CintoSeguranca = false
local ExNoCarro = false
local gasolina = 0
local started = true
local displayValue = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- DATA E HORA
-----------------------------------------------------------------------------------------------------------------------------------------
-- function CalculateTimeToDisplay()
	-- hour = GetClockHours()
	-- minute = GetClockMinutes()
	-- if hour <= 9 then
		-- hour = "0" .. hour
	-- end
	-- if minute <= 9 then
		-- minute = "0" .. minute
	-- end
-- end

-- function CalculateDateToDisplay()
	-- month = GetClockMonth()
	-- dayOfMonth = GetClockDayOfMonth()
	-- if month == 0 then
		-- month = "Enero"
	-- elseif month == 1 then
		-- month = "Febrero"
	-- elseif month == 2 then
		-- month = "Marzo"
	-- elseif month == 3 then
		-- month = "Abril"
	-- elseif month == 4 then
		-- month = "Mayo"
	-- elseif month == 5 then
		-- month = "Junio"
	-- elseif month == 6 then
		-- month = "Julio"
	-- elseif month == 7 then
		-- month = "Agosto"
	-- elseif month == 8 then
		-- month = "Septiembre"
	-- elseif month == 9 then
		-- month = "Ostubre"
	-- elseif month == 10 then
		-- month = "Nomienbre"
	-- elseif month == 11 then
		-- month = "Diciembre"
	-- end
-- end

-- Citizen.CreateThread(function()
	-- while true do
		-- Citizen.Wait(1000)	
		-- CalculateTimeToDisplay()
		-- CalculateDateToDisplay()
	-- end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VOICE
-----------------------------------------------------------------------------------------------------------------------------------------
-- AddEventHandler("playerSpawned",function()
	-- NetworkSetTalkerProximity(1.0)
	-- started = true
-- end)

-- Citizen.CreateThread(function()
	-- while true do
		-- Citizen.Wait(1000)
		-- setVoice()
	-- end
-- end)

-- function setVoice()
	-- NetworkSetTalkerProximity(1.0)
	-- NetworkClearVoiceChannel()
-- end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD
-----------------------------------------------------------------------------------------------------------------------------------------
-- local menu_celular = false
-- RegisterNetEvent("status:celular")
-- AddEventHandler("status:celular",function(status)
	-- menu_celular = status
-- end)


-- local inventarioState = false
-- RegisterNetEvent("status:inventario")
-- AddEventHandler("status:inventario",function(status)
	-- inventarioState = status
-- end)


local zones = { ['AIRP'] = "Los Santos International Airport", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon Dr", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain State Wilderness", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora Desert", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo Lighthouse", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "GWC and Golfing Society", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Paleto Cove", ['PALETO'] = "Paleto Bay", ['PALFOR'] = "Paleto Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Lights Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski Mountain Range", ['SANDY'] = "Sandy Shores", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Ron Alternates Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port of South Los Santos", ['ZQ_UAR'] = "Davis Quartz" } or "Não encontrado"

Citizen.CreateThread(function()
    local currSpeed = 0.0
    local cruiseSpeed = 999.0
    local cruiseIsOn = false
    local seatbeltIsOn = false
	while true do
		Citizen.Wait(10)
		ped = PlayerPedId()
		health = (GetEntityHealth(ped)-100)/300*100
		armor = GetPedArmour(ped)
        --health = GetEntityHealth(PlayerPedId())/2/10
        --armor = GetPedArmour(PlayerPedId())		
		local x,y,z = table.unpack(GetEntityCoords(ped,false))
		if IsControlJustPressed(1,101) and GetEntityHealth(ped) > 100 then
			if proximity == 1 then
				voiceDisplay = "<span style='color:white'><img class='microfone' src='img/mic.png'>Normal</span>"
				proximity = 2
			elseif proximity == 2 then
				voiceDisplay = "<span style='color:white'><img class='microfone' src='img/mic3.png'>Gritando</span>"
				proximity = 3
			elseif proximity == 3 then
				voiceDisplay = "<span style='color:white'><img class='microfone' src='img/mic2.png'>Sussurro</span>"
				proximity = 1
			end
		end
		HideHudComponentThisFrame(1) 
		HideHudComponentThisFrame(2) 
		HideHudComponentThisFrame(3) 
		HideHudComponentThisFrame(4) 
		HideHudComponentThisFrame(6) 
		HideHudComponentThisFrame(7) 
		HideHudComponentThisFrame(8)
		HideHudComponentThisFrame(9)
		HideHudComponentThisFrame(13)
		HideHudComponentThisFrame(17)
		HideHudComponentThisFrame(20) 
		HideHudComponentThisFrame(5)
		HideHudComponentThisFrame(21) 

		
		
		if IsPedInAnyVehicle(ped) then
			DisplayRadar(true)
			inCar  = true
			PedCar = GetVehiclePedIsIn(ped)
			speed = math.ceil(GetEntitySpeed(PedCar)*3.605936)
			rpm = GetVehicleCurrentRpm(PedCar)
			nsei,baixo,alto = GetVehicleLightsState(PedCar)
			if baixo == 1 and alto == 0 then
				farol = 1
			elseif  alto == 1 then
				farol = 2
			else
				farol = 0
			end
			if GetEntitySpeed(PedCar) == 0 and GetVehicleCurrentGear(PedCar) == 0  then
				marcha = "P"
			elseif GetEntitySpeed(PedCar) ~= 0 and GetVehicleCurrentGear(PedCar) == 0  then
				marcha = "R"
			else
				marcha = GetVehicleCurrentGear(PedCar)
			end
		 	--gasolina = GetVehicleFuelLevel(PedCar)
			gasolina = DecorGetInt(PedCar, "_Fuel_Level") * 0.001
			VehIndicatorLight = GetVehicleIndicatorLights(PedCar)
			if(VehIndicatorLight == 0) then
				piscaEsquerdo = false
				piscaDireito = false
			elseif(VehIndicatorLight == 1) then
				piscaEsquerdo = true
				piscaDireito = false
			elseif(VehIndicatorLight == 2) then
				piscaEsquerdo = false
				piscaDireito = true
			elseif(VehIndicatorLight == 3) then
				piscaEsquerdo = true
				piscaDireito = true
			end		
		else	
			-- DisplayRadar(false)
			inCar  = false
			PedCar = 0
			speed = 0
			rpm = 0
			marcha = 0
			cruiseIsOn = false
			VehIndicatorLight = 0
		end
		SendNUIMessage({
			show = show,
			incar = inCar,
			speed = speed,
			rpm = rpm,
			gear = marcha,
			heal = health,
			armor = armor,
			dia = dayOfMonth,
			mes = month,
			hora = hour,
			minuto = minute,
			voz = voiceDisplay,
			piscaEsquerdo = piscaEsquerdo,
			piscaDireito = piscaDireito,
			gas = gasolina,
			cinto = CintoSeguranca,
			farol = farol,
			cruise = cruiseIsOn,
		 	display = displayValue,
		 	rua = street,
		 	rua2 = street2
		});
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CINTO DE SEGURANÇA
-----------------------------------------------------------------------------------------------------------------------------------------
IsCar = function(veh)
	local vc = GetVehicleClass(veh)
	return (vc >= 0 and vc <= 7) or (vc >= 9 and vc <= 12) or (vc >= 17 and vc <= 20)
end	
Fwv = function (entity)
	local hr = GetEntityHeading(entity) + 90.0
	if hr < 0.0 then
		hr = 360.0 + hr
	end
	hr = hr * 0.0174533
	return { x = math.cos(hr) * 2.0, y = math.sin(hr) * 2.0 }
end
local segundos = 0
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if inCar then
			local ped = PlayerPedId()
			local car = GetVehiclePedIsIn(ped)
			if car ~= 0 and (ExNoCarro or IsCar(car)) then
				ExNoCarro = true
				if CintoSeguranca then
					DisableControlAction(0,75)
				end

				sBuffer[2] = sBuffer[1]
				sBuffer[1] = GetEntitySpeed(car)

				if sBuffer[2] ~= nil and not CintoSeguranca and GetEntitySpeedVector(car,true).y > 1.0 and sBuffer[1] > 10.25 and (sBuffer[2] - sBuffer[1]) > (sBuffer[1] * 0.255) then
					local co = GetEntityCoords(ped)
					local fw = Fwv(ped)
					SetEntityHealth(ped,GetEntityHealth(ped)-150)
					SetEntityCoords(ped,co.x+fw.x,co.y+fw.y,co.z-0.47,true,true,true)
					SetEntityVelocity(ped,vBuffer[2].x,vBuffer[2].y,vBuffer[2].z)
					segundos = 20
				end
				vBuffer[2] = vBuffer[1]
				vBuffer[1] = GetEntityVelocity(car)
				if IsControlJustReleased(1,29) then
					TriggerEvent("cancelando",true)
					if CintoSeguranca then
						TriggerEvent("vrp_sound:source",'unbelt',0.5)
						SetTimeout(2000,function()
							CintoSeguranca = false
							TriggerEvent("cancelando",false)
						end)
					else
						TriggerEvent("vrp_sound:source",'belt',0.5)
						SetTimeout(3000,function()
							CintoSeguranca = true
							TriggerEvent("cancelando",false)
						end)
					end
				end
			elseif ExNoCarro then
				ExNoCarro = false
				CintoSeguranca = false
				sBuffer[1],sBuffer[2] = 0.0,0.0
			end
		end
	end
end)
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SOM DAS SETAS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(300)
		if VehIndicatorLight == 1 or VehIndicatorLight == 2 or VehIndicatorLight == 3 then
			TriggerEvent('vrp_sound:source','setas1', 0.9)
			Citizen.Wait(300)
			TriggerEvent('vrp_sound:source','setas2', 0.9)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OCULTA A HUD QUANDO PAUSA
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
    Citizen.Wait(100)
      	if started then 
	        if IsPauseMenuActive() or menu_celular or inventarioState then
	            displayValue = false
	        else
	            displayValue = true
	        end
	  	end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CONTAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if segundos > 0 then
			segundos = segundos - 1
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RAGDOLL
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if segundos > 0 and GetEntityHealth(PlayerPedId()) > 100 then
			SetPedToRagdoll(PlayerPedId(),1000,1000,0,0,0,0)
		end
	end
end)
