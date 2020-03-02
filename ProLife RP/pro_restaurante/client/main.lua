local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil
local PlayerData              = {}
local kockSpawned             = false
local IsAnimated              = false
local cinema = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getShtoniaredObjtoniect', function(obj) ESX = obj end)
		Citizen.Wait(200)
		PlayerData = ESX.GetPlayerData()
	end
end)

RegisterNetEvent('hamilton:syncCL')
AddEventHandler('hamilton:syncCL', function(ped, need)
    if need == happymeal then
        servped()
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

function Draw3DText(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
  
	local scale = 0.45
   
	if onScreen then
		SetTextScale(scale, scale)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
        DrawText(_x,_y)
        local factor = (string.len(text)) / 370
        DrawRect(_x, _y + 0.0150, 0.030 + factor , 0.030, 66, 66, 66, 150)
	end
end

-- Pnotify
function sendNotification(message, messageType, messageTimeout)
	TriggerEvent("pNotify:SendNotification", {
		text = message,
		type = messageType,
		queue = "didrik",
		timeout = messageTimeout,
		layout = "bottomCenter"
	})
end

local kockSpawned = false

function kockped()
        modelHash = -1931689897 
        RequestModel(modelHash)

        while not HasModelLoaded(modelHash) do
            Wait(1)
        end
        Wait(200)
        if not kockSpawned then
        kock = CreatePed(5, modelHash, 1589.11, 6457.0, 25.6, -190.0, false, false)
        kockSpawned = true
        end
        Wait(200)
        kockSpawned = false
        Wait(200)
end

local servSpawned = false

function servped()
    modelHash = -1954728090 
    RequestModel(modelHash)

    while not HasModelLoaded(modelHash) do
        Wait(1)
    end
    Wait(200)
    if not servSpawned then
    serv = CreatePed(5, modelHash, 1590.62, 6457.86, 25.6, -190.0, false, false)
    servSpawned = true
    end
    Wait(200)
    servSpawned = false
    Wait(200)
end

function deletekock()
    DeleteEntity(kock)
end

function deleteserv()
    DeleteEntity(serv)
end

Citizen.CreateThread(function()
	while true do Citizen.Wait(0)
		if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 1588.3, 6455.12, 25.00, true) <= 2.1 ) then
			if IsControlPressed(0, Keys['E']) then

				local elements = {
                    {label = 'Donut (EUR 50)', value = 'happymeal', item = 'donut', price = 50},
                    {label = 'Agua (EUR 30)', value = 'happymeal', item = 'water', price = 30},
				}
			
				ESX.UI.Menu.CloseAll()
			
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'didrik_restaurant', {
					title    = ('BURGER KING'),
					align    = 'top-left',
					elements = elements
                }, function(data, menu)
                    local item = data.current.item
                    local price = data.current.price

				    if data.current.value == 'happymeal' then
                      ESX.UI.Menu.CloseAll()
                      kockped()
                      sendNotification('Enviando Orden a Cocina..', 'error', 3500)
                      RequestAnimDict("missah_2_ext_altleadinout")
                      while not HasAnimDictLoaded("missah_2_ext_altleadinout") do
                          Citizen.Wait(100)
                      end
                      TaskPlayAnim(kock, "missah_2_ext_altleadinout", "hack_loop", 3.5, -8, -1, 2, 0, 0, 0, 0, 0)
                      Wait(4000)
                      FreezeEntityPosition(kock, false)
                      TaskGoStraightToCoord(kock, 1590.62, 6457.86, 25.6, 1.0, 100000, 0.0, 2.0)  
                      Wait(1500)
                      deletekock()
                          blockinput = true
                          local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
                          SetCamCoord(cam, 1591.05, 6452.87, 27.6)
                              SetCamRot(cam, 0.0, 0.0, 20.0, 2)
                          RenderScriptCams(1, 0, 0, 0, 0)
                              Citizen.Wait(500)
                      TimeLeft = Config.TimeToMat
                      repeat                                	
                      TriggerEvent("mt:missiontext", 'Tu comida se está cocinando, por favor espera. Tiempo restante: ~r~' .. TimeLeft .. ' ~w~segundos', 1000)
                      TimeLeft = TimeLeft - 1
                      Citizen.Wait(1000)
                      until(TimeLeft == 0)	  
                      servped()   
                      FreezeEntityPosition(serv, false)
                      TaskGoStraightToCoord(serv, 1588.74, 6456.7, 25.6, 1.0, 100000, 0.0, 2.0)      
                      Citizen.Wait(3500)   
                      RequestAnimDict("mp_common")
                      while not HasAnimDictLoaded("mp_common") do
                          Citizen.Wait(100)
                      end
                      TaskPlayAnim(serv, "mp_common", "givetake1_a", 3.5, -8, -1, 2, 0, 0, 0, 0, 0) 
                      TriggerServerEvent('esx_didrik_matvagn:buy', item, price)
                      TriggerServerEvent('esx:useItem', item)
                      sendNotification('Tu menu esta listo..', 'error', 5500)
                      Wait(4500) --- EStaba en 9000
                      blockinput = false
                      DestroyCam(createdCamera, 0)
                      RenderScriptCams(0, 0, 0, 0, 1)
                      createdCamera = 0      
                      deleteserv()	
				    end
			    end, function(data, menu)
				menu.close()

				end)
			end
		end
	end
  end)
  
--- Mat meny
  
  Citizen.CreateThread(function()
  while true do
	Citizen.Wait(1)
  
		if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 1588.3, 6455.12, 25.20, true) <= 1000 ) then
			DrawMarker(27, 1588.3, 6455.12, 25.00, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 204, 204, 204, 200, 0, 0, 0, 0)
		end
  
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 1588.3, 6455.12, 25.40, true) <= 6.5 then
			Draw3DText(1588.3, 6455.12, 25.50, '[~g~E~w~] para abrir ~r~menu~w~')
		end
	end
  end)


  Citizen.CreateThread(function()
    local count
    while true do
        Citizen.Wait(0)
        if blockinput then
            count = 1
            DisableAllControlActions(1)
            DisableAllControlActions(2)
            DisableAllControlActions(3)
            DisableAllControlActions(4)
            DisableAllControlActions(5)
            DisableAllControlActions(6)
            DisableAllControlActions(7)
            DisableAllControlActions(8)
            DisableAllControlActions(9)
            DisableAllControlActions(10)
            DisableAllControlActions(11)
            DisableAllControlActions(12)
            DisableAllControlActions(13)
            DisableAllControlActions(14)
            DisableAllControlActions(15)
            DisableAllControlActions(16)
            DisableAllControlActions(17)
            DisableAllControlActions(18)
            DisableAllControlActions(19)
            DisableAllControlActions(20)
            DisableAllControlActions(21)
            DisableAllControlActions(22)
            DisableAllControlActions(23)
            DisableAllControlActions(24)
            DisableAllControlActions(25)
            DisableAllControlActions(26)
            DisableAllControlActions(27)
            DisableAllControlActions(28)
            DisableAllControlActions(29)
            DisableAllControlActions(30)
            DisableAllControlActions(31)
        else
        Citizen.Wait(500)
        end
    end
end)  

--- Blip
Citizen.CreateThread(function()
    local blip = AddBlipForCoord(1590.62, 6457.86, 25.6)
  
    SetBlipSprite (blip, 106)
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.8)
    SetBlipColour (blip, 51)
    SetBlipAsShortRange(blip, true)
  
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Restaurante')
    EndTextCommandSetBlipName(blip)
  end)