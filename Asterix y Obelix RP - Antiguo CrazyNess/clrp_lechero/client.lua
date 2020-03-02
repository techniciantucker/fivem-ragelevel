local follow_player = true

-- Quantidade de leite que cada vaca da;
local max_leite = 10

-- PemissĂ£o para pessoa poder usar este emprego;
local permission = "trabalho.leiteiro"

-- Quatidade aleat?ria de carne que da ao abater a vaca;
local max_carne = 10
local min_carne = 5

-- Tempo (em segundos) para o leite de cada vaca encher;
local cooldown_timer = 240

-- Tempo (em segundos) para limpar as vacas mortas e spawnar todas as vacas de volta no curral;
local spawn_timer = 600

--Curral
cfgvacas = {
	{2264.403,4894.549,40.894},
	{2256.824,4903.487,40.877},
	{2249.381,4910.914,40.729},
	{2240.950,4919.405,40.772},
    {2233.205,4926.877,40.830},
    {2225.209,4936.901,40.934},
    {2203.448,4915.189,40.609},
    {2212.525,4905.927,40.786},
    {2219.000,4898.711,40.750},
    {2227.893,4890.349,40.702},
    {2235.881,4882.518,40.928},
    {2245.104,4873.593,40.849},
    {2242.649,4850.552,40.745},
    {2248.541,4842.787,40.657},
    {2256.164,4835.662,40.657},
}

--Abatedouro
abatedouro = {2309.861,4885.552,41.808}

-- Propriedades do item
local peso_leite = 1.0
local sede_leite = 20
local peso_carne = 2.0
local fome_carne = 40

coletando = false
obj = 0

haspermission = false
notabate = true

Citizen.CreateThread(function()
	local vaca = 0
	notabate = true
    while true do
		Wait(0)
		
		local pos = GetEntityCoords(GetPlayerPed(-1))
		for k,v in pairs(cfgvacas)do
			if(Vdist(pos.x, pos.y, pos.z, v[1], v[2], v[3]) < 40.0)then
				DrawMarker(21, v[1], v[2], v[3]+0.80, 0, 0, 0, 0, 0, 0, 0.7, 0.5, 0.3100, 255, 255, 255,255, 9, 0, 0,0)
			end
			if(Vdist(pos.x, pos.y, pos.z, v[1], v[2], v[3]) < 2.0)then
				DrawText3D(v[1], v[2], v[3], "~w~PRESSIONE [~y~E~w~] PARA COLETAR~w~ LECHE.\n \n PRESSIONE [~y~F~w~] PARA ABATER~w~ LA VACA.",255,255,255)
				if IsControlJustPressed(1, 38) and not coletando then
					if GetEntityHealth(vacas[k]) > 50 then
						x, y, z = table.unpack(GetEntityCoords(vacas[k], true))
						if(Vdist(x, y, z, v[1], v[2], v[3]) < 4.0)then
               
                           RequestAnimDict("anim@heists@heist_safehouse_intro@phone_couch@male")
                           while not HasAnimDictLoaded('anim@heists@heist_safehouse_intro@phone_couch@male') do
                           Wait(0)
                           end			   
                            TaskPlayAnim(GetPlayerPed(-1),"anim@heists@heist_safehouse_intro@phone_couch@male", "phone_couch_male_idle", 1.0,-1.0, 120000, 1, 1, 0, 0, 0)
							coletarLeite(true,k)								
	                        local finished = exports["clrp-taskbar"]:taskBar(7000,"Coletar Leche")	  
                            if finished == 100 then

							PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
  
							coletando = true
	
                            TriggerEvent("inventory:addQty", 503, 1)
                            exports.pNotify:SendNotification({text = "<font color='lightgreen'> +1 Leche de Vaca"})							
                            StopAnimTask(GetPlayerPed(-1), "anim@heists@heist_safehouse_intro@phone_couch@male", "phone_couch_male_idle", 1.0)	
                            ClearPedTasksImmediately(GetPlayerPed(-1))							
                            TriggerEvent("leite:stopanim")
							vaca = k
							end
							
						
						else
							exports['clrp_notify']:DoHudText('error',  "La vaca no está en el corral.")
						end
					else
						exports['clrp_notify']:DoHudText('error',  "No se puede ordeñar una vaca ~r~Herida~w~.")
					end
				end
				if IsControlJustPressed(1, 49) and not coletando then
					x, y, z = table.unpack(GetEntityCoords(vacas[k], true))
					if(Vdist(x, y, z, v[1], v[2], v[3]) < 4.0)then
						coletarLeite(false,k)
						-- if haspermission then
							-- notabate = false
							FreezeEntityPosition(vacas[k], false)
							conduzir(k)
                            								
						-- else
							-- exports['clrp_notify']:DoHudText('error',  "~r~Não possui permissão.")
						-- end
					else
						exports['clrp_notify']:DoHudText('error',  "La vaca no está en el corral.")
					end
				end
			elseif coletando and vaca == k then
				coletando = false
				vaca = 0
				--_coletarLeite(false,k)
				ClearPedTasks(GetPlayerPed(-1))
				TriggerEvent("leite:deleteprop")
			end
        end
	end
end)

