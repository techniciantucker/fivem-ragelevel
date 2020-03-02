ESX                           = nil
local isPlayed = false
local isInJob = false
local jobFase = 0
local NPCs = {
	{x = -453.04, y = 6197.56, z = 29.56,hash = -1922568579,rot = 0.0, top = "Don ~r~Antoine ToutDoux", id = 'reyes',anim = 'WORLD_HUMAN_SMOKING'},
	{x = -454.92, y = 6198.56, z = 29.56,hash = -1731772337,rot = -90.0, top = "Sr ~r~Cholo Simeone", id = 'rockefeller',anim = 'world_human_leaning'},
	{x = -452.64, y = 6200.52, z = 29.56,hash = 919005580,rot = 145.0, top = "Cp ~r~Awesome", id = 'marcos',anim = 'WORLD_HUMAN_PARTYING'},
	{x = -455.24, y = 6205.08, z = 29.56,hash = -1040164288,rot = -180.0, top = "Rct ~r~Carlos Santos", id = 'carlos',anim = 'WORLD_HUMAN_PARTYING'},
	{x = -455.08, y = 6203.96, z = 29.56,hash = -277325206,rot = 90.0, top = "Rct ~r~Asikause", id = 'asikause',anim = 'mp_player_int_grab_crotch'},
	{x = -456.16, y = 6207.16, z = 29.56,hash = 874722259,rot = -90.0, top = "Padre ~r~Nico", id = 'nico',anim = 'WORLD_HUMAN_SMOKING'}
}
local Doors = {
	{x = -442.72, y = 6197.88, z = 29.56 },
	{ x = -467.92, y = 6206.04, z = 29.56 }
}
local cars = {
	{x = -437.92, y = 6210.2, z = 29.72, h = 255.0},
	{x = -437.48, y = 6204.44, z = 29.56, h = 300.0}
} 
local interactSound = { x = -443.88, y = 6207.52, z = 29.56 }
local centerOfTheHouse = { x = -451.08, y = 6198.52, z = 32.84 }
local jobs = {
	{
		id = 'reyes',
		name = 'Antoine ToutDoux',
		car = 'Crusader',
		posX = 2414.56,
		posY = 4991.8,
		posZ = 46.2,
		noText = 'Ya nos veremos otro día',
		msg = 'Eio loco, llevame el coche ese de ahí atrás, el de camuflaje militar, llevalo a este punto del gps y después me lo traes.',
		msgEntrega = '[E] - Dejame mirar lo que tienes aquí',
		msgErrorCar = '¿Me como este coche o klk?',
		msgToFinal = 'Ve y pídele a tu jefe que te de el dinero...',
		msgToMoney = 'Recoge el dinero',
		msgFinal = '[E] - Deja el coche aquí.',
		isInJob = 'Buen.',
		carX = -451.48,
		carY = 6181.48,
		carZ = 29.6,
		carH = -90.0,
		wait = 6000,
		money = 10000,
		successMSG = "Gracias por el trabajo",
		exp = 95
	},
	{
		id = 'rockefeller',
		name = 'Cholo Simeone',
		car = 'Crusader',
		posX = -2544.64,
		posY = 2321.12,
		posZ = 33.04,
		noText = 'Ya nos veremos otro día',
		msg = 'A ver, para dirección los santos, después de cruzar el puente hay una gasolinera, llévame el coche ahí, el de detrás y me lo traes.',
		msgEntrega = '[E] - Dejame mirar lo que tienes aquí',
		msgErrorCar = '¿Me como este coche o klk?',
		msgToFinal = 'Ve y pídele a tu jefe que te de el dinero...',
		msgToMoney = 'Recoge el dinero',
		msgFinal = '[E] - Deja el coche aquí.',
		isInJob = 'Buen.',
		carX = -451.48,
		carY = 6181.48,
		carZ = 29.6,
		carH = -90.0,
		wait = 6000,
		money = 10000,
		successMSG = "Gracias por el trabajo",
		exp = 95
	},
	{
		id = 'marcos',
		name = 'Awesome',
		car = 'Crusader',
		posX = -311.0,
		posY = 2789.36,
		posZ = 59.52,
		noText = 'Ya nos veremos otro día',
		msg = 'Coge el crusader, me das acciones de facebo.. digo, lo llevas a la iglesia perdida del condado de blayne y me lo traes, pero rapidito',
		msgEntrega = '[E] - Dejame mirar lo que tienes aquí',
		msgErrorCar = '¿Me como este coche o klk?',
		msgToFinal = 'Ve y pídele a tu jefe que te de el dinero...',
		msgToMoney = 'Recoge el dinero',
		msgFinal = '[E] - Deja el coche aquí.',
		isInJob = 'Buen.',
		carX = -451.48,
		carY = 6181.48,
		carZ = 29.6,
		carH = -90.0,
		wait = 6000,
		money = 13000,
		successMSG = "Gracias por el trabajo",
		exp = 115
	},
	{
		id = 'carlos',
		name = 'Carlos Santos',
		car = 'Crusader',
		posX = 1552.24,
		posY = 2192.16,
		posZ = 78.88,
		noText = 'Ya nos veremos otro día',
		msg = 'Ve al sitio que te he marcado en el mapa y me traes el coche, no hagas preguntas.',
		msgEntrega = '[E] - Dejame mirar lo que tienes aquí',
		msgErrorCar = '¿Me como este coche o klk?',
		msgToFinal = 'Ve y pídele a tu jefe que te de el dinero...',
		msgToMoney = 'Recoge el dinero',
		msgFinal = '[E] - Deja el coche aquí.',
		isInJob = 'Buen.',
		carX = -451.48,
		carY = 6181.48,
		carZ = 29.6,
		carH = -90.0,
		wait = 6000,
		money = 15000,
		successMSG = "Gracias por el trabajo",
		exp = 135
	},
	{
		id = 'asikause',
		name = 'Asikause',
		car = 'Crusader',
		posX = -41.96,
		posY = 1882.48,
		posZ = 195.76,
		noText = 'Ya nos veremos otro día',
		msg = 'A ver, ahí, hay, ahi, coge el coche oooh, y lleva.. bueno si sabes que hacer perfectamente, rápido.',
		msgEntrega = '[E] - Dejame mirar lo que tienes aquí',
		msgErrorCar = '¿Me como este coche o klk?',
		msgToFinal = 'Ve y pídele a tu jefe que te de el dinero...',
		msgToMoney = 'Recoge el dinero',
		msgFinal = '[E] - Deja el coche aquí.',
		isInJob = 'Buen.',
		carX = -451.48,
		carY = 6181.48,
		carZ = 29.6,
		carH = -90.0,
		wait = 6000,
		money = 17000,
		successMSG = "Gracias por el trabajo",
		exp = 135
	},
	{
		id = 'nico',
		name = 'Nico',
		car = 'Crusader',
		posX = 2405.76,
		posY = 3126.44,
		posZ = 48.2,
		noText = 'Ya nos veremos otro día',
		msg = 'Bliet, ve a dejar la mercancia en su sitio y no hagas preguntas.',
		msgEntrega = '[E] - Dejame mirar lo que tienes aquí',
		msgErrorCar = '¿Me como este coche o klk?',
		msgToFinal = 'Ve y pídele a tu jefe que te de el dinero...',
		msgToMoney = 'Recoge el dinero',
		msgFinal = '[E] - Deja el coche aquí.',
		isInJob = 'Buen.',
		carX = -451.48,
		carY = 6181.48,
		carZ = 29.6,
		carH = -90.0,
		wait = 6000,
		money = 14000,
		successMSG = "Gracias por el trabajo",
		exp = 115
	}
}
local actualJob = {}
local freeze = false
AddEventHandler('playerSpawned', function(spawn)
	TriggerServerEvent('tm1_donreyes:spawnFirstCar')
end)
TriggerServerEvent('tm1_donreyes:spawnFirstCar')

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getShtoniaredObjtoniect', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	spawnPeds()
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
		if freeze == true then
			DrawText3D(x, y, z, "Descargando...", 255,255,255)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
		----------------------------------
		------------TRABAJOS--------------
		----------------------------------
		if isInJob == true then
			if jobFase == 0 then
				drawTxt("Estas en un cargo de ~r~"..actualJob.name.."~w~, lleva la mercancia.",4, 1, 0.50, 0.845, 0.55,255,255,255,255)
				DrawMarker(1,actualJob.posX,actualJob.posY,actualJob.posZ - 1, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,255,0,0, 200, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(actualJob.posX,actualJob.posY,actualJob.posZ,x,y,z) < 3.0 then
					DrawText3D(actualJob.posX,actualJob.posY,actualJob.posZ, actualJob.msgEntrega, 255,255,255)
					if IsControlJustPressed(1,38) then
						local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), true)
						if IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), true), GetHashKey(actualJob.car)) then
							FreezeEntityPosition(vehicle, true)
							freeze = true
							Citizen.Wait(actualJob.wait)
							freeze = false
							FreezeEntityPosition(vehicle, false)
							jobFase = 1
							RemoveBlip(blip)
							blip = AddBlipForCoord(actualJob.carX,actualJob.carY,actualJob.carZ)
							SetBlipRoute(blip, true)
							successarea(actualJob.msgToFinal,3000)
						else
							errorarea(actualJob.msgErrorCar,3000)
						end
					end
				end
			end
			if jobFase == 1 then
				drawTxt("Estas en un cargo de ~r~"..actualJob.name.."~w~, devuelve el coche.",4, 1, 0.50, 0.845, 0.55,255,255,255,255)
				DrawMarker(1,actualJob.carX,actualJob.carY,actualJob.carZ - 1, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,255,0,0, 200, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(actualJob.carX,actualJob.carY,actualJob.carZ,x,y,z) < 3.0 then
					DrawText3D(actualJob.carX,actualJob.carY,actualJob.carZ, actualJob.msgFinal, 255,255,255)
					if IsControlJustPressed(1,38) then
						if IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), true), GetHashKey(actualJob.car)) then
							local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), true)
							jobFase = 2
							FreezeEntityPosition(vehicle, true)
							successarea(actualJob.msgToMoney,3000)
							RemoveBlip(blip)
							SetEntityAsMissionEntity(vehicle,true,true)
			   			 	deleteCar(vehicle)
						else
							errorarea(actualJob.msgErrorCar,3000)
						end
					end
				end
			end
			if jobFase == 2 then
				drawTxt("Estas en un cargo de ~r~"..actualJob.name.."~w~, recoge el dinero.",4, 1, 0.50, 0.845, 0.55,255,255,255,255)			
			end
		end

		if IsEntityDead(GetPlayerPed(-1)) then
			isInJob = false
			jobFase = 0
			actualJob = {}
		end
		---------------------------------
		------------SONIDOS--------------
		---------------------------------
		if GetDistanceBetweenCoords(interactSound.x,interactSound.y,interactSound.z,x,y,z) < 3 and isPlayed == false then
			SendNUIMessage({
		        transactionType     = 'playSound',
		        transactionFile     = 'padrino',
		        transactionVolume   = 0.2
		    })
		    countDownMusic()
		end
		for i,v in pairs(NPCs) do
			if GetDistanceBetweenCoords(v.x,v.y,v.z,x,y,z) < 3.0 then
				DrawText3D(v.x,v.y,v.z + 1, v.top, 255,255,255)
				if IsControlJustPressed(1,38) then
					if GetDistanceBetweenCoords(v.x,v.y,v.z,x,y,z) < 0.8 then
						SendNUIMessage({
					        transactionType     = 'playSound',
					        transactionFile     = v.id,
					        transactionVolume   = 0.2
				    	})
				    	local data = getJobData(v.id)
				    	if data == false then
				    		errorarea("No se encuentra nada",3000)
				    	else
				    		if isInJob == false then
				    			openJobMenu(data)
				    		else
				    			if v.id == actualJob.id and jobFase == 2 then
				    				openGetMoney()
				    			else
				    				errorarea("¿Que haces hablando conmigo?",3000)
				    			end
				    		end
				    	end
				    end
			    end
			end
		end
		if GetDistanceBetweenCoords(centerOfTheHouse.x,centerOfTheHouse.y,centerOfTheHouse.z,x,y,z) < 30.0 then
			drawTxt("Estas en dominios de ~r~Mafia",4, 1, 0.88, 0.935, 0.85,255,255,255,255)
		end
		for i,v in pairs(Doors) do
			if GetDistanceBetweenCoords(v.x,v.y,v.z,x,y,z) < 3.0 then
				DrawText3D(v.x,v.y,v.z, "Fuera ~r~escoria~w~, no queremos gente de tu casta ~r~aquí", 255,255,255)
				if IsControlJustPressed(1,38) then
					SendNUIMessage({
				        transactionType     = 'playSound',
				        transactionFile     = 'campanada',
				        transactionVolume   = 0.2
			    	})
				end
			end
		end

	end
