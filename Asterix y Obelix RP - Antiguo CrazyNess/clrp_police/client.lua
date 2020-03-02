local dutyLocation = {{x = 459.126, y = -992.424, z = 30.690}, {x = 1852.322, y = 3691.616, z = 34.267}, {x = -450.341, y = 6011.161, z = 31.716}}
local policeWeapons = {{name = "Combat Pistol", weapon = "WEAPON_COMBATPISTOL", attachment = 'COMPONENT_AT_PI_FLSH'}, {name = "Pump Shotgun", weapon = "WEAPON_PUMPSHOTGUN", attachment = 'COMPONENT_AT_AR_FLSH'}, {name = "SMG", weapon = "WEAPON_SMG", attachment = 'COMPONENT_AT_AR_FLSH'}, {name = "Carbine", weapon = "WEAPON_CARBINERIFLE", attachment = 'COMPONENT_AT_AR_FLSH'}}
local onDutyLocations = {
 {x = -466.257, y = 6021.872, z = 31.341, menu = 'policeGarage', title = 'Acceso al garaje de la policía'},
 {x = 1869.977, y = 3695.366, z = 33.557, menu = 'policeGarage', title = 'Acceso al garaje de la policía'},
 {x = -1122.623, y = -847.764, z = 13.438, menu = 'policeGarage', title = 'Acceso al garaje de la policía'},
 {x = 539.363, y = -42.184, z = 70.808, menu = 'policeGarage', title = 'Acceso al garaje de la policía'},
 {x = 854.804, y = -1280.100, z = 26.500, menu = 'policeGarage', title = 'Acceso al garaje de la policía'},
 {x = 387.510, y = -1621.073, z = 29.292, menu = 'policeGarage', title = 'Acceso al garaje de la policía'},
 {x = -630.283, y = -74.188, z = 40.482, menu = 'policeGarage', title = 'Acceso al garaje de la policía'},
 {x = 442.772, y = -1019.438, z = 28.654, menu = 'policeGarage', title = 'Acceso al garaje de la policía'},
 {x = -893.363, y = -2376.915, z = 13.944, menu = 'policeGarage', title = 'Acceso al garaje de la policía'},
 {x = -448.132, y = 6008.409, z = 31.719, menu = 'policeArmory', title = 'Accede a la Armería de la Policía'},
 {x = 452.329, y = -980.018, z = 30.689, menu = 'police_armoury', title = 'Accede a la Armería de la Policía'}, 
 {x = 1848.832, y = 3689.946, z = 34.270, menu = 'policeArmory', title = 'Accede a la Armería de la Policía'},
 {x = 460.980, y = -981.156, z = 30.690, menu = 'policeArmory', title = 'Accede a la Armería de la Policía'},
 {x = -475.284, y = 5988.354, z = 31.337, menu = 'policeHeliGarage', title = 'Engendrar un helicóptero'},
 {x = 449.499, y = -981.03, z = 44.0, menu = 'policeHeliGarage', title = 'Engendrar un helicóptero'} 
}
local policeVehicles = {
 {name = "Policia", model = "duranleo", rank = 0},
 {name = "Ford ", model = "fusionleo", rank = 0},
 {name = "Ford ", model = "cvpileo", rank = 0},
 {name = "Ford ", model = "18chgrleo", rank = 0},
 {name = "Ford ", model = "tauleo", rank = 0},
 {name = "Ford ", model = "expleo", rank = 0},
 {name = "Ford ", model = "14hoeleo", rank = 0},
 {name = "Ford ", model = "18hoeleo", rank = 0},
 {name = "Ford ", model = "14chgrleo", rank = 0}, 

 {name = "Ford Taurus", model = "lssdfpis", rank = 0},
 {name = "Crown Victoria LSPD", model = "metro2", rank = 0},
 {name = "Crown Victoria Trooper", model = "state1", rank = 0},
 {name = "BMW 1200 Trooper", model = "1200RT", rank = 0},
 {name = "Moto montaña LSPD", model = "policeb", rank = 0},

 {name = "Swat", model = "riot", rank = 0},
 {name = "Swat 2", model = "riot2", rank = 0},
}

local policeHeliVehicles = {
 {name = "Helicoptero ASD", model = "polmav", rank = 0},
 {name = "Buzzard", model = "buzzard2", rank = 0},
}

garage = {

  {x = -466.257, y = 6021.872, z = 31.341},

  {x = 1869.977, y = 3695.366, z = 33.557},

  {x = 434.06, y = -1012.01, z = 28.7},

  {x = 2806.36, y = 5874.23, z = -121.42}

}

