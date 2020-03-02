--==============================================================--
--                                                              --  
--                         EDIT BY CHANGER                      -- 
--                                                              --                               
--==============================================================--

local Diamantes = {
	{-587.893,2059.510,130.638},
	{-589.565,2069.174,131.205}
}

local Cooldown = {}

local ProcessarDima = {
	{1108.438,-2006.903,30.944}
}

local DrawMarksDima = {
    {-587.893,2059.510,130.638},
	{-589.565,2069.174,131.205}
}

local isProcessing = false

--=========================== FELLAS2 =============================--

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        for k,v in pairs(Diamantes) do
            local x,y,z = table.unpack(v)
            z = z-1
            local pCoords = GetEntityCoords(GetPlayerPed(-1))
            local distance = GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, x, y, z, true)
            local alpha = math.floor(255 - (distance * 30))
            if Cooldown[k] ~= nil then
            	local timeDiff = GetTimeDifference(GetGameTimer(), Cooldown[k])
            	if timeDiff < 5000 then
            		if distance < 6.0 then
		            local seconds = math.ceil(5 - timeDiff/1000)
		            DrawText3d(x, y, z+1.5, "~w~ESPERA ~r~"..tostring(seconds).."~w~ SEGUNDOS.", alpha)
		            end
            	else
            		Cooldown[k] = nil
            	end
            else
	            if distance < 2.0 then
	                DrawText3d(x, y, z+1.5, "PRESSIONE [~r~E~w~] PARA COLETAR MINERAR DIAMANTES", alpha)
	            	if (IsControlJustPressed(1, 38)) then
	            		if Cooldown[k] ~= nil then
	            			if GetTimeDifference(GetGameTimer(), Cooldown[k]) > 5000 then
	            				Cooldown[k] = GetGameTimer()
	                    		TriggerEvent('Changer:GetDiamante')
	            			end
	            		else
	            			Cooldown[k] = GetGameTimer()
	                    	TriggerEvent('Changer:GetDiamante')
	            		end
	                end
	            elseif distance < 5.0 then
	            DrawText3d(x, y, z+1.5, "~w~CHEGUE MAIS PERTO PARA MINERAR.", alpha)
	            end
            end
        end
    end
end)

local lastProcess = 0

Citizen.CreateThread(function()
    while true do
        if isProcessing then
        	if GetTimeDifference(GetGameTimer(), lastProcess) > 4000 then
        		lastProcess = GetGameTimer()
        		TriggerServerEvent('Changer:ProcessarDiamante')
			end 
        end
        Citizen.Wait(1)
    end
end)

--===========================## TEXTO DRAWMARK ##=============================--

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        for k,v in pairs(ProcessarDima) do
            local x,y,z = table.unpack(v)
            local pCoords = GetEntityCoords(GetPlayerPed(-1))
            local distance = GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, x, y, z, true)
            local alpha = math.floor(30 - (distance * 30))
            DrawMarker(21, x, y, z+0.7, 0, 0, 0, 0.0, 0, 0, 0.5, 0.5, -0.3001, 255, 255, 255, 255, 9, 9, 9, 0, 0, 0)
            if isProcessing then
            if distance < 2.0 then
	        DrawText3d(x, y, z+0.2, "~w~PRESSIONE ~r~[E]~w~ PARA CANCELAR PROCESSO.", alpha)
	        if (IsControlJustPressed(1, 38)) then
	        TriggerEvent('Changer:ProcessarDima')
	        end
	        elseif distance < 8.0 then
	        DrawText3d(x, y, z+0.2, "~w~MÁS CERCA PARA PROCESSAR.", alpha)
	        end
            else
	        if distance < 2.0 then
	        DrawText3d(x, y, z+0.2, "~w~PRESSIONE ~g~[E]~w~ PARA PROCESSAR O DIAMANTE.", alpha)
            if (IsControlJustPressed(1, 38)) then
	        TriggerEvent('Changer:ProcessarDima')
	        end
            elseif distance < 8.0 then
	        DrawText3d(x, y, z+0.2, "~w~MÁS CERCA PARA PROCESSAR.", alpha)
           end
        end
      end
    end
end)

--============================## DRAWMARK ##=============================--

Citizen.CreateThread(function()
    while true do
    Citizen.Wait(1)
    for k,v in pairs(DrawMarksDima) do
    local x,y,z = table.unpack(v)
    local pCoords = GetEntityCoords(GetPlayerPed(-1))
    local distance = GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, x, y, z, true)
    DrawMarker(21, x, y, z+1, 0, 0, 0, 0.0, 0, 0, 0.3, 0.3, -0.2001, 255, 255, 255, 75, 9, 9, 9, 0, 0, 0)
    end
  end
end)
 
--===========================## ANIMAÇÃO FARM ##===========================--

    RegisterNetEvent("Changer:GetDiamante")
    AddEventHandler("Changer:GetDiamante", function(tree)
	local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1)))
	while (not HasAnimDictLoaded("amb@world_human_hammering@male@base")) do 
	RequestAnimDict("amb@world_human_hammering@male@base")
	Citizen.Wait(5)
	end
	propmachado = CreateObject(GetHashKey("prop_tool_pickaxe"), x, y, z+0.2,  true,  true, true)
	AttachEntityToEntity(propmachado, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 57005), 0.08, -0.4, -0.10, 80.0, -20.0, 175.0, true, true, false, true, 1, true)
	TaskPlayAnim(GetPlayerPed(-1), "amb@world_human_hammering@male@base", "base", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
	FreezeEntityPosition(GetPlayerPed(-1),true)
    Citizen.Wait(3000)
    DetachEntity(propmachado, 1, 1)
	DeleteObject(propmachado)
	FreezeEntityPosition(GetPlayerPed(-1),false)
    ClearPedTasksImmediately(GetPlayerPed(-1))
	TriggerEvent("inventory:addQty", 507, 1)
	TriggerEvent('chatMessage', "SUCCESS", {0, 173, 66}, "F2 para ver tu inventario")
end)

--=========================## ANIMAÇÃO PROCESS ##=============================--

    RegisterNetEvent("Changer:ProcessarDima")
    AddEventHandler("Changer:ProcessarDima", function()
	isProcessing = not isProcessing
	if isProcessing and exports['core']:GetItemQuantity(507) >= 5 then

    TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_STAND_FIRE", 0, true)
    FreezeEntityPosition(GetPlayerPed(-1),true)
    TriggerEvent("inventory:removeQty", 507, 5)

    TriggerEvent("inventory:addQty", 133, 1)

    TriggerEvent('chatMessage', "SUCCESS", {0, 173, 66}, "+1 Oro")	
	else
    FreezeEntityPosition(GetPlayerPed(-1),false)
    ClearPedTasksImmediately(GetPlayerPed(-1))
	TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "No tienes los materiales correctos para crear esto")
	end
end)

--=============================## TEXTO ##==================================--

    function DrawText3d(x,y,z, text, alpha)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    if onScreen then
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, alpha)
    SetTextDropshadow(0, 0, 0, 0, alpha)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
    end
end