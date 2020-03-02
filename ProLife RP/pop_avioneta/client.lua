-----------------------------------------------------------------------------------------------
--SCRIPT CREADO PARA EL SERVIDOR DE FIVEM DE PLATA O PLOMO COMUNIDAD GAMER.
--SCRIPT CREADO TOTALMENTE POR THEMAYKELLLL1 [ MIGUEL ANGEL LOPEZ REYES ].
--PLATA O PLOMO COMUNIDAD GAMER ACEPTA NO VENDER / REGALAR / PASAR ESTOS SCRIPTS A OTRAS PERSONAS O COMUNIDADES
--SIN PERMISOS DEL CREADOR DE EL SCRIPT.
-----------------------------------------------------------------------------------------------

local isInPlane = false
local isInJob = false
local opc = 0
local PermisoTorre = 50
local IsWhileFinish = true
local HaveIPermission = nil
local IsPeding = false
local destino = 1
local isDelivery = false
local gate = 0
local jobs = {
	[1] = {
		info = "Transporta a el VIP a el areopuerto de Los Santos.",
		x = -936.88,
		y = -2999.92,
		z = 13.96,
		comeback = "Vuelve al hangar principal y estaciona al fondo a la izquierda",
		comex = 1718.28,
		comey = 3254.72,
		comez = 40.12,
		plane = "vestra",
		money = 5400,
		posinx = 1742.2,
		posiny = 3275.32,
		posinz = 41.12,
		posinxu = 1746.64,
		posinyu = 3260.76,
		posinzu = 41.36,
		posinxd = 1752.12,
		posinyd = 3243.92,
		posinzd = 41.76,
		planerror = "Montante en el vestra para transportar al vip"
	},
	--[1] = {
	--	info = "Ve a fumigar a el viñedo. Situate a unos 130 metros de altura",
	--	x = -1853.76,
	--	y = 2246.2,
	--	z = 133.08,
	--	comeback = "Vuelve al hangar principal y estaciona al fondo a la izquierda",
	--	comex = -971.96,
	--	comey = -3035.76,
	--	comez = 12.96,
	--	plane = "vestra",
	--	money = 100,
	--	posinx = -936.72,
	--	posiny = -2985.92,
	--	posinz = 13.96
	--}
}
local job = nil
AddEventHandler('playerSpawned', function(spawn)
	TriggerServerEvent('pop_avioneta:getJob')
end)
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  	TriggerServerEvent('pop_avioneta:getJob')
end)
TriggerServerEvent('pop_avioneta:getJob')
RegisterNetEvent('pop_avioneta:setJob')
AddEventHandler('pop_avioneta:setJob',function(jobu)
	job = jobu
end)
----------------------------
----------------------------
----------------------------

