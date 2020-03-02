ESX                           = nil
local npcs = {
	{
	name = "concesionario",
	x = -231.34, 
	y = 6234.92,
	z = 31.5,
	rotation = 30.0,
	msg = "[Manolo] Pulsa E para entrar al concesionario.",
	r = 255,
	g = 242,
	b = 0,
	model = 'G_M_Y_Lost_03'}
}
local elements = {}
local isSet = false


Citizen.CreateThread(function() 
	for i,v in pairs(npcs) do
		Citizen.Trace(0)
		wanted_model= "hc_driver"
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
		created_ped = CreatePed(5, GetHashKey('hc_driver') , v.x,v.y,v.z - 1, v.rotation, false, true)
		FreezeEntityPosition(created_ped, true)
		SetEntityInvincible(created_ped, true)
		SetBlockingOfNonTemporaryEvents(created_ped, true)
		TaskStartScenarioInPlace(created_ped, "world_human_leaning", 0, true)
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		for i,v in pairs(npcs) do
			if GetDistanceBetweenCoords(v.x, v.y, v.z, GetEntityCoords(GetPlayerPed(-1),true)) <= 2.5 then
				DrawText3D(v.x,v.y,v.z + 1, v.msg, v.r,v.g,v.b)
				if IsControlJustReleased(0, 38) then
				end
			end
		end
	end
end)

function OpenMenu()
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'seed_shop',
		{
			title  = "",
			align    = 'center',
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