-----------------
-- Duty Points --
-----------------
Citizen.CreateThread(function()
 while true do
  local ped = PlayerPedId()
  Wait(5)
  if DecorGetBool(ped, "isOfficer") then
   for k,v in pairs(dutyLocation) do
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 50) then
     DrawMarker(21, v.x, v.y, v.z, 0, 0, 0, 0, 0, 0, 0.8,0.8,0.5, 0, 82, 165, 240, 0, 0, 2, 0, 0, 0, 0)
     if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 2.0) then
      if isInService then
       drawTxt('~b~Presiona ~g~E~b~ Para aplicar todos los extras')
       if IsControlJustPressed(0, 38) then
        TriggerEvent("police:offnotification")
        OffDuty()
        isInService = false
        PlaySound(-1, 'GO', 'HUD_MINI_GAME_SOUNDSET', 0, 0, 1)
       end
      else
       drawTxt('~b~Presiona ~g~E~b~ para entrar de servicio')
       if IsControlJustPressed(0, 38) then
        TriggerEvent("police:ondutynotification")
        OnDuty()
        isInService = true
        PlaySound(-1, 'GO', 'HUD_MINI_GAME_SOUNDSET', 0, 0, 1)
       end
      end
     end
    end
   end
   
   if DecorGetBool(ped, 'isOfficer') then 
    for k,v in pairs(garage) do
      if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 4.0) then
	   drawTxt('~b~Presiona ~g~E~b~ para salir de servicio')
         if IsControlPressed(0, 38) then
          Applyextras()
          TriggerEvent("pNotify:SendNotification", {text= "Extras Applied"})
          Wait(1000)
       end
      end
     end
    end
	
   if DecorGetBool(ped, 'isOfficer') then 
    for k,v in pairs(onDutyLocations) do 
     if(GetDistanceBetweenCoords(GetEntityCoords(ped), v.x, v.y, v.z, true) < 15) then
      DrawMarker(21, v.x, v.y, v.z, 0, 0, 0, 0, 0, 0, 0.8,0.8,0.5, 0, 82, 165, 240, 1, 1, 2, 0, 0, 0, 0)
      if(GetDistanceBetweenCoords(GetEntityCoords(ped), v.x, v.y, v.z, true) < 2.0) then
       drawTxt('~b~Pulse ~g~E~b~ Para '..v.title)
       if IsControlJustPressed(0, 38) and not IsPedInAnyVehicle(ped, false) then 
        WarMenu.OpenMenu(v.menu)
       elseif IsControlJustPressed(0, 38) then 
        DeleteVehicle(GetVehiclePedIsIn(ped, false))
       end
      end
     end
    end
    if IsControlJustPressed(0, 167) or IsDisabledControlJustReleased(0, 167) then 
     WarMenu.OpenMenu('police_toolkit') 
    end
   end
  else 
   Citizen.Wait(2500)
  end
 end
end)


RegisterNetEvent('police:offnotification')
AddEventHandler('police:offnotification', function(x,y,z)
 if DecorGetBool(GetPlayerPed(-1), "isOfficer") then
  TriggerEvent("pNotify:SendNotification", {text= "Hss salido de servicio"})
  PlaySound(-1, 'GO', 'HUD_MINI_GAME_SOUNDSET', 0, 0, 1)
end
end)

RegisterNetEvent('police:ondutynotification')
AddEventHandler('police:ondutynotification', function(x,y,z, source)
 if DecorGetBool(GetPlayerPed(-1), "isOfficer") then
  TriggerEvent("pNotify:SendNotification", {text= "Has entrado de servicio"})
  PlaySound(-1, 'GO', 'HUD_MINI_GAME_SOUNDSET', 0, 0, 1)
end
end)

------------------
-- Police Menus --
------------------
Citizen.CreateThread(function()
 WarMenu.CreateLongMenu('policeGarage', "Police")
 WarMenu.CreateLongMenu('policeArmory', "Police")
 WarMenu.CreateLongMenu('policeHeliGarage', "Police")
  WarMenu.CreateLongMenu('police_armoury', "Police")
 WarMenu.CreateLongMenu('police_props', 'Police')
 while true do
  local ped = PlayerPedId()
  Wait(5)
  if DecorGetBool(ped, "isOfficer") and DecorGetBool(ped, 'isOfficer') then
   if WarMenu.IsMenuOpened('policeArmory') then
    if WarMenu.Button('Body Armour') then 
     SetPedArmour(ped, 200)
    elseif WarMenu.Button('Basic Loadout') then
     giveBasicLoadout(ped)
    elseif WarMenu.Button('Bandage Bundle') then
     TriggerEvent("inventory:addQty", 96, 5)
     TriggerEvent("inventory:addQty", 10, 10)
    end
    for k,v in pairs(policeWeapons) do 
     if WarMenu.Button(v.name) then
      GiveWeaponToPed(ped, GetHashKey(v.weapon), 5000, false, false)
      GiveWeaponComponentToPed(ped, GetHashKey(v.weapon), GetHashKey(v.attachment))
     end 
    end
    WarMenu.Display()
   elseif WarMenu.IsMenuOpened('policeGarage') then
    for k,v in pairs(policeVehicles) do 
     if v.rank <= DecorGetInt(ped, 'Faction') then 
      if WarMenu.Button(v.name) then
       spawnVehicle(v.model)
      end
     end 
    end
    WarMenu.Display()   
   elseif WarMenu.IsMenuOpened('policeHeliGarage') then
    for k,v in pairs(policeHeliVehicles) do 
     if v.rank <= DecorGetInt(ped, 'Faction') then 
      if WarMenu.Button(v.name) then
       spawnVehicle(v.model)
      end
     end 
    end
    WarMenu.Display()
  elseif WarMenu.IsMenuOpened('police_armoury') then
   if WarMenu.Button('Service Pistola') then
    if exports['core']:GetItemQuantity(187) >= 1 then
      TriggerEvent("inventory:removeQty", 187, 1)
      TriggerServerEvent('bank:intoSharedBank', 2000, 7)	  
    else
      TriggerEvent("inventory:addQty", 187, 1)
      TriggerServerEvent('bank:outofSharedBank', 1500, 7)
    end
   end
   if WarMenu.Button('Service Glock') then
    if exports['core']:GetItemQuantity(252) >= 1 then
      TriggerEvent("inventory:removeQty", 252, 1)
      TriggerServerEvent('bank:intoSharedBank', 2000, 7)
    else
      TriggerEvent("inventory:addQty", 252, 1)
      TriggerServerEvent('bank:outofSharedBank', 2000, 7)
    end
   end
   if WarMenu.Button('CARBINE RIFLE') then
    if exports['core']:GetItemQuantity(222) >= 1 then
      TriggerEvent("inventory:removeQty", 222, 1)
      TriggerServerEvent('bank:intoSharedBank', 7000, 7)
    else
      TriggerEvent("inventory:addQty", 222, 1)
      TriggerServerEvent('bank:outofSharedBank', 7000, 7)
    end
   end
   if WarMenu.Button('COMBAT PDW') then
    if exports['core']:GetItemQuantity(196) >= 1 then
      TriggerEvent("inventory:removeQty", 196, 1)
      TriggerServerEvent('bank:intoSharedBank', 4500, 7)
    else
      TriggerEvent("inventory:addQty", 196, 1)
      TriggerServerEvent('bank:outofSharedBank', 4500, 7)
    end
   end
   if WarMenu.Button('Service Shotgun') then
    if exports['core']:GetItemQuantity(200) >= 1 then
      TriggerEvent("inventory:removeQty", 200, 1)
      TriggerServerEvent('bank:intoSharedBank', 4000, 7)
    else
      TriggerEvent("inventory:addQty", 200, 1)
      TriggerServerEvent('bank:outofSharedBank', 4000, 7)
    end
   end
   if WarMenu.Button('Porra') then
    if exports['core']:GetItemQuantity(213) >= 1 then
      TriggerEvent("inventory:removeQty", 213, 1)
      TriggerServerEvent('bank:intoSharedBank', 100, 7)
    else
      TriggerEvent("inventory:addQty", 213, 1)
      TriggerServerEvent('bank:outofSharedBank', 100, 7)
    end
   end
   if WarMenu.Button('Cuchillo') then
    if exports['core']:GetItemQuantity(212) >= 1 then
      TriggerEvent("inventory:removeQty", 212, 1)
      TriggerServerEvent('bank:intoSharedBank', 80, 7)
    else
      TriggerEvent("inventory:addQty", 212, 1)
      TriggerServerEvent('bank:outofSharedBank', 80, 7)
    end
   end
   if WarMenu.Button('Linterna') then
    if exports['core']:GetItemQuantity(197) >= 1 then
      TriggerEvent("inventory:removeQty", 197, 1)
      TriggerServerEvent('bank:intoSharedBank', 20, 7)
    else
      TriggerEvent("inventory:addQty", 197, 1)
      TriggerServerEvent('bank:outofSharedBank', 20, 7)
    end
   end
   if WarMenu.Button('Taser') then
    if exports['core']:GetItemQuantity(198) >= 1 then
      TriggerEvent("inventory:removeQty", 198, 1)
      TriggerServerEvent('bank:intoSharedBank', 600, 7)
    else
      TriggerEvent("inventory:addQty", 198, 1)
      TriggerServerEvent('bank:outofSharedBank', 600, 7)
    end
   end
   if WarMenu.Button('Flashbang') then
      TriggerEvent("inventory:addQty", 256, 1)
      TriggerServerEvent('bank:outofSharedBank', 80, 7)
   end
       WarMenu.Display()
   end
  else 
   Citizen.Wait(2500)
  end
 end
end)