function conduzir(k)

	if DecorGetInt(PlayerPedId(), 'job') == 35 then
		TriggerEvent("vrp:abater",k)
	else
		exports['clrp_notify']:DoHudText('error',  "No esta trabajando aqui.")
	end		
		
end

local coletar = true

function coletarLeite(coletarP,k)
	coletar = coletarP
		if coletar then
			--vRPclient._setProgressBar(source,"vRP:leite","center","...",255,255,255,0)
			--TriggerEvent("leite:anim",source)
			TriggerEvent("leite:prop",source)
		end
end
Citizen.CreateThread(function()
	while true do
		Wait(0)
		local pos = GetEntityCoords(GetPlayerPed(-1))
		if(Vdist(pos.x, pos.y, pos.z, abatedouro[1], abatedouro[2], abatedouro[3]) < 102.0)then
			DrawMarker(22, abatedouro[1], abatedouro[2], abatedouro[3]+0.5, 0, 0, 0, 0, 0, 0, 2.5, 2.5, 2.0, 255, 255, 255,255, 9, 9, 9, 0,0)
		end
		if(Vdist(pos.x, pos.y, pos.z, abatedouro[1], abatedouro[2], abatedouro[3]) < 30.0)then
		DrawText3D(abatedouro[1], abatedouro[2], abatedouro[3], "~w~MATADERO",255,255,255,120)
		end
	end
end)

RegisterNetEvent('vrp:perm')
AddEventHandler("vrp:perm", function(bool)
	haspermission = bool
end)

RegisterNetEvent('leite:prop')
AddEventHandler("leite:prop", function()
	DeleteObject(obj)
	local pos = GetEntityCoords(GetPlayerPed(-1))
	obj = CreateObject(GetHashKey("prop_bucket_01a"), pos.x+0.5, pos.y, pos.z, true, true, true)
	PlaceObjectOnGroundProperly(obj)
	SetEntityRotation(obj, 0.00, 0.00, 340.00)
end)

RegisterNetEvent('leite:deleteprop')
AddEventHandler("leite:deleteprop", function()
	Wait(10000)
	DeleteObject(obj)
end)

RegisterNetEvent('leite:anim')
AddEventHandler("leite:anim", function()

		local ad = "anim@heists@heist_safehouse_intro@phone_couch@male"
		local player = GetPlayerPed( -1 )
		loadAnimDict(ad)
		TaskPlayAnim( player, ad, "phone_couch_male_idle", 8.0, 1.0, 5000, 49, 0, 0, 0, 0 )
		Wait(5000)

end)

RegisterNetEvent('leite:stopanim')
AddEventHandler("leite:stopanim", function()
	ClearPedTasks(GetPlayerPed(-1))
end)

-- function loadAnimDict(dict)
	-- while (not HasAnimDictLoaded(dict)) do 
		-- RequestAnimDict(dict)
		-- Citizen.Wait(5)
	-- end
