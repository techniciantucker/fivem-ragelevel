local currentDrivers = 0
local myRoute = {}
local ped_models = {"A_M_Y_GenStreet_01", "A_M_M_Business_01", "A_M_Y_Hiker_01"}
local busRoutes = {
  [1] = {
   {name = "LSIA Terminal 2", x = -1048.877930, y = -2540.111572, z = 12.505210},
   {name = "Maze Bank Arena", x = -307.695801, y = -1844.940430, z = 23.845625},
   {name = "Strawberry Avenue", x = -43.776791, y = -1648.477661, z = 28.033178},
   {name = "Carson Avenue", x = 50.928295, y = -1536.593506, z = 28.018265},
   {name = "Adam's Apple Blv", x = 98.416206, y = -1055.010620, z = 28.118307},
   {name = "San Andreas Avenue", x = 115.008423, y = -784.036377, z = 30.126572},
   {name = "San Vitus Blvd", x = -256.629272, y = -330.119690, z = 28.699272},
   {name = "Boulevard Del Perro", x = -490.618530, y = 20.407391, z = 43.791027},
   {name = "Strangeways Drive", x = -693.450562, y = -5.167409, z = 37.019169},
   {name = "Mad Wayne Thunder Dr", x = -931.669128, y = -126.633087, z = 36.415554},
   {name = "Marathon Avenue", x = -1047.878540, y = -389.459473, z = 36.419994},
   {name = "Rockford Hills", x = -679.639771, y = -376.881226, z = 33.043865},
   {name = "Ginger Street", x = -652.388367, y = -607.065369, z = 32.059444},
   {name = "Vespucci Blvd", x = -558.416321, y = -846.186951, z = 26.312037},
   {name = "La Puerta Fwy", x = -250.537796, y = -883.167053, z = 29.415934},
   {name = "Innocence Blvd", x = -302.779999, y = -1476.822632, z = 29.369450},
   {name = "Bus Station", x = 462.654, y = -634.446, z = 28.493},
  },

  [2] = {
   {name = "Textile City", x = 307.135803, y = -766.019043, z = 28.227528},
   {name = "Strawberry Metro Station", x = 261.568085, y = -1217.424927, z = 28.424841},
   {name = "Davis Sherrif's Office", x = 364.583069, y = -1568.484009, z = 28.203512},
   {name = "Billingsgate Motel", x = 574.867859, y = -1734.191040, z = 28.182583},
   {name = "Little Bighorn Ave", x = 774.118408, y = -1752.040039, z = 28.409100},
   {name = "Popular Street", x = 879.431213, y = -1766.265015, z = 28.894323},
   {name = "Amarillo Vista", x = 1303.761475, y = -1648.289551, z = 50.393467},
   {name = "El Burro Heights Gas Station", x = 1191.970215, y = -1421.047852, z = 34.044270},
   {name = "Olympic Fwy", x = 806.741638, y = -1353.140259, z = 25.286720},
   {name = "Popular Street", x = 785.882019, y = -775.321411, z = 25.329002},
   {name = "Occupation Avenue", x = 428.806915, y = -359.720764, z = 46.116802},
   {name = "Power Street", x = 160.195572, y = -372.077209, z = 41.672024},
   {name = "Union Depository", x = 41.333294, y = -706.174377, z = 43.126556},
   {name = "Downtown Parking Garage", x = -335.592316, y = -683.291138, z = 31.849171},
   {name = "Alta Street", x = -86.832825, y = -652.732300, z = 35.105892},
   {name = "Low Power Street", x = 70.441124, y = -627.019653, z = 30.579842},
   {name = "Vespucci Blvd", x = 62.284081, y = -996.830688, z = 28.256859},
   {name = "Bus Station", x = 462.654, y = -634.446, z = 28.493},
  },

  [3] = {
   {name = "Vespucci Beach", x = -1456.489258, y = -967.370056, z = 6.261691},
   {name = "Vespucci Beach", x = -1352.111206, y = -1113.946533, z = 3.407488},
   {name = "Vespucci Beach", x = -1321.315552, y = -1292.585571, z = 3.940287},
   {name = "Vespucci Beach", x = -1286.420532, y = -1396.484009, z = 3.523031},
   {name = "Aguja Street", x = -1167.743652, y = -1472.403931, z = 3.280961},
   {name = "Melanoma Street", x = -1087.516235, y = -1586.963745, z = 3.321031},
   {name = "La Puerta Apartments", x = -944.724731, y = -1527.015015, z = 4.056648},
   {name = "La Puerta Apartments", x = -993.357361, y = -1441.655884, z = 4.072592},
   {name = "Vista Del Mar Apartments", x = -1037.417603, y = -1532.505371, z = 4.053168},
   {name = "The Wiseroy", x = -830.088196, y = -1218.166382, z = 5.931358},
   {name = "La Puerta Marina", x = -800.468201, y = -1332.293945, z = 3.997653},
   {name = "Higgins Helitours", x = -716.186951, y = -1405.214233, z = 3.997248},
   {name = "Little Seoul Gas Station", x = -524.743774, y = -1198.608643, z = 17.541819},
   {name = "Little Seoul Tram Station", x = -521.956665, y = -1302.051392, z = 27.012049},
   {name = "La Puerta Gas Station", x = -322.942200, y = -1443.668823, z = 29.714195},
   {name = "Carson Avenue", x = -21.008894, y = -1378.070068, z = 28.275986},
   {name = "Olympic Fwy Underpass", x = 77.380333, y = -1214.512207, z = 28.123667},
   {name = "Adam's Apple Blvd", x = 95.186195, y = -1061.527832, z = 28.265455},
   {name = "San Andreas Avenue", x = 115.118439, y = -783.993042, z = 30.291632},
   {name = "Little Seoul Parking Complex", x = -466.381317, y = -649.065796, z = 31.306229},
   {name = "Ginger Street", x = -770.386658, y = -647.734436, z = 28.840813},
   {name = "Weazel Plaza", x = -931.685364, y = -465.941254, z = 36.085449},
   {name = "Lifeinvader HQ", x = -1077.113647, y = -264.329651, z = 36.719830},
   {name = "Morningwood Blvd", x = -1280.407349, y = -321.272278, z = 35.672688},
   {name = "North Rockford Drive", x = -1417.084595, y = -399.028290, z = 35.194302},
   {name = "Prosperity Street", x = -1525.448242, y = -465.898956, z = 34.293213},
   {name = "Bay City Avenue", x = -1538.372559, y = -683.898926, z = 27.764669},
   {name = "Del Perro Pier", x = -1629.170898, y = -999.052368, z = 12.034500},
   {name = "Bus Station", x = 462.654, y = -634.446, z = 28.493},
  },

  [4] = {
   {name = "Pillbox Hill Medical Center", x = 290.073639, y = -588.705994, z = 42.999905},
   {name = "Alta", x = 393.089783, y = -198.228836, z = 59.249481},
   {name = "Vinewood Plaza", x = 546.343018, y = 154.992188, z = 98.938354},
   {name = "Vinewood Hills Arena", x = 707.297607, y = 661.271912, z = 128.741226},
   {name = "North Conker Avenue", x = 340.571075, y = 473.769196, z = 149.536407},
   {name = "Sisyphus Theater", x = 233.522186, y = 1175.608643, z = 225.289536},
   {name = "Lake Vinewood", x = -75.519508, y = 893.577209, z = 235.406143},
   {name = "North Sheldon Avenue", x = -718.873962, y = 960.467590, z = 237.414627},
   {name = "Normandy Drive", x = -918.196106, y = 793.625732, z = 183.889343},
   {name = "Hillcrest Avenue", x = -917.567871, y = 697.311035, z = 151.466461},
   {name = "Hillcrest Avenue", x = -686.764465, y = 604.516663, z = 143.481186},
   {name = "Normandy Drive", x = -629.844666, y = 685.028870, z = 150.348328},
   {name = "Didion Drive", x = -510.327759, y = 569.082642, z = 118.609016},
   {name = "Hillcrest Ridge Access Road", x = -696.260254, y = 489.169250, z = 109.245049},
   {name = "Dunstable Lane", x = -837.081909, y = 292.296692, z = 86.154709},
   {name = "The Generic", x = -481.763062, y = 224.086395, z = 82.916214},
   {name = "Eclipse Lodge", x = -256.527252, y = 12.497521, z = 52.772953},
   {name = "Cancer Way", x = -296.263885, y = -271.570099, z = 31.390156},
   {name = "Daily Globe International", x = -286.271729, y = -616.369568, z = 33.201347},
   {name = "Power Street", x = 119.872200, y = -812.574402, z = 30.998062},
   {name = "Bus Station", x = 462.654, y = -634.446, z = 28.493},
  }
 }

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(5)
  --
  if DecorGetInt(PlayerPedId(), 'Job') == 22 then
   local coords = GetEntityCoords(PlayerPedId(), true)
   -- Going On Duty
   if GetDistanceBetweenCoords(coords, 435.354, -645.826, 28.737, false) < 50.0 then
    DrawMarker(23, 435.354, -645.826, 28.737-0.99, 0, 0, 0, 0, 0, 0, 2.5,2.5,0.5, 50, 250, 50, 50, 0, 0, 2, 0, 0, 0, 0)
    if GetDistanceBetweenCoords(coords, 435.354, -645.826, 28.737, false) < 3.0 then
     if currentDrivers <= 5 then
      showMessage('Press ~g~E~w~ To Start Work')
      if IsControlJustPressed(0, 38) then
       -- if math.random(1,100) <= 50 then
        coachDriver()
       -- else
       --  busDriver()
       -- end
      end
     else
      showMessage('~r~No Work Available')
     end
    end
   else
   Citizen.Wait(5000)
   end
  else
   Citizen.Wait(5000)
  end
 end
