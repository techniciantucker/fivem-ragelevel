
local actualNeg = nil

function round(num, numDecimalPlaces)
	return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end


RegisterNUICallback('escape', function(data,cb)
    SendNUIMessage({type = 'jefeOff'})
    SetNuiFocus(false,false)
    menujefe[actualNeg] = false
    actualNeg = nil
    cb(nil)
end)


RegisterNUICallback('manageBalance', function(data,cb)
    local money = tonumber(data.money)
    if data.tipo == 'retirar' then

        if actualNeg ~= nil then
            if negocio[actualNeg].dinero >= money and money > 0 then
                TriggerServerEvent('chaini_negocios:manageBalance','retirar',money,actualNeg)
            else
                ESX.ShowNotification('No tienes tanto ~g~dinero ~w~ en el ~b~negocio')
            end
        else
            ESX.ShowNotification('Ha ocurrido un ~r~error')
        end

    elseif data.tipo == 'depositar' then
        if actualNeg ~= nil then
            if tonumber(money) > 0 and type(money) == "number" then
                TriggerServerEvent('chaini_negocios:manageBalance','depositar',money,actualNeg)
            end
        else
            ESX.ShowNotification('Ha ocurrido un ~r~error')
        end
    end

    cb(nil)
end)

RegisterNUICallback('cambioNombre', function(data,cb)
    if actualNeg ~= nil then
        if data.str == '' then
            ESX.ShowNotification('Nombre ~r~inválido')
        else
            TriggerServerEvent('chaini_negocios:sincronizodatos',actualNeg,data.str)
        end
    end
    cb(nil)
end)

RegisterNUICallback('vendernegocio', function(data,cb)
    if actualNeg ~= nil then
        data.precio = tonumber(data.precio)
        data.usuario = tonumber(data.usuario)
        if type(data.precio) == 'number' and type(data.usuario) == 'number' then

            TriggerServerEvent('chaini_negocios:vendernegocio',tonumber(data.precio),tonumber(data.usuario),actualNeg)
            SendNUIMessage({type = 'jefeOff'})
            menujefe[actualNeg] = false
            actualNeg = nil
        end
    end
    SetNuiFocus(false,false)
    cb(nil)
end)


RegisterNUICallback('venderGob', function(data,cb)
    if actualNeg ~= nil then
        TriggerServerEvent('chaini_negocios:vendoGob',actualNeg)
        SendNUIMessage({type = 'jefeOff'})
        SetNuiFocus(false,false)
        menujefe[actualNeg] = false
        actualNeg = nil
    end
    cb(nil)
end)


function AbrirMenuJefe(neg_id)


    actualNeg = neg_id
    SetNuiFocus(true,true)
    SendNUIMessage({
        type = "jefeOn",
        dinero = negocio[neg_id].dinero
    })
  --[[  ESX.UI.Menu.CloseAll()
    
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'menujefe',
		{
			title    = 'Caja fuerte',
			align    = 'bottom-right',
            elements = {
                {label = '<b>Dinero: <span style="color: green;">'..round(negocio[neg_id].dinero,0)..'$</b></span>', value = 'dinero'},
                {label = '<b>Cambiar nombre</b>',value = 'cambiarNombre'},
                {label = '<b>Vender negocio al <span style="color: blue;">gobierno</span></b>', value="sellgob"}
            }
		},
		function(data, menu)
                    
            if data.current.value == 'dinero' then


                ESX.UI.Menu.Open(
                    'default', GetCurrentResourceName(), 'menujefe_2',
                    {
                        title    = 'Caja fuerte',
                        align    = 'bottom-right',
                        elements = {
                            {label = 'Añadir dinero', value = 'addMoney'},
                            {label = 'Retirar dinero', value = 'withdrawMoney'}
                        }
                    },
                    function(data2,menu2)

                        if data2.current.value == 'addMoney' then
                            ESX.UI.Menu.Open(
                                'dialog', GetCurrentResourceName(), 'menujefe_dialog',
                                {
                                    title = 'Cantidad a añadir'
                                },
                                function(data4,menu4)
                                    if tonumber(data4.value) <= 0 then
                                        ESX.ShowNotification('Cantidad ~r~ inválida')
                                    else
                                        TriggerServerEvent('chaini_negocios:manageBalance',"anadir",tonumber(data4.value),neg_id)
                                    end
                                    menu4.close()
                                end,
                                function(data4,menu4)
                                    menu4.close()
                                end
                            )
                        end

                        if data2.current.value == 'withdrawMoney' then
                            ESX.UI.Menu.Open(
                                'dialog', GetCurrentResourceName(), 'menujefe_dialog',
                                {
                                    title = 'Cantidad a retirar'
                                },
                                function(data4,menu4)
                                    if tonumber(data4.value) <= 0 then
                                        ESX.ShowNotification('Cantidad ~r~ inválida')
                                    else
                                        TriggerServerEvent('chaini_negocios:manageBalance',"retirar",tonumber(data4.value),neg_id)
                                    end
                                    menu4.close()
                                end,
                                function(data4,menu4)
                                    menu4.close()
                                end
                            )
                        end
                    end,
                    function(data2, menu2)
                        ESX.UI.Menu.CloseAll()
                    end
                )

            end

            if data.current.value == 'cambiarNombre' then
                ESX.UI.Menu.Open(
                    'dialog', GetCurrentResourceName(), 'menujefe_dialog_cambiar_nombre',
                    {
                        title = 'Nuevo nombre'
                    },
                    function(data4)

                        local nombre = data4.value
                        TriggerServerEvent('chaini_negocios:sincronizodatos',neg_id,nombre)
                        ESX.UI.Menu.CloseAll()
                    end,
                    function(data4,menu4)
                        menu4.close()
                    end
                )
            end

            if data.current.value == 'sellgob' then
                ESX.UI.Menu.Open(
                'default', GetCurrentResourceName(), 'sellgob',
                {
                    title    = 'Si lo vendes, recibirás el 75% de su precio de mercado',
                    align    = 'bottom-right',
                    elements = {
                        {label = '<b>No</b>', value = 'no'},
                        {label = '<b><span style="color: red;"> Sí </span></b>',value = 'si'},
                    }
                },
                function(data2,menu2)
                    if data2.current.value == "no" then
                        menu2.close()
                    end

                    if data2.current.value == "si" then

                        ESX.UI.Menu.CloseAll()
                        TriggerServerEvent('chaini_negocios:vendoGob',neg_id)
                    end
                end,
                function(data2,menu2)
                    menu2.close()
                end)
            end

		end,
		function(data, menu)
            ESX.UI.Menu.CloseAll()

		end
	)

]]

end