Citizen.CreateThread(function()
 WarMenu.CreateLongMenu('police_toolkit', 'Police')
 local currentItemIndex4 = 1
 local selectedItemIndex4 = 1
 local currentItemIndex = 1
 local Search = 1
 local Hand = 1
 local currentItemIndex3 = 1
 local currentItemIndex2 = 1
 local Vehicle = 1
 local Confiscate = 1
 local currentItemIndex5 = 1
 local Test = 1
 local currentItemIndex7 = 1
 while true do
  Wait(5)
  if WarMenu.IsMenuOpened('police_toolkit') then
   if WarMenu.ComboBox('Esposar', {'Suave','Fuerte'}, currentItemIndex3, Hand, function(currentIndex3)
    currentItemIndex3 = currentIndex3 Hand = currentIndex3
    end) then
    local t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then 
	 if not IsPedCuffed(GetPlayerPed(t)) then 
	  RequestAnimDict('mp_arrest_paired')
	  while not HasAnimDictLoaded('mp_arrest_paired') do
	   Citizen.Wait(0)
	  end
	  TaskPlayAnim(GetPlayerPed(-1), "mp_arrest_paired", "cop_p2_back_right", 8.0, -8, -1, 48, 0, 0, 0, 0)
	  TriggerServerEvent('police:drag', GetPlayerServerId(t))
	 end
	 if Hand == 1 then TriggerServerEvent('police:handcuff', GetPlayerServerId(t)) else TriggerServerEvent('police:hardcuff', GetPlayerServerId(t)) end
	 if AnimationComplete(GetPlayerPed(-1), "mp_arrest_paired", "cop_p2_back_right", 0.89, 300) then
		ClearPedTasksImmediately(GetPlayerPed(-1))
	 end
    else 
     TriggerEvent("pNotify:SendNotification", {text = "No hay jugador cerca"}) 
    end
   elseif WarMenu.Button('Coger') then
    local t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then TriggerServerEvent('police:drag', GetPlayerServerId(t)) else TriggerEvent("pNotify:SendNotification", {text = "No hay jugador cerca"}) end
   elseif WarMenu.Button('Props Menu') then
    WarMenu.OpenMenu('police_props')
   elseif WarMenu.ComboBox('Vehiculo', {'Meter','Sacar'}, currentItemIndex2, Vehicle, function(currentIndex2)
    currentItemIndex2 = currentIndex2 Vehicle = currentIndex2
    end) then
    local t, distance = GetClosestPlayer()
    if Vehicle == 1 then if(distance ~= -1 and distance < 3) then TriggerServerEvent('police:vehiclein', GetPlayerServerId(t)) else TriggerEvent("pNotify:SendNotification", {text = "No hay jugador cerca"}) end end
    if Vehicle == 2 then if(distance ~= -1 and distance < 5) then TriggerServerEvent('police:vehicleout', GetPlayerServerId(t)) else TriggerEvent("pNotify:SendNotification", {text = "No hay jugador cerca"}) end end
   elseif WarMenu.ComboBox('Inventario', {'Cachear','Quitar'}, currentItemIndex, Search, function(currentIndex)
    currentItemIndex = currentIndex Search = currentIndex
    end) then
    local t, distance = GetClosestPlayer()
    if Search == 1 then if(distance ~= -1 and distance < 3) then TriggerServerEvent('police:targetCheckInventory', GetPlayerServerId(t)) else TriggerEvent("pNotify:SendNotification", {text = "No hay jugador cerca"}) end end
    if Search == 2 then if(distance ~= -1 and distance < 5) then TriggerServerEvent('police:targetSeizeInventory', GetPlayerServerId(t)) else TriggerEvent("pNotify:SendNotification", {text = "No hay jugador cerca"}) end end
   elseif WarMenu.ComboBox('Armas', {'Cachear','Quitar'}, currentItemIndex5, Confiscate, function(currentIndex5)
    currentItemIndex5 = currentIndex5 Confiscate = currentIndex5
    end) then
    local t, distance = GetClosestPlayer()
    if Confiscate == 1 then if(distance ~= -1 and distance < 3) then TriggerServerEvent('police:targetCheckGuns', GetPlayerServerId(t)) else TriggerEvent("pNotify:SendNotification", {text = "No hay jugador cerca"}) end end   
    if Confiscate == 2 then if(distance ~= -1 and distance < 3) then TriggerServerEvent('police:byebyeweapons', GetPlayerServerId(t)) else TriggerEvent("pNotify:SendNotification", {text = "No hay jugador cerca"}) end end
   elseif WarMenu.ComboBox('Test', {'Armas','Alcohol','TACHO'}, currentItemIndex7, Test, function(currentIndex7)
    currentItemIndex7 = currentIndex7 Test = currentIndex7
    end) then
    local t, distance = GetClosestPlayer()
    if Test == 1 then 
     if(distance ~= -1 and distance < 3) then 
       isGSRactive = DecorGetBool(GetPlayerPed(t), "GSR_Active")
       if isGSRactive then
        TriggerEvent("pNotify:SendNotification", {text = "Arma analizada <b style='color:red'>Positivo</b><br>Este arma ha sido utilizada recientemente!"}) 
       else
        TriggerEvent("pNotify:SendNotification", {text = "Arma analizada <b style='color:lime'>Negativo</b><br>Este arma no ha sido utilizada recientemente!"}) 
       end
     else 
      TriggerEvent("pNotify:SendNotification", {text = "No hay jugador cerca"}) 
     end 
    end
    if Test == 2 then 
     if(distance ~= -1 and distance < 3) then 
      local isBACActive = DecorGetBool(GetPlayerPed(t), "BAC_Active")
      if isBACActive then
       TriggerEvent("pNotify:SendNotification", {text = "Muestra analizada <b style='color:red'>Positivo</b> <br>Su concentración de alcohol en aire está fuera de los límites legales"}) 
      else
       TriggerEvent("pNotify:SendNotification", {text = "Muestra analizada <b style='color:lime'>Negativo</b> <br>Su concentración de alcohol en aire está dentro de los límites legales"}) 
      end 
     else 
      TriggerEvent("pNotify:SendNotification", {text = "No hay jugador cerca"}) 
     end 
    end
    if Test == 3 then 
     if(distance ~= -1 and distance < 5) then 
      local tachoTime = DecorGetInt(GetPlayerPed(t), "Tacho")
      if tachoTime >= 15 then 
       TriggerEvent('chatMessage', '^5Tacómetro: ^1'..tachoTime.."^5 Minutos | El sospechoso está por encima del límite legal")
      else 
       TriggerEvent('chatMessage', '^5Tacómetro: ^3'..tachoTime.."^5 Minutos | El sospechoso está dentro del límite legal")
      end
     else 
      TriggerEvent("pNotify:SendNotification", {text = "No hay jugador cerca"}) 
     end 
    end
   elseif WarMenu.Button('Clave Robert') then
    local pos = GetEntityCoords(GetPlayerPed(-1))
    TriggerServerEvent('police:triggerpanic', pos.x, pos.y, pos.z)
   elseif WarMenu.Button('Revivir') then
    local t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 5) then
     TaskStartScenarioInPlace(GetPlayerPed(-1), 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true) 
     Citizen.Wait(13000)
     ClearPedTasks(GetPlayerPed(-1))
     TriggerServerEvent('ems:revive', GetPlayerServerId(t))
     exports.pNotify:SendNotification({text = "Revivir completado"})
    else
     TriggerEvent("pNotify:SendNotification", {text = "No hay jugador cerca"})
    end
   elseif WarMenu.Button('Examinar') then
    local t, distance = GetClosestPlayer()
  if(distance ~= -1 and distance < 5) then
     TaskStartScenarioInPlace(GetPlayerPed(-1), 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
     Citizen.Wait(5000)
     ClearPedTasks(GetPlayerPed(-1))
     TriggerServerEvent('ems:damage', GetPlayerServerId(t))
    else
   exports.pNotify:SendNotification({text = "No hay jugador cerca"})
  end
   elseif WarMenu.ComboBox('Mecanico', {"Reparar", "Incautar", "Desbloquear"}, currentItemIndex4, selectedItemIndex4, function(currentIndex4, selectedIndex4)
     currentItemIndex4 = currentIndex4
     selectedItemIndex4 = selectedIndex4
    end) then
     if currentItemIndex4 == 1 then
    local coords = GetEntityCoords(GetPlayerPed(-1))
      if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
      local vehicle = nil
    if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
     vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
        else
         local coords = GetEntityCoords(GetPlayerPed(-1))
         vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
        end
        if DoesEntityExist(vehicle) then
         TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_BUM_BIN", 0, true)
         if ProgressBar('Intentando Reparar', 55) then 
          ClearPedTasks(GetPlayerPed(-1))
          SetVehicleUndriveable(vehicle,false)
          SetVehicleFixed(vehicle)
          SetVehicleEngineOn(vehicle, true, false)
         end
        end
      end
     elseif currentItemIndex4 == 2 then
      if IsPedInAnyVehicle(GetPlayerPed(-1)) then
    local veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
    SetEntityAsMissionEntity(veh,  false,  true)
      DeleteVehicle(veh)
      exports.pNotify:SendNotification({text = "Vehículo enviado al depósito"})
    else
      local coords = GetEntityCoords(GetPlayerPed(-1))
      local veh = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
    SetEntityAsMissionEntity(veh,  false,  true)
    DeleteVehicle(veh)
    exports.pNotify:SendNotification({text = "Vehículo enviado al depósito"})
    end
   elseif currentItemIndex4 == 3 then
    local coords = GetEntityCoords(GetPlayerPed(-1))
      if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
        local vehicle = nil
        if IsPedInAnyVehicle(playerPed, false) then
         vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
        else
         vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
        end
        if DoesEntityExist(vehicle) then
         TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_WELDING", 0, true)
         Citizen.CreateThread(function()
          Citizen.Wait(10000)
          SetVehicleDoorsLocked(vehicle, 1)
          SetVehicleDoorsLockedForAllPlayers(vehicle, false)
          ClearPedTasksImmediately(GetPlayerPed(-1))
          exports.pNotify:SendNotification({text = "Vehículo desbloqueado"})
         end)
        end
      end
     end
   end
   WarMenu.Display()
  end
 end
end)

