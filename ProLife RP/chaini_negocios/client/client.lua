
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getShtoniaredObjtoniect', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

end)

negocio = {}

local labels3dvar = false
local esdueno = {}
menujefe = {}
local enMenu = false
local negMenuId = nil

local enumTipos = {
    [1] = {"24/7",52,5},
    [2] = {"Ammunation",313},
    [3] = {"Concesionario",225},
    [4] = {"Farmacia",499},
    [5] = {"Tienda de ropa",73},
    [6] = {"Gasolinera con 24/7",52,5},
    [7] = {"Máscaras",362,15},
    [8] = {"Tatuajes",75},
    [9] = {"Jollería",439,47},
	[10] = {"Apartamento",439,47},
	[11] = {"Tienda de ropa real",73, 5},
	[12] = {"BurgerShot"} 
}

function DrawText3D(x,y,z, text) 

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

function labels3D()
    local coords = GetEntityCoords(GetPlayerPed(-1))
    if labels3dvar == true then
        for i=1,#negocio,1 do
            if negocio[i] ~= {} or negocio[i] ~= nil then
                if get3DDistance(coords.x,coords.y,coords.z,negocio[i].pos_info.x,negocio[i].pos_info.y,negocio[i].pos_info.z) < 30.0 then
                    if negocio[i].dueno_name ~= "none" and negocio[i].dueno_identifier ~= "none" then
                        DrawText3D(negocio[i].pos_info.x,negocio[i].pos_info.y,negocio[i].pos_info.z, "Nombre: ~g~"..negocio[i].nombre)
                        DrawText3D(negocio[i].pos_info.x,negocio[i].pos_info.y,negocio[i].pos_info.z-0.15, "ID: ~b~"..negocio[i].id) 
                        DrawText3D(negocio[i].pos_info.x,negocio[i].pos_info.y,negocio[i].pos_info.z-0.30,"Dueño: ~b~"..negocio[i].dueno_name)

                    else
                        DrawText3D(negocio[i].pos_info.x,negocio[i].pos_info.y,negocio[i].pos_info.z, "Estado: ~g~ EN VENTA")  
                        DrawText3D(negocio[i].pos_info.x,negocio[i].pos_info.y,negocio[i].pos_info.z-0.15, "ID: ~b~"..negocio[i].id) 
                        DrawText3D(negocio[i].pos_info.x,negocio[i].pos_info.y,negocio[i].pos_info.z-0.30,"Precio: ~b~"..negocio[i].precio.." $")
                    end
                end
                DrawMarker(27, negocio[i].pos.x,negocio[i].pos.y,negocio[i].pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5,1.5, 200, 100, 120, 100, false, true, 2, false, false, false, false)
            end
        end
    end
end

function dueno_actions()
    local coords = GetEntityCoords(GetPlayerPed(-1))
    for i=1,#negocio,1 do
        if negocio[i] ~= {} or negocio[i] ~= nil then

            if GetDistanceBetweenCoords(coords.x,coords.y,coords.z,negocio[i].dueno_pos.x,negocio[i].dueno_pos.y,negocio[i].dueno_pos.z) < 10 and esdueno[i] == true then
                DrawMarker(27, negocio[i].dueno_pos.x,negocio[i].dueno_pos.y,negocio[i].dueno_pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0,1.0, 200, 100, 120, 100, false, true, 2, false, false, false, false)
            end
            if GetDistanceBetweenCoords(coords.x,coords.y,coords.z,negocio[i].dueno_pos.x,negocio[i].dueno_pos.y,negocio[i].dueno_pos.z) < 1.5 and esdueno[i] == true then
                DisplayHelpText("Presiona ~INPUT_CONTEXT~ para abrir la caja fuerte ")
                if IsControlJustReleased(1,38) then

                    AbrirMenuJefe(i)
                    menujefe[i] = true
                end
            else
                if menujefe[i] == true then
                    ESX.UI.Menu.CloseAll()
                    menujefe[i] = false
                end
            end
        end
    end
end

RegisterNetEvent('chaini_negocios:getNegociosPropios')
AddEventHandler('chaini_negocios:getNegociosPropios',function(cb)
    local negocios = {}
    for k,v in pairs(esdueno) do
        if esdueno[k] == true then
            table.insert(negocios,{id = negocio[k].idSql, pos = negocio[k].pos, nombre = negocio[k].nombre})
        end
    end
    cb(negocios)

end)

RegisterNetEvent('chaini_negocios:setPos')
AddEventHandler('chaini_negocios:setPos',function(negId)
    print(negId)
    SetEntityCoords(PlayerPedId(),negocio[negId].pos_info.x,negocio[negId].pos_info.y,negocio[negId].pos_info.z)

end)

RegisterNetEvent('chaini_negocios:sincronizotodo')
AddEventHandler('chaini_negocios:sincronizotodo',function(data)
    negocio = data
    labels3dvar = true
end)

RegisterNetEvent('chaini_negocios:manageDueno')
AddEventHandler('chaini_negocios:manageDueno',function(tipo,id)
    if tipo == 'retiro' then
        esdueno[id] = false
    end
    if tipo == 'anado' then
        esdueno[id] = true
    end
end)

