local jailtime = 0
local jailed = false 
local prisonjob = ''
local inTransport = false 
local transportTime = 0 
local electrical = {
 [1] = {x = 1718.682, y = 2527.943, z = 44.574, repaired = false},
 [2] = {x = 1699.77, y = 2475.443, z = 44.574, repaired = false},
 [3] = {x = 1630.091, y = 2563.716, z = 44.574, repaired = false}
}
local maintenance = {
 [1] = {x = 1685.298, y = 2526.521, z = -121.831, repaired = false},
 [2] = {x = 1668.866, y = 2552.348, z = 44.574, repaired = false},
 [3] = {x = 1744.511, y = 2533.466, z = 44.574, repaired = false}
}
local gardening = {
 [1] = {x = 1771.236, y = 2565.3349, z = 44.596, repaired = false},
 [2] = {x = 1772.415, y = 2559.618, z = 44.596, repaired = false},
 [3] = {x = 1772.008, y = 2549.623, z = 44.582, repaired = false},
 [4] = {x = 1771.539, y = 2541.774, z = 44.606, repaired = false}
}

DecorRegister("inJail", 2)
DecorSetBool(GetPlayerPed(-1), "inJail", false)

function IsJailed()
 if jailed then
  return true 
 else
  return false 
 end
end

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(0)
  if jailed then
   local coords = GetEntityCoords(GetPlayerPed(-1))
   NdrawTxt(1.337, 1.095, 1.0, 1.0, 0.6, "~b~Trabajo de prision: ~w~"..prisonjob, 255, 255, 255, 255, false)
   NdrawTxt(1.337, 1.122, 1.0, 1.0, 0.6, "~b~Mes/s restante: ~w~"..jailtime, 255, 255, 255, 255, false)
   if(GetDistanceBetweenCoords(coords, 1699.904, 2515.469, -121.849, true) < 10) then
    DrawMarker(27, 1699.904, 2515.469, -121.842, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 155, 155, 100, false, true, 2, false, false, false, false)
    if(GetDistanceBetweenCoords(coords, 1699.904, 2515.469, -121.849, true) < 2) then
     drawTxt('~b~Pulse ~g~E~b~ Para acceder a trabajos de la prisión')
     if IsControlJustPressed(0, 38) then
      WarMenu.OpenMenu('prison_jobs')
     end
    end
   end
   -- Electircal Jobsa 
   if prisonjob == 'Electrical' then
    for k,v in pairs(electrical) do
     if(GetDistanceBetweenCoords(coords, v.x,v.y,v.z, true) < 10) and not v.repaired then
      DrawMarker(27, v.x,v.y,v.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 155, 155, 100, false, true, 2, false, false, false, false)
      if(GetDistanceBetweenCoords(coords, v.x,v.y,v.z, true) < 2) then
       drawTxt('~b~Pulse ~g~E~b~ Para reparar')
       if IsControlJustPressed(0, 38) then
        TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_WELDING", 0, true)
        Wait(65000)
        ClearPedTasksImmediately(GetPlayerPed(-1))
        --exports.pNotify:SendNotification({text = "Ha reparado el componente eléctrico, se le ha reducido el tiempo para un buen trabajo"})
		exports['clrp_notify']:DoLongHudText ('success', 'Ha reparado el componente eléctrico, se le ha reducido el tiempo para un buen trabajo')
        NewJailTime()
        v.repaired = true
        TriggerServerEvent('prison:jailtime', jailtime)
       end
      end
     end
    end
   end
   -- Gardening
   if prisonjob == 'Gardening' then
    for k,v in pairs(gardening) do
     if(GetDistanceBetweenCoords(coords, v.x,v.y,v.z, true) < 10) and not v.repaired then
      DrawMarker(27, v.x,v.y,v.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 155, 155, 100, false, true, 2, false, false, false, false)
      if(GetDistanceBetweenCoords(coords, v.x,v.y,v.z, true) < 2) then
       drawTxt('~b~Pulse ~g~E~b~ Para trabajar en el jardin')
       if IsControlJustPressed(0, 38) then
        TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_GARDENER_PLANT", 0, true)
        Wait(75000)
        ClearPedTasksImmediately(GetPlayerPed(-1))
        --exports.pNotify:SendNotification({text = "Has completado el trabajo, has tenido tiempo reducido por un buen trabajo"})
		exports['clrp_notify']:DoLongHudText ('success', 'Has completado el trabajo, has tenido tiempo reducido por un buen trabajo')
        NewJailTime()
        v.repaired = true
        TriggerServerEvent('prison:jailtime', jailtime)
       end
      end
     end
    end
   end
   -- maintenance Jobs
   if prisonjob == 'Maintenance' then
    for k,v in pairs(maintenance) do
     if(GetDistanceBetweenCoords(coords, v.x,v.y,v.z, true) < 10) and not v.repaired then
      DrawMarker(27, v.x,v.y,v.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 155, 155, 100, false, true, 2, false, false, false, false)
      if(GetDistanceBetweenCoords(coords, v.x,v.y,v.z, true) < 2) then
       drawTxt('~b~Pulse ~g~E~b~ Para Arreglar')
       if IsControlJustPressed(0, 38) then
        TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_BUM_BIN", 0, true)
        Wait(65000)
        ClearPedTasksImmediately(GetPlayerPed(-1))
        --exports.pNotify:SendNotification({text = "Has completado el trabajo, has tenido tiempo reducido por un buen trabajo"})
		exports['clrp_notify']:DoLongHudText ('success', 'Has completado el trabajo, has tenido tiempo reducido por un buen trabajo')
        NewJailTime()
        v.repaired = true
        TriggerServerEvent('prison:jailtime', jailtime)
       end
      end
     end
    end
   end
  end
 end