---------------------
-- Police Commands --
---------------------
RegisterCommand('duty', function(source, args, rawCommand)
 if DecorGetBool(GetPlayerPed(-1), "isOfficer") then 
  OnDuty()
 elseif DecorGetBool(GetPlayerPed(-1), "isParamedic") then 
  TriggerEvent('ems:dutystatus')
 end
end)

RegisterCommand('dutyveh', function(source, args, rawCommand)
 if DecorGetBool(GetPlayerPed(-1), "isOfficer") then 
  spawnVehicle('police8')
 elseif DecorGetBool(GetPlayerPed(-1), "isParamedic") then 
  spawnVehicle('ambulance2')
 end
end)

RegisterCommand('dutyboat', function(source, args, rawCommand)
 if DecorGetBool(GetPlayerPed(-1), "isOfficer") then 
  spawnVehicle('pdboat')
 end
end)

RegisterCommand('dutyboat2', function(source, args, rawCommand)
 if DecorGetBool(GetPlayerPed(-1), "isOfficer") then 
  spawnVehicle('pdjski')
 end
end)

RegisterCommand('bcso', function(source, args, rawCommand)
 if DecorGetBool(GetPlayerPed(-1), "isOfficer") then 
  local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false) 
  SetVehicleLivery(vehicle, 2)
  SetVehicleColours(vehicle, 2, 2)
 end
