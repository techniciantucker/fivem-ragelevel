local invisible = false
local godmode = false
local soygm = false
local activadoAmmo = false
ESX = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getShtoniaredObjtoniect', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)


function DrawText3D(x,y,z, text) 

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 1.1*scale)
        SetTextFont(0)
        SetTextProportional(1)
        -- SetTextScale(0.0, 0.55)
        SetTextColour(255, 255, 255, 255)
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
RegisterNetEvent('inv:godmode')
AddEventHandler('inv:godmode',function()
	if godmode then
		SetEntityInvincible(GetPlayerPed(-1),false)
		SetNotificationTextEntry("STRING")
		AddTextComponentString("GodMode desactivado :(" )
		DrawNotification(false, true)
		godmode = false
	else
		SetEntityInvincible(GetPlayerPed(-1),true)
		SetNotificationTextEntry("STRING")
		AddTextComponentString("GodMode activado bro" )
		DrawNotification(false, true)
		godmode = true
	end
end)

RegisterNetEvent('inv:invisible')
AddEventHandler('inv:invisible',function()
	if invisible == false then
		SetEntityVisible(GetPlayerPed(-1),false)
		invisible = true
		SetNotificationTextEntry("STRING")
		AddTextComponentString("eres invisible  :)." )
		DrawNotification(false, true)
	else
		SetEntityVisible(GetPlayerPed(-1),true)
		invisible = false
		SetNotificationTextEntry("STRING")
		AddTextComponentString("Ya no eres invisible  :(, con lo que mola" )
		DrawNotification(false, true)
	end

end)

RegisterNetEvent('inv:gordo')
AddEventHandler('inv:gordo',function()
	local model = GetHashKey("a_m_m_fatlatin_01")
        RequestModel(model)
        while not HasModelLoaded(model) do
          RequestModel(model)
          Citizen.Wait(0)
        end

        SetPlayerModel(PlayerId(), model)
        SetModelAsNoLongerNeeded(model)
end)

RegisterNetEvent('inv:teleport')
AddEventHandler('inv:teleport',function()
	local player = GetPlayerPed(-1)
	local blip = GetFirstBlipInfoId(8)
	if DoesBlipExist(blip) then
		local coord = Citizen.InvokeNative(0xFA7C7F0AADF25D09, blip, Citizen.ResultAsVector())
		SetEntityCoords(player,coord.x,coord.y,coord.z+5)
		SetNotificationTextEntry("STRING")
		AddTextComponentString("Has hecho teleport a tu posición del mapa" )
		DrawNotification(false, true)
	end
end)


RegisterNetEvent('inv:tpcoche')
AddEventHandler('inv:tpcoche',function()
	local player = GetPlayerPed(-1)
	local blip = GetFirstBlipInfoId(8)
	local coche =  GetVehiclePedIsIn(GetPlayerPed(-1),false)
	if DoesBlipExist(blip) then
		local coord = Citizen.InvokeNative(0xFA7C7F0AADF25D09, blip, Citizen.ResultAsVector())
		SetEntityCoords(player,coord.x,coord.y,coord.z+5)
		SetNotificationTextEntry("STRING")
		AddTextComponentString("Has hecho teleport a tu posición del mapa y al coche en el que estabas" )
		SetEntityCoords(coche,coord.x,coord.y,coord.z+5)
		SetPedIntoVehicle(GetPlayerPed(-1), coche, - 1)
		DrawNotification(false, true)
	end


end)

RegisterNetEvent('inv:adelante')
AddEventHandler('inv:adelante',function()
	local player = GetPlayerPed(-1)
	local blip = GetFirstBlipInfoId(8)
	local coord = GetEntityCoords(GetPlayerPed(-1))
	local player = GetPlayerPed(-1)
	local coche = nil
	if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
		 coche =  GetVehiclePedIsIn(GetPlayerPed(-1),false)
	end
		SetEntityCoords(player,coord.x+5,coord.y,coord.z)
		if coche then
			SetEntityCoords(coche,coord.x+5,coord.y,coord.z)
			SetPedIntoVehicle(GetPlayerPed(-1), coche, - 1)
		end


end)

RegisterNetEvent('inv:abrircoche')
AddEventHandler('inv:abrircoche',function()
  local coords = GetEntityCoords(GetPlayerPed(-1))

  local vehicle, distance = ESX.Game.GetClosestVehicle({
    x = coords.x,
    y = coords.y,
    z = coords.z
  })


  	if distance ~= -1 and distance <= 1.0 then

		SetVehicleDoorsLocked(vehicle, 1)
		SetVehicleDoorsLockedForPlayer(vehicle, PlayerId(), false)
	end
end)

RegisterNetEvent('inv:fixcar')
AddEventHandler('inv:fixcar',function()
	local coche = nil
	if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
		 coche =  GetVehiclePedIsIn(GetPlayerPed(-1),false)
	end
	if coche then
	    SetVehicleFixed(coche)
	    SetVehicleDeformationFixed(coche)
	    end
end)

RegisterNetEvent('inv:gorra')
AddEventHandler('inv:gorra',function()
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
end)

RegisterNetEvent('inv:ammo')
AddEventHandler('inv:ammo',function()
	if activadoAmmo then
		SetPedInfiniteAmmoClip(GetPlayerPed(-1),false)
		activadoAmmo = false
	else
		SetPedInfiniteAmmoClip(GetPlayerPed(-1),true)
		activadoAmmo = true
	end
end)
