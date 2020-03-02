






local hudStatus = false
local thirst = 100
local hunger = 100
local health = 100
local armor = 100
local voip = 50
local stamina = 0
local isTalking = false
local isInVehicle = false
local currentVehicle = 0
local vehicleFuel = 0

-- Hud Status
DecorRegister('hudStatus', 2)
DecorSetBool(GetPlayerPed(-1), 'hudStatus', true)

-- VOIP
DecorRegister('level', 3)
DecorSetInt(PlayerPedId(), 'level', 2)


Citizen.CreateThread(function()
 while true do
  Citizen.Wait(5)
  if hudStatus then
   -- Background
   DrawRect(0.0853, 0.9800, 0.1430, 0.025, 40, 40, 40, 255)
   -- Health
   DrawRect(0.0148 + (0.07)/2, 0.9740, 0.07, 0.008595, 150, 150, 150, 255)
   DrawRect(0.0148 + (health/1428.52142857)/2, 0.9740, health/1428.52142857, 0.008595, 75, 200, 75, 255)
   -- Armour 358.5
   DrawRect(0.0865 + (0.069)/2,  0.9740, 0.069, 0.008595, 150, 150, 150, 200)
   DrawRect(0.0865 + (armor/1449.22536232)/2, 0.9740, armor/1449.22536232, 0.008595, 45, 124, 252, 255)
    -- Thrist
   DrawRect(0.0506 + (0.034)/2, 0.9860, 0.034, 0.008595, 150, 150, 150, 200)
   DrawRect(0.0506 + (thirst/2898.50072464)/2, 0.9860, thirst/2898.50072464, 0.008595, 96, 154, 247, 255)
   -- Hunger
   DrawRect(0.0148 + (0.035)/2, 0.9860, 0.035, 0.008595, 150, 150, 150, 200)
   DrawRect(0.0148 + (hunger/2857.09285714)/2, 0.9860, hunger/2857.09285714, 0.008595, 245, 30, 80, 155)
   
   -- VOIP
   DrawRect(0.0863 + (0.035)/2, 0.9860, 0.035, 0.008595, 150, 150, 150, 200)
   DrawRect(0.0863 + (voip/2857.22536232)/2, 0.9860, voip/2857.22536232, 0.008595, 100, 100, 100, 255)

   -- Talking 
   if isTalking then
    DrawRect(0.0863 + (100/2857.22536232)/2, 0.9860, 100/2857.22536232, 0.008595, 255, 0, 255, 75)
   end

   DrawRect(0.1218 + (0.034)/2, 0.9860, 0.034, 0.008595, 150, 150, 150, 200)

   -- Fuel
   if isInVehicle then 
    DrawRect(0.1218 + (vehicleFuel/2857.22536232)/2, 0.9860, vehicleFuel/2857.22536232, 0.008595, 158,230,237,255)
   else 
    DrawRect(0.1218 + (stamina/2857.22536232)/2, 0.9860, stamina/2857.22536232, 0.008595, 168, 158, 50, 255)
   end
  else 
   Citizen.Wait(500)
  end
 end
end)


-- Hud Bars 
-- Citizen.CreateThread(function()
 -- while true do
  -- Citizen.Wait(5)
  -- if hudStatus then
   -- --Background
   -- DrawRect(0.0853, 0.9800, 0.1430, 0.025, 40, 40, 40, 255)
   -- --Health
   -- DrawRect(0.0148 + (0.07)/2, 0.9740, 0.07, 0.008595, 150, 150, 150, 255)
   -- DrawRect(0.0148 + (health/1428.52142857)/2, 0.9740, health/1428.52142857, 0.008595, 75, 200, 75, 255)
  -- -- Armour 358.5
   -- DrawRect(0.0865 + (0.069)/2,  0.9740, 0.069, 0.008595, 150, 150, 150, 200)
   -- DrawRect(0.0865 + (armor/1449.22536232)/2, 0.9740, armor/1449.22536232, 0.008595, 45, 124, 252, 255)
    -- --Thrist
   -- DrawRect(0.0506 + (0.034)/2, 0.9860, 0.034, 0.008595, 150, 150, 150, 200)
   -- DrawRect(0.8700 + (thirst/1620.09285714)/2, 0.0982, thirst/1620.09285714, 0.008595, 20, 150, 245, 155)
   -- --Hunger
   -- DrawRect(0.0148 + (0.035)/2, 0.9860, 0.035, 0.008595, 150, 150, 150, 200)
   -- DrawRect(0.8700 + (hunger/1620.09285714)/2, 0.0795, hunger/1620.09285714, 0.008595, 245, 30, 80, 155)
   
   -- --VOIP
   -- DrawRect(0.0863 + (0.035)/2, 0.9860, 0.035, 0.008595, 150, 150, 150, 200)
   -- DrawRect(0.0863 + (voip/2857.22536232)/2, 0.9860, voip/2857.22536232, 0.008595, 100, 100, 100, 255)

   -- --Talking 
   -- if isTalking then
    -- DrawRect(0.0863 + (100/2857.22536232)/2, 0.9860, 100/2857.22536232, 0.008595, 255, 0, 255, 75)
   -- end

   -- DrawRect(0.1218 + (0.034)/2, 0.9860, 0.034, 0.008595, 150, 150, 150, 200)

   -- --Fuel
   -- if isInVehicle then 
    -- DrawRect(0.1218 + (vehicleFuel/2857.22536232)/2, 0.9860, vehicleFuel/2857.22536232, 0.008595, 158,230,237,255)
   -- else 
    -- DrawRect(0.1218 + (stamina/2857.22536232)/2, 0.9860, stamina/2857.22536232, 0.008595, 168, 158, 50, 255)
   -- end
  -- else 
   -- Citizen.Wait(500)
  -- end
 -- end
-- end)

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(100)
  hudStatus = DecorGetBool(PlayerPedId(), 'hudStatus')
  if hudStatus then
   health = GetEntityHealth(PlayerPedId())/2/10
   armor = GetPedArmour(PlayerPedId())
   voip = 25*DecorGetInt(PlayerPedId(), 'level')   
   --voip = 25*DecorGetInt(PlayerPedId(), 'voice')
   isTalking = NetworkIsPlayerTalking(PlayerId())
   isInVehicle = IsPedInAnyVehicle(PlayerPedId(), false)
   currentVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
   if isInVehicle then 
    vehicleFuel = DecorGetInt(currentVehicle, "_Fuel_Level") * 0.001
    if vehicleFuel >= 97 then 
     vehicleFuel = 97
    end
   end

   if not isInVehicle then 
    _,stamina = StatGetInt(GetHashKey("MP0_STAMINA"), true)
    if stamina >= 97 then 
     stamina = 97
    end
   end
  else 
   Citizen.Wait(2500)
  end
 end
end)

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(90000)
  if hudStatus then
   if thirst > 0 then
    thirst = thirst - 1.5
   end
   if hunger > 0 then
    hunger = hunger - 1
   end
  end
 end
end) 


Citizen.CreateThread(function()
 while true do
  Citizen.Wait(30000)
  if hudStatus then 
   if hunger <= 10 then 
    SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId())-50)
   end
   if thirst <= 10 then 
    SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId())-75)
   end
  end
 end
end) 


-- RegisterNetEvent('food:eat')
-- AddEventHandler('food:eat', function()
 -- local ped = PlayerPedId()
 -- Citizen.CreateThread(function()
  -- local x,y,z = table.unpack(GetEntityCoords(ped, true))
  -- local prop = CreateObject(GetHashKey('prop_cs_burger_01'), x, y, z+0.2,  true,  true, true)
  -- AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, 18905), 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
  -- RequestAnimDict('mp_player_inteat@burger')
  -- while not HasAnimDictLoaded('mp_player_inteat@burger') do
   -- Wait(0)
  -- end
  -- TriggerEvent("InteractSound_CL:PlayOnOne", "eating", 0.5)
  -- TaskPlayAnim(ped, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 8.0, -8, -1, 49, 0, 0, 0, 0)
  -- Wait(2000)
  -- TriggerEvent("InteractSound_CL:PlayOnOne", "eating", 0.5)
  -- Wait(2500)
  -- if hunger+50 > 100 then hunger = 100 else hunger = hunger+50 end
  -- ClearPedSecondaryTask(ped)
  -- DeleteObject(prop)
  -- end)
-- end)

RegisterNetEvent('food:eat')
AddEventHandler('food:eat', function()
 local ped = PlayerPedId()
 Citizen.CreateThread(function()
  local x,y,z = table.unpack(GetEntityCoords(ped, true))
  local prop = CreateObject(GetHashKey('prop_cs_burger_01'), x, y, z+0.2,  true,  true, true)
  AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, 18905), 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
  RequestAnimDict('mp_player_inteat@burger')
  while not HasAnimDictLoaded('mp_player_inteat@burger') do
   Wait(0)
  end
  TriggerEvent("InteractSound_CL:PlayOnOne", "eating", 0.5)
  TaskPlayAnim(ped, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 8.0, -8, -1, 49, 0, 0, 0, 0)
  Wait(2000)
  TriggerEvent("InteractSound_CL:PlayOnOne", "eating", 0.5)
  Wait(2500)
  if hunger+25 > 100 then hunger = 100 else hunger = hunger+25 end
  ClearPedSecondaryTask(ped)
  DeleteObject(prop)
  end)
end)