end)

RegisterCommand('sasp', function(source, args, rawCommand)
 if DecorGetBool(GetPlayerPed(-1), "isOfficer") then 
  local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false) 
  SetVehicleLivery(vehicle, 1)
 end
end)

RegisterCommand('rack', function(source, args, rawCommand)
 if DecorGetBool(GetPlayerPed(-1), "isOfficer") then 
  if args[1] == '1' then 
   RemoveWeaponFromPed(PlayerPedId(), GetHashKey('WEAPON_PUMPSHOTGUN'))
  elseif args[1] == '2' then 
   RemoveWeaponFromPed(PlayerPedId(), GetHashKey('WEAPON_SMG'))
  elseif args[1] == '3' then 
   RemoveWeaponFromPed(PlayerPedId(), GetHashKey('WEAPON_CARBINERIFLE'))
  elseif args[1] == '4' then 
   RemoveWeaponFromPed(PlayerPedId(), GetHashKey('WEAPON_PETROLCAN'))
  end
 end
end)

RegisterCommand('unrack', function(source, args, rawCommand)
 if DecorGetBool(GetPlayerPed(-1), "isOfficer") then 
  if args[1] == '1' then 
   GiveWeaponToPed(GetPlayerPed(-1), GetHashKey('WEAPON_PUMPSHOTGUN'), 25000, false, true)
  elseif args[1] == '2' then 
   GiveWeaponToPed(GetPlayerPed(-1), GetHashKey('WEAPON_SMG'), 25000, false, true)
  elseif args[1] == '3' then 
   GiveWeaponToPed(GetPlayerPed(-1), GetHashKey('WEAPON_CARBINERIFLE'), 25000, false, true)
  elseif args[1] == '4' then 
   GiveWeaponToPed(GetPlayerPed(-1), GetHashKey('WEAPON_PETROLCAN'), 25000, false, true)
  end
 end
end)

RegisterCommand('vehcolour', function(source, args, rawCommand)
 if DecorGetBool(GetPlayerPed(-1), "isOfficer") or DecorGetBool(GetPlayerPed(-1), "isParamedic") then 
  local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false) 
  if tonumber(args[1]) and tonumber(args[2]) then 
   SetVehicleColours(vehicle, tonumber(args[1]), tonumber(args[2]))
  else 
   TriggerEvent('chatMessage', '^1Formato de comando: /vehcolour 2 2')
  end
 end
end)

RegisterCommand('vehextra', function(source, args, rawCommand)
 if DecorGetBool(GetPlayerPed(-1), "isOfficer") or DecorGetBool(GetPlayerPed(-1), "isParamedic") then 
  local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
  if args[1] == 'all' then 
   for i = 1, 256 do 
    if (DoesExtraExist(vehicle, i)) then 
     SetVehicleExtra(vehicle, i, tonumber(args[2]))
    end 
   end 
  elseif args[1] ~= nil then 
   if DoesExtraExist(vehicle, tonumber(args[1])) then
    SetVehicleExtra(vehicle, tonumber(args[1]), IsVehicleExtraTurnedOn(vehicle, tonumber(args[1])))
   else 
    TriggerEvent('chatMessage', '^1Extra '..args[1]..' No existe')
   end
  else 
   TriggerEvent('chatMessage', '^1Formato de comando: /vehextra 2')
   local extras = ''
   for i = 1, 256 do 
    if (DoesExtraExist(vehicle, i)) then 
     extras = i..","..extras
    end 
   end 
   TriggerEvent('chatMessage', '^1Extras disponibles: ^3'..extras)
  end
 end
end)