end)

function PrisonOutfit()
 if (GetEntityModel(GetPlayerPed(-1)) == -1667301416) then
  -- Female
  SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 0)
  SetPedComponentVariation(GetPlayerPed(-1), 4, 3, 15, 0)
  SetPedComponentVariation(GetPlayerPed(-1), 6, 10, 1, 0)
  SetPedComponentVariation(GetPlayerPed(-1), 8, 2, 0, 0)
  SetPedComponentVariation(GetPlayerPed(-1), 11, 117, 0, 0)
 else
  -- Male
  SetPedComponentVariation(GetPlayerPed(-1), 3, 5, 0, 0)
  SetPedComponentVariation(GetPlayerPed(-1), 4, 9, 4, 0)
  SetPedComponentVariation(GetPlayerPed(-1), 6, 61, 0, 0)
  SetPedComponentVariation(GetPlayerPed(-1), 11, 5, 0, 0)
  SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 0)
 end
end

RegisterNetEvent('prison:switchcharacter')
AddEventHandler('prison:switchcharacter', function()
 jailed = false
 jailtime = 0
 DecorSetBool(GetPlayerPed(-1), "inJail", false)
end)

function NdrawTxt(x,y ,width,height,scale, text, r,g,b,a, center)
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

Citizen.CreateThread(function()
 WarMenu.CreateMenu('prison_jobs', 'default','Prison Jobs')
 while true do
  Citizen.Wait(0)
  if WarMenu.IsMenuOpened('prison_jobs') then
   if WarMenu.Button('Electrical') then
    prisonjob = 'Electrical'
   elseif WarMenu.Button('Maintenance') then
    prisonjob = 'Maintenance'
   elseif WarMenu.Button('Gardening') then
    prisonjob = 'Gardening'
   end
   WarMenu.Display()
  end
 end
end)

RegisterNetEvent("prison:jail")
AddEventHandler("prison:jail", function(time)
 jailed = true
 jailtime = tonumber(time)
 if jailtime > 0 then 
  PrisonOutfit()
  SetEntityCoords(GetPlayerPed(-1), 1687.403, 2513.339, -120.849)
  FreezeEntityPosition(GetPlayerPed(-1), false)
  SetEnableHandcuffs(GetPlayerPed(-1), false)
  SetEntityHealth(GetPlayerPed(-1), 20000)    
  inTransport = false    
 else 
  jailed = false 
  jailtime = 0
  local pos = GetEntityCoords(PlayerPedId(), true)
  if(Vdist(pos.x, pos.y, pos.z, 1699.904, 2515.469, -121.842) < 100.0) then 
   SetEntityCoords(GetPlayerPed(-1), 1855.807, 2601.949, 45.323)
   DecorSetBool(GetPlayerPed(-1), "inJail", false)
   TriggerServerEvent('prison:jailtime', 0)
   TriggerServerEvent('skin:loadclothes')
  end
 end
end)