function loading()
	isInJob = true
	IsPeding = false
	destino = math.random(1,1)
	gate = math.random(1,3)
	blip = AddBlipForCoord(jobs[destino].x,jobs[destino].y,jobs[destino].z)
	SetBlipRoute(blip, true)
	Wait(2000)
	if gate == 1 then
		spawn_vehicle(jobs[destino].plane,jobs[destino].posinx,jobs[destino].posiny,jobs[destino].posinz)
	elseif gate == 2 then
		spawn_vehicle(jobs[destino].plane,jobs[destino].posinxu,jobs[destino].posinyu,jobs[destino].posinzu)
	elseif gate == 3 then
		spawn_vehicle(jobs[destino].plane,jobs[destino].posinxd,jobs[destino].posinyd,jobs[destino].posinzd)
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
		if opc ~= 69 then
			if isInJob == false then
				DrawMarker(1, 1715.64, 3276.24, 40.12, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,252,255,0, 200, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(1715.64, 3276.24, 40.12, x,y,z) < 1.5 then
					drawTxt("PULSE E PARA CONSEGUIR UN DESTINO",4, 1, 0.5, 0.935, 0.85,255,255,255,255)
					if IsControlJustPressed(1,38) and job == "pilot" then
						loading()
						IsPeding = true
					elseif IsControlJustPressed(1,38) and not(job == "pilot") then
						TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0},"No eres piloto.")
					end
				end
			end
		end
		if GetDistanceBetweenCoords(jobs[destino].x,jobs[destino].y,jobs[destino].z, x,y,z) < 5 and isInJob and isDelivery == false then
			isDelivery = true
			RemoveBlip(blip)
			blip = AddBlipForCoord(jobs[destino].comex,jobs[destino].comey,jobs[destino].comez)
			SetBlipRoute(blip, true)
		end
		if GetDistanceBetweenCoords(jobs[destino].comex,jobs[destino].comey,jobs[destino].comez, x,y,z) < 5 and isInJob and isDelivery then
			if IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), true), GetHashKey(jobs[destino].plane)) then
				isDelivery = false
				isInJob = false
				RemoveBlip(blip)
				local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), true)
				TriggerServerEvent("pop_avioneta:cobrarDinero", jobs[destino].money)
				TriggerServerEvent('exp:addExperience',125)
				SetEntityAsMissionEntity( vehicle, true, true )
				deleteCar(vehicle)
			end
		end
		if isInJob and IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), true), GetHashKey(jobs[destino].plane)) and isDelivery == false then
			drawTxt(jobs[destino].info ,4, 1, 0.5, 0.935, 0.85,51,247,107,255)
			DrawMarker(1, jobs[destino].x,jobs[destino].y,jobs[destino].z, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,252,255,0, 200, 0, 0, 0, 0)
		elseif isInJob and IsPedSittingInAnyVehicle(GetPlayerPed(-1)) and isDelivery == true then
			drawTxt(jobs[destino].comeback,4, 1, 0.5, 0.935, 0.85,51,247,107,255)
			DrawMarker(1, jobs[destino].comex,jobs[destino].comey,jobs[destino].comez, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,252,255,0, 200, 0, 0, 0, 0)		
		elseif isInJob and IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), true), GetHashKey(jobs[destino].plane)) == false and isDelivery == false then
			drawTxt(jobs[destino].planerror ,4, 1, 0.5, 0.935, 0.85,51,247,107,255)
		elseif isInJob and IsPedSittingInAnyVehicle(GetPlayerPed(-1)) == false then
			drawTxt("DIRIGETE HACIA LA AVIONETA",4, 1, 0.5, 0.935, 0.85,51,247,107,255)	
		end 
		if opc == 69 then
			drawTxt("CONEXION FALLIDA, TE HAS RETIRADO DEL TELEFONO.",4, 1, 0.5, 0.935, 0.85,255,0,0,255)
		end
		if IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), false), GetHashKey(jobs[destino].plane)) then
			drawTxt(round(z,0).."m",4, 1, 0.19, 0.935, 0.85,255,255,255,255)
		end
		if false then
			drawTxt("x = "..round(x,2)..",  y = "..round(y,2)..",  z = "..round(z,2),4, 1, 0.5, 0.25, 0.65,255,255,255,255)
			local h = GetEntityHeading(GetPlayerPed(-1))
			drawTxt("Rx = "..h,4, 1, 0.5, 0.15, 0.65,255,255,255,255)
			local x,y,z = table.unpack(GetCamCoord(GetRenderingCam()))
			drawTxt("Cx = "..round(x,2)..",  Cy = "..round(y,2)..",  Cz = "..round(z,2),4, 1, 0.5, 0.05, 0.65,255,255,255,255)
		end
		if IsEntityDead(GetPlayerPed(-1)) then
			isInPlane = false
			isInJob = false
			opc = 0
			PermisoTorre = 50
			IsWhileFinish = true
			HaveIPermission = nil
			IsPeding = false
			destino = 1
			isDelivery = false
		end
	end
end)

----------------------------
----------------------------
----------------------------

local blips = {
	{title="Transportes aereos", colour=66, id=90, x = 1715.64, y = 3276.24, z = 40.12},
}
Citizen.CreateThread(function()

    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, 90)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.9)
      SetBlipColour(info.blip, 66)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)

----------------------------
----------------------------
----------------------------

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

function round(num, numDecimalPlaces)
	local mult = 5^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

function spawn_vehicle(veh,spawnx,spawny,spawnz)
	Citizen.Wait(0)

	local myPed = GetPlayerPed(-1)
	local vehicle = GetHashKey(veh)

	RequestModel(vehicle)

	while not HasModelLoaded(vehicle) do
		Wait(1)
	end

	local plate = "CTZN"..math.random(100, 900)
	local spawned_car = CreateVehicle(vehicle, spawnx,spawny,spawnz, 431.436, - 996.786, 25.1887, true, false)

	SetVehicleNumberPlateText(spawned_car, plate)
	SetVehicleOnGroundProperly(spawned_car)
	--SetVehicleLivery(spawned_car, 2)
	SetPedIntoVehicle(myPed, spawned_car, - 1)
	SetModelAsNoLongerNeeded(vehicle)
	Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(spawned_car))
	TriggerEvent("advancedFuel:setEssence", 100, GetVehicleNumberPlateText(spawned_car), GetDisplayNameFromVehicleModel(GetEntityModel(spawned_car)))
end

function deleteCar( entity )
    Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) )
end

function get3DDistance(x1, y1, z1, x2, y2, z2)
	local a = (x1 - x2) * (x1 - x2)
	local b = (y1 - y2) * (y1 - y2)
	local c = (z1 - z2) * (z1 - z2)
    return math.sqrt(a + b + c)
end