end)

---------------------------------
------------EVENTOS--------------
---------------------------------
RegisterNetEvent('tm1_donreyes:spawnedFirstCar')
AddEventHandler('tm1_donreyes:spawnedFirstCar',function()
	for i,v in pairs(cars) do
		spawn_vehicle('btype',v.x,v.y,v.z,v.h)
	end
end)

---------------------------------
-----------FUNCIONES-------------
---------------------------------
function startJob()
	successarea(actualJob.msg,2000)
	isInJob = true
	spawn_vehicle(actualJob.car,actualJob.carX,actualJob.carY,actualJob.carZ,actualJob.carH)
	blip = AddBlipForCoord(actualJob.posX,actualJob.posY,actualJob.posZ)
	SetBlipRoute(blip, true)
end

function openJobMenu(dataJob)
	local elements = {
		{label = "Si", value = "yes"},
		{label = "No", value = "no"}
	}
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'job_menu',
		{
			title  = dataJob.name..' ¿Quieres realizar un encargo?',
			align    = 'bottom-right',
			elements = elements
		},
		function(data, menu)
			if data.current.value == "yes" then
				if isInJob == true then
					errorarea(dataJob.isInJob,2000)
				else
					actualJob = dataJob
					startJob()
					menu.close()
				end
			elseif data.current.value == "no" then
				errorarea(dataJob.noText,2000)
				menu.close()
			end
		end,
		function(data, menu)
			menu.close()
		end
	)