RegisterNetEvent("prison:sendtojail")
AddEventHandler("prison:sendtojail", function(time)
 DoScreenFadeOut(1000)
 Wait(1000)
 loadModel('s_m_m_prisguard_01') loadModel('pbus') 
 local vehicle = CreateVehicle(GetHashKey('pbus'), 423.452, -1070.628, 29.213, 84.581, true, true)
 local driver = CreatePedInsideVehicle(vehicle, 4, GetHashKey('s_m_m_prisguard_01'), -1, true, true)
 SetBlockingOfNonTemporaryEvents(driver, true)
 SetVehicleColours(vehicle, 0, 0)
 SetVehicleMod(vehicle, 16, 100)
 SetPedFleeAttributes(driver, 0, 0)
 TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, 2)
 TaskVehicleDriveToCoordLongrange(driver, vehicle, 1854.285, 2583.922, 45.672, 50.0, 319, 5.0)
 SetVehicleSiren(vehicle, true)
 Wait(2000)
 DoScreenFadeIn(1000)
 inTransport = true
 transportTime = time 
 while DoesEntityExist(vehicle) do
  Citizen.Wait(5)
  DisableControlAction(0, 75, true) -- INPUT_VEH_EXIT
  DecorSetBool(PlayerPedId(), 'Seatbelt', true)
  if GetDistanceBetweenCoords(GetEntityCoords(vehicle), 1854.285, 2583.922, 45.672, false) < 5 then 
   SetEntityAsMissionEntity(GetVehiclePedIsIn(GetPlayerPed(-1), false), true, true)
   Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(GetVehiclePedIsIn(GetPlayerPed(-1), false)))
   Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(GetVehiclePedIsIn(GetPlayerPed(-1), true)))
   DeletePed(driver)
   TriggerServerEvent('prison:arrived', time)
   DecorSetBool(PlayerPedId(), 'Seatbelt', false)
   inTransport = false 
  end
 end
end) 

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(30000)
  if inTransport then
   if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
    local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), true)
    local speed = math.floor(GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId(), false)) * 2.236936)
    if speed < 20 then 
     TriggerServerEvent('prison:arrived', transportTime)
     DeletePed(GetPedInVehicleSeat(vehicle, -1))
     Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle))
    end
   else 
    TriggerServerEvent('prison:arrived', transportTime)
    DeletePed(GetPedInVehicleSeat(vehicle, -1))
    Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle))
   end
  end
 end
end)



Citizen.CreateThread(function()
 while true do
  Citizen.Wait(60000)
  if jailed then
   if jailtime > 0 then 
    jailtime = jailtime-1
    exports.pNotify:SendNotification({text = jailtime.." Months Until Release."})
    DecorSetBool(GetPlayerPed(-1), "inJail", true)
    TriggerServerEvent('prison:jailtime', jailtime)
    local pos = GetEntityCoords(GetPlayerPed(-1))
    if(Vdist(pos.x, pos.y, pos.z, 1699.904, 2515.469, -121.842) > 200.0) then SetEntityCoords(GetPlayerPed(-1), 1687.403, 2513.339, -120.849) end
   else
    SetEntityCoords(GetPlayerPed(-1), 1855.807, 2601.949, 45.323)
    DecorSetBool(GetPlayerPed(-1), "inJail", false)
    jailed = false 
    jailtime = 0
    TriggerServerEvent('prison:jailtime', 0)
    TriggerServerEvent('skin:loadclothes')
   end
  end
 end
end)

function NewJailTime()
 if jailtime > 100 then
  jailtime = math.floor(jailtime-math.floor(jailtime/math.random(10,15)))
 elseif jailtime < 100 and jailtime > 10 then
  jailtime = math.floor(jailtime-math.floor(jailtime/math.random(5,10)))  
 else
  jailtime = math.floor(jailtime-2)
 end
end
 
function loadModel(model)
 RequestModel(GetHashKey(model))
 while not HasModelLoaded(GetHashKey(model)) do
  Wait(0)
 end
end
