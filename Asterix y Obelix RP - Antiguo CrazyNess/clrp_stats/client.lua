local statistics = {}

-- Arms
Citizen.CreateThread(function()
 while true do
  Citizen.Wait(0)
  if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1197.334, -1572.727, 4.6115, true) < 50) then
   DrawMarker(27,  -1197.334, -1572.727, 4.6115-0.95, 0, 0, 0, 0, 0, 0, 0.8,0.8,1.0, 100,20,255, 200, 0, 0, 2, 0, 0, 0, 0)
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),  -1197.334, -1572.727, 4.6115, true) < 1.0) then
    drawTxt('~b~Pulse ~g~E~b~ Hacer ejercicio')
    if IsControlJustPressed(0, 38) then
      TaskStartScenarioInPlace(GetPlayerPed(-1), "world_human_muscle_free_weights", 0, true)
      Citizen.Wait(60000)
      TriggerServerEvent('stats:add', 'Strength', 1)
      exports.pNotify:SendNotification({text = "+1 Fuerza"})
      ClearPedTasksImmediately(GetPlayerPed(-1))
      exports.pNotify:SendNotification({text = "Estás demasiado cansado para continuar"})
      Wait(300000)
    end
   end
  end 
 end
end)

-- Strength 2
Citizen.CreateThread(function()
 while true do
  Citizen.Wait(0)
  if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1199.785, -1571.337, 4.6115, true) < 50) then
   DrawMarker(27, -1199.785, -1571.337, 4.6115-0.95, 0, 0, 0, 0, 0, 0, 0.8,0.8,1.0, 100,20,255, 200, 0, 0, 2, 0, 0, 0, 0)
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1199.785, -1571.337, 4.6115, true) < 0.5) then
    drawTxt('~b~Pulse ~g~E~b~ Hacer ejercicio')
    if IsControlJustPressed(0, 38) then
      TaskStartScenarioInPlace(GetPlayerPed(-1), "prop_human_muscle_chin_ups", 0, true)
      Citizen.Wait(60000)
      if math.random(1, 500) > 450 then 
        SetPedToRagdoll(GetPlayerPed(-1), 2500, 2500, 0, 0, 0, 0)
        break
      end
      TriggerServerEvent('stats:add', 'Strength', 1)
      exports.pNotify:SendNotification({text = "+1 Fuerza"})
      ClearPedTasksImmediately(GetPlayerPed(-1))
      exports.pNotify:SendNotification({text = "Estás demasiado cansado para continuar"})
      Wait(300000)
    end
   end
  end 
 end
end)

-- Strength 2
Citizen.CreateThread(function()
 while true do
  Citizen.Wait(0)
  if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1205.056, -1564.090, 4.6115, true) < 50) then
   DrawMarker(27, -1205.056, -1564.090, 4.6115-0.95, 0, 0, 0, 0, 0, 0, 0.8,0.8,1.0, 100,20,255, 200, 0, 0, 2, 0, 0, 0, 0)
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1205.056, -1564.090, 4.6115, true) < 0.5) then
    drawTxt('~b~Pulse ~g~E~b~ Hacer ejercicio')
    if IsControlJustPressed(0, 38) then
      TaskStartScenarioInPlace(GetPlayerPed(-1), "prop_human_muscle_chin_ups", 0, true)
      Citizen.Wait(60000)
      if math.random(1, 500) > 450 then 
        SetPedToRagdoll(GetPlayerPed(-1), 2500, 2500, 0, 0, 0, 0)
        break
      end
      TriggerServerEvent('stats:add', 'Strength', 1)
      exports.pNotify:SendNotification({text = "+1 Fuerza"})
      ClearPedTasksImmediately(GetPlayerPed(-1))
      exports.pNotify:SendNotification({text = "Estás demasiado cansado para continuar"})
      Wait(300000)
    end
   end
  end 
 end
end)

-- Jogging
Citizen.CreateThread(function()
 while true do
  Citizen.Wait(0)
  if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1197.455, -1566.198, 4.620, true) < 50) then
   DrawMarker(27, -1197.455, -1566.198, 4.620-0.95, 0, 0, 0, 0, 0, 0, 0.8,0.8,1.0, 100,20,255, 200, 0, 0, 2, 0, 0, 0, 0)
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1197.455, -1566.198, 4.620, true) < 1.0) then
    drawTxt('~b~Pulse ~g~E~b~ Hacer ejercicio')
    if IsControlJustPressed(0, 38) then
      TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_JOG_STANDING", 0, true)
      Citizen.Wait(60000)
      TriggerServerEvent('stats:add', 'Stamina', 1)
      exports.pNotify:SendNotification({text = "+1 Stamina"})
      ClearPedTasksImmediately(GetPlayerPed(-1))
      exports.pNotify:SendNotification({text = "Estás demasiado cansado para continuar"})
      Wait(300000)
    end
   end
  end 
 end
end)

