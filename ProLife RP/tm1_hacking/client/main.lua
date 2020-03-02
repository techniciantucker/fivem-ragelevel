local hacker = {x = -218.52,y = 6368.32,z = 32.08}
local paperEncoder = {x = -186.2,y = 6548.44,z = 11.16}
local passLocation = {x = 457.16, y = 5571.52,z = 781.2}
local pass = "M1GU4L R3Y3S"
local intents = 0
local isInJob = false
local __ESLOCALES = {
    passTitle = '¿Cual es la contraseña?',
    incorrectPass = 'Lo siento, pero esa no es la contraseña. Tendrás que investigar más.',
    correctPass = 'Contraseña correcta.',
    getJob = 'Conseguir trabajo',
    setCode = 'Canjear código',
    cancel = 'Cancelar',
    process = 'Procesando...',
    menuHacker = 'Menu de hacker',
    noGod = 'Deja de llamar a la puta puerta. Vete al monte chiliad a buscar el puto código de una vez. Parece que en esta cuidad no se puede estar tranquilo. JODER ME CAGO EN LA OSTIA PUTA QUE ME PARIO',
    isInJob = 'Primero acaba el trabajo que te he mandado y si me sale de los huevos te mando otro.',
    rubbishJob = 'A ver gilipollas presta atención que no te lo voy a decir dos putas veces. He perdido mi puto papel con las fórmulas, bueno, lo he tirado a la papelera. Estará en alguna papelera de Procopio Drive o Paleto Boulevard. Cuando lo cojas me llamas y te envio otra cosa.',
    getPaper = 'Aquí hay un papel con unas formulas. Pulsa E para cogerlo',
    goPaper = 'Buenas, soy el hacker. He hackeado tu mente. ¿Algún problema? Ahora veo lo que ves, nah es broma no te ralles. Cerca de la playa hay una casa abandonada, lleva este papel para recibir un código.',
    takeMePaper = '<MAQUINA> Si introduces el papel aquí te daré un código.',
    code = 'El código es : ',
    setCode = 'Introduce el código:',
    pass = 'Aquí hay un mensaje : '
}
local rubbish = {
    {x = -251.28, y = 6411.76, z = 31.16},
    {x = -265.8 , y = 6368.68, z = 31.32},
    {x = -373.08, y = 6285.28, z = 29.72},
    {x = -385.36, y = 6272.96, z = 30.28},
    {x = -349.6 , y = 6168.6 , z = 31.36},
    {x = -44.48 , y = 6625.52, z = 30.16}
}
ESX                           = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getShtoniaredObjtoniect', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(0)
        local playercoords = GetEntityCoords(GetPlayerPed(-1), true)
        if GetDistanceBetweenCoords(hacker.x,hacker.y,hacker.z,playercoords) < 3 then
            DrawText3D(hacker.x,hacker.y,hacker.z,__ESLOCALES.passTitle,255,0,0)
            if IsControlJustPressed(1,38) then
                openPassMenu()
            end
        end
        if GetDistanceBetweenCoords(passLocation.x,passLocation.y,passLocation.z,playercoords) < 3 then
            DrawText3D(passLocation.x,passLocation.y,passLocation.z,__ESLOCALES.pass..pass,255,0,0)
        end
        if GetDistanceBetweenCoords(paperEncoder.x,paperEncoder.y,paperEncoder.z,playercoords) < 3 then
            DrawText3D(paperEncoder.x,paperEncoder.y,paperEncoder.z,__ESLOCALES.takeMePaper,255,0,0)
            if IsControlJustPressed(1,38) then
                TriggerServerEvent('tm1_hacking:paperCode')
            end
        end
    end
end)

