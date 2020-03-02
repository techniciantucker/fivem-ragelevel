 local ped0
 local ped1
 local ped2
 local ped3
 local robando = false
 local tiempo = 0
 local grupo
 local puertaabierta = false
 local explosion = nil
 local temporizador = false

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
	    SetTextOutline()
	end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

 function get3DDistance(x1, y1, z1, x2, y2, z2)
    local a = (x1 - x2) * (x1 - x2)
    local b = (y1 - y2) * (y1 - y2)
    local c = (z1 - z2) * (z1 - z2)
    return math.sqrt(a + b + c)
end

--[[function creoIA()
	RequestModel( GetHashKey( "s_m_m_security_01" ) )
	while not HasModelLoaded( GetHashKey( "s_m_m_security_01" ) ) do
    	Citizen.Wait( 1 )
	end
		ped0 = CreatePed(27,GetHashKey("s_m_m_security_01"),260.79998779297,221.28179931641,106.28293609619,69.938171386719,true,false)
	 	ped1 = CreatePed(27,GetHashKey("s_m_m_security_01"),261.58850097656,222.6916809082,106.2836227417,69.938171386719,true,false)
	 	ped3 = CreatePed(27,GetHashKey("s_m_m_security_01"),261.58850097656,221.6916809082,106.2836227417,69.938171386719,true,false)
	 	ped2 = CreatePed(27,GetHashKey("s_m_m_security_01"),256.72607421875,219.80041503906,106.28636169434,175.13543701172,true,false)

	 	GiveWeaponToPed(ped0,GetHashKey("WEAPON_CARBINERIFLE"),100,true,true)
	 	GiveWeaponToPed(ped1,GetHashKey("weapon_carbinerifle"),100,true,true)
	 	GiveWeaponToPed(ped2,GetHashKey("WEAPON_CARBINERIFLE"),100,true,true)
	 	GiveWeaponToPed(ped3,GetHashKey("WEAPON_CARBINERIFLE"),100,true,true)

	 	SetPedInfiniteAmmo(ped0,true,GetHashKey("WEAPON_CARBINERIFLE"))
	 	SetPedInfiniteAmmo(ped1,true,GetHashKey("weapon_carbinerifle"))
	 	SetPedInfiniteAmmo(ped2,true,GetHashKey("WEAPON_CARBINERIFLE"))
	 	SetPedInfiniteAmmo(ped3,true,GetHashKey("WEAPON_CARBINERIFLE"))

	 	SetPedAccuracy(ped0,75)
	 	SetPedAccuracy(ped0,75)
	 	SetPedAccuracy(ped0,75)
	 	SetPedAccuracy(ped0,75)
end]]
function creoexplosion()
	AddExplosion(253.783,224.084,101.902,2,80,true,false,50.5,false)
	explosion = false
end

RegisterNetEvent('robos:notificacion')
AddEventHandler('robos:notificacion',function(mensaje)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(mensaje)
	DrawNotification(false, true)

end)
RegisterNetEvent('robos:toofarlocal')
AddEventHandler('robos:toofarlocal', function()
	robando = false
	ESX.ShowNotification("Robo cancelado por estar demasiado lejos del punto")
	tiempo = 0
	puertaabierta = false
	explosion = nil
end)

RegisterNetEvent('robos:esmafia')
AddEventHandler('robos:esmafia',function(var)
	if var == 1 then

	else


	end
end)

RegisterNetEvent('robos:empiezorobo')
AddEventHandler('robos:empiezorobo',function()
	robando = true
	temporizador = true
	tiempo = 7 * 60
	TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "alarma", 1.0)
	--tiempo = 10

end)