RegisterNetEvent('food:sana')
AddEventHandler('food:sana', function()
 local ped = PlayerPedId()
 Citizen.CreateThread(function()
  local x,y,z = table.unpack(GetEntityCoords(ped, true))
  local prop = CreateObject(GetHashKey('prop_cs_burger_01'), x, y, z+0.2,  true,  true, true)
  AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, 18905), 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
  RequestAnimDict('mp_player_inteat@burger')
  while not HasAnimDictLoaded('mp_player_inteat@burger') do
   Wait(0)
  end
  TriggerEvent("InteractSound_CL:PlayOnOne", "eating", 0.5)
  TaskPlayAnim(ped, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 8.0, -8, -1, 49, 0, 0, 0, 0)
  Wait(2000)
  TriggerEvent("InteractSound_CL:PlayOnOne", "eating", 0.5)
  Wait(2500)
  if hunger+50 > 100 then hunger = 100 else hunger = hunger+50 end
  TriggerServerEvent('stats:add', 'Stamina', 2)
  exports.pNotify:SendNotification({text = "+2 Stamina"})
  ClearPedSecondaryTask(ped)
  DeleteObject(prop)
  end)
end)

RegisterNetEvent('food:hotdog')
AddEventHandler('food:hotdog', function()
 local ped = PlayerPedId()
  local x,y,z = table.unpack(GetEntityCoords(ped, true))
  local prop = CreateObject(GetHashKey('prop_cs_hotdog_01'), x, y, z,  true,  true, true)
  AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, 18905), 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
  RequestAnimDict('mp_player_inteat@burger')
  while not HasAnimDictLoaded('mp_player_inteat@burger') do
   Wait(0)
  end
  TriggerEvent("InteractSound_CL:PlayOnOne", "eating", 0.5)
  TaskPlayAnim(ped, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 8.0, -8, -1, 49, 0, 0, 0, 0)
  Wait(2000)
  TriggerEvent("InteractSound_CL:PlayOnOne", "eating", 0.5)
  Wait(2500)
  if hunger+50 > 100 then hunger = 100 else hunger = hunger+50 end


 local closest = GetClosestObjectOfType(x, y, z+0.2, 2.5, GetHashKey('prop_cs_hotdog_01'), false, false, false)
 DeleteObject(closest)
 ClearPedSecondaryTask(ped)
 DeleteObject(prop)

end)

RegisterNetEvent('food:drink')
AddEventHandler('food:drink', function()
 local ped = PlayerPedId()
 Citizen.CreateThread(function()
  local x,y,z = table.unpack(GetEntityCoords(ped, true))
  prop = CreateObject(GetHashKey('prop_ld_flow_bottle'), x, y, z,  true,  true, true)
  AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, 18905), 0.12, 0.0, 0.05, -110.0, 0.0, -25.0, true, true, false, true, 1, true)
  RequestAnimDict('mp_player_intdrink')
  while not HasAnimDictLoaded('mp_player_intdrink') do
   Wait(0)
  end
  TriggerEvent("InteractSound_CL:PlayOnOne", "drinking", 0.5)
  TaskPlayAnim(ped, 'mp_player_intdrink', 'loop_bottle', 8.0, -8, -1, 49, 0, 0, 0, 0)
  Wait(2000)
  TriggerEvent("InteractSound_CL:PlayOnOne", "drinking", 0.5)
  Wait(2500)
  thirst = 100

  local closest = GetClosestObjectOfType(x, y, z+0.2, 2.5, GetHashKey('prop_ld_flow_bottle'), false, false, false)
  DeleteObject(closest)
  ClearPedSecondaryTask(ped)
  DeleteObject(prop)
 end)
end)


RegisterNetEvent('food:coke')
AddEventHandler('food:coke', function()
 local ped = PlayerPedId()
 Citizen.CreateThread(function()
  local x,y,z = table.unpack(GetEntityCoords(ped, true))
  prop = CreateObject(GetHashKey('ng_proc_sodacan_01a'), x, y, z,  true,  true, true)     
  AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, 18905), 0.08, -0.06, 0.06, -110.0, 0.0, -25.0, true, true, false, true, 1, true)
  RequestAnimDict('mp_player_intdrink')  
  while not HasAnimDictLoaded('mp_player_intdrink') do
   Wait(0)
  end
  TriggerEvent("InteractSound_CL:PlayOnOne", "drinking", 0.5)
  TaskPlayAnim(ped, 'mp_player_intdrink', 'loop_bottle', 8.0, -8, -1, 49, 0, 0, 0, 0)
  Wait(2000)
  TriggerEvent("InteractSound_CL:PlayOnOne", "drinking", 0.5)
  Wait(2500)
  ClearPedSecondaryTask(ped)
  DeleteObject(prop)
  thirst = 100
 end)
end)

RegisterNetEvent('food:coffee')
AddEventHandler('food:coffee', function()
 local ped = PlayerPedId()
 Citizen.CreateThread(function()
  local x,y,z = table.unpack(GetEntityCoords(ped, true))
  prop = CreateObject(GetHashKey('p_amb_coffeecup_01'), x, y, z,  true,  true, true)     
  AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, 18905), 0.12, 0.035, 0.03, -110.0, 0.0, -25.0, true, true, false, true, 1, true)
  RequestAnimDict('mp_player_intdrink')  
  while not HasAnimDictLoaded('mp_player_intdrink') do
   Wait(0)
  end
  TriggerEvent("InteractSound_CL:PlayOnOne", "drinking", 0.5)
  TaskPlayAnim(ped, 'mp_player_intdrink', 'loop_bottle', 8.0, -8, -1, 49, 0, 0, 0, 0)
  Wait(2000)
  TriggerEvent("InteractSound_CL:PlayOnOne", "drinking", 0.5)
  Wait(2500)
  ClearPedSecondaryTask(ped)
  DeleteObject(prop)
  thirst = 100
 end)
end)

RegisterNetEvent('hud:varibles')
AddEventHandler('hud:varibles', function(data)
 hunger = data.hunger
 thirst = data.thirst
 DecorRegister('hudStatus', 2)
 DecorSetBool(GetPlayerPed(-1), 'hudStatus', true)
end)

--============================================================
--====================== Street Display ======================
--============================================================
local zones = { ['AIRP'] = "Los Santos International Airport", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon Dr", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain State Wilderness", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora Desert", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo Lighthouse", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "GWC and Golfing Society", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Paleto Cove", ['PALETO'] = "Paleto Bay", ['PALFOR'] = "Paleto Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Lights Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski Mountain Range", ['SANDY'] = "Sandy Shores", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Ron Alternates Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port of South Los Santos", ['ZQ_UAR'] = "Davis Quartz" }
local directions = {[0] = 'North', [45] = 'North West', [90] = 'West', [135] = 'South West', [180] = 'South', [225] = 'South East', [270] = 'East', [315] = 'North East', [360] = 'North', } 
local var1 = nil 
local var2 = nil
local pos = {}
local direction = nil

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(5)
  if hudStatus then
   if IsPedInAnyVehicle(PlayerPedId()) then
    DisplayRadar(true) 

    if(GetStreetNameFromHashKey(var1) and GetNameOfZone(pos.x, pos.y, pos.z))then
     if(zones[GetNameOfZone(pos.x, pos.y, pos.z)] and tostring(GetStreetNameFromHashKey(var1)))then
      drawUI(0.660, 1.4246, 1.0,1.0,0.36, '~b~'..direction.."~w~\n"..tostring(GetStreetNameFromHashKey(var1)).."\n"..zones[GetNameOfZone(pos.x, pos.y, pos.z)], 255, 255, 255, 255, false)
     end
    end
   else 
    DisplayRadar(false)
    Citizen.Wait(2000)
   end
  end
 end
end)

Citizen.CreateThread(function()
 while true do
  pos = GetEntityCoords(PlayerPedId(), true)
  var1, var2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
  for k,v in pairs(directions)do
   direction = GetEntityHeading(PlayerPedId())
   if(math.abs(direction - k) < 22.5)then
    direction = v  
    break;
   end
  end
  Citizen.Wait(500)
 end
end)

function drawUI(x,y ,width,height,scale, text, r,g,b,a, center)
 SetTextFont(4)
 SetTextProportional(0)
 SetTextScale(scale, scale)
 SetTextColour(r, g, b, a)
 SetTextDropShadow(0, 0, 0, 0,255)
 SetTextEdge(2, 0, 0, 0, 255)
 SetTextDropShadow()
 SetTextOutline()
 SetTextEntry("STRING")
 AddTextComponentString(text)
 DrawText(x - width/2, y - height/2 + 0.005)
end


