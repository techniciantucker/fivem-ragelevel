ESX                           = nil
local npcs = {
	{
	name = "garage",
	x = -203.88, 
	y = 6230.56,
	z = 31.48,
	rotation = -170.0,
	msg = "[El profe Ortega] Pulsa E para hablar",
	r = 255,
	g = 0,
	b = 0,
	model = 'G_M_Y_Lost_03'}
}
local elements = {}
local isSet = false

AddEventHandler('playerSpawned', function(spawn)
	TriggerServerEvent('tm1_adviser:getElements')
end)
TriggerServerEvent('tm1_adviser:getElements')

RegisterNetEvent('tm1_mafias:setElements')
AddEventHandler('tm1_mafias:setElements',function(el)
	if isSet == false then
		for i,v in pairs(el) do
			table.insert(elements, {label  = '<b><span style="color: green;">'..v.name..'</span></b>', value = v.description})
		end
		table.insert(elements, {label  = "Cerrar", value = "close"})
		isSet = true
	else

	end
end)

Citizen.CreateThread(function()
	for i,v in pairs(npcs) do
		Citizen.Trace(0)
		wanted_model= "ig_zimbor"
    	modelHash = GetHashKey(wanted_model)
    	RequestModel(modelHash)
	    while not HasModelLoaded(modelHash) do
	       	Wait(1)
	    end
	end
	createNPCA()
end)

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getShtoniaredObjtoniect', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

function createNPCA()
	for i,v in pairs(npcs) do
		created_ped = CreatePed(5, GetHashKey('ig_zimbor') , v.x,v.y,v.z - 1, v.rotation, false, true)
		FreezeEntityPosition(created_ped, true)
		SetEntityInvincible(created_ped, true)
		SetBlockingOfNonTemporaryEvents(created_ped, true)
		TaskStartScenarioInPlace(created_ped, "WORLD_HUMAN_DRINKING", 0, true)
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		for i,v in pairs(npcs) do
			if GetDistanceBetweenCoords(v.x, v.y, v.z, GetEntityCoords(GetPlayerPed(-1),true)) <= 2.5 then
				DrawText3D(v.x,v.y,v.z + 1, v.msg, v.r,v.g,v.b)
				if IsControlJustReleased(0, 38) then
					OpenMenu()
				end
			end
		end
	end
end)

function OpenMenu()
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'seed_shop',
		{
			title  = "Novedades",
			align    = 'bottom-right',
			elements = elements
		},
		function(data, menu)

			if data.current.value == "close" then
				menu.close()
			else
				successmsg(data.current.value)
				menu.close()
			end
		end,
		function(data, menu)
			menu.close()
		end
	)
end

function successmsg(msg)
	TriggerEvent("pNotify:SetQueueMax", "center", 2)
    TriggerEvent("pNotify:SendNotification", {
        text = msg,
        type = "success",
        timeout = 8000,
        layout = "centerRight",
        queue = "center"
    })
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