-- end

RegisterNetEvent('vrp:abater')
AddEventHandler("vrp:abater", function(k)
	notabate = false
	TaskGoToCoordAnyMeans(vacas[k], abatedouro[1], abatedouro[2], abatedouro[3], 1.0, 0, 0, 786603, 1.0)
	if follow_player then
		showScaleform("~r~Abate","Lleva a la vaca al matadero",2)
	end
	while true do
		if follow_player then
			TaskGoToEntity(vacas[k], GetPlayerPed(-1), -1, 1.0, 10.0, 1073741824.0, 0)
		end
		
		-- if (GetEntityHealth(vacas[k])) == 0 then
			-- exports['clrp_notify']:DoHudText('error',  "La vaca murió afuera del matadero.")
			-- return
		-- end
		x, y, z = table.unpack(GetEntityCoords(vacas[k], true))
		if(Vdist(x, y, z, abatedouro[1], abatedouro[2], abatedouro[3]) < 5.0)then
			ClearPedTasks(vacas[k])
			SetPedAsNoLongerNeeded(vacas[k])
			SetEntityAsMissionEntity(vacas[k], true, true)
			SetEntityHealth(vacas[k],0)

            TriggerEvent("inventory:addQty", 506, 5)
            exports.pNotify:SendNotification({text = "<font color='lightgreen'> +5 Carne de Vaca"})	
			--abater()			
			return
		end
		Wait(4000)
	end
	notabate = true
end)

vacas = {}


Citizen.CreateThread(function()
	RequestModel(GetHashKey("a_c_cow"))
	while not HasModelLoaded(GetHashKey("a_c_cow")) do
		Wait(1)
	end

	for k, v in pairs(cfgvacas) do
		if vacas[k] then
			DeleteEntity(vacas[k])
		end
		vacas[k] = CreatePed(4, GetHashKey( "a_c_cow" ), v[1], v[2], v[3]-1, 0.0, false, true)
		FreezeEntityPosition(vacas[k], true)
	end
end)

Citizen.CreateThread(function()
	while true do
		while notabate do
			for k,v in pairs(cfgvacas)do
				ClearPedTasks(vacas[k])
			end
			Citizen.Wait(0)
		end
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		TriggerServerEvent("vrp:perm")
		Citizen.Wait(10000)
	end
end)

function ProgressBar(text, time)
 progress_bar_text = text
 progress_bar_duration = time
 progress_time = 0.20
 progress_bar = true
end

RegisterNetEvent('hud:progressbar')
AddEventHandler('hud:progressbar', function(text, time)
 ProgressBar(text, time)
end)

function DrawText3D(x,y,z, text, r,g,b)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.45*scale, 0.45*scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextScale(0.25, 0.25)
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

function showScaleform(title, desc, sec)
    function Initialize(scaleform)
        local scaleform = RequestScaleformMovie(scaleform)

        while not HasScaleformMovieLoaded(scaleform) do
            Citizen.Wait(0)
        end
        PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
        PushScaleformMovieFunctionParameterString(title)
        PushScaleformMovieFunctionParameterString(desc)
        PopScaleformMovieFunctionVoid()
        return scaleform
    end
    scaleform = Initialize("mp_big_message_freemode")
    while sec > 0 do
		sec = sec - 0.02
        Citizen.Wait(0)
        DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
    end
	SetScaleformMovieAsNoLongerNeeded(scaleform)
end

function drawUI(x,y ,width,height,scale, text, r,g,b,a, center)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextCentre(center)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

function drawTxt(text)
  SetTextFont(0)
  SetTextProportional(0)
  SetTextScale(0.32, 0.32)
  SetTextColour(0, 255, 255, 255)
  SetTextDropShadow(0, 0, 0, 0, 255)
  SetTextEdge(1, 0, 0, 0, 255)
  SetTextDropShadow()
  SetTextOutline()
  SetTextCentre(1)
  SetTextEntry("STRING")
  AddTextComponentString(text)
  DrawText(0.5, 0.93)
end