-- Arms
Citizen.CreateThread(function()
 while true do
  Citizen.Wait(0)
  if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1205.022, -1559.370, 4.6115, true) < 50) then
   DrawMarker(27, -1205.022, -1559.370, 4.6115-0.95, 0, 0, 0, 0, 0, 0, 0.8,0.8,1.0, 100,20,255, 200, 0, 0, 2, 0, 0, 0, 0)
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1205.022, -1559.370, 4.6115, true) < 1.0) then
    drawTxt('~b~Pulse ~g~E~b~ Hacer ejercicio')
    if IsControlJustPressed(0, 38) then
      TaskStartScenarioInPlace(GetPlayerPed(-1), "world_human_sit_ups", 0, true)
      Citizen.Wait(60000)
      TriggerServerEvent('stats:add', 'Strength', 1)
      exports.pNotify:SendNotification({text = "+1 Fuerza"})
      if math.random(1, 1000) > 500 then 
        TriggerServerEvent('stats:add', 'Stealth', 1)
      end
      ClearPedTasksImmediately(GetPlayerPed(-1))
      exports.pNotify:SendNotification({text = "Estás demasiado cansado para continuar"})
      Wait(300000)
    end
   end
  end 
 end
end)


-- Jogging
Citizen.CreateThread(function()
 while true do
  Citizen.Wait(0)
  if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1203.3242, -1570.6184, 4.6115, true) < 50) then
   DrawMarker(27, -1203.3242, -1570.6184, 4.6115-0.95, 0, 0, 0, 0, 0, 0, 0.8,0.8,1.0, 100,20,255, 200, 0, 0, 2, 0, 0, 0, 0)
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),-1203.3242, -1570.6184, 4.6115, true) < 1.0) then
    drawTxt('~b~Pulse ~g~E~b~ Hacer ejercicio')
    if IsControlJustPressed(0, 38) then
      TaskStartScenarioInPlace(GetPlayerPed(-1), "world_human_push_ups", 0, true)
      Citizen.Wait(60000)
      TriggerServerEvent('stats:add', 'Strength', 1)
      exports.pNotify:SendNotification({text = "+1 Fuerza"})
      if math.random(1, 1000) > 500 then 
        TriggerServerEvent('stats:add', 'Stealth', 1)
      end
      ClearPedTasksImmediately(GetPlayerPed(-1))
      exports.pNotify:SendNotification({text = "Estás demasiado cansado para continuar"})
      Wait(300000)
    end
   end
  end 
 end
end)

---------------------------------------------------- PRISON
-- Arms
Citizen.CreateThread(function()
 while true do
  Citizen.Wait(0)
  if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 1639.214, 2527.591, 45.565, true) < 50) then
   DrawMarker(27, 1639.214, 2527.591, 45.565-0.95, 0, 0, 0, 0, 0, 0, 0.8,0.8,1.0, 100,20,255, 200, 0, 0, 2, 0, 0, 0, 0)
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 1639.214, 2527.591, 45.565, true) < 1.0) then
    drawTxt('~b~Pulse ~g~E~b~ Hacer ejercicio')
    if IsControlJustPressed(0, 38) then
      TaskStartScenarioInPlace(GetPlayerPed(-1), "world_human_muscle_free_weights", 0, true)
      Citizen.Wait(60000)
      TriggerServerEvent('stats:add', 'Strength', 1)
      exports.pNotify:SendNotification({text = "+1 Fuerza"})
      if math.random(1, 1000) > 500 then 
        TriggerServerEvent('stats:add', 'Stealth', 1)
      end
      ClearPedTasksImmediately(GetPlayerPed(-1))
      exports.pNotify:SendNotification({text = "Estás demasiado cansado para continuar"})
      Wait(300000)
    end
   end
  end 
 end
end)

-- Strength 2
Citizen.CreateThread(function()
 while true do
  Citizen.Wait(0)
  if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 1643.222, 2527.781, 45.565, true) < 50) then
   DrawMarker(27, 1643.222, 2527.781, 45.565-0.95, 0, 0, 0, 0, 0, 0, 0.8,0.8,1.0, 100,20,255, 200, 0, 0, 2, 0, 0, 0, 0)
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 1643.222, 2527.781, 45.565, true) < 0.5) then
    drawTxt('~b~Pulse ~g~E~b~ Hacer ejercicio')
    if IsControlJustPressed(0, 38) then
      TaskStartScenarioInPlace(GetPlayerPed(-1), "prop_human_muscle_chin_ups", 0, true)
      Citizen.Wait(60000)
      TriggerServerEvent('stats:add', 'Strength', 1)
      exports.pNotify:SendNotification({text = "+1 Fuerza"})
      ClearPedTasksImmediately(GetPlayerPed(-1))
      exports.pNotify:SendNotification({text = "Estás demasiado cansado para continuar"})
      Wait(300000)
    end
   end
  end 
 end
end)

RegisterNetEvent('stats:character')
AddEventHandler('stats:character', function(data)
 for _,v in pairs(data) do
  if v.name == 'Stamina' then 
   StatSetInt(GetHashKey("MP0_STAMINA"), v.value, true)
  elseif v.name == 'Strength' then
   StatSetInt(GetHashKey("MP0_STRENGTH"), v.value, true)
  --elseif v.name == '' then 
  end
 end
end)

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