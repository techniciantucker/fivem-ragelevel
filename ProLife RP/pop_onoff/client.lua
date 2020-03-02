--=================--
--==  Variables  ==--
--=================--

local puntos = {
    {x = -380.0, y = 6110.4, z = 31.48},
    {x = 1858.8, y = 3687.36, z = 34.28},
    {x = -449.24, y = 6011.41, z = 31.42},
    {x = -419.44, y = 6170.58, z = 31.48}, 
    {x = 100.19, y = 6430.89, z = 37.85}
}

local trabajos = {
    "police",
    "polioff",
    "police1",
    "poli1off",
    "mechanic",
    "mecaoff",
    "securitas",
    "secuoff",
    "ambulance",
    "emsoff"
}

local active = false
local crash = true
local crashed = true
local blips = false
local PlayerData = {}

--===========--
--==  ESX  ==--
--===========--

ESX = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getShtoniaredObjtoniect', function(obj) ESX = obj end)
    PlayerData = ESX.GetPlayerData()
    Citizen.Wait(0)
  end
end)

--======================--
--==  HILO PRINCIPAL  ==--
--======================--

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(0)
        
        for i=1, #puntos, 1 do 
            local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
            
            if GetDistanceBetweenCoords(puntos[i].x, puntos[i].y, puntos[i].z, x,y,z) < 100.0 then
                DrawMarker(1, puntos[i].x, puntos[i].y, puntos[i].z - 1, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,252,255,0, 200, 0, 0, 0, 0)
            end 
            
            if GetDistanceBetweenCoords(puntos[i].x, puntos[i].y, puntos[i].z, x,y,z) < 1.5 then
                drawTxt("PULSE E PARA ENTRAR/SALIR DE SERVICIO",4, 1, 0.5, 0.935, 0.85,255,255,255,255)
                if IsControlJustPressed(1,38) then
                    cambiarTrabajo()
                end
            end
        end               
    end
end)

--====================--
--==    Funciones   ==--
--====================--

function cambiarTrabajo()
    TriggerServerEvent('unk:setJob', GetPlayerServerId(PlayerPedId()))
end 

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(centre)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x , y)
end

