local comienzoruta = false
local estoyenruta = false
local voyacargar = false
local voyaentregar = false
local estoyvolviendo = false
local puntoair = 0
local infojobs = {
	{x = -208.88, y = 6450.56, z = 31.5},
    {x = -128.64, y = 6549.96, z = 29.52},
    {x = -28.8, y = 6457.0, z = 31.24},
    {x = -1439.28, y = 3659.84, z = 34.2},
    {x = 1702.72, y = 3865.84, z = 34.58},
    {x = 1777.68, y = 3728.84, z = 34.02},
    {x = 1706.2, y = 3779.32, z = 34.36},
	{x=-93.72, y =6325.28, z=43.28},
	{x=-38.8, y=6452.6, z=31.28},
	{x=-9.84, y=6560.08,  z=31.28},
	{x=52.92, y=6641.76, z=31.24},
	{x=-8.52,  y=6621.96, z=30.26},
	{x=-451.68, y=6355.24, z=12.28},
	{x=-690.88, y=57771.12, z=17.04},
	{x=-771.28, y=5582.8, z=33.2},
	{x=1584.16, y=6447.72, z=24.44},
	{x=1697.16, y=6422.56, z=32.32}
}
local job = nil
AddEventHandler('playerSpawned', function(spawn)
  TriggerServerEvent('pop_transporte:getJob')
end)
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    TriggerServerEvent('pop_transporte:getJob')
end)
TriggerServerEvent('pop_transporte:getJob')
RegisterNetEvent('pop_transporte:setJob')
AddEventHandler('pop_transporte:setJob',function(jobu)
  job = jobu
end)

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getShtoniaredObjtoniect', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)
----==================----
----=====FUNCIONES====----
----==================----


function drawTxt(text, font, centre, x, y, scale, r, g, b, a)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(centre)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

function creocoche()
	local vehicle = GetHashKey('boxville2')
 
    RequestModel(vehicle)
 
    while not HasModelLoaded(vehicle) do
        Wait(1)
    end
 
	local plate = math.random(100, 900)
	local tractor = CreateVehicle(vehicle,9.84,6333.8,31.24, 111.646, true, false)
	SetVehicleOnGroundProperly(tractor)
	SetVehicleNumberPlateText(tractor, "CTZN"..plate)
	SetPedIntoVehicle(GetPlayerPed(-1), tractor, - 1)
	SetModelAsNoLongerNeeded(vehicle)
	Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(tractor))
	TriggerEvent("advancedFuel:setEssence", 100, GetVehicleNumberPlateText(tractor), GetDisplayNameFromVehicleModel(GetEntityModel(tractor))) 
end

function deleteCar( entity )
    Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) )
end

function eligorandoms()
	puntoair = math.random(1,3)
	voyaentregar = true
end

function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    if num >= 0 then return math.floor(num * mult + 0.5) / mult
    else return math.ceil(num * mult - 0.5) / mult end