end)


-- Bus Driver
function busDriver()
 myRoute.route = busRoutes[math.random(1,4)]
 myRoute.fares = 0
 myRoute.peds = {}

 SpawnJobVehicle('bus', 464.151, -613.634, 28.500, 172.00)

 generateBlipsFromRoute(myRoute.route)
 SetNewWaypoint(myRoute.route[1].x, myRoute.route[1].y)

 while true do
  Citizen.Wait(5)

  local ped = PlayerPedId()
  local pedCoords = GetEntityCoords(ped)
  local vehicle = GetVehiclePedIsIn(ped)

  for k,v in pairs(myRoute.route) do
   DrawMarker(20, v.x, v.y, v.z+2.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.50, 2.50, 2.50, 190, 190, 190, 100, false, true, 0, false, nil, nil, false)

   if GetDistanceBetweenCoords(pedCoords, v.x, v.y, v.z) < 5 then
    if GetEntitySpeed(vehicle) < 0.1 then
     showMessage('Press ~g~E~w~ To Open Doors')
     if IsControlJustPressed(0, 38) then
      pickupJob(k)
     end
    end
   end
  end
 end
end


function generateBlipsFromRoute(route)
 for k,v in next, route do
  local blip = AddBlipForCoord(v.x, v.y, 0)
  SetBlipScale(blip, 0.5)
  SetBlipSprite(blip, 480)
  SetBlipColour(blip, 7)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString("(Route) " .. v.name)
  EndTextCommandSetBlipName(blip)
  v.blip = blip
 end