--============================================================
--====================== Vehicle HUD =========================
--============================================================
local speedLimiter = false
local setSpeed = 0 
--local vehicleSpeeds = {["entity2"] = 150,["luxor"] = 400, ["frogger"] = 400, ["maverick"] = 400, ["supervolito2"] = 400, ["swift2"] = 400, ["volatus"] = 400, ["luxor2"] = 400, ["velum"] = 400, ["velum2"] = 400, ["dodo"] = 400, ["nimbus"] = 400, ["mammatus"] = 400, ["pdram"] = 150, ["toros"] = 170, ["f350"] = 175, ["buzzard2"] = 195, ["gargoyle"] = 125, ["nero"] = 150, ["boxville"] = 70, ["neon"] = 160, ["tezeract"] = 180, ["taipan"] = 180, ["tyrant"] = 180, ["pfister811"] = 150, ["pariah"] = 140, ["entity2"] = 170, ["lx570"] = 125, ["q7"] = 140, ["vogue"] = 135, ["yukonxl"] = 110, ["silverado"] = 110, ["escalade"] = 120, ["rover"] = 130, ["coquette3"] = 150, ["feltzer3"] = 150, ["guardian"] = 150, ["contender"] = 140, ["trophytruck2"] = 140, ["lurcher"] = 130, ["btype"] = 140, ["slamvan"] = 140, ["slamvan2"] = 140, ["slamvan3"] = 140, ["minivan2"] = 120, ["sabregt2"] = 140, ["tornado5"] = 130, ["virgo2"] = 130, ["comet3"] = 160, ["torero"] = 160, ["osiris"] = 160, ["elegy"] = 150, ["sultanrs"] = 150, ["specter2"] = 160, ["tempesta"] = 170, ["italigtb2"] = 170, ["cheetah2"] = 180, ["xa21"] = 180, ["nero2"] = 190, ["blista"] = 120, ["brioso"] = 120, ["dilettante"] = 120, ["issi2"] = 130, ["panto"] = 130, ["prairie"] = 120, ["rhapsody"] = 120, ["cogcabrio"] = 130, ["exemplar"] = 130, ["f620"] = 140, ["felon"] = 130, ["felon2"] = 140, ["jackal"] = 140, ["oracle"] = 130, ["oracle2"] = 140, ["sentinel"] = 130, ["sentinel2"] = 140, ["windsor"] = 130, ["windsor2"] = 140, ["zion"] = 130, ["zion2"] = 140, ["futo"] = 140, ["ninef"] = 140, ["ninef2"] = 145, ["alpha"] = 130, ["banshee"] = 130, ["bestiagts"] = 130, ["buffalo"] = 140, ["buffalo2"] = 140, ["carbonizzare"] = 140, ["comet2"] = 150, ["coquette"] = 150, ["feltzer2"] = 150, ["furoregt"] = 150, ["fusilade"] = 140, ["jester"] = 140, ["jester2"] = 150, ["lynx"] = 140, ["massacro"] = 140, ["massacro2"] = 150, ["omnis"] = 150, ["penumbra"] = 130, ["tampa2"] = 130, ["rapidgt"] = 140, ["rapidgt2"] = 140, ["schafter3"] = 130, ["sultan"] = 140, ["surano"] = 140, ["tropos"] = 140, ["verlierer2"] = 140, ["kuruma"] = 140, ["casco"] = 120, ["coquette2"] = 130, ["jb700"] = 130, ["pigalle"] = 120, ["stinger"] = 140, ["stingergt"] = 150, ["feltzer3"] = 150, ["ztype"] = 130, ["adder"] = 160, ["banshee2"] = 150, ["bullet"] = 150, ["cheetah"] = 160, ["entityxf"] = 160, ["sheava"] = 150, ["fmj"] = 160, ["infernus"] = 140, ["osiris"] = 150, ["le7b"] = 150, ["reaper"] = 170, ["t20"] = 170, ["turismor"] = 170, ["tyrus"] = 170, ["vacca"] = 160, ["Voltic"] = 150, ["prototipo"] = 185, ["zentorno"] = 175, ["blade"] = 120, ["buccaneer"] = 120, ["chino"] = 120, ["coquette3"] = 140, ["dominator"] = 140, ["dukes"] = 130, ["gauntlet"] = 130, ["hotknife"] = 140, ["faction"] = 120, ["nightshade"] = 120, ["picador"] = 120, ["sabregt"] = 130, ["tampa"] = 120, ["virgo"] = 120, ["vigero"] = 130, ["bifta"] = 120, ["blazer"] = 120, ["brawler"] = 120, ["sadler"] = 120, ["dubsta3"] = 130, ["rebel"] = 120, ["sandking2"] = 130, ["sandking"] = 130, ["trophytruck"] = 140, ["baller"] = 130, ["baller3"] = 140, ["cavalcade"] = 120, ["granger"] = 120, ["huntley"] = 120, ["landstalker"] = 120, ["radi"] = 120, ["rocoto"] = 120, ["seminole"] = 120, ["xls"] = 140, ["bison"] = 120, ["bobcatxl"] = 125, ["gburrito"] = 120, ["journey"] = 115, ["minivan"] = 120, ["paradise"] = 125, ["rumpo"] = 120, ["surfer"] = 125, ["youga"] = 125, ["asea"] = 120, ["fugitive"] = 120, ["asterope"] = 120, ["glendale"] = 120, ["ingot"] = 120, ["intruder"] = 120, ["premier"] = 130, ["primo"] = 120, ["primo2"] = 130, ["schafter2"] = 130, ["tailgater"] = 120, ["warrener"] = 120, ["washington"] = 130, ["surge"] = 130, ["superd"] = 130, ["stretch"] = 120, ["blazer"] = 120, ["faggio2"] = 120, ["sanchez"] = 120, ["enduro"] = 130, ["akuma"] = 150, ["bagger"] = 130, ["bati"] = 140, ["bati2"] = 150, ["bf400"] = 120, ["carbonrs"] = 150, ["cliffhanger"] = 120, ["daemon"] = 120, ["double"] = 120, ["gargoyle"] = 95, ["hakuchou"] = 140, ["hakuchou2"] = 150, ["hexer"] = 120, ["fatboy"] = 130, ["innovation"] = 120, ["lectro"] = 120, ["nemesis"] = 140, ["pcj"] = 120, ["ruffian"] = 120, ["knucklehead"] = 120, ["vindicator"] = 150, ["diablous2"] = 150, ["blazer4"] = 150, ["blazer"] = 150, ["police"] = 165, ["policeb"] = 195, ["police2"] = 185, ["police3"] = 175, ["police4"] = 160, ["police5"] = 155, ["police6"] = 155, ["police7"] = 155, ["police8"] = 155, ["polaventa"] = 195, ["polmav"] = 310, ["emscar"] = 165, ["sheriff2"] = 175, ["emscar2"] = 185, ["emscar4"] = 185, ["cprotection"] = 185, ["emssuv2"] = 175, ["emssuv"] = 160, ["polmav"] = 255, ["ambulance"] = 155, ["ambulance2"] = 155, ["emscar3"] = 175, ["emschiron"] = 210, ["supervolito"] = 310, ["annihilator"] = 310, ["raiden"] = 155, ["cyclone"] = 155, ["visione"] = 145, ["nissantitan17"] = 140, ["rs7"] = 155, ["demon"] = 135, ["bmwm3e92"] = 135, ["m3e92gts"] = 155, ["sq72016"] = 145, ["zl12017"] = 145, ["vortex"] = 118, ["teslax"] = 145,  ["r6"] = 145, ["c63s"] = 150, ["s65"] = 140, ["hvrod"] = 145, ['desmo'] = 140, ['mst'] = 150, ['phantom'] = 70, ['phantom3'] = 80, ['hauler'] = 65, ['packer'] = 75, ['2015polstang'] = 165, ['fbi'] = 185, ['fbi2'] = 165, ['deveste'] = 200, ['italigto'] = 155, ['schlagen'] = 150, ['clique'] = 140}
local vehicleSpeeds = {["sheriff"] = 500,["metro2"] = 1000,["drafter"] = 400,["M4SP"] = 400,["ts1"] = 400,["m2"] = 300,["zl12017"] = 400,["tricolore"] = 400,["subwrx"] = 255,["subaruimpreza"] = 255,["ibiza"] = 235,["kiagt"] = 270,["xkgt"] = 280,["yFiat595ssA"] = 160,["ds4"] = 190,["citroenc3"] = 168,["por911"] = 290,["peug308"] = 201,["polo2018"] = 187,["passat"] = 209,["mk3"] = 198,["R50"] = 235,["gtr"] = 350,["entity2"] = 250,["luxor"] = 400, ["frogger"] = 400, ["maverick"] = 400, ["supervolito2"] = 400, ["swift2"] = 400, ["volatus"] = 400, ["luxor2"] = 400, ["velum"] = 400, ["velum2"] = 400, ["dodo"] = 400, ["nimbus"] = 400, ["mammatus"] = 400, ["pdram"] = 300, ["toros"] = 300, ["f350"] = 300, ["buzzard2"] = 300, ["gargoyle"] = 300, ["nero"] = 300, ["boxville"] = 170, ["neon"] = 300, ["tezeract"] = 180, ["taipan"] = 180, ["tyrant"] = 180, ["pfister811"] = 300, ["pariah"] = 300, ["entity2"] = 300, ["lx5170"] = 300, ["q7"] = 300, ["vogue"] = 135, ["yukonxl"] = 260, ["silverado"] = 260, ["escalade"] = 300, ["rover"] = 300, ["coquette3"] = 300, ["feltzer3"] = 300, ["guardian"] = 300, ["contender"] = 300, ["trophytruck2"] = 300, ["lurcher"] = 300, ["btype"] = 300, ["slamvan"] = 300, ["slamvan2"] = 300, ["slamvan3"] = 300, ["minivan2"] = 300, ["sabregt2"] = 300, ["tornado5"] = 300, ["virgo2"] = 300, ["comet3"] = 300, ["torero"] = 300, ["osiris"] = 300, ["elegy"] = 300, ["sultanrs"] = 300, ["specter2"] = 300, ["tempesta"] = 300, ["italigtb2"] = 300, ["cheetah2"] = 180, ["xa21"] = 180, ["nero2"] = 190, ["blista"] = 300, ["brioso"] = 300, ["dilettante"] = 300, ["issi2"] = 300, ["panto"] = 300, ["prairie"] = 300, ["rhapsody"] = 300, ["cogcabrio"] = 300, ["exemplar"] = 300, ["f620"] = 300, ["felon"] = 300, ["felon2"] = 300, ["jackal"] = 300, ["oracle"] = 300, ["oracle2"] = 300, ["sentinel"] = 300, ["sentinel2"] = 300, ["windsor"] = 300, ["windsor2"] = 300, ["zion"] = 300, ["zion2"] = 300, ["futo"] = 300, ["ninef"] = 300, ["ninef2"] = 145, ["alpha"] = 300, ["banshee"] = 300, ["bestiagts"] = 300, ["buffalo"] = 300, ["buffalo2"] = 300, ["carbonizzare"] = 300, ["comet2"] = 300, ["coquette"] = 300, ["feltzer2"] = 300, ["furoregt"] = 300, ["fusilade"] = 300, ["jester"] = 300, ["jester2"] = 300, ["lynx"] = 300, ["massacro"] = 300, ["massacro2"] = 300, ["omnis"] = 300, ["penumbra"] = 300, ["tampa2"] = 300, ["rapidgt"] = 300, ["rapidgt2"] = 300, ["schafter3"] = 300, ["sultan"] = 300, ["surano"] = 300, ["tropos"] = 300, ["verlierer2"] = 300, ["kuruma"] = 300, ["casco"] = 300, ["coquette2"] = 300, ["jb1700"] = 300, ["pigalle"] = 300, ["stinger"] = 300, ["stingergt"] = 300, ["feltzer3"] = 300, ["ztype"] = 300, ["adder"] = 300, ["banshee2"] = 300, ["bullet"] = 300, ["cheetah"] = 300, ["entityxf"] = 300, ["sheava"] = 300, ["fmj"] = 300, ["infernus"] = 300, ["osiris"] = 300, ["le7b"] = 300, ["reaper"] = 300, ["t20"] = 300, ["turismor"] = 300, ["tyrus"] = 300, ["vacca"] = 300, ["Voltic"] = 300, ["prototipo"] = 300, ["zentorno"] = 300, ["blade"] = 300, ["buccaneer"] = 300, ["chino"] = 300, ["coquette3"] = 300, ["dominator"] = 300, ["dukes"] = 300, ["gauntlet"] = 300, ["hotknife"] = 300, ["faction"] = 300, ["nightshade"] = 300, ["picador"] = 300, ["sabregt"] = 300, ["tampa"] = 300, ["virgo"] = 300, ["vigero"] = 300, ["bifta"] = 300, ["blazer"] = 300, ["brawler"] = 300, ["sadler"] = 300, ["dubsta3"] = 300, ["rebel"] = 300, ["sandking2"] = 300, ["sandking"] = 300, ["trophytruck"] = 300, ["baller"] = 300, ["baller3"] = 300, ["cavalcade"] = 300, ["granger"] = 300, ["huntley"] = 300, ["landstalker"] = 300, ["radi"] = 300, ["rocoto"] = 300, ["seminole"] = 300, ["xls"] = 300, ["bison"] = 300, ["bobcatxl"] = 300, ["gburrito"] = 300, ["journey"] = 300, ["minivan"] = 300, ["paradise"] = 300, ["rumpo"] = 300, ["surfer"] = 300, ["youga"] = 300, ["asea"] = 300, ["fugitive"] = 300, ["asterope"] = 300, ["glendale"] = 300, ["ingot"] = 300, ["intruder"] = 300, ["premier"] = 300, ["primo"] = 300, ["primo2"] = 300, ["schafter2"] = 300, ["tailgater"] = 300, ["warrener"] = 300, ["washington"] = 300, ["surge"] = 300, ["superd"] = 300, ["stretch"] = 300, ["blazer"] = 300, ["faggio2"] = 300, ["sanchez"] = 300, ["enduro"] = 300, ["akuma"] = 300, ["bagger"] = 300, ["bati"] = 300, ["bati2"] = 300, ["bf400"] = 300, ["carbonrs"] = 300, ["cliffhanger"] = 300, ["daemon"] = 300, ["double"] = 300, ["gargoyle"] = 300, ["hakuchou"] = 300, ["hakuchou2"] = 300, ["hexer"] = 300, ["fatboy"] = 300, ["innovation"] = 300, ["lectro"] = 300, ["nemesis"] = 300, ["pcj"] = 300, ["ruffian"] = 300, ["knucklehead"] = 300, ["vindicator"] = 300, ["diablous2"] = 300, ["blazer4"] = 300, ["blazer"] = 300, ["police"] = 500, ["policeb"] = 300, ["police2"] = 300, ["police3"] = 300, ["police4"] = 300, ["police5"] = 300, ["police6"] = 300, ["police7"] = 300, ["police8"] = 300, ["polaventa"] = 300, ["polmav"] = 410, ["emscar"] = 300, ["sheriff2"] = 300, ["emscar2"] = 300, ["emscar4"] = 300, ["cprotection"] = 300, ["emssuv2"] = 300, ["emssuv"] = 300, ["polmav"] = 300, ["ambulance"] = 300, ["ambulance2"] = 300, ["emscar3"] = 300, ["emschiron"] = 310, ["supervolito"] = 410, ["annihilator"] = 410, ["raiden"] = 300, ["cyclone"] = 300, ["visione"] = 300, ["nissantitan17"] = 250, ["rs7"] = 300, ["demon"] = 300, ["bmwm3e92"] = 300, ["m3e92gts"] = 300, ["sq72016"] = 300, ["zl30017"] = 300, ["vortex"] = 300, ["teslax"] = 300,  ["r6"] = 300, ["c63s"] = 300, ["s65"] = 300, ["hvrod"] = 300, ['desmo'] = 300, ['mst'] = 300, ['phantom'] = 300, ['phantom3'] = 300, ['hauler'] = 300, ['packer'] = 300, ['2015polstang'] = 300, ['fbi'] = 300, ['fbi2'] = 300, ['deveste'] = 300, ['italigto'] = 300, ['schlagen'] = 300, ['clique'] = 300}

