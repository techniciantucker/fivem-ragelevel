local locations = {
 [1] = {name = 'The Court House', enter = {x= 233.206, y= -410.577, z= 47.121}, exit = {x= 235.851, y= -413.782, z= -119.153}},
 [2] = {name = 'The Court Room', enter = {x= 225.179, y= -419.713, z= -119.189}, exit = {x= 238.897, y= -334.212, z= -119.763}},
 [3] = {name = 'The Hallway', enter = {x= 246.305, y= -337.176, z= -119.789}, exit = {x= 248.111, y= -337.610, z= -119.789}},
 [4] = {name = 'The Cellblock', enter = {x= 1669.297, y= 2565.767, z= 44.574}, exit = {x= 1677.712, y= 2518.810, z= -121.839}},
 [5] = {name = 'Cells', enter = {x= 1851.189, y= 3683.385, z= 33.277}, exit = {x= 1849.620, y= 3683.022, z= -119.761}},
 [6] = {name = 'Cells', enter = {x= -442.544, y= 6012.520, z= 30.726}, exit = {x= -441.949, y= 6010.596, z= -119.751}},
 [8] = {name = 'La Fuente Blanca', enter = {x= 1400.550, y= 1127.208, z= 113.344}, exit = {x= 1400.550, y= 1129.208, z= 113.344}},
 [13] = {name = 'Split-Sides', enter = {x= -419.887, y= 266.354, z= 82.204}, exit = {x= 382.299, y= -1001.551, z= -100.00}},
-- [14] = {name = 'NightClubs Galaxy', enter = {x = -379.377, y = 218.405, z = 83.657}, exit = {x = -1569.448, y = -3017.468, z = -74.412}}, 
 [18] = {name = 'Vinewood PD', enter = {x= 639.470, y= 1.425, z= 81.836}, exit = {x= 2155.102, y= 2921.036, z= -62.052}},
 [24] = {name = 'The Bar', enter = {x=132.664, y=-1293.992, z=29.270-0.95}, exit = {x=132.483, y=-1287.010, z=29.273-0.95}},
 [25] = {name = 'The Bar', enter = {x=-1380.449, y=-612.023, z=29.820}, exit = {x=-1385.460, y=-606.701, z=30.320-0.95}}, --Bahama Mamas
 [26] = {name = 'The Bar', enter = {x=-1381.760, y=-632.952, z=30.820-0.95}, exit = {x=-1379.496, y=-630.881, z=30.820-0.95}},
 [28] = {name = 'The Store', enter = {x = 1736.895, y = 6417.975, z = 35.037-0.95}, exit = {x = 1741.606, y = 6419.847, z = 35.042-0.95}},
 [29] = {name = 'Yellow Jacks', enter = {x = 1997.326, y = 3039.383, z = 46.027}, exit = {x = 1994.404, y = 3046.756, z = 47.215-0.95}},
 [30] = {name = 'The Hospital Helipad', enter = {x = 308.675, y = -602.633, z = 42.292}, exit = {x = 339.189, y = -583.965, z = 73.166}},
 [31] = {name = 'The Hospital', enter = {x = 355.892, y = -596.615, z = 27.776}, exit = {x = 298.702, y = -599.310, z = 42.292}},
 [32] = {name = 'The Store', enter = {x = 1702.464, y = 4916.459, z = 41.078}, exit = {x = 1707.078, y = 4918.785, z = 41.064}},
 [33] = {name = 'The Store', enter = {x = 1963.758, y = 3749.659, z = 31.261}, exit = {x = 1962.622, y = 3749.028, z = 31.344}},
 [34] = {name = 'The Store', enter = {x = 541.985, y = 2663.701, z = 41.173}, exit = {x = 543.287, y = 2663.760, z = 41.157}},
 [35] = {name = 'The Store', enter = {x = 2670.491, y = 3286.386, z = 54.241}, exit = {x = 2675.355, y = 3288.560, z = 54.241}},
 [36] = {name = 'The Store', enter = {x = -3047.643, y = 590.208, z = 6.768}, exit = {x = -3047.322, y = 588.840, z = 6.909}},
 [37] = {name = 'The Store', enter = {x = -1829.274, y = 801.239, z = 137.411}, exit = {x = -1828.238, y = 800.133, z = 137.161}},
 [38] = {name = 'The Store', enter = {x = 2546.141, y = 385.503, z = 107.618}, exit = {x = 2550.896, y = 387.887, z = 107.623}},
 [39] = {name = 'The Store', enter = {x = 380.263, y = 357.097, z = 101.569}, exit = {x = 380.618, y = 331.042, z = 102.566}},
 [40] = {name = 'The Store', enter = {x = 1161.147, y = -313.250, z = 68.205}, exit = {x = 1160.654, y = -311.922, z = 68.277}},
 [41] = {name = 'The Store', enter = {x = 26.438, y = -1315.539, z = 28.623}, exit = {x = 31.078, y = -1340.621, z = 28.497}},
 [42] = {name = 'The Store', enter = {x = -41.862, y = -1749.234, z = 28.421}, exit = {x = -40.737, y = -1747.642, z = 28.309}},
 [43] = {name = 'The Morgue', enter = {x = 240.869, y = -1379.426, z = 32.750}, exit = {x = 275.504, y = -1361.113, z = 23.538}},
 [44] = {name = 'The Hospital Staff Door', enter = {x = 319.417, y = -559.885, z = 27.744}, exit = {x = 310.313, y = -599.176, z = 42.292}},
 [45] = {name = "Stephen's Motorworks", enter = {x = -177.250, y = -1158.532, z = 22.814}, exit = {x = 207.166, y = -999.141, z = -100.000}},
 [47] = {name = "Donovans & Associates", enter = {x = -118.675, y = -608.368, z = 35.281}, exit = {x = -141.190, y = -620.846, z = 167.999}},
 [48] = {name = "Doctor's Office", enter = {x = -1898.238, y = -572.195, z = 10.845}, exit = {x = -1902.179, y = -572.606, z = 18.097}},
 [49] = {name = "Doctor's Office", enter = {x = -1911.729, y = -575.867, z = 18.097}, exit = {x = -1910.815, y = -574.818, z = 18.097}},
 --[50] = {name = "Casino", enter = {x = 931.49945068359, y = 43.982097625732, z = 81.096649169922}, exit = {x = 906.82446289062, y = -942.3056640625, z = 44.422801971436}},
}