RegisterCommand('escort', function(source, args, rawCommand)
 if DecorGetBool(GetPlayerPed(-1), "isOfficer") or DecorGetBool(GetPlayerPed(-1), "isParamedic") or DecorGetInt(GetPlayerPed(-1), 'Job') == 8 then
  local t, distance = GetClosestPlayer()
  if(distance ~= -1 and distance < 3) then
   TriggerServerEvent('police:drag', GetPlayerServerId(t)) 
  else 
   TriggerEvent("pNotify:SendNotification", {text = "No hay jugador cerca"})   
  end
 end
end)

local listWeapons = {{weapon = "WEAPON_KNIFE", name = "Knife"},{weapon = "WEAPON_KNUCKLE", name = "Knuckle Dusters"},{weapon = "WEAPON_NIGHTSTICK", name = "Nightstick"},{weapon = "WEAPON_HAMMER", name = "Hammer"},{weapon = "WEAPON_BAT", name = "Bat"},{weapon = "WEAPON_GOLFCLUB", name = "Golf Club"},{weapon = "WEAPON_CROWBAR", name = "Crowbar"},{weapon = "WEAPON_BOTTLE", name = "Bottle"},{weapon = "WEAPON_DAGGER", name = "Dagger"},{weapon = "WEAPON_HATCHET", name = "Hatchet"},{weapon = "WEAPON_MACHETE", name = "Machete"},{weapon = "WEAPON_FLASHLIGHT", name = "Flashlight"},{weapon = "WEAPON_SWITCHBLADE", name = "Switchblade"},{weapon = "WEAPON_PISTOL", name = "Pistol"},{weapon = "WEAPON_COMBATPISTOL", name = "Combat Pistol"},{weapon = "WEAPON_APPISTOL", name = "AP Pistol"},{weapon = "WEAPON_PISTOL50", name = "Pistol .50"},{weapon = "WEAPON_SNSPISTOL", name = "SNS Pistol"},{weapon = "WEAPON_HEAVYPISTOL", name = "Heavy Pistol"},{weapon = "WEAPON_VINTAGEPISTOL", name = "Vintage Pistol"},{weapon = "WEAPON_STUNGUN", name = "Tazer"},{weapon = "WEAPON_FLAREGUN", name = "Flare Gun"},{weapon = "WEAPON_MARKSMANPISTOL", name = "Marksman Pistol"},{weapon = "WEAPON_REVOLVER", name = "Revolver"},{weapon = "WEAPON_MICROSMG", name = "Micro SMG"},{weapon = "WEAPON_SMG", name = "SMG"},{weapon = "WEAPON_ASSAULTSMG", name = "Assault SMG"},{weapon = "WEAPON_MG", name = "MG"},{weapon = "WEAPON_COMBATMG", name = "Combat MG"},{weapon = "WEAPON_COMBATPDW", name = "Combat PDW"},{weapon = "WEAPON_GUSENBERG", name = "Gusenberg"},{weapon = "WEAPON_MACHINEPISTOL", name = "Machine Pistol"},{weapon = "WEAPON_ASSAULTRIFLE", name = "Assault Rifle"},{weapon = "WEAPON_CARBINERIFLE", name = "Carbine Rifle"},{weapon = "WEAPON_ADVANCEDRIFLE", name = "Advanced Rifle"},{weapon = "WEAPON_SPECIALCARBINE", name = "Special Carbine"},{weapon = "WEAPON_BULLPUPRIFLE", name = "Bullpup Rifle"},{weapon = "WEAPON_COMPACTRIFLE", name = "Compact Rifle"},{weapon = "WEAPON_PUMPSHOTGUN", name = "Pump Shotgun"},{weapon = "WEAPON_SAWNOFFSHOTGUN", name = "Sawnoff Shotgun"},{weapon = "WEAPON_BULLPUPSHOTGUN", name = "Bullpup Shotgun"},{weapon = "WEAPON_ASSAULTSHOTGUN", name = "Assault Shotgun"},{weapon = "WEAPON_MUSKET", name = "Hunting Rifle"},{weapon = "WEAPON_HEAVYSHOTGUN", name = "Heavy Shotgun"},{weapon = "WEAPON_DBSHOTGUN", name = "DB Shotgun"},{weapon = "WEAPON_SNIPERRIFLE", name = "Sniper"},{weapon = "WEAPON_HEAVYSNIPER", name = "Heavy Sniper"},{weapon = "WEAPON_MARKSMANRIFLE", name = "Marksman Rifle"},{weapon = "WEAPON_GRENADELAUNCHER", name = "Grenade Launcher"},{weapon = "WEAPON_GRENADELAUNCHER_SMOKE", name = ""},{weapon = "WEAPON_RPG", name = "RPG"},{weapon = "WEAPON_STINGER", name = ""},{weapon = "WEAPON_MINIGUN", name = "Minigun"},{weapon = "WEAPON_FIREWORK", name = "Firework Launcher"},{weapon = "WEAPON_RAILGUN", name = "Railgun"},{weapon = "WEAPON_HOMINGLAUNCHER", name = "Homing Launcher"},{weapon = "WEAPON_GRENADE", name = "Grenade"},{weapon = "WEAPON_STICKYBOMB", name = "Sticky Bomb"},{weapon = "WEAPON_PROXMINE", name = "Proxmine"},{weapon = "WEAPON_BZGAS", name = "BZGas"},{weapon = "WEAPON_SMOKEGRENADE", name = "Smoke Grenade"},{weapon = "WEAPON_MOLOTOV", name = "Molotov"},{weapon = "WEAPON_FIREEXTINGUISHER", name = "Extinguisher"},{weapon = "WEAPON_PETROLCAN", name = "Jerry Can"},{weapon = "WEAPON_SNOWBALL", name = "Snowball"},{weapon = "WEAPON_FLARE", name = "Flare"},{weapon = "WEAPON_BALL", name = "Ball"}}