function getMaxSpeed(vehicle)
 local vehicle = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
 local veh = string.lower(vehicle)
 return vehicleSpeeds[veh]
end

DecorRegister('Seatbelt', 2)
DecorSetBool(PlayerPedId(), 'Seatbelt', false)



-- SCREEN POSITION PARAMETERS
local screenPosX = 0.160                   -- X coordinate (top left corner of HUD)
local screenPosY = 0.852

-- Helper function to draw text to screen
function drawTxt(content, font, colour, scale, x, y)
    SetTextFont(font)
    SetTextScale(scale, scale)
    SetTextColour(colour[1],colour[2],colour[3], 255)
    SetTextEntry("STRING")
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextDropShadow()
    SetTextEdge(4, 0, 0, 0, 255)
    SetTextOutline()
    AddTextComponentString(content)
    DrawText(x, y)
end



Citizen.CreateThread(function()
 while true do
  local ped = PlayerPedId()  
  local vehicle = GetVehiclePedIsIn(ped, false)
  --local speed = math.floor(GetEntitySpeed(vehicle) * 2.236936)
  local speed = math.floor(GetEntitySpeed(vehicle) * 3.6)  
  Citizen.Wait(5)
  if hudStatus then
   if IsPedInAnyVehicle(ped) then
               local hour = GetClockHours()
            local minute = GetClockMinutes()
            local timeText = ("%.2d"):format((hour == 0) and 12 or hour) .. ":" .. ("%.2d"):format( minute) .. ((hour < 12) and " AM" or " PM")
            drawTxt(timeText, 4, {255,255,255}, 0.4, screenPosX, screenPosY + 0.048)
       -- Speed & Fuel
    local currentfuel = DecorGetInt(vehicle, "_Fuel_Level") * 0.001
    --drawUI(0.517, 1.302, 1.0, 1.0, 0.4, "KMH", 255, 255, 255, 255, false)
    --drawUI(1.035, 1.452, 1.0, 1.0, 0.3,round(currentfuel,1).."%", 255, 255, 255, 255, 0, 1)
    -- Speed & Fuel
    --drawUI(0.517, 1.302, 1.0, 1.0, 0.4, "KMH", 255, 255, 255, 255, false)
    -- Speed Limiter
    if speedLimiter then
     --drawUI(0.535, 1.302, 1.0, 1.0, 0.4, speed.." ~b~"..math.floor(setSpeed*2.236936), 255, 255, 255, 255, false)  
     drawUI(0.517, 1.322, 1.0, 1.0, 0.4, speed.."~g~ KMH ~b~"..math.floor(setSpeed*3.6), 255, 255, 255, 255, false) 	 
    else
     --drawUI(0.535, 1.302, 1.0, 1.0, 0.4, speed, 255, 255, 255, 255, false)
    end
    -- Seatbelt Display
    local class = GetVehicleClass(vehicle)
    if (class >= 0 and class <= 7) or (class >= 10 and class <= 12) or (class >= 17 and class <= 20) then
     if DecorGetBool(ped, 'Seatbelt') then
      --drawUI(0.634, 1.302, 1.0, 1.0, 0.4, "~g~BELT", 255, 255, 255, 255, false)
     else
      --drawUI(0.634, 1.302, 1.0, 1.0, 0.4, "~r~BELT", 255, 255, 255, 255, false)
     end
    end

    if GetPedInVehicleSeat(vehicle, -1) == ped and IsPedInAnyVehicle(ped, false) then
     if IsControlJustPressed(1, 21) and not IsVehicleModel(GetVehiclePedIsIn(ped, false), GetHashKey("BMX")) and not IsVehicleModel(GetVehiclePedIsIn(ped, false), GetHashKey("Cruiser")) and not IsVehicleModel(GetVehiclePedIsIn(ped, false), GetHashKey("Scorcher")) and not IsVehicleModel(GetVehiclePedIsIn(ped, false), GetHashKey("Fixter")) then
      if speedLimiter == false then setSpeed = GetEntitySpeed(vehicle) speedLimiter = true else speedLimiter = false end
     end
    end
   else 
    Citizen.Wait(1000)
    speedLimiter = false
   end
  end
 end
end)