end



function pickupJob(id)
 local p = table.remove(myRoute.route, id)

 if p.name == 'Bus Station' then
  if #myRoute.route == 1 then
   makePedsLeaveTheVehicle(25)
   RemoveBlip(p.blip)
   p.blip = nil
   DeleteVehicle(GetVehiclePedIsIn(GetPlayerPed(-1), false))
   showMessage('~g~Bus Route Successful, Payment Recieved')
   TriggerServerEvent('jobs:addmoney', myRoute.fares)
  end
  if #myRoute.route == 0 then
    makePedsLeaveTheVehicle(25)
    RemoveBlip(p.blip)
    p.blip = nil
    DeleteVehicle(GetVehiclePedIsIn(GetPlayerPed(-1), false))
    showMessage('~g~Bus Route Successful, Payment Recieved')
    TriggerServerEvent('jobs:addmoney', myRoute.fares)
   end
 else
  makePedsLeaveTheVehicle(math.random(1,5))
  RemoveBlip(p.blip)
  p.blip = nil

  local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
  local peds = createPedsThatEnterVehicle(math.random(1,3))

  local newpeds = 0
  if next(peds) ~= nil then
   for k,v in next, peds do
    newpeds = newpeds + 1
    table.insert(myRoute.peds, v)
   end
  end

  myRoute.fares = myRoute.fares + math.floor(newpeds*math.random(140,210))

  SetNewWaypoint(myRoute.route[1].x, myRoute.route[1].y)
 end
end