RegisterCommand('frisk', function(source, args, rawCommand)
 if DecorGetBool(GetPlayerPed(-1), "isOfficer") or DecorGetBool(GetPlayerPed(-1), "isParamedic") or DecorGetInt(GetPlayerPed(-1), 'Job') == 8 then
  local t, distance = GetClosestPlayer()
  local allWeapons = ''
  if(distance ~= -1 and distance < 3) then
   for id,v in pairs(listWeapons) do 
    if HasPedGotWeapon(GetPlayerPed(t), GetHashKey(v.weapon), false) then
     allWeapons = v.name..', '..allWeapons
    end
   end
   TriggerEvent('chatMessage', '^5Armas: '..allWeapons)
  else 
   TriggerEvent("pNotify:SendNotification", {text = "No hay jugador cerca"})   
  end
 end
end)


function getPlayerID(source)
 local identifiers = GetPlayerIdentifiers(source)
 local player = getIdentifiant(identifiers)
 return player
end

function getIdentifiant(id)
 for _, v in ipairs(id) do
  return v
 end
end




------------Spikes
---------------------------------------------------------------------------
-- Important Variables --
---------------------------------------------------------------------------
local PoliceModels = {}
local SpawnedSpikes = {}
local spikemodel = "P_ld_stinger_s"
local nearSpikes = false
local spikesSpawned = false

---------------------------------------------------------------------------
-- Checking Distance To Spikestrips --
---------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        if IsPedInAnyVehicle(LocalPed(), false) then
            local vehicle = GetVehiclePedIsIn(LocalPed(), false)
            if GetPedInVehicleSeat(vehicle, -1) == LocalPed() then
                local vehiclePos = GetEntityCoords(vehicle, false)
                local spikes = GetClosestObjectOfType(vehiclePos.x, vehiclePos.y, vehiclePos.z, 80.0, GetHashKey(spikemodel), 1, 1, 1)
                local spikePos = GetEntityCoords(spikes, false)
                local distance = Vdist(vehiclePos.x, vehiclePos.y, vehiclePos.z, spikePos.x, spikePos.y, spikePos.z)

                if spikes ~= 0 then
                    nearSpikes = true
                else
                    nearSpikes = false
                end
            else
                nearSpikes = false
            end
        else
            nearSpikes = false
        end

        Citizen.Wait(0)
    end
end)

---------------------------------------------------------------------------
-- Tire Popping --
---------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        if nearSpikes then
            local tires = {
                {bone = "wheel_lf", index = 0},
                {bone = "wheel_rf", index = 1},
                {bone = "wheel_lm", index = 2},
                {bone = "wheel_rm", index = 3},
                {bone = "wheel_lr", index = 4},
                {bone = "wheel_rr", index = 5}
            }

            for a = 1, #tires do
                local vehicle = GetVehiclePedIsIn(LocalPed(), false)
                local tirePos = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, tires[a].bone))
                local spike = GetClosestObjectOfType(tirePos.x, tirePos.y, tirePos.z, 15.0, GetHashKey(spikemodel), 1, 1, 1)
                local spikePos = GetEntityCoords(spike, false)
                local distance = Vdist(tirePos.x, tirePos.y, tirePos.z, spikePos.x, spikePos.y, spikePos.z)

                if distance < 1.8 then
                    if not IsVehicleTyreBurst(vehicle, tires[a].index, true) or IsVehicleTyreBurst(vehicle, tires[a].index, false) then
                        SetVehicleTyreBurst(vehicle, tires[a].index, false, 1000.0)
                    end
                end
            end
        end

        Citizen.Wait(0)
    end
end)

---------------------------------------------------------------------------
-- Keypresses Spikes Event --
---------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        if spikesSpawned then
            DisplayNotification("To remove the spikstrips press ~INPUT_CHARACTER_WHEEL~ + ~INPUT_PHONE~")
            if IsControlPressed(1, 19) and IsControlJustPressed(1, 27) then
                RemoveSpikes()
                spikesSpawned = false
            end
        end
        Citizen.Wait(0)
    end
end)

---------------------------------------------------------------------------
-- Spawn Spikes Event --
---------------------------------------------------------------------------
RegisterNetEvent("Spikes:SpawnSpikes")
AddEventHandler("Spikes:SpawnSpikes", function(config)
    if config.isRestricted then
        if CheckPedRestriction(LocalPed(), config.pedList) then
            CreateSpikes(config.amount)
        end
    else
        CreateSpikes(config.amount)
    end
end)

---------------------------------------------------------------------------
-- Delete Spikes Event --
---------------------------------------------------------------------------
RegisterNetEvent("Spikes:DeleteSpikes")
AddEventHandler("Spikes:DeleteSpikes", function(netid)
    Citizen.CreateThread(function()
        local spike = NetworkGetEntityFromNetworkId(netid)
        DeleteEntity(spike)
    end)
end)

---------------------------------------------------------------------------
-- Extra Functions --
---------------------------------------------------------------------------
function CreateSpikes(amount)
    local spawnCoords = GetOffsetFromEntityInWorldCoords(LocalPed(), 0.0, 2.0, 0.0)
    for a = 1, amount do
        local spike = CreateObject(GetHashKey(spikemodel), spawnCoords.x, spawnCoords.y, spawnCoords.z, 1, 1, 1)
        local netid = NetworkGetNetworkIdFromEntity(spike)
        SetNetworkIdExistsOnAllMachines(netid, true)
        SetNetworkIdCanMigrate(netid, false)
        SetEntityHeading(spike, GetEntityHeading(LocalPed()))
        PlaceObjectOnGroundProperly(spike)
        spawnCoords = GetOffsetFromEntityInWorldCoords(spike, 0.0, 4.0, 0.0)
        table.insert(SpawnedSpikes, netid)
    end
    spikesSpawned = true