function round(num, dec)
  local mult = 10^(dec or 0)
  return math.floor(num * mult + 0.5) / mult
end

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(250)
  if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
   local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
    local match = false
   if not speedLimiter then 
    for name,speed in pairs(vehicleSpeeds) do 
     if GetEntityModel(vehicle) == GetHashKey(name) then
      --SetEntityMaxSpeed(vehicle, speed/2.236936)
      SetEntityMaxSpeed(vehicle, speed/3.6)	  
      match = true
     end
     if not match then 
      --SetEntityMaxSpeed(vehicle, 115/2.236936)
      SetEntityMaxSpeed(vehicle, 300/3.6)	  
     end
    end
   else 
    SetEntityMaxSpeed(vehicle, setSpeed)
   end
  else 
   Citizen.Wait(2000)
  end
 end
end)

local vehiclePowers = { 
 ['italigto'] = 45.0,
 ['deveste'] = 55.0,
 ['schlagen'] = 25.0,
}

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(0)
  if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then 
   local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
   if (GetPedInVehicleSeat(vehicle, -1) == GetPlayerPed(-1)) then
    local match = false
    for name,speed in pairs(vehiclePowers) do 
     if GetEntityModel(vehicle) == GetHashKey(name) then
      SetVehicleEnginePowerMultiplier(vehicle, speed)
      match = true
     end
     if not match then 
      SetVehicleEnginePowerMultiplier(vehicle, 0.0)
     end
    end
   else 
    Citizen.Wait(1000)
   end
  else 
   Citizen.Wait(2000)
  end
 end
end)

--============================================================
--====================== ID Above Head =======================
--============================================================
local enableids = true
local enablemarkers = true

Citizen.CreateThread(function()
 AddTextEntry('FE_THDR_GTAO', 'ASTERIX AND OBELIX RP 128 SLOTS')
 while true do
  Citizen.Wait(5)
  if hudStatus then
   for i=0,256 do N_0x31698aa80e0223f8(i) end
   for id = 0, 256 do
    if (NetworkIsPlayerActive(id)) and GetPlayerPed(id) ~= GetPlayerPed(-1) then
     ped = GetPlayerPed(id)
     x1, y1, z1 = table.unpack(GetEntityCoords(GetPlayerPed( -1 ), true ))
     x2, y2, z2 = table.unpack(GetEntityCoords(GetPlayerPed( id ), true ))
     distance = math.floor(GetDistanceBetweenCoords(x1,  y1,  z1,  x2,  y2,  z2,  true))
     local phone = DecorGetFloat(ped, 'Phone')
     local loggingOut = DecorGetBool(ped, 'isLoggingOut')

     if ((distance < 20)) and IsEntityVisible(ped) and enableids then
      if loggingOut == 1 then 
       DrawText3D(x2, y2, z2+1.5, 'Logging Out', false)
      else
       if NetworkIsPlayerTalking(id) then
        DrawText3D(x2, y2, z2+1.5, GetPlayerServerId(id), true)
       else
        DrawText3D(x2, y2, z2+1.5, GetPlayerServerId(id), false)
       end
      end
     end
     
     if enablemarkers and ((distance < 30)) and IsEntityVisible(ped) then
      if not IsPedInAnyVehicle(ped) then 
       if phone == 2.0 then 
        DrawMarker(23, x2, y2, z2-0.97, 0, 0, 0, 0, 0, 0, 0.8,0.8,0.5, 255, 28, 28, 95, 0, 0, 2, 0, 0, 0, 0)
       else
        if NetworkIsPlayerTalking(id) then
         DrawMarker(23, x2, y2, z2-0.97, 0, 0, 0, 0, 0, 0, 0.8,0.8,0.5, 0, 145, 254, 95, 0, 0, 2, 0, 0, 0, 0)
        end
       end
      end
     end
    end
   end
  end
 end
end)

function DrawText3D(x,y,z, text, talking)
 local onScreen,_x,_y=World3dToScreen2d(x,y,z)
 local px,py,pz=table.unpack(GetGameplayCamCoords())
 local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 local scale = (2/dist)*2
 local fov = (1/GetGameplayCamFov())*100
 local scale = scale*fov
 if onScreen then
  SetTextScale(0.0*scale, 0.60*scale)
  SetTextFont(2)
  SetTextProportional(0)
  if talking then SetTextColour(50, 255, 50, 255) else SetTextColour(255, 255, 255, 255) end
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
--========================================================================================--
--==================================== carteras =========================================--
--========================================================================================--
-- local money = 0

-- Citizen.CreateThread(function()
 -- while true do
  -- local ped = PlayerPedId()
  -- Citizen.Wait(5)
  -- if hudStatus then
   -- if IsPedOnFoot(ped) then 
    -- drawUI(0.514, 1.436, 1.0, 1.0, 0.42, "~g~CARTERA ~y~$~w~"..money, 255, 255, 255, 255, false)
   -- end 
  -- else 
   -- Citizen.Wait(200)
  -- end
 -- end
-- end)

-- RegisterNetEvent('hud:money')
-- AddEventHandler('hud:money', function(data)
 -- money = data
-- end)

--========================================================================================--
--==================================== Seat Belt =========================================--
--========================================================================================--
local speedBuffer  = {}
local velBuffer    = {}
local wasInCar     = false
local carspeed = 0
local speed = 0 

Citizen.CreateThread(function()
 Citizen.Wait(500)
  while true do
   local ped = GetPlayerPed(-1)
   local car = GetVehiclePedIsIn(ped) 
   if car ~= 0 and (wasInCar or IsCar(car)) then
    wasInCar = true
    speedBuffer[2] = speedBuffer[1]
    speedBuffer[1] = GetEntitySpeed(car) 
    if speedBuffer[2] ~= nil and GetEntitySpeedVector(car, true).y > 1.0 and speedBuffer[2] > 18.00 and (speedBuffer[2] - speedBuffer[1]) > (speedBuffer[2] * 0.465) and DecorGetBool(GetPlayerPed(-1), 'Seatbelt') == false then
    local co = GetEntityCoords(ped, true)
    local fw = Fwv(ped)
    SetEntityCoords(ped, co.x + fw.x, co.y + fw.y, co.z - 0.47, true, true, true)
    SetEntityVelocity(ped, velBuffer[2].x-10/2, velBuffer[2].y-10/2, velBuffer[2].z-10/4)
    Citizen.Wait(1)
    SetPedToRagdoll(ped, 1000, 1000, 0, 0, 0, 0)
   end    
    velBuffer[2] = velBuffer[1]
    velBuffer[1] = GetEntityVelocity(car)    

    if IsControlJustPressed(0, 29) and speed < 200 then 
		  local finished = exports["clrp-taskbar"]:taskBar(1700,"Cinturon seguridad")	  
      if finished == 100 then	
     --if ProgressBar('Seatbelt', 10, 1750) then
      if DecorGetBool(GetPlayerPed(-1), 'Seatbelt') == false then
       DecorSetBool(GetPlayerPed(-1), 'Seatbelt', true)
       exports.pNotify:SendNotification({text = "Cinturón abrochado"})
      else 
       DecorSetBool(GetPlayerPed(-1), 'Seatbelt', false)
       exports.pNotify:SendNotification({text = "Cinturón desabrochado"})
      end
     end 
    end
    
    if speed > 120 then 
     DisableControlAction(0, 75)
    end
   elseif wasInCar then
    wasInCar = false
    DecorSetBool(GetPlayerPed(-1), 'Seatbelt', false)
    speedBuffer[1], speedBuffer[2] = 0.0, 0.0
   end
   Citizen.Wait(5)
   --speed = math.floor(GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) * 2.236936)
   speed = math.floor(GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) * 3.6)   
  end
end)

function IsCar(veh)
 local vc = GetVehicleClass(veh)
 return (vc >= 0 and vc <= 7) or (vc >= 9 and vc <= 12) or (vc >= 17 and vc <= 20)
end 

function Fwv(entity)
 local hr = GetEntityHeading(entity) + 90.0
 if hr < 0.0 then hr = 360.0 + hr end
 hr = hr * 0.0174533
 return { x = math.cos(hr) * 2.0, y = math.sin(hr) * 2.0 }
end

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(9500)
  if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
   if not DecorGetBool(GetPlayerPed(-1), 'Seatbelt') then 
    --local speed = math.floor(GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) * 2.236936)
    local speed = math.floor(GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) * 3.6)	
    local vc = GetVehicleClass(GetVehiclePedIsIn(GetPlayerPed(-1), false))
    if (vc >= 0 and vc <= 7) or (vc >= 9 and vc <= 12) or (vc >= 17 and vc <= 20) then 
     if speed > 50 then 
      TriggerEvent("InteractSound_CL:PlayOnOne", "belt", 0.2)
     end
    end  
   end
  else 
   Citizen.Wait(2000)
  end
 end
end)

local players = {}
local cops = 'Low'
local ems = 'Call PD'
local mechanic = 'None'
local qCount = 0