function makePedsLeaveTheVehicle(number)
 local _i = 0
 for _i = 1, number do
  if next(myRoute.peds) ~= nil then
   local ped = myRoute.peds[math.random(#myRoute.peds)]
   if DoesEntityExist(ped) then
    TaskLeaveAnyVehicle(ped, 0, 0)
    SetTimeout(3000, function()
     RemovePedElegantly(ped)
    end)
   end
  end
 end
end

function createPedsThatEnterVehicle(number)
 local peds = {}
 local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
 local pos = GetEntityCoords(vehicle)

 local _peds = 0

 for _i = 1, GetVehicleMaxNumberOfPassengers(vehicle) do
  if _peds >= number then break end
  if not DoesEntityExist(GetPedInVehicleSeat(vehicle, _i)) then
   local ped = CreatePed(4, getRandomPedModel(), pos.x + GetEntityForwardX(vehicle) * (6 + _peds), pos.y + GetEntityForwardY(vehicle) * (6 + _peds), pos.z, 0, true, 0)
   TaskEnterVehicle(ped, vehicle, 1000, _i, 1.0, 3, 0)
   table.insert(peds, ped)
   _peds = _peds + 1
  end
 end
 return peds
end






















-- Coach Driver
function coachDriver()
 local ped = PlayerPedId()
 local coachPeds = {}
 local currentStop = 0
 -- Spawn Coach
 SpawnJobVehicle('coach', 464.151, -613.634, 28.500, 172.00)
 Wait(500)

 -- Add Clients
 local vehicle = GetVehiclePedIsIn(ped, false)
 local maxSeats = GetVehicleModelNumberOfSeats(GetEntityModel(vehicle))

 for i=1, maxSeats+1 do
  coachPeds[i] = CreatePedInsideVehicle(vehicle, 4, getRandomPedModel(), i-1, true, false)
 end

 SetJobBlip(1864.581, 2620.960, 46.503)
 currentStop = 1

 -- Doing The Job
 while true do
  Citizen.Wait(5)
  -- Stage 1
  if GetDistanceBetweenCoords(GetEntityCoords(ped, true), 1864.581, 2620.960, 46.503) < 50.0 and currentStop == 1 then
   DrawMarker(21, 1864.581, 2620.960, 46.503, 0, 0, 0, 0, 0, 0, 1.0,1.0,1.0, 255, 25, 25, 100, 1, 1, 2, 0, 0, 0, 0)
   if GetDistanceBetweenCoords(GetEntityCoords(ped, true), 1864.581, 2620.960, 46.503) < 5.0 then
    if IsVehicleStopped(vehicle) then
     TaskLeaveVehicle(coachPeds[1], vehicle, 256)
     TaskGoToCoordAnyMeans(coachPeds[1], 1846.233, 2585.848, 45.672, 1.0, 0, 0, 786603, 1.0)
     Wait(10000)
     TaskLeaveVehicle(coachPeds[2], vehicle, 256)
     TaskGoToCoordAnyMeans(coachPeds[2], 1846.233, 2585.848, 45.672, 1.0, 0, 0, 786603, 1.0)
     Wait(10000)
     if math.random(1, 100) > 92 then
      TriggerServerEvent('jobs:addmoney', math.random(70,270))
     end
     showMessage('~g~Continue To Next Stop')
     currentStop = 2
     SetJobBlip(-210.059, 6196.945, 32.318)
    end
   end
  elseif GetDistanceBetweenCoords(GetEntityCoords(ped, true), 1864.581, 2620.960, 46.503) > 75.0 and currentStop == 2 then
   DeletePed(coachPeds[1])
   DeletePed(coachPeds[2])
  end

  -- Stage 2
  if GetDistanceBetweenCoords(GetEntityCoords(ped, true), -210.059, 6196.945, 32.318) < 50.0 and currentStop == 2 then
   DrawMarker(21, -210.059, 6196.945, 32.318, 0, 0, 0, 0, 0, 0, 1.0,1.0,1.0, 255, 25, 25, 100, 1, 1, 2, 0, 0, 0, 0)
   if GetDistanceBetweenCoords(GetEntityCoords(ped, true), -210.059, 6196.945, 32.318) < 5.0 then
    if IsVehicleStopped(vehicle) then
     TaskLeaveVehicle(coachPeds[3], vehicle, 256)
     TaskGoToCoordAnyMeans(coachPeds[3], -293.723, 6198.647, 31.489, 1.0, 0, 0, 786603, 1.0)
     Wait(10000)
     TaskLeaveVehicle(coachPeds[4], vehicle, 256)
     TaskGoToCoordAnyMeans(coachPeds[4], -293.723, 6198.647, 31.489, 1.0, 0, 0, 786603, 1.0)
     if math.random(1, 100) > 92 then
      TriggerServerEvent('jobs:addmoney', math.random(70,270))
     end
     Wait(10000)
     TaskLeaveVehicle(coachPeds[5], vehicle, 256)
     TaskGoToCoordAnyMeans(coachPeds[5], -293.723, 6198.647, 31.489, 1.0, 0, 0, 786603, 1.0)
     Wait(10000)
     showMessage('~g~Continue To Next Stop')
     currentStop = 3
     SetJobBlip(-3035.341, 111.652, 12.438)
    end
   end
  elseif GetDistanceBetweenCoords(GetEntityCoords(ped, true), -210.059, 6196.945, 32.318) > 75.0 and currentStop == 3 then
   DeletePed(coachPeds[3])
   DeletePed(coachPeds[4])
   DeletePed(coachPeds[5])
  end

  -- Stage 3
  if GetDistanceBetweenCoords(GetEntityCoords(ped, true), -3035.341, 111.652, 12.438) < 50.0 and currentStop == 3 then
   DrawMarker(21, -3035.341, 111.652, 12.438, 0, 0, 0, 0, 0, 0, 1.0,1.0,1.0, 255, 25, 25, 100, 1, 1, 2, 0, 0, 0, 0)
   if GetDistanceBetweenCoords(GetEntityCoords(ped, true), -3035.341, 111.652, 12.438) < 5.0 then
    if IsVehicleStopped(vehicle) then
     TaskLeaveVehicle(coachPeds[6], vehicle, 256)
     TaskGoToCoordAnyMeans(coachPeds[6], -2963.388, 52.938, 11.609, 1.0, 0, 0, 786603, 1.0)
     Wait(10000)
     TaskLeaveVehicle(coachPeds[7], vehicle, 256)
     TaskGoToCoordAnyMeans(coachPeds[7], -2963.388, 52.938, 11.609, 1.0, 0, 0, 786603, 1.0)
     Wait(10000)
     TaskLeaveVehicle(coachPeds[8], vehicle, 256)
     TaskGoToCoordAnyMeans(coachPeds[8], -2963.388, 52.938, 11.609, 1.0, 0, 0, 786603, 1.0)
     Wait(10000)
     TaskLeaveVehicle(coachPeds[9], vehicle, 256)
     TaskGoToCoordAnyMeans(coachPeds[9], -2963.388, 52.938, 11.609, 1.0, 0, 0, 786603, 1.0)
     Wait(10000)
     showMessage('~g~Drive Back To The Depo')
     currentStop = 4
     SetJobBlip(462.654, -634.446, 28.493)
    end
   end
  elseif GetDistanceBetweenCoords(GetEntityCoords(ped, true), -3035.341, 111.652, 12.438) > 75.0 and currentStop == 4 then
   DeletePed(coachPeds[6])
   DeletePed(coachPeds[7])
   DeletePed(coachPeds[8])
   DeletePed(coachPeds[9])
  end

  -- Last Stage
  if GetDistanceBetweenCoords(GetEntityCoords(ped, true), 462.654, -634.446, 28.493) < 50.0 and currentStop == 4 then
   DrawMarker(21, 462.654, -634.446, 28.493, 0, 0, 0, 0, 0, 0, 1.0,1.0,1.0, 255, 25, 25, 100, 1, 1, 2, 0, 0, 0, 0)
   if GetDistanceBetweenCoords(GetEntityCoords(ped, true), 462.654, -634.446, 28.493) < 5.0 then
    if IsVehicleStopped(vehicle) then
     TaskLeaveVehicle(ped, vehicle, 256)
     TaskGoToCoordAnyMeans(ped, 432.962, -647.753, 28.733, 1.0, 0, 0, 786603, 1.0)
     RemoveJobBlip()
     Wait(25000)
     showMessage('~g~Coach Run Successful, Payment Recieved')
     DeleteVehicle(GetVehiclePedIsIn(ped, true))
     TriggerServerEvent('jobs:addmoney', math.random(13000,14000))
     break
    end
   end
  end
 end
end

RegisterNetEvent('bus:updateDrivers')
AddEventHandler('bus:updateDrivers', function(drivers)
 currentDrivers = drivers
end)