end

Citizen.CreateThread(function()
    while true do
        local dev = false

        if dev then
            local plyOffset = GetOffsetFromEntityInWorldCoords(LocalPed(), 0.0, 2.0, 0.0)
            DrawMarker(0, plyOffset.x, plyOffset.y, plyOffset.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, 2.0, 2.0, 255, 0, 0, 255, 0, 0, 0, 0, 0, 0, 0)
            local spike = GetClosestObjectOfType(plyOffset.x, plyOffset.y, plyOffset.z, 80.0, GetHashKey(spikemodel), 1, 1, 1)
            Citizen.Trace("NETID: " .. ObjToNet(spike))
        end
        Citizen.Wait(0)
    end
end)

function RemoveSpikes()
    for a = 1, #SpawnedSpikes do
        TriggerServerEvent("Spikes:TriggerDeleteSpikes", SpawnedSpikes[a])
    end
    SpawnedSpikes = {}
end

function LocalPed()
    return GetPlayerPed(PlayerId())  
end

function CheckPedRestriction(ped, pedList)
    for a = 1, #pedList do
        if GetHashKey(pedList[a]) == GetEntityModel(ped) then
            return true
        end
    end
    return false
end

function DisplayNotification(string)
  SetTextComponentFormat("STRING")
  AddTextComponentString(string)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

-------------
local propslist = {}

Citizen.CreateThread(function()
 WarMenu.CreateLongMenu('police_props', 'Props')
 while true do 
  Wait(5)
  if DecorGetInt(GetPlayerPed(-1), "Job") == 1 then
   if WarMenu.IsMenuOpened('police_props') then
    if WarMenu.Button('Cone') then
     ProgressBar('Placing Barrier', 15)
     Citizen.Wait(1500)
     SpawnProps('prop_mp_cone_02')
    elseif WarMenu.Button('Police Barrier') then
     ProgressBar('Placing Barrier', 15)
     Citizen.Wait(1500)
     SpawnProps('prop_barrier_work05')
    elseif WarMenu.Button('Work Barrier') then
     ProgressBar('Placing Barrier', 15)
     Citizen.Wait(1500)
     SpawnProps('prop_barrier_work04a')
    elseif WarMenu.Button('Work Barrier (Arrow)') then
     ProgressBar('Placing Barrier', 15)
     Citizen.Wait(1500)
     SpawnProps('prop_mp_arrow_barrier_01')
    elseif WarMenu.Button('Channelizer Drum') then
     ProgressBar('Placing Barrier', 15)
     Citizen.Wait(1500)
     SpawnProps('prop_barrier_wat_03a')
    elseif WarMenu.Button('Remove Last Prop') then
     ProgressBar('Removing Barrier', 15)
     Citizen.Wait(1500)
     RemoveLastProps()
    elseif WarMenu.Button('Remove All Props') then
     ProgressBar('Removing All Barriers', 15)
     Citizen.Wait(1500)
     RemoveAllProps()
    end
   end
  end
 end
end)

function SpawnProps(model)
 if not IsPedInAnyVehicle(PlayerPedId(), false) then
  if(#propslist < 4) then
   local prophash = GetHashKey(tostring(model))
   RequestModel(prophash)
   while not HasModelLoaded(prophash) do
    Citizen.Wait(0)
   end

   local offset = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.75, 0.0)
   local _, worldZ = GetGroundZFor_3dCoord(offset.x, offset.y, offset.z)
   local propsobj = CreateObjectNoOffset(prophash, offset.x, offset.y, worldZ, true, true, true)
   local heading = GetEntityHeading(PlayerPedId())

   SetEntityHeading(propsobj, heading)
   SetEntityAsMissionEntity(propsobj)
   FreezeEntityPosition(propsobj, true)
   SetModelAsNoLongerNeeded(prophash)

   propslist[#propslist+1] = ObjToNet(propsobj)
  end
 end
end

function RemoveLastProps()
 DeleteObject(NetToObj(propslist[#propslist]))
 propslist[#propslist] = nil
end

function RemoveAllProps()
 for i, props in pairs(propslist) do
  DeleteObject(NetToObj(props))
  propslist[i] = nil
 end
end

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(5)
  for _, props in pairs(propslist) do
   local ox, oy, oz = table.unpack(GetEntityCoords(NetToObj(props), true))
   local cVeh = GetClosestVehicle(ox, oy, oz, 15.0, 0, 70)
   if(IsEntityAVehicle(cVeh)) then
    if IsEntityAtEntity(cVeh, NetToObj(props), 20.0, 20.0, 2.0, 0, 1, 0) then
     SetVehicleForwardSpeed(cVeh, 0)
    end
   end
  end 
 end
end)

--===============Vehicle Extra==================--
local DoesExtraExist = false

function Applyextras()
  local vehicle = GetVehiclePedIsUsing(GetPlayerPed(-1))
   SetVehicleExtra(vehicle, 1)
   SetVehicleExtra(vehicle, 2)
   SetVehicleExtra(vehicle, 3)
   SetVehicleExtra(vehicle, 4)
   SetVehicleExtra(vehicle, 5)
   SetVehicleExtra(vehicle, 6)
   SetVehicleExtra(vehicle, 7)
   SetVehicleExtra(vehicle, 8)
   SetVehicleExtra(vehicle, 9)
   SetVehicleExtra(vehicle, 10)
   SetVehicleExtra(vehicle, 11)
   SetVehicleExtra(vehicle, 12)
   SetVehicleExtra(vehicle, 13)
   SetVehicleExtra(vehicle, 14)
end

function VehicleInFront()
 local pos = GetEntityCoords(GetPlayerPed(-1))
 local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 4.0, 0.0)
 local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
 local a, b, c, d, result = GetRaycastResult(rayHandle) 
 return result 
end