end
----==================----
----=====CITIZEN======----
----==================----

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		DrawMarker(1,1.6,6310.8,30.24, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,255,255,51, 200, 0, 0, 0, 0)
		if GetDistanceBetweenCoords(1.6,6310.8,30.24, GetEntityCoords(GetPlayerPed(-1))) < 3.0 then
			if estoyenruta == false then
				if estoyvolviendo == false then
					drawTxt('Presiona ~g~E~s~ para conseguir tu camion', 2, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
					if IsControlJustReleased(1, 38) and job == "transport" then

								ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				                    if skin.sex == 0 then
				                        TriggerEvent('skinchanger:change', 'sex', 0)                    	
				                        TriggerEvent('skinchanger:change', 'tshirt_1', 57)
				                        TriggerEvent('skinchanger:change', 'tshirt_2', 0)
				                        TriggerEvent('skinchanger:change', 'torso_1', 36)
				                        TriggerEvent('skinchanger:change', 'torso_2', 2)
				                        TriggerEvent('skinchanger:change', 'arms', 0)
				                        TriggerEvent('skinchanger:change', 'pants_1', 27)
				                        TriggerEvent('skinchanger:change', 'pants_2', 0)
				                        TriggerEvent('skinchanger:change', 'shoes_1', 25)
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
				                    end                        	
								end)

								creocoche()
								TriggerServerEvent('chaini_karma:addKarmaCl',5.0)
								comienzoruta = true
								voyacargar = true
								estoyenruta = true
								
					elseif IsControlJustReleased(1, 38) and not(job == "transport") then
						TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0},"No eres transportista.")
					end
				else
					drawTxt('Presiona ~g~E~s~ para cobrar tu paga', 2, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
					if IsControlJustReleased(1, 38) then
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
						if IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), true), GetHashKey("boxville2"))  then
							local myPed = GetPlayerPed(-1)
							local myVehicle = GetVehiclePedIsIn(myPed, false)
	                   		SetEntityAsMissionEntity( myVehicle, true, true )
	                    	deleteCar( myVehicle )
	                    	local dineroinicial = math.random(1500,2000)
	                    	local dinerodistancia = GetDistanceBetweenCoords(1.6,6310.8,30.24,infojobs[puntoair].x,infojobs[puntoair].y,infojobs[puntoair].z,true) * 0.5
	                    	dinerodistanciard = round(dinerodistancia,0)
	                    	local dinerofinal = dinerodistanciard + dineroinicial
	                    	TriggerServerEvent('exp:addExperience',65)
	                    	RegisterNetEvent('pop_transporte:paga')
	                    	TriggerServerEvent('pop_transporte:paga',dinerofinal)
	                    	TriggerEvent('chatMessage', 'SYSTEM', {255,0,0},"====================================================")
	                    	TriggerEvent('chatMessage', 'SYSTEM', {255,0,0}, " Paga inicial:" ..dineroinicial.."$")
	                    	TriggerEvent('chatMessage', 'SYSTEM', {255,0,0}, " Paga por distancia:" ..dinerodistanciard.."$")
	                    	TriggerEvent('chatMessage', 'SYSTEM', {255,0,0}, "Paga final:" ..dinerofinal.."$")
	                    	TriggerEvent('chatMessage', 'SYSTEM', {255,0,0}, "===================================================")
	                    	estoyvolviendo = false
						else
							TriggerEvent('chatMessage', 'TRANSPORTES S.L.', {255, 0, 0},"Debes devolver tu camión.")
						end
					end
				end
			else
				drawTxt('Presiona ~g~E~s~ para finalizar tu trabajo sin cobrar', 2, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
				if IsControlJustReleased(1, 38) then
					if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
						local vehicleu = GetVehiclePedIsIn(GetPlayerPed(-1), false)
	                    SetEntityAsMissionEntity( vehicleu, true, true )
	                    deleteCar( vehicleu )
						comienzoruta = false
						voyacargar = false
						estoyenruta = false
						estoyvolviendo = false
						voyaentregar = false
						TriggerEvent('chatMessage', 'TRANSPORTES S.L.', {255, 0, 0},"Tu camión ha sido devuelto.")
					else
						TriggerEvent('chatMessage', 'TRANSPORTES S.L.', {255, 0, 0},"Debes devolver tu camión.")
					end
				end
			end
		end
		if voyacargar then
			drawTxt('Ve a cargar el camion', 2, 1, 0.5, 1, 0.6, 255, 255, 255, 255)
			DrawMarker(1,-14.68,6314.68,30.24, 0, 0, 0, 0, 0, 0, 2.5001, 2.5001, 1.6001,98,192,249, 200, 0, 0, 0, 0)
			if GetDistanceBetweenCoords(-14.68,6314.68,30.24,  GetEntityCoords(GetPlayerPed(-1))) < 2.0 then
				FreezeEntityPosition(GetVehiclePedIsIn(GetPlayerPed(-1), false),true)
				Wait(5000)
				FreezeEntityPosition(GetVehiclePedIsIn(GetPlayerPed(-1), false),false)
				TriggerEvent('chatMessage', 'TRANSPORTES S.L.', {255, 0, 0},"Camión cargado.")
				voyacargar = false
				eligorandoms()
			end
		end
		if voyaentregar then
			drawTxt('Ve a entregar la carga', 2, 1, 0.5, 1, 0.6, 255, 255, 255, 255)
			DrawMarker(1,infojobs[puntoair].x,infojobs[puntoair].y,infojobs[puntoair].z, 0, 0, 0, 0, 0, 0, 2.5001, 2.5001, 1.6001,98,192,249, 200, 0, 0, 0, 0)
			SetNewWaypoint(infojobs[puntoair].x,infojobs[puntoair].y)
			if GetDistanceBetweenCoords(infojobs[puntoair].x,infojobs[puntoair].y,infojobs[puntoair].z, GetEntityCoords(GetPlayerPed(-1))) < 2.0 then
				if not IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
					TriggerEvent('chatMessage', 'TRANSPORTES S.L.', {255, 0, 0},"DEBES ESTAR EN TU CAMIÓN.")
				else
					TriggerEvent('chatMessage', 'TRANSPORTES S.L.', {255, 0, 0},"Espera mientras descargas la mercancía.")
					FreezeEntityPosition(GetVehiclePedIsIn(GetPlayerPed(-1), false),true)
					Wait(5000)
					FreezeEntityPosition(GetVehiclePedIsIn(GetPlayerPed(-1), false),false)
					voyacargar = false
					voyaentregar = false
					estoyenruta = false
					estoyvolviendo = true
				end
			end
		end
		if estoyvolviendo then
			drawTxt('Vuelve a la central para cobrar y poder elegir un nuevo destino', 2, 1, 0.5, 1, 0.6, 255, 255, 255, 255)
			SetNewWaypoint(1.6,6310.8)
		end
		if IsEntityDead(GetPlayerPed(-1)) then 
			estoyvolviendo = false
      		estoyenruta = false
      		voyaentregar = false
      		voyacargar = false
      		comienzoruta = false
		end
	end
end)


----==================----
----=======BLIPS======----
----==================----
local blips = {
    {title="Correos", colour=2, id=479, x = 1.6, y = 6310.8, z = 30.24},
}
 
Citizen.CreateThread(function()
	Citizen.Wait(0)
    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.9)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end

end)