local blips = {
    {title="Gran Robo", colour=24, id=500, x = 255.91546630859, y = 226.02563476563, z = 101.87572479248},
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

local blips = {
    {title="Circuito", colour=5, id=315, x = 2688.72, y = 1504.56, z = 24.56},
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

 Citizen.CreateThread(function()
 	while true do
 		Citizen.Wait(0)
 		local pos = GetEntityCoords(GetPlayerPed(-1))

	
 		if not robando then

 			if get3DDistance(255.91546630859,226.02563476563,101.87572479248,pos.x,pos.y,pos.z) < 15.0 then
	 			DrawMarker(1,255.91546630859,226.02563476563,101.87572479248 - 1, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 1.5001, 1555, 0, 0,255, 0, 0, 0,0)
	 			if get3DDistance(255.91546630859,226.02563476563,100.87572479248,pos.x,pos.y,pos.z) < 1.8 then
	 				DisplayHelpText("Presiona ~INPUT_CONTEXT~ para comenzar el robo al banco~b~")
	 			end
	 			if IsControlJustReleased(1,38) then
	 				TriggerServerEvent('robos:roboactivo')
	 			end
	 		end
	 	elseif robando and temporizador then
	 		if IsEntityDead(GetPlayerPed(-1)) then
 				robando = false
 				tiempo = 0
 				--creoIA()
 				TriggerServerEvent('robos:hamuerto')
 				explosion = nil
 			end
	 		--StartAlarm("Out_Of_Bounds_Timer", 0);
	 		drawTxt(0.66, 1.44, 1.0,1.0,0.4, '~r~Robo al banco en progreso.~b~ ' .. tiempo.. ' ~w~segundos para finalizar', 255, 255, 255, 255)

			if get3DDistance(255.91546630859,226.02563476563,101.87572479248,pos.x,pos.y,pos.z) > 18.0then
				TriggerServerEvent('robos:demasiadolejos')
			end
		elseif puertaabierta then
			DrawMarker(1,263.646,214.168,100.183, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 1.5001, 1555, 255, 0,255, 0, 0, 0,0)
			drawTxt(0.66, 1.44, 1.0,1.0,0.4, 'La puerta de la cámara acorazada está ~b~ABIERTA', 255, 255, 255, 255)
			
			SetNotificationTextEntry("STRING")
			AddTextComponentString("Entra en el marker para poder coger el dinero. Desde dentro puedes empujar la puerta para abrirla")
			DrawNotification(false, true)
			DrawMarker(1,255.91546630859 - 0.15,226.02563476563 -1,101.87572479248 - 1, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 1.5001, 1555, 255, 0,255, 0, 0, 0,0)
			if get3DDistance(255.91546630859 - 0.15,226.02563476563 -1,101.87572479248 - 1,pos.x,pos.y,pos.z) < 1.8 then
				DisplayHelpText("Presiona ~INPUT_CONTEXT~ para entrar a la cámara acorazada~b~")
	 			if IsControlJustReleased(1,38) then
	 				SetEntityCoords(GetPlayerPed(-1),253.783,221.084,100.902)
	 			end
			end
			if get3DDistance(263.646,214.168,100.183,pos.x,pos.y,pos.z) < 1.8 then
				DisplayHelpText("Presiona ~INPUT_CONTEXT~ para recoger el dinero~b~")
	 			if IsControlJustReleased(1,38) then
	 				TriggerEvent('chatMessage', 'SYSTEM', {255,0,0}, " Espera mientras recoges el dinero")
					FreezeEntityPosition(GetPlayerPed(-1),true)
					Citizen.Wait(5000)
					FreezeEntityPosition(GetPlayerPed(-1),false)
					TriggerEvent('chatMessage', 'SYSTEM', {255,0,0}, "Ya tienes el dinero, ahora ESCAPA")
	 				local dinero = 300000
	 				TriggerServerEvent('robos:doydinero',dinero)
	 				puertaabierta = false
	 				robando = false
	 				tiempo = 0
	 				explosion = nil
	 				--creoIA()
	 			end
			end
			if get3DDistance(255.91546630859,226.02563476563,101.87572479248,pos.x,pos.y,pos.z) > 18.0 then
				TriggerServerEvent('robos:demasiadolejos')
			end
		end
 	end
 end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if robando and temporizador then
			Citizen.Wait(1000)
			if(tiempo > 0)then
				tiempo = tiempo - 1
			end
			if tiempo == 5 then
				SetNotificationTextEntry("STRING")
				AddTextComponentString("¡Ten cuidad, la puerta va a explotar!")
				DrawNotification(false, true)
			end
			if tiempo == 0 then
				if explosion == nil then
					explosion = true
					creoexplosion()
				end
				puertaabierta = true
				temporizador = false
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(0)
		if GetPlayerWantedLevel(GetPlayerPed(-1)) ~= 0 then 
			SetPlayerWantedLevel(GetPlayerPed(-1), 0, false) 
			SetPlayerWantedLevelNow(GetPlayerPed(-1), false) 
		end 
	end 
end)

 Citizen.CreateThread(function()
 --	creoIA()

 end)



 
