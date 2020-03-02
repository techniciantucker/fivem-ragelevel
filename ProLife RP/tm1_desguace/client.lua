local desguace = {x = 1685.6, y = -1564.64, z = 112.6}
ESX                           = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getShtoniaredObjtoniect', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local blips = {
	{title="Desguace clandestino", colour=66, id=85,x = 1685.6, y = -1564.64, z = 112.6},
}

-------------------------------------------
--------------------BLIPS------------------
-------------------------------------------

Citizen.CreateThread(function()

    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x,info.y,info.z)
      SetBlipSprite(info.blip, 85)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.9)
      SetBlipColour(info.blip,75)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
		DrawMarker(1, desguace.x, desguace.y, desguace.z - 1, 0, 0, 0, 0, 0, 0, 3.5001, 3.5001, 0.6001,252,0,0, 200, 0, 0, 0, 0)
		if GetDistanceBetweenCoords(desguace.x,desguace.y,desguace.z, x,y,z) < 3.5 then
			DrawText3D(desguace.x, desguace.y, desguace.z, "Pulsa E para vender el vehículo", 252,0,0)
            if IsControlJustPressed(1,38) then
                if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
                    ESX.UI.Menu.CloseAll()
                    TriggerServerEvent('tm1_mafias:getMoney',GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(GetPlayerPed(-1), true))))
                else
                    TriggerEvent('esx:showNotification', "No tienes ningún coche.")
                end
			end
		end
	end
end)

RegisterNetEvent('tm1_mafias:openSeller')
AddEventHandler('tm1_mafias:openSeller',function(type,price)
    local precio = price * 0.001
	local elements = {
		{label = "Aceptar" ,value = "accept"},
		{label = "Denegar" ,value = "unaccept"}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'acceptseller',
		{
			title  = "¿Quieres vender el "..type.." por "..precio.."€?",
			elements = elements
		},
		function(data, menu)
			if data.current.value == "accept" then
                TriggerServerEvent('tm1_mafias:sellCar',precio)
                local vehicleu = GetVehiclePedIsIn(GetPlayerPed(-1), false)
				SetEntityAsMissionEntity( vehicleu, true, true )
			    deleteCar( vehicleu )
                menu.close()
			else
				menu.close()
			end
		end,
		function(data, menu)
			menu.close()
		end
	)
end)

function deleteCar( entity )
    Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) )
end

function DrawText3D(x,y,z, text, r,g,b) -- some useful function, use it if you want!
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
        -- SetTextScale(0.0, 0.55)
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