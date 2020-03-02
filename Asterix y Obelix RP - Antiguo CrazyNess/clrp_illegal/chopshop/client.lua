local neededVehicles = {}
local currentPolice = 0
local chop_locations = {
 {x = 144.939, y = -3081.098, z = 5.896},
}

local list_locations = {
 {x = 109.301, y = -2016.146, z = 18.406},
}


Citizen.CreateThread(function()
 while true do
  Wait(5)
  if currentPolice >= 0 then
   for _,v in pairs(chop_locations) do
    if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x,v.y,v.z, true) < 20) and IsPedInAnyVehicle(GetPlayerPed(-1), false) then
     DrawMarker(27, v.x,v.y,v.z-0.95, 0, 0, 0, 0, 0, 0, 2.0,2.0,0.5, 0, 82, 165, 240, 0, 0, 2, 0, 0, 0, 0)
     if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x,v.y,v.z, true) < 2.2) then
      drawTxt('~b~Press ~g~E~b~ To Chop Vehicle')
      if IsControlJustPressed(0, 38) then
       local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
       for id,v in pairs(neededVehicles) do
        if GetEntityModel(vehicle) == v.model then
         if not exports['clrp_garage']:HasKey(GetVehicleNumberPlateText(vehicle)) then
          if not v.chopped then
           TriggerServerEvent('chopshop:scrap', id, GetVehicleNumberPlateText(vehicle))
           SetEntityAsMissionEntity(vehicle, true, true)
           Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle))
           DeleteVehicle(vehicle)
           ExecuteCommand('dv')
            if ProgressBar('Chopping Vehicle', 55) then
            giveParts()
           end
          end
         else
          TriggerEvent('chatMessage', '^1You Cannot Chop Your Own Vehicle')
         end
        end
       end
      end
     end
    end
   end

   for _,v in pairs(list_locations) do 
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x,v.y,v.z, true) < 20) and not IsPedInAnyVehicle(GetPlayerPed(-1), false) then 
     DrawMarker(27, v.x,v.y,v.z-0.98, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 0, 82, 165, 240, 0, 0, 2, 0, 0, 0, 0)
     if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x,v.y,v.z, true) < 1.2) then 
      drawTxt('~b~Press ~g~E~b~ To Get Chop List')
      if IsControlJustPressed(0, 38) then 
       TriggerServerEvent('chopshop:getVehicleList')
      end
     end
    end
   end
  end
 end
end)

RegisterNetEvent('chopshop:vehicleList')
AddEventHandler('chopshop:vehicleList', function(list)
 neededVehicles = list 
end)

function giveParts()
 if currentPolice > 1 then
  TriggerEvent("inventory:addQty", 53, 1)
 end

 if currentPolice >= 0 then
  TriggerEvent("inventory:addQty", 55, math.floor(1,2))
  TriggerEvent("inventory:addQty", 56, math.floor(1,2))
 end

 for i=1, 5 do
  if i == 1 then
   if math.random(1,3) > 2 then
    TriggerEvent("inventory:addQty", 52, 1)
   end
  elseif i == 3 then
   if math.random(1,4) > 2 then
    TriggerEvent("inventory:addQty", 54, math.floor(1,2))
   end
  end
 end
end

RegisterNetEvent('hud:updatepresence')
AddEventHandler('hud:updatepresence', function(copss)
 currentPolice = copss
end)