Citizen.CreateThread(function()
 WarMenu.CreateLongMenu('player_list', "Players")
 while true do
  Wait(5)
  if WarMenu.IsMenuOpened('player_list') then
   enableids = true 
   if WarMenu.Button('Server ID: ', GetPlayerServerId(PlayerId())) then
   elseif WarMenu.Button('EMS Presencia: ', ems) then
   elseif WarMenu.Button('Police Presencia: ', cops) then  
   elseif WarMenu.Button('Mechanic Presencia: ', mechanic) then
   elseif WarMenu.Button('Players:', #players..'/128') then
   end
   if qCount > 0 then
    if WarMenu.Button('Queued:', qCount) then
    end
   end
   WarMenu.Display()
  elseif enableids then
   enableids = false
  end
  if IsControlJustPressed(0, 303) then 
    players = {} 
    WarMenu.OpenMenu('player_list')
    for i = 0, 256 do
     if NetworkIsPlayerActive( i ) then
      table.insert( players, i )
     end
    end 
  end
 end
end) 

-- RegisterNetEvent('hud:updatepresence')
-- AddEventHandler('hud:updatepresence', function(copss, emss, mechc)
 -- if copss == 0 then
  -- cops = '0'
 -- elseif copss > 1 then 
  -- cops = '1'  
 -- elseif copss > 2 then 
  -- cops = '2'
 -- elseif copss > 3 then 
  -- cops = '3'
 -- elseif copss > 4 then 
  -- cops = '4'
 -- elseif copss > 5 then 
  -- cops = '5'  
 -- elseif copss <= 6 then 
  -- cops = '+6'  
 -- end
 -- if emss == 0 then
  -- ems = 'Call PD'
 -- elseif emss > 1 then
  -- ems = '1'
 -- elseif emss > 2 then 
  -- ems = '2'
 -- elseif emss > 3 then 
  -- ems = '3'
 -- elseif emss > 4 then 
  -- ems = '4' 
 -- elseif emss <= 5 then 
  -- ems = '+5'  
 -- end
 -- if mechc == 0 then
  -- mechanic = '0'
 -- elseif mechc > 1 then
  -- mechanic = '1'
 -- elseif mechc > 2 then 
  -- mechanic = '2'
 -- elseif mechc <= 3 then 
  -- mechanic = '+3'
 -- end
-- end)

RegisterNetEvent('hud:updatepresence')
AddEventHandler('hud:updatepresence', function(copss, emss, mechc)
 if copss <= 2 then
  cops = 'Bajo'
 elseif copss > 2 and copss <= 5 then 
  cops = 'Medio'
 elseif copss > 5 then 
  cops = 'Alta'
 end
 if emss == 0 then
  ems = 'Call PD'
 elseif emss <= 2 then
  ems = 'Bajo'
 elseif emss > 2 and emss <= 4 then 
  ems = 'Medio'
 elseif emss > 4 then 
  ems = 'Alta'
 end
 if mechc == 0 then
  mechanic = 'None'
 elseif mechc <= 2 then
  mechanic = 'Bajo'
 elseif mechc > 2 and mechc <= 4 then 
  mechanic = 'Medio'
 elseif mechc > 4 then 
  mechanic = 'Alta'
 end
end)

RegisterNetEvent('debug:queueCount')
AddEventHandler('debug:queueCount', function(count)
 qCount = count
end)

RegisterNetEvent('hud:money')
AddEventHandler('hud:money', function(data)
 money = data
end)

Citizen.CreateThread( function()
 while true do 
  local ped = GetPlayerPed(-1)
  Citizen.Wait(3500)
  if IsPedInAnyVehicle(ped) then
   local vehicle = GetVehiclePedIsIn(ped, false)
   if GetVehicleEngineHealth(vehicle) < 250 then 
    if math.random(1,50) > 20 then 
     SetVehicleUndriveable(vehicle, true)
     PlaySoundFrontend(-1, "CHECKPOINT_MISSED", 'HUD_MINI_GAME_SOUNDSET', 1)
     SetVehicleDoorShut(vehicle, 4, false)
    end
   end
  end
 end
end)

Citizen.CreateThread(function()
    for i = 1, 256 do
        Citizen.InvokeNative(0xDC0F817884CDD856, i, false)
    end
    while true do
        Citizen.Wait(0)
        if GetPlayerWantedLevel(PlayerId()) ~= 0 then
            ClearPlayerWantedLevel(PlayerId())
        end
    end
end)


--============================================================
--====================== VOIP System =========================
--============================================================
-- voice = {default = 14.0, shout = 20.0, whisper = 7.0, current = 0, level = 'NEAR'}

-- Citizen.CreateThread(function()
	-- while true do
		-- Citizen.Wait(1)

		-- if IsControlJustPressed(1, 74) and IsControlPressed(1, 21) then
			-- voice.current = (voice.current + 1) % 3
			-- if voice.current == 0 then
				-- NetworkSetTalkerProximity(voice.default)
        -- voice.level = 'NEAR'
        -- DecorSetInt(PlayerPedId(), 'voipRange', 2)
			-- elseif voice.current == 1 then
				-- NetworkSetTalkerProximity(voice.shout)
        -- voice.level = 'YELL'
        -- DecorSetInt(PlayerPedId(), 'voipRange', 3)
			-- elseif voice.current == 2 then
				-- NetworkSetTalkerProximity(voice.whisper)
        -- voice.level = 'WHIS'
        -- DecorSetInt(PlayerPedId(), 'voipRange', 1)
			-- end
		-- end

		-- if voice.current == 0 then
			-- voice.level = 'NEAR'
		-- elseif voice.current == 1 then
			-- voice.level = 'YELL'
		-- elseif voice.current == 2 then
			-- voice.level = 'WHIS'
		-- end
	-- end
-- end)

RegisterNetEvent('hud:time')
AddEventHandler('hud:time', function(hours, minutes)
 hour = hours
 minute = minutes

 if hour <= 9 then
  hour = "0" .. hour
 end
 if minute <= 9 then
  minute = "0" .. minute
 end
end)
--teste de los coche

-- local NosVehicles = {}
-- local nosForce = 0.0
-- RegisterNetEvent('NosStatus')
-- AddEventHandler('NosStatus', function()
	-- local playerPed = GetPlayerPed(-1)
	
	-- local currentVehicle = GetVehiclePedIsIn(playerPed, false)
	-- local driverPed = GetPedInVehicleSeat(currentVehicle, -1)
	-- if GetVehicleMod(currentVehicle,11) == -1 and GetVehicleMod(currentVehicle,18) == -1 then
		-- TriggerEvent("DoLongHudText","Need Engine/Turbo upgraded!",2) 
		-- return 
	-- end

	-- if currentVehicle ~= nil and currentVehicle ~= false and currentVehicle ~= 0 then
		-- if driverPed == GetPlayerPed(-1) then
			-- NosVehicles[currentVehicle] = 100

		-- end
	-- end
-- end)

-- local handbrake = 0
-- local nitroTimer = false

-- RegisterNetEvent('resethandbrake')
-- AddEventHandler('resethandbrake', function()
	-- while handbrake > 0 do
		-- handbrake = handbrake - 1
		-- Citizen.Wait(30)
	-- end
-- end)
-- RegisterNetEvent('NetworkNos')
-- AddEventHandler('NetworkNos', function(plt)

    -- if plt == GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), false)) then
        -- startNos()
    -- end

-- end)


-- RegisterNetEvent('NetworkNosOff')
-- AddEventHandler('NetworkNosOff', function(plt)

    -- if plt == GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), false)) then
        -- endNos()
    -- end

-- end)


-- RegisterNetEvent('NosBro')
-- AddEventHandler('NosBro', function(currentVehicle)

	-- if not nitroTimer then
		-- TriggerServerEvent("NetworkNos",GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), false)))
	-- end		

	-- local passedCurrentVehicle = currentVehicle
	-- if not IsVehicleOnAllWheels(passedCurrentVehicle) or not IsVehicleEngineOn(passedCurrentVehicle) then return end
	-- local curSpeed = GetEntitySpeed(passedCurrentVehicle)
	-- local modifier = (1.0 / (curSpeed / 5)) * 0.81
	-- SetVehicleForwardSpeed(passedCurrentVehicle, curSpeed + modifier) --Forward Speed

	-- if nosForce == 0.0 then
		-- local fInitialDriveForce = GetVehicleHandlingFloat(passedCurrentVehicle, 'CHandlingData', 'fInitialDriveForce')
		-- nosForce = fInitialDriveForce
	-- end
	-- local burst = math.ceil( (nosForce + nosForce * 1.15) * 100000 ) / 100000
	-- if GetEntitySpeed(passedCurrentVehicle) > 70 then
		-- burst = math.ceil( (nosForce + nosForce * 0.85) * 100000 ) / 100000
	-- end
	

	-- if burst > 0 then
		-- SetVehicleHandlingField(passedCurrentVehicle, 'CHandlingData', 'fInitialDriveForce', burst)
	-- end

-- end)

-- RegisterNetEvent('nos:help')
-- AddEventHandler('nos:help', function()
	
	-- local playerPed = GetPlayerPed(-1)
	-- local currentVehicle = GetVehiclePedIsIn(playerPed, false)	

	-- if NosVehicles[currentVehicle] == nil then
		-- NosVehicles[currentVehicle] = 0
	-- end

	-- TriggerEvent("chatMessage", "NOS: ", {255, 255, 255}, "You have %" .. math.floor(NosVehicles[currentVehicle]) .. " left")

-- end)


-- local disablenos = false
-- function startNos()
	-- disablenos = true
	-- nitroTimer = true
	-- local playerPed = GetPlayerPed(-1)
	-- local currentVehicle = GetVehiclePedIsIn(playerPed, false)		
	-- SetVehicleBoostActive(currentVehicle, 1) --Boost Sound
    -- StartScreenEffect("RaceTurbo", 30.0, 0)
    -- StartScreenEffect("ExplosionJosh3", 30.0, 0)	
    -- Citizen.Wait(200)
    -- StartScreenEffect("RaceTurbo", 0, 0)
    -- StartScreenEffect("ExplosionJosh3", 0, 0)
    -- SetVehicleBoostActive(currentVehicle, 0)
