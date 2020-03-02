--en la zona de minas: x rocas con un máximo extraíble. Se regenera con el tiempo, si llega a 0 no puedes minar.
local clicks = 0
local roca = nil
local npcvender = true --false si no quieres el npc que te lo cambia por dinero
local cargado = false 

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getShtoniaredObjtoniect', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

--LOCALES
for i = 1,#Config.rocas,1 do

	Config.rocas[i].tipo = _U(Config.rocas[i].data)

end
---

RegisterNetEvent('minar:recibodatacliente')
AddEventHandler('minar:recibodatacliente',function(data)
    Config.rocas = data
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

function DrawText3Dlittle(x,y,z, text) 

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 0.5*scale)
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

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

 function get3DDistance(x1, y1, z1, x2, y2, z2)
    local a = (x1 - x2) * (x1 - x2)
    local b = (y1 - y2) * (y1 - y2)
    local c = (z1 - z2) * (z1 - z2)
    return math.sqrt(a + b + c)
end

local punto = {x = 1905.96, y = 3718.96, z = 31.26}


Citizen.CreateThread(function() 
    while true do 
        Citizen.Wait(0)
        local PlayerCoords = GetEntityCoords(PlayerPedId())
        local distace = GetDistanceBetweenCoords(PlayerCoords, punto.x, punto.y, punto.z)
        if distace < 100 then 
            DrawMarker(1, punto.x, punto.y, punto.z,0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, 1.5, 255, 0, 0, 100, false, true, 2, false, nil, nil, false)
        end 
    end
end)

function AbrirMenu()

	local elements = {
		{label = _U('si'),value = "yes"},
		{label = _U('no'),value = "no"}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'get_job',
		{
			title  = _U('vendedorTitulo'),
			align    = 'bottom-right',
			elements = elements
		},
		function(data, menu)	
			if data.current.value == 'yes' then
				TriggerServerEvent('minar:quitomin')
			end
			menu.close()
		end,
		function(data, menu)
			menu.close()
		end
	)
end

Citizen.CreateThread(function()
	while true do
        if IsPedDead then
            clicks = 0
            roca = nil
        end
		Citizen.Wait(0)
		local coords = GetEntityCoords(GetPlayerPed(-1))
		for i=1, #Config.rocas, 1 do
            if GetDistanceBetweenCoords(coords.x,coords.y,coords.z,Config.rocas[i].x,Config.rocas[i].y,Config.rocas[i].z) < 75 then
                if Config.rocas[i].vida >= 50 then
    		      DrawText3D(Config.rocas[i].x,Config.rocas[i].y,Config.rocas[i].z, _U('tipoDeRoca').." ~b~"..Config.rocas[i].tipo.."~w~ : ~g~"..Config.rocas[i].vida.."/"..Config.rocas[i].max)
                elseif Config.rocas[i].vida >= 25 then
                   DrawText3D(Config.rocas[i].x,Config.rocas[i].y,Config.rocas[i].z, _U('tipoDeRoca').." ~b~"..Config.rocas[i].tipo.."~w~ : ~b~"..Config.rocas[i].vida.."/"..Config.rocas[i].max)
                elseif Config.rocas[i].vida < 25 and Config.rocas[i].vida ~= 0 then
                     DrawText3D(Config.rocas[i].x,Config.rocas[i].y,Config.rocas[i].z, _U('tipoDeRoca').." ~b~"..Config.rocas[i].tipo.."~w~ : ~y~"..Config.rocas[i].vida.."/"..Config.rocas[i].max)
                elseif Config.rocas[i].vida <= 0 then
                     DrawText3D(Config.rocas[i].x,Config.rocas[i].y,Config.rocas[i].z, _U('tipoDeRoca').." ~b~"..Config.rocas[i].tipo.."~w~ : ~r~ "..Config.rocas[i].vida.."/"..Config.rocas[i].max)  
                end
            end
		end

        if GetCurrentPedWeapon(GetPlayerPed(-1),"WEAPON_BATTLEAXE",true) then
            if IsControlJustReleased(1,  24) then --click izq

                for i=1, #Config.rocas, 1 do
                    if GetDistanceBetweenCoords(coords.x,coords.y,coords.z,Config.rocas[i].x,Config.rocas[i].y,Config.rocas[i].z) < 1.8 and Config.rocas[i].vida > 0 then
                        roca = i
                    end
                end
                if roca ~= nil then
                        click()
                        Citizen.Wait(2)
                end
            end
        end

        if get3DDistance(coords.x,coords.y,coords.z,2953.68,2790.68,41.28) > 150 then

            local nothing, weapon = GetCurrentPedWeapon(GetPlayerPed(-1), true)

            if weapon == "WEAPON_BATTLEAXE" then

	            RemoveWeaponFromPed(GetPlayerPed(-1),"WEAPON_BATTLEAXE")
	            SetNotificationTextEntry("STRING")
	            AddTextComponentString(_U('fueraMina'))
                DrawNotification(false, true)
                
            end
        end

        if get3DDistance(2952.0,2748.8,43.48-1,coords.x,coords.y,coords.z) < 100 then

            DrawMarker(1,2952.0,2748.8,43.48-1, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 1.5001, 1555, 132, 23,255, 0, 0, 0,0)

        end

        if get3DDistance(2952.0,2748.8,43.48-1,coords.x,coords.y,coords.z) < 1.5 then

            DisplayHelpText(_U('cogerHerramienta'))

            if IsControlJustReleased(1,38) then
                GiveWeaponToPed(GetPlayerPed(-1),"WEAPON_BATTLEAXE",1,false,true)
            end

        end

        if npcvender then

            if get3DDistance(1905.96,3718.96,31.76,coords.x,coords.y,coords.z) < 20 then
                
                DrawText3Dlittle(1905.96,3718.96,33.76, _U('hombreTexto'))
                
                if IsControlJustReleased(1,38) then
                    
                    AbrirMenu()
                    
        		end
        	end
    	end
	end
end)


function click()
-- Los clicks habrán que equilibrarlos a la dinámica del servidor
    if roca ~= nil then

        if Config.rocas[roca].vida > 0 then
           if clicks >= 25 then 
                clicks = 0
                Config.rocas[roca].vida = Config.rocas[roca].vida - 1
                TriggerServerEvent('minar:doymineral',Config.rocas[roca].data)
                TriggerServerEvent('minar:recibodata',Config.rocas)
                roca = nil
            else
                clicks = clicks + 1 
                roca = nil
            end
        end
    end

end

local blips = {
    {title=_U('mina'), colour=2, id=486, x = 2952.0, y = 2748.8, z = 43.48-1},
    {title=_U('vendedorMinerales'), colour=2, id=486, x = 1905.96,y = 3718.96,z = 31.76},
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