end

function openGetMoney()
	local elements = {
		{label = "Si", value = "yes"},
		{label = "No", value = "no"}
	}
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'job_menu',
		{
			title  = '¿Quieres recoger el dinero?',
			align    = 'bottom-right',
			elements = elements
		},
		function(data, menu)
			if data.current.value == "yes" then
			    successarea(actualJob.successMSG..", recoge esto : €€€",3000)
			    TriggerServerEvent('exp:addExperience',actualJob.exp)
			    TriggerServerEvent('tm1_donreyes:pagar', math.random(10000,20000))
			    isInJob = false
				jobFase = 0
				actualJob = {}
			    menu.close()
			elseif data.current.value == "no" then
				menu.close()
			end
		end,
		function(data, menu)
			menu.close()
		end
	)
end

function countDownMusic()
	Citizen.CreateThread(function ()
		isPlayed = true
		Citizen.Wait(120000)
		isPlayed = false
	end)
end

function getJobData(id)
	for i,v in pairs(jobs) do
		if v.id == id then
			return v
		end
	end
	return false
end

function deleteCar( entity )
    Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) )
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

function DrawText3D(x,y,z, text, r,g,b)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(r, g, b, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

function errorarea(msg,temp)
	TriggerEvent("pNotify:SetQueueMax", "center", 2)
    TriggerEvent("pNotify:SendNotification", {
        text = msg,
        type = "error",
        timeout = temp,
        layout = "centerRight",
        queue = "center"
    })
end

function successarea(msg,temp)
	TriggerEvent("pNotify:SetQueueMax", "center", 2)
    TriggerEvent("pNotify:SendNotification", {
        text = msg,
        type = "success",
        timeout = temp,
        layout = "centerRight",
        queue = "center"
    })
end

function spawnPeds()
	Citizen.CreateThread(function()
		for i,v in pairs(NPCs) do
			local hash = v.hash
		  	while not HasModelLoaded( hash ) do
		  		RequestModel( hash )
		 	    Citizen.Wait(20)
			end
		  	local pos =  GetEntityCoords(GetPlayerPed(-1))
		  	local ped =  CreatePed(4, hash, v.x, v.y, v.z - 1, v.rot, false, true)
			FreezeEntityPosition(ped, true)
			SetEntityInvincible(ped, true)
			SetBlockingOfNonTemporaryEvents(ped, true)
			TaskStartScenarioInPlace(ped, v.anim, 0, true)
			if v.id == "asikause" then
				Citizen.CreateThread(function ()
					RequestAnimDict("mp_player_int_uppergrab_crotch")
	  
					  while not HasAnimDictLoaded("mp_player_int_uppergrab_crotch") do
					    Citizen.Wait(0)
					  end
					while true do
						Citizen.Wait(400)
						TaskPlayAnim(ped, "mp_player_int_uppergrab_crotch" ,v.anim ,8.0, -8.0, -1, 0, 0, false, false, false )
					end
				end)
			end
		end
	end)
end

function spawn_vehicle(veh,spawnx,spawny,spawnz,spawnh)
	Citizen.CreateThread(function()
		local myPed = GetPlayerPed(-1)
		local vehicle = GetHashKey(veh)
		RequestModel(vehicle)
		while not HasModelLoaded(vehicle) do
			Citizen.Wait(1)
		end

		local plate = "REYES"..math.random(100, 900)
		local spawned_car = CreateVehicle(vehicle, spawnx,spawny,spawnz, spawnh, - 996.786, 25.1887, false, false)
		SetVehicleNumberPlateText(spawned_car, plate)
		SetVehicleOnGroundProperly(spawned_car)
		SetEntityAsMissionEntity( spawned_car, true, true )
		
		SetModelAsNoLongerNeeded(vehicle)
		Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(spawned_car))
		if veh == "btype" then
			TriggerEvent("advancedFuel:setEssence", 0, GetVehicleNumberPlateText(spawned_car), GetDisplayNameFromVehicleModel(GetEntityModel(spawned_car)))
			FreezeEntityPosition(spawned_car, true)
		else
			actualJob.plate = plate
			TriggerEvent("advancedFuel:setEssence", 65, GetVehicleNumberPlateText(spawned_car), GetDisplayNameFromVehicleModel(GetEntityModel(spawned_car)))
		end
	end)
end