-- end

-- function endNos()
	-- local playerPed = GetPlayerPed(-1)
	-- local currentVehicle = GetVehiclePedIsIn(playerPed, false)	
	-- if nosForce ~= 0.0 then
		-- SetVehicleHandlingField(currentVehicle, 'CHandlingData', 'fInitialDriveForce', nosForce)
	-- end
	-- nosForce = 0.0
	-- nitroTimer = false
	-- Citizen.Wait(1000)
	-- disablenos = false
-- end


-- Citizen.CreateThread(function()
	-- Citizen.Wait(1000)
	-- local newvehicleBodyHealth = 0
	-- local newvehicleEngineHealth = 0
	-- local currentvehicleEngineHealth = 0
	-- currentvehicleBodyHealth = 0
	-- local frameBodyChange = 0
	-- local frameEngineChange = 0
	-- local lastFrameVehiclespeed = 0
	-- local lastFrameVehiclespeed2 = 0
	-- local thisFrameVehicleSpeed = 0
	-- local tick = 0
	-- damagedone = false
	-- curEnginehealth = 0
	-- local modifierDensity = true
	-- while true do

		-- Citizen.Wait(5)
		-- local playerPed = GetPlayerPed(-1)
		-- local currentVehicle = GetVehiclePedIsIn(playerPed, false)

		-- local driverPed = GetPedInVehicleSeat(currentVehicle, -1)

		-- if currentVehicle ~= nil and currentVehicle ~= false and currentVehicle ~= 0 then

			-- SetPedHelmet(playerPed, false)

			-- lastVehicle = GetVehiclePedIsIn(playerPed, false)

			-- if driverPed == GetPlayerPed(-1) then


				-- if GetVehicleEngineHealth(currentVehicle) < 0.0 then
					-- SetVehicleEngineHealth(currentVehicle,0.0)
				-- end



				-- if (GetVehicleHandbrake(currentVehicle) or (GetVehicleSteeringAngle(currentVehicle)) > 25.0 or (GetVehicleSteeringAngle(currentVehicle)) < -25.0) then
					-- if handbrake == 0 then
						-- handbrake = 100
						-- TriggerEvent("resethandbrake")
					-- else
						-- handbrake = 100
					-- end
				-- end

				-- if NosVehicles[currentVehicle] == nil then
					-- NosVehicles[currentVehicle] = 0
				-- end

				-- if IsControlJustReleased(1,96) and not IsThisModelAHeli(GetEntityModel(lastVehicle)) then
					-- TriggerEvent("car:engine")
				-- end

				-- thisFrameVehicleSpeed = GetEntitySpeed(currentVehicle) * 3.6

				-- if (IsControlJustReleased(1,21) or NosVehicles[currentVehicle] < 10) and nitroTimer then
					-- endNos()
				-- end

				-- if not disablenos and handbrake < 5 and lastFrameVehiclespeed > 45.0 and IsControlPressed(1,21) and not IsThisModelAHeli(GetEntityModel(currentVehicle)) and not IsThisModelABoat(GetEntityModel(currentVehicle)) and not IsThisModelABike(GetEntityModel(currentVehicle)) and NosVehicles[currentVehicle] ~= nil then
					-- if NosVehicles[currentVehicle] > 1 then
						-- TriggerEvent("NosBro",currentVehicle)
						-- NosVehicles[currentVehicle] = NosVehicles[currentVehicle] - 4
					-- end
				-- end






				-- currentvehicleBodyHealth = GetVehicleBodyHealth(currentVehicle)


				-- if currentvehicleBodyHealth == 2000 and frameBodyChange ~= 0 then
					-- frameBodyChange = 0
				-- end

				-- if frameBodyChange ~= 0 then
						
					-- if lastFrameVehiclespeed > 110 and thisFrameVehicleSpeed < (lastFrameVehiclespeed * 0.75) and not damagedone then

						-- if frameBodyChange > 18.0 then
								-- if not IsThisModelABike(currentVehicle) then 
								-- TriggerServerEvent("carhud:ejection:server",GetVehicleNumberPlateText(currentVehicle))
								-- end		

								-- if not seatbelt and not IsThisModelABike(currentVehicle) then
									-- if math.random(math.ceil(lastFrameVehiclespeed)) > 110 then
										-- ejectionLUL()							
									-- end
								-- elseif seatbelt and not IsThisModelABike(currentVehicle) then
									-- if lastFrameVehiclespeed > 150 then
										-- if math.random(math.ceil(lastFrameVehiclespeed)) > 99 then
											-- ejectionLUL()							
										-- end
									-- end
								-- end
						-- else
							-- if not IsThisModelABike(currentVehicle) then 
								-- TriggerServerEvent("carhud:ejection:server",GetVehicleNumberPlateText(currentVehicle))
							-- end		

							-- if not seatbelt and not IsThisModelABike(currentVehicle) then
								-- if math.random(math.ceil(lastFrameVehiclespeed)) > 60 then
									-- ejectionLUL()							
								-- end
							-- elseif seatbelt and not IsThisModelABike(currentVehicle) then
								-- if lastFrameVehiclespeed > 120 then
									-- if math.random(math.ceil(lastFrameVehiclespeed)) > 99 then
										-- ejectionLUL()							
									-- end
								-- end
							-- end
						-- end
						-- damagedone = true		
						-- SetVehicleTyreBurst(currentVehicle, tireToBurst, true, 1000) 
						-- SetVehicleEngineHealth(currentVehicle, 0)
						-- SetVehicleEngineOn(currentVehicle, false, true, true)
						-- Citizen.Wait(1000)
						-- TriggerEvent("civilian:alertPolice",50.0,"carcrash",0)

					-- end

					-- if currentvehicleBodyHealth < 950.0 and not damagedone then
						-- damagedone = true
						-- SetVehicleBodyHealth(targetVehicle, 945.0)
						-- SetVehicleTyreBurst(currentVehicle, tireToBurst, true, 1000) 
						-- SetVehicleEngineHealth(currentVehicle, 0)
						-- SetVehicleEngineOn(currentVehicle, false, true, true)
						-- Citizen.Wait(1000)
					-- end

				-- end

				-- frameBodyChange = newvehicleBodyHealth - currentvehicleBodyHealth
				-- if tick > 0 then 
					-- tick = tick - 1
					-- if tick == 1 then
						-- lastFrameVehiclespeed = GetEntitySpeed(currentVehicle) * 3.6
					-- end
				-- else
					
					-- if damagedone then
						-- damagedone = false
						-- frameBodyChange = 0
						-- lastFrameVehiclespeed = GetEntitySpeed(currentVehicle) * 3.6
					-- end

					-- lastFrameVehiclespeed2 = GetEntitySpeed(currentVehicle) * 3.6
					-- if lastFrameVehiclespeed2 > lastFrameVehiclespeed then
						-- lastFrameVehiclespeed = GetEntitySpeed(currentVehicle) * 3.6
					-- end

					-- if lastFrameVehiclespeed2 < lastFrameVehiclespeed then
						-- tick = 25
					-- end

				-- end

				-- vels = GetEntityVelocity(currentVehicle)

				-- if tick < 0 then 
					-- tick = 0
				-- end		

				-- newvehicleBodyHealth = GetVehicleBodyHealth(currentVehicle)
				-- if not modifierDensity then
					-- modifierDensity = true
					-- TriggerEvent("DensityModifierEnable",modifierDensity)
				-- end
			-- else

				-- vels = GetEntityVelocity(currentVehicle)
				-- if modifierDensity then
					-- modifierDensity = false
					-- TriggerEvent("DensityModifierEnable",modifierDensity)
				-- end
			-- end

			-- veloc = GetEntityVelocity(currentVehicle)

		-- else

			-- if lastVehicle ~= nil then
				-- SetPedHelmet(playerPed, true)
				-- Citizen.Wait(200)
				-- newvehicleBodyHealth = GetVehicleBodyHealth(lastVehicle)

				-- if not damagedone and newvehicleBodyHealth < currentvehicleBodyHealth then
					-- damagedone = true					
					-- SetVehicleTyreBurst(lastVehicle, tireToBurst, true, 1000) 
					-- SetVehicleEngineHealth(lastVehicle, 0)
					-- SetVehicleEngineOn(lastVehicle, false, true, true)
					-- Citizen.Wait(1000)
				-- end

				-- lastVehicle = nil
				-- TriggerEvent("DensityModifierEnable",true)
			-- end
			-- lastFrameVehiclespeed2 = 0
			-- lastFrameVehiclespeed = 0
			-- newvehicleBodyHealth = 0
			-- currentvehicleBodyHealth = 0
			-- frameBodyChange = 0
			-- Citizen.Wait(1000)
		-- end
	-- end
-- end)

local movieBars = false 

RegisterCommand('movie', function(source, args)
 movieBars = not movieBars
 DecorSetBool(PlayerPedId(), 'hudStatus', not movieBars)
end)

Citizen.CreateThread(function()
 while true do 
  Citizen.Wait(5)

  if movieBars then 
   hideHudComponents()
   drawRct(0.000 + 0.0, -0.001 + 0.0, 1.0,0.15,0,0,0,255)
   drawRct(0.000 + 0.0, -0.001 + 0.85, 1.0,0.151,0,0,0,255) 
  else 
   Citizen.Wait(2500)
  end 
 end
end)