local vehicle_locations = {
 [1] = {name = 'The Car Showroom', enter = {x = -221.582, y = -1162.778, z = 22.023}, exit = {x = 194.402, y = -1005.909, z = -100.000}},
 [2] = {name = 'NightClubs Galaxy', enter = {x = -419.769, y = 182.609, z = 80.456}, exit = {x = -1642.041, y = -2989.630, z = -77.011}}, 
}


local isNearArea = false 
local currentArea = {}

Citizen.CreateThread(function()
 while true do 
  Citizen.Wait(2500)
  isNearArea = false 
  currentArea = {}

  for _,v in pairs(locations) do
   if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.enter.x, v.enter.y, v.enter.z, true) < 5 then
    isNearArea = true 
    currentArea = v
   elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.exit.x, v.exit.y, v.exit.z, true) < 5 then
    isNearArea = true 
    currentArea = v
   end
  end
 end 
end)

Citizen.CreateThread(function()
 while true do
  Wait(5)
  if isNearArea then 
   local v = currentArea
   -- Drawing
   DrawMarker(27, v.exit.x, v.exit.y, v.exit.z, 0, 0, 0, 0, 0, 0, 0.5,0.5,0.5, 255,255,255,80, 0, 0, 2, 0, 0, 0, 0)
   DrawMarker(27, v.enter.x, v.enter.y, v.enter.z, 0, 0, 0, 0, 0, 0, 0.5,0.5,0.5, 255,255,255,80, 0, 0, 2, 0, 0, 0, 0)
    -- Entering
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.exit.x, v.exit.y, v.exit.z+0.20, true) < 1.2) then
    drawTxt('~b~Press ~g~E~b~ To Exit '..v.name)
    if IsControlJustPressed(0, 38) then
     Teleport(v.enter.x, v.enter.y, v.enter.z)
    end
   -- Exiting
   elseif(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.enter.x, v.enter.y, v.enter.z+0.20, true) < 1.2) then
    drawTxt('~b~Press ~g~E~b~ To Enter '..v.name)
    if IsControlJustPressed(0, 38) then
     Teleport(v.exit.x, v.exit.y, v.exit.z)
    end
   end
  end

  for _,v in pairs(vehicle_locations) do
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.exit.x, v.exit.y, v.exit.z, true) < 20) and IsPedInAnyVehicle(GetPlayerPed(-1), false) then
    DrawMarker(27, v.exit.x, v.exit.y, v.exit.z, 0, 0, 0, 0, 0, 0, 1.2,1.2,0.5, 200,255,255,120, 0, 0, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.exit.x, v.exit.y, v.exit.z, true) < 1.5) then
     drawTxt('~b~Press ~g~E~b~ To Exit '..v.name)
     if IsControlJustPressed(0, 38) then
      VehicleTeleport(v.enter.x, v.enter.y, v.enter.z)
     end
    end
   end 
   -- Exit Locations 
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.enter.x, v.enter.y, v.enter.z, true) < 20) and IsPedInAnyVehicle(GetPlayerPed(-1), false) then
    DrawMarker(27, v.enter.x, v.enter.y, v.enter.z, 0, 0, 0, 0, 0, 0, 1.2,1.2,0.5, 200,255,255,120, 0, 0, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.enter.x, v.enter.y, v.enter.z, true) < 1.5) then
     drawTxt('~b~Press ~g~E~b~ To Enter '..v.name)
     if IsControlJustPressed(0, 38) then
      VehicleTeleport(v.exit.x, v.exit.y, v.exit.z)
     end
    end
   end
  end
 end
end)

function Teleport(x,y,z)
  Wait(100)
  RequestCollisionAtCoord(x,y,z)
  while not HasCollisionLoadedAroundEntity(GetPlayerPed(-1)) do 
    RequestCollisionAtCoord(x,y,z)
    Citizen.Wait(0)
  end
  SetEntityCoords(GetPlayerPed(-1), x,y,z)
end

function VehicleTeleport(x,y,z)
  Wait(100)
  RequestCollisionAtCoord(x,y,z)
  while not HasCollisionLoadedAroundEntity(GetPlayerPed(-1)) do 
    RequestCollisionAtCoord(x,y,z)
    Citizen.Wait(0)
  end
  local targetPed = GetPlayerPed(-1)
  if(IsPedInAnyVehicle(targetPed))then
    targetPed = GetVehiclePedIsUsing(targetPed)
  end
  SetEntityCoords(targetPed, x,y,z)
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