RegisterNetEvent('chaini_negocios:updateNegocioBalance')
AddEventHandler('chaini_negocios:updateNegocioBalance',function(id,balance)

        negocio[id].dinero = balance
        if menujefe[id] == true then
            SendNUIMessage({type = 'updateBalance', dinero = negocio[id].dinero})
        end
end)

-- Si hay que sincronizar solo una variable de un negocio( ej: stock) no quiero enviarle a todos los clientes todos los negocios de nuevo
RegisterNetEvent('chaini_negocios:sincronizoparcial')
AddEventHandler('chaini_negocios:sincronizoparcial',function(data)
    negocio[data.id] = data

end)


RegisterNetEvent('chaini_negocios:ofertanegocio')
AddEventHandler('chaini_negocios:ofertanegocio',function(precio,id,jugador)
    TriggerEvent('chatMessage',"Negocio", {255, 0, 0},"La ID("..jugador..") te quiere vender su negocio ID("..id..") con nombre "..negocio[id].nombre.." por ^2 "..precio.." $")
	TriggerEvent('chatMessage',"Negocio", {255, 0, 0},"^2 TECLA 1 ^0 para ACEPTAR o ^2 TECLA 2 ^0 para rechazar la oferta")
	local oferta = true
	Citizen.CreateThread(function()
		while oferta do
				if IsControlJustPressed(1, 157) then -- 1 = YES
					TriggerServerEvent('chaini_negocios:handleroferta',true,precio,id,jugador)
					oferta = false
				end
				if IsControlJustPressed(1, 158) then -- 2 = NO
					TriggerServerEvent('chaini_negocios:handleroferta',false,precio,id,jugador)
					oferta = false
				end
			Citizen.Wait(0)
		end
	end)

end)

Citizen.CreateThread(function()
    while not labels3dvar do
        Citizen.Wait(0)
    end
        for i=1,#negocio,1 do

            local blip = AddBlipForCoord(negocio[i].pos.x,negocio[i].pos.y,negocio[i].pos.z)
            SetBlipSprite (blip, enumTipos[negocio[i].tipo][2])
            SetBlipDisplay(blip, 4)
            SetBlipScale  (blip, 1.0)
            if enumTipos[negocio[i].tipo][3] ~= nil then
                SetBlipColour (blip, enumTipos[negocio[i].tipo][3])
            end
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(enumTipos[negocio[i].tipo][1])
            EndTextCommandSetBlipName(blip)
        end


end)
Citizen.CreateThread(function()
    
    while true do

        labels3D()
        dueno_actions()
        Citizen.Wait(0)

    end
end)


Citizen.CreateThread(function()
    while true do

        local coords = GetEntityCoords(GetPlayerPed(-1))
        for i=1, #negocio,1 do
            if GetDistanceBetweenCoords(coords,negocio[i].pos.x,negocio[i].pos.y,negocio[i].pos.z) < 1.0 then
                     DisplayHelpText("Presiona ~INPUT_CONTEXT~ para abrir la tienda: "..negocio[i].nombre)
                            if IsControlJustReleased(1,38) then
                                if negocio[i].tipo == 1 then
                                    TriggerEvent('esx_shops:openMenu',i)

                                end

                                if negocio[i].tipo == 2 then
                                    TriggerEvent('esx_weaponshop:openMenu',i)
                                end

                                if negocio[i].tipo == 3 then
                                    TriggerEvent('esx_vehicleshop:openMenu',negocio[i].extraData,i)
                                end

                                if negocio[i].tipo == 4 then

                                    TriggerEvent('esx_farmacia:openMenu',i)
                                end

                                if negocio[i].tipo == 5 then

                                    TriggerEvent('esx_clotheshop:openMenu',i)
                                end

                                if negocio[i].tipo == 6 then
                                    TriggerEvent('esx_shops:openMenu',i)
                                end

                                if negocio[i].tipo == 7 then
                                    TriggerEvent('esx_mask:openMenu',i)
                                end

                                if negocio[i].tipo == 8 then
                                    TriggerEvent('esx_tattoosShop:openMenu',i)
                                end

                                if negocio[i].tipo == 9 then
                                    TriggerEvent('esx_jolleria:openMenu',i)
                                end
								
								if negocio[i].tipo == 10 then
                                    TriggerEvent('esx_apartamento:openMenu',i) 
                                end
								
								if negocio[i].tipo == 11 then
                                    TriggerEvent('esx_realClothesProCoins:openMenu',i) 
                                end

                                if negocio[i].tipo == 12 then

                                end
                                negMenuId = i
                                enMenu = true
                            end
            else
                if enMenu and negMenuId == i and negocio[negMenuId].tipo ~= 3 then
                    negMenuId = nil
                    enMenu = false
                    ESX.UI.Menu.CloseAll()
                end
            end

            if  negocio[i].dueno_name == "none" or negocio[i].dueno_identifier == "none" then
                
                if GetDistanceBetweenCoords(coords,negocio[i].pos_info.x,negocio[i].pos_info.y,negocio[i].pos_info.z) < 1.5 then
                    DisplayHelpText("Este negocio se encuentra actualmente EN VENTA. Para comprarlo presiona ~INPUT_CONTEXT~")            
                    if IsControlJustReleased(1,38) then -- E
                        TriggerServerEvent('chaini_negocios:comproNegocio',i)
                    end   
                end
            end
        end
        
        Citizen.Wait(0)
    end
end)