function drawRct(x, y, width, height)
 DrawRect(x + width/2, y + height/2, width, height, 0, 0, 0, 255)
end

function hideHudComponents()
 HideHelpTextThisFrame()
 HideHudAndRadarThisFrame()
 HideHudComponentThisFrame(1)
 HideHudComponentThisFrame(2)
 HideHudComponentThisFrame(3)
 HideHudComponentThisFrame(4)
 HideHudComponentThisFrame(6)
 HideHudComponentThisFrame(7)
 HideHudComponentThisFrame(8)
 HideHudComponentThisFrame(9)
 HideHudComponentThisFrame(13)
 HideHudComponentThisFrame(11)
 HideHudComponentThisFrame(12)
 HideHudComponentThisFrame(15)
 HideHudComponentThisFrame(18)
 HideHudComponentThisFrame(19)
end


function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
      RequestAnimDict( dict )
      Citizen.Wait( 0 )
    end
end

RegisterNetEvent('food:coffee')
AddEventHandler('food:coffee', function()
 local ped = PlayerPedId()
 Citizen.CreateThread(function()
  local x,y,z = table.unpack(GetEntityCoords(ped))
  prop = CreateObject(GetHashKey('p_ing_coffeecup_01'), x, y, z+0.2,  true,  true, true)
  AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, 18905), 0.13, 0.003, 0.019, 301.0, 112.0, 0.0, true, true, false, true, 1, true)
  RequestAnimDict('mp_player_intdrink')
  while not HasAnimDictLoaded('mp_player_intdrink') do
   Wait(0)
  end
  TaskPlayAnim(ped, 'mp_player_intdrink', 'loop_bottle', 8.0, -8, -1, 49, 0, 0, 0, 0)
  Wait(4500)
  thirst = 100
  ClearPedSecondaryTask(ped)
  DeleteObject(prop)
  updateStatus(hunger, thirst)
 end)
end)

RegisterNetEvent('food:eCola')
AddEventHandler('food:eCola', function()
 local ped = PlayerPedId()
 Citizen.CreateThread(function()
  local x,y,z = table.unpack(GetEntityCoords(ped))
  prop = CreateObject(GetHashKey('ng_proc_sodacan_01a'), x, y, z+0.2,  true,  true, true)
  AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, 18905), 0.08, -0.070, 0.040, 301.0, 112.0, 0.0, true, true, false, true, 1, true)
  RequestAnimDict('mp_player_intdrink')
  while not HasAnimDictLoaded('mp_player_intdrink') do
   Wait(0)
  end
  TaskPlayAnim(ped, 'mp_player_intdrink', 'loop_bottle', 8.0, -8, -1, 49, 0, 0, 0, 0)
  Wait(4500)
  thirst = 100
  ClearPedSecondaryTask(ped)
  DeleteObject(prop)
  updateStatus(hunger, thirst)
 end)
end)

RegisterNetEvent('food:sprunk')
AddEventHandler('food:sprunk', function()
 local ped = PlayerPedId()
 Citizen.CreateThread(function()
  local x,y,z = table.unpack(GetEntityCoords(ped))
  prop = CreateObject(GetHashKey('ng_proc_sodacan_01b'), x, y, z+0.2,  true,  true, true)
  AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, 18905), 0.08, -0.070, 0.040, 301.0, 112.0, 0.0, true, true, false, true, 1, true)
  RequestAnimDict('mp_player_intdrink')
  while not HasAnimDictLoaded('mp_player_intdrink') do
   Wait(0)
  end
  TaskPlayAnim(ped, 'mp_player_intdrink', 'loop_bottle', 8.0, -8, -1, 49, 0, 0, 0, 0)
  Wait(4500)
  thirst = 100
  ClearPedSecondaryTask(ped)
  DeleteObject(prop)
  updateStatus(hunger, thirst)
 end)
end)

RegisterNetEvent('food:donut')
AddEventHandler('food:donut', function()
 local donutprop = nil
 local donutrnd = math.random(1,2)
 if donutrnd == 1 then
  donutprop = 'prop_donut_01'
 elseif donutrnd == 2 then
  donutprop = 'prop_donut_02'
 end

 local ped = PlayerPedId()
 Citizen.CreateThread(function()
  local x,y,z = table.unpack(GetEntityCoords(ped))
  local prop = CreateObject(GetHashKey(donutprop), x, y, z+0.2,  true,  true, true)
  AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, 18905), 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
  RequestAnimDict('mp_player_inteat@burger')
  while not HasAnimDictLoaded('mp_player_inteat@burger') do
   Wait(0)
  end
  TaskPlayAnim(ped, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 8.0, -8, -1, 49, 0, 0, 0, 0)
  Wait(4500)
  local newHunger = 0
  Wait(10)
  if hunger+70 >= 100 then
    newHunger = 100
  else
    newHunger = hunger+20
  end
  hunger = newHunger
  ClearPedSecondaryTask(ped)
  DeleteObject(prop)
  updateStatus(hunger, thirst)
  end)
end)



RegisterNetEvent('food:cheeseburger')
AddEventHandler('food:cheeseburger', function()
 local ped = PlayerPedId()
 Citizen.CreateThread(function()
  local x,y,z = table.unpack(GetEntityCoords(ped))
  local prop = CreateObject(GetHashKey('prop_cs_burger_01'), x, y, z+0.2,  true,  true, true)
  AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, 18905), 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
  RequestAnimDict('mp_player_inteat@burger')
  while not HasAnimDictLoaded('mp_player_inteat@burger') do
   Wait(0)
  end
  TaskPlayAnim(ped, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 8.0, -8, -1, 49, 0, 0, 0, 0)
  Wait(4500)
  if hunger+80 >= 100 then
    newHunger = 100
  else
    newHunger = hunger+80
  end
  hunger = newHunger
  ClearPedSecondaryTask(ped)
  DeleteObject(prop)
  updateStatus(hunger, thirst) 
  end)
end)

RegisterNetEvent('food:burger')
AddEventHandler('food:burger', function()
 local ped = PlayerPedId()
 Citizen.CreateThread(function()
  local x,y,z = table.unpack(GetEntityCoords(ped))
  local prop = CreateObject(GetHashKey('prop_cs_burger_01'), x, y, z+0.2,  true,  true, true)
  AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, 18905), 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
  RequestAnimDict('mp_player_inteat@burger')
  while not HasAnimDictLoaded('mp_player_inteat@burger') do
   Wait(0)
  end
  TaskPlayAnim(ped, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 8.0, -8, -1, 49, 0, 0, 0, 0)
  Wait(4500)
  local newHunger = 0
  Wait(10)
  if hunger+50 >= 100 then
    newHunger = 100
  else
    newHunger = hunger+50
  end
  hunger = newHunger
  ClearPedSecondaryTask(ped)
  DeleteObject(prop)
  updateStatus(hunger, thirst)
  end)
end)

RegisterNetEvent('food:hotdog')
AddEventHandler('food:hotdog', function()
 local ped = PlayerPedId()
 Citizen.CreateThread(function()
  local x,y,z = table.unpack(GetEntityCoords(ped))
  local prop = CreateObject(GetHashKey('prop_cs_hotdog_01'), x, y, z+0.2,  true,  true, true)
  AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, 18905), 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
  RequestAnimDict('mp_player_inteat@burger')
  while not HasAnimDictLoaded('mp_player_inteat@burger') do
   Wait(0)
  end
  TaskPlayAnim(ped, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 8.0, -8, -1, 49, 0, 0, 0, 0)
  Wait(4500)
  local newHunger = 0
  Wait(10)
  if hunger+30 >= 100 then
    newHunger = 100
  else
    newHunger = hunger+30
  end
  hunger = newHunger
  ClearPedSecondaryTask(ped)
  DeleteObject(prop)
  updateStatus(hunger, thirst) 
  end)
end)

RegisterNetEvent('food:sandwich')
AddEventHandler('food:sandwich', function()
 local ped = PlayerPedId()
 Citizen.CreateThread(function()
  local x,y,z = table.unpack(GetEntityCoords(ped))
  local prop = CreateObject(GetHashKey('prop_sandwich_01'), x, y, z+0.2,  true,  true, true)
  AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, 18905), 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
  RequestAnimDict('mp_player_inteat@burger')
  while not HasAnimDictLoaded('mp_player_inteat@burger') do
   Wait(0)
  end
  TaskPlayAnim(ped, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 8.0, -8, -1, 49, 0, 0, 0, 0)
  Wait(4500)
  local newHunger = 0
  Wait(10)
  hunger = 100
  ClearPedSecondaryTask(ped)
  DeleteObject(prop)
  updateStatus(hunger, thirst) 
  end)
end)

RegisterNetEvent('food:drink')
AddEventHandler('food:drink', function()
 local ped = PlayerPedId()
 Citizen.CreateThread(function()
  local x,y,z = table.unpack(GetEntityCoords(ped))
  prop = CreateObject(GetHashKey('prop_ld_flow_bottle'), x, y, z+0.2,  true,  true, true)     
  AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, 18905), 0.13, 0.003, 0.019, 301.0, 112.0, 0.0, true, true, false, true, 1, true)
  RequestAnimDict('mp_player_intdrink')  
  while not HasAnimDictLoaded('mp_player_intdrink') do
   Wait(0)
  end
  TaskPlayAnim(ped, 'mp_player_intdrink', 'loop_bottle', 8.0, -8, -1, 49, 0, 0, 0, 0)
  Wait(4500)
  thirst = 100
  ClearPedSecondaryTask(ped)
  DeleteObject(prop)
  updateStatus(hunger, thirst) 
 end)
end)

