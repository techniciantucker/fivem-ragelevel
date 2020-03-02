local miarray = {}
local lastiterador = nil
ESX = nil
--ESX.Game.GetClosestPlayer(coords)
Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getShtoniaredObjtoniect', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

RegisterNetEvent('llaves:tomaarray')
AddEventHandler('llaves:tomaarray',function(array,iterador)
	miarray = array
	lastiterador = iterador
end)

RegisterNetEvent('llaves:esMillave')
AddEventHandler('llaves:esMillave',function(matr,cb)
	if miarray.llaves then
		if matr then
			for i=1,#miarray.llaves,1 do
				if miarray.llaves[i].matr == matr then
					cb(1)
					break
				end
			end
			cb(nil)
		else
			cb(nil)
		end
	end
end)

function abrocierro(modo,i,vehicle)

	if modo == "abro" then
		miarray.llaves[i].stat = "opened"
		SetVehicleDoorsLocked(vehicle, 1)
		SetVehicleDoorsLockedForPlayer(vehicle, PlayerId(), false)
		TriggerServerEvent('llaves:pasoarray',miarray,lastiterador)
		notificacion("Coche abierto")
		TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "lock", 1.0)
	elseif modo == "cierro" then
		miarray.llaves[i].stat = "closed"
		SetVehicleDoorsLocked(vehicle, 4)
		SetVehicleDoorsLockedForPlayer(vehicle, PlayerId(), true)
		TriggerServerEvent('llaves:pasoarray',miarray,lastiterador)
		notificacion("Coche cerrado")
		TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "lock", 1.0)
	end
end

function notificacion(texto)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(texto)
    Citizen.InvokeNative(0x1E6611149DB3DB6B, "CHAR_CARSITE", "CHAR_CARSITE", true, 1, "LLAVERO", "", 0.080)
    DrawNotification(false, true)
end

function openmenu()

	local elementos = {{label = "Dar llave", value = 'yes'},
						{label = "Cerrar", value = 'no'}}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'llavero',
		{
			title  = 'Llavero',
			align    = 'bottom-right',
			elements = elementos
		},
		function(data, menu)	
			if data.current.value == 'yes' then
			end
			menu.close()
			openmenu2()
			if data.current.value == 'no' then
				menu.close()
			end
		end,
		function(data, menu)
			menu.close()
		end
	)
end

function openmenu2()

	local elementos = {}
	if miarray.llaves then
		for i=1,#miarray.llaves,1 do
			table.insert(elementos,{label = "Matrícula : "..miarray.llaves[i].matr, value = miarray.llaves[i]})
		end
	else
		table.insert(elementos,{label = "No tienes coches",value = nil})
	end
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'llavero',
		{
			title  = 'Llavero',
			align    = 'bottom-right',
			elements = elementos
		},
		function(data, menu)	
			menu.close()
			ESX.UI.Menu.Open(
				'dialog', GetCurrentResourceName(), 'llavero',
				{
				  title = 'ID de la persona para dar la llave'
				},
				function(data3, menu3)
					local id = tonumber(data3.value)
					local info

					for i=1,#miarray.llaves,1 do
						if miarray.llaves[i].matr == data.current.value.matr then
							info = miarray.llaves[i].matr
							break
						end
					end
					TriggerServerEvent('llaves:prestollaves',data.current.value,id)
					menu3.close()

				end,
				function(data3, menu3)
				  menu3.close()
				end
			  )
		end,
		function(data, menu)
			menu.close()
		end
	)
end

Citizen.CreateThread(function()
	while true do
		local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
		if IsControlJustPressed(1, 303) then --U
			if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then 	
				local matr = GetVehicleNumberPlateText(vehicle)
				--Citizen.Trace(tostring(miarray.llaves[1].matr))
				if miarray.llaves then
					for i=1,#miarray.llaves,1 do

						if matr == miarray.llaves[i].matr then

							if miarray.llaves[i].stat == "opened" then

								abrocierro("cierro",i,vehicle)
								break
							else
								abrocierro("abro",i,vehicle)

								break
							end
						end
					end
				end
			else
				local coords = GetEntityCoords(GetPlayerPed(-1))

  				local vehicle, distance = ESX.Game.GetClosestVehicle({
    				x = coords.x,
    				y = coords.y,
    				z = coords.z
  				})
  				if distance <= 2 then
					local matr = GetVehicleNumberPlateText(vehicle)
					if miarray.llaves then
						for i=1,#miarray.llaves,1 do
							if matr == miarray.llaves[i].matr then
								if miarray.llaves[i].stat == "opened" then
									abrocierro("cierro",i,vehicle)
									break
								else
									abrocierro("abro",i,vehicle)
									break
								end
							end
						end
					end
				end
			end
		elseif IsControlJustPressed(1, 311) then --K
			openmenu()
		end
		Citizen.Wait(0)
	end
end)