----------------------------
-----------FUNCIONES--------
----------------------------
function openPassMenu()
    ESX.UI.Menu.Open(
        'dialog', GetCurrentResourceName(), 'passhacking',
        {
          title = __ESLOCALES.passTitle
        },
        function(data, menu)
          local momentPass = data.value
          if momentPass ==  pass and isInJob == false then
            Citizen.CreateThread(function ()
                TriggerEvent("pNotify:SetQueueMax", "center", 2)
                TriggerEvent("pNotify:SendNotification", {
                    text = __ESLOCALES.correctPass,
                    type = "success",
                    timeout = 3000,
                    layout = "centerRight",
                    queue = "center"
                })
                TriggerEvent("pNotify:SetQueueMax", "center", 2)
                TriggerEvent("pNotify:SendNotification", {
                    text = __ESLOCALES.process,
                    type = "success",
                    timeout = 6000,
                    layout = "centerRight",
                    queue = "center"
                })
                Citizen.Wait(7000)
                OpenHackerMenu()
            end)
            menu.close()
          elseif momentPass ==  pass and isInJob == true then
                TriggerEvent("pNotify:SetQueueMax", "center", 2)
                TriggerEvent("pNotify:SendNotification", {
                    text = __ESLOCALES.isInJob,
                    type = "error",
                    timeout = 3000,
                    layout = "centerRight",
                    queue = "center"
                })
          else
            if intents < 3 then
                TriggerEvent("pNotify:SetQueueMax", "center", 2)
                TriggerEvent("pNotify:SendNotification", {
                    text = __ESLOCALES.incorrectPass,
                    type = "error",
                    timeout = 3000,
                    layout = "centerRight",
                    queue = "center"
                })
                intents = intents + 1
            else
                TriggerEvent("pNotify:SetQueueMax", "center", 2)
                TriggerEvent("pNotify:SendNotification", {
                    text = __ESLOCALES.noGod,
                    type = "error",
                    timeout = 7000,
                    layout = "centerRight",
                    queue = "center"
                })
            end
          end
          menu.close()
        end,
      function(data, menu)
        menu.close()
      end)
end

function OpenHackerMenu()

	local elements = {
		{label = __ESLOCALES.getJob,value = "getJob"},
        {label = __ESLOCALES.setCode,value = "setCode"},
        {label = __ESLOCALES.cancel,value = "cancel"}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'hackerMenu',
		{
			title  = __ESLOCALES.menuHacker,
			align    = 'bottom-right',
			elements = elements
		},
		function(data, menu)	
            if data.current.value == 'getJob' then
                local job = math.random(1,1)
                if job == 1 then
                    isInJob = true
                    TriggerEvent("pNotify:SetQueueMax", "center", 2)
                    TriggerEvent("pNotify:SendNotification", {
                        text = __ESLOCALES.rubbishJob,
                        type = "success",
                        timeout = 10000,
                        layout = "centerRight",
                        queue = "center"
                    })
                    local trash = math.random(1,#rubbish)
                    local x = rubbish[trash].x
                    local y = rubbish[trash].y
                    local z = rubbish[trash].z
                    createPaper(x,y,z)
                end
                menu.close()
            elseif data.current.value == 'setCode' then
                ESX.UI.Menu.CloseAll()
                openCodeMenu()
            elseif data.current.value == 'cancel' then
                menu.close()
			end	
		end,
		function(data, menu)
			menu.close()
		end
	)
end

function openCodeMenu()
    ESX.UI.Menu.Open(
        'dialog', GetCurrentResourceName(), 'codemenu',
        {
          title = __ESLOCALES.setCode
        },
        function(data, menu)
          local code = data.value
          TriggerServerEvent('tm1_hacking:getCode',code)
          menu.close()
        end,
      function(data, menu)
        menu.close()
      end)
end

function createPaper(x,y,z)
    Citizen.CreateThread(function ()
        while true do
            Citizen.Wait(0)
            local playercoords = GetEntityCoords(GetPlayerPed(-1), true)
            if GetDistanceBetweenCoords(x,y,z,playercoords) < 5 then  
                DrawText3D(x,y,z,__ESLOCALES.getPaper,255,0,0)
                if IsControlJustPressed(1,38) then
                    TriggerEvent("pNotify:SetQueueMax", "center", 2)
                    TriggerEvent("pNotify:SendNotification", {
                        text = __ESLOCALES.goPaper,
                        type = "success",
                        timeout = 10000,
                        layout = "centerRight",
                        queue = "center"
                    })
                    TriggerServerEvent('tm1_hacking:addItem','paper',1)
                    isInJob = false
                    break
                end
            end
        end
    end)
end

RegisterNetEvent('tm1_hacking:paperSuccessFull')
AddEventHandler('tm1_hacking:paperSuccessFull', function(code)
	TriggerEvent("pNotify:SetQueueMax", "center", 2)
    TriggerEvent("pNotify:SendNotification", {
        text = (__ESLOCALES.code)..tostring(code),
        type = "success",
        timeout = 15000,
        layout = "centerRight",
        queue = "center"
    })
end)

RegisterNetEvent('tm1_hacking:pastilla')
AddEventHandler('tm1_hacking:pastilla', function()
	local Ped = GetPlayerPed(-1)
	SetEntityHealth(Ped, 200)
	ClearPedBloodDamage(Ped)
	ResetPedVisibleDamage(Ped)
	ClearPedLastWeaponDamage(Ped)
end)

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
