local group = 'user'
local frozen = false

RegisterNetEvent('admin:setGroup')
AddEventHandler('admin:setGroup', function(g)
 group = g
end)

RegisterNetEvent('admin:spawnVehicle')
AddEventHandler('admin:spawnVehicle', function(v)
 local carid = GetHashKey(v)
 local playerPed = GetPlayerPed(-1)
 if playerPed and playerPed ~= -1 then
  RequestModel(carid)
  while not HasModelLoaded(carid) do
   Citizen.Wait(0)
  end
  local playerCoords = GetEntityCoords(playerPed)
  veh = CreateVehicle(carid, playerCoords, 0.0, true, false)
  SetVehicleAsNoLongerNeeded(veh)
  TaskWarpPedIntoVehicle(playerPed, veh, -1)
  SetVehicleEngineOn(veh, true)
 end
end)

RegisterNetEvent('admin:setModel')
AddEventHandler('admin:setModel', function(model)
 local model = GetHashKey(model)
 RequestModel(model)
 while not HasModelLoaded(model) do
  RequestModel(model)
  Citizen.Wait(0)
 end
 SetPlayerModel(PlayerId(), model)
 SetModelAsNoLongerNeeded(model)
 SetPedRandomComponentVariation(GetPlayerPed(-1), true)
end)

RegisterNetEvent('admin:freezePlayer')
AddEventHandler("admin:freezePlayer", function(state)
 local player = PlayerId()
 local ped = GetPlayerPed(-1)
 frozen = state
 if not state then
  SetEntityVisible(ped, true)
  SetEntityCollision(ped, true)
  FreezeEntityPosition(ped, false)
  SetPlayerInvincible(player, false)
 else
  SetEntityCollision(ped, false)
  FreezeEntityPosition(ped, true)
  SetPlayerInvincible(player, true)
 end
end)

RegisterNetEvent('admin:teleport')
AddEventHandler('admin:teleport', function(pos)
 pos.x = pos.x + 0.0
 pos.y = pos.y + 0.0
 pos.z = pos.z + 0.0
 RequestCollisionAtCoord(pos.x, pos.y, pos.z)
 while not HasCollisionLoadedAroundEntity(GetPlayerPed(-1)) do
  RequestCollisionAtCoord(pos.x, pos.y, pos.z)
  Citizen.Wait(1)
 end
 SetEntityCoords(GetPlayerPed(-1), pos.x, pos.y, pos.z)
end)

RegisterNetEvent('admin:kill')
AddEventHandler('admin:kill', function()
 SetEntityHealth(GetPlayerPed(-1), 0)
end)

RegisterNetEvent('admin:crash')
AddEventHandler('admin:crash', function()
 while true do
 end
end)
--========================================================================================--
--===================================== Commands =========================================--
--========================================================================================--
RegisterCommand('pos', function(source, args, rawCommand)
 if user ~= 'user' then
  local pos = GetEntityCoords(GetPlayerPed(-1))
  local string = "{coords = {x = "..string.format("%.3f", pos.x)..", y = "..string.format("%.3f", pos.y)..", z = "..string.format("%.3f", pos.z).."}, heading = "..string.format("%.3f", GetEntityHeading(GetPlayerPed(-1))).."}"
  TriggerServerEvent('admin:savecoords', string)
  --exports.pNotify:SendNotification({text = "Posición guardada en archivo!"})
  exports['clrp_notify']:DoLongHudText ('success', 'Posición guardada en archivo')
 end
end)

RegisterCommand('cleararea', function(source, args, rawCommand)
 if group ~= 'user' then
  local pos = GetEntityCoords(GetPlayerPed(-1)) 
  ClearAreaOfVehicles(pos.x, pos.y, pos.z, 250.0, false, false, false, false, false)
  ClearAreaOfPeds(pos.x, pos.y, pos.z, 250.0, 1)
  --exports.pNotify:SendNotification({text = "El área ha sido despejada!"})
  exports['clrp_notify']:DoLongHudText ('success', 'El área ha sido despejada!')
 end
end)

RegisterCommand('dv', function(source, args, rawCommand)
 if user ~= 'user' then
  local ped = GetPlayerPed(-1)
  local pos = GetEntityCoords(ped)
  if IsPedSittingInAnyVehicle(ped) then 
   local vehicle = GetVehiclePedIsIn(ped, false)
   SetEntityAsMissionEntity(vehicle, true, true)
   Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle))
   exports.pNotify:SendNotification({text = "Vehículo eliminado"})
  else
   local pos = GetEntityCoords(GetPlayerPed(-1), false)
   local vehicle = GetClosestVehicle(pos.x, pos.y, pos.z, 5.0, 0, 71)
   if DoesEntityExist(vehicle) then 
    SetEntityAsMissionEntity(vehicle, true, true)
    Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle))
    exports.pNotify:SendNotification({text = "Vehículo eliminado"})
   else 
    exports.pNotify:SendNotification({text = "Ningún vehículo cerca de ti"})
   end 
  end 
 end
end)

local isInTrunk = false

RegisterCommand('trunk', function(source, args, rawCommand)
 local pos = GetEntityCoords(GetPlayerPed(-1), false)
 local vehicle = GetClosestVehicle(pos.x, pos.y, pos.z, 5.0, 0, 71)
 if DoesEntityExist(vehicle) then 
  if not isInTrunk then
   AttachEntityToEntity(GetPlayerPed(-1), vehicle, -1, 0.0, -2.2, 0.5, 0.0, 0.0, 0.0, false, false, false, false, 20, true)		
   RaiseConvertibleRoof(vehicle, false)
   if IsEntityAttached(GetPlayerPed(-1)) then
    RequestAnimDict('timetable@floyd@cryingonbed@base')
    while not HasAnimDictLoaded('timetable@floyd@cryingonbed@base') do
     Citizen.Wait(1)
    end      			
    TaskPlayAnim(GetPlayerPed(-1), 'timetable@floyd@cryingonbed@base', 'base', 1.0, -1, -1, 1, 0, 0, 0, 0)	
   end    
  else
   DetachEntity(GetPlayerPed(-1), 0, true)
   SetEntityVisible(GetPlayerPed(-1), true)
   ClearPedTasksImmediately(GetPlayerPed(-1))
  end
  isInTrunk = not isInTrunk
 else 
  exports.pNotify:SendNotification({text = "Ningún vehículo cerca de ti"})
 end 
end)

RegisterCommand('agun', function(source, args, rawCommand)
 if user ~= 'user' then
  GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_AUTOSHOTGUN"), 5000, false, true)
  SetPedInfiniteAmmo(GetPlayerPed(-1), true, GetHashKey("WEAPON_AUTOSHOTGUN"))
 end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    local hash = GetSelectedPedWeapon(GetPlayerPed(-1))
    if group ~= "user" then
      if IsPlayerFreeAiming(PlayerId()) and hash == 317205821 then
        local entity = getEntity(PlayerId())
        if IsPedShooting(GetPlayerPed(-1)) then
          SetEntityAsMissionEntity(entity, true, true)
          DeleteEntity(entity)
        end
      end
    end
  end
end)

function getEntity(player) --Function To Get Entity Player Is Aiming At
  local result, entity = GetEntityPlayerIsFreeAimingAt(player)
  return entity
end


--========================================================================================--
--=================================== Logging Out ========================================--
--========================================================================================--
DecorRegister("isLoggingOut", 2)
DecorSetBool(GetPlayerPed(-1), "isLoggingOut", false)
local isLoggingOut = false
local LoggingTime = 0

RegisterCommand('logout', function(source, args, rawCommand)
 if group == 'user' and not IsEntityDead(GetPlayerPed(-1)) and not IsPedCuffed(GetPlayerPed(-1)) then
  isLoggingOut = true 	
  LoggingTime = 60
  RequestAnimDict('mp_player_int_uppersalute') 
  while not HasAnimDictLoaded('mp_player_int_uppersalute') do 
   Citizen.Wait(1) 
  end
  TaskPlayAnim(GetPlayerPed(-1), 'mp_player_int_uppersalute', 'mp_player_int_salute', 3.0, -1, -1, 63, 1, false, false, false)
  FreezeEntityPosition(GetPlayerPed(-1), true)
  DecorSetBool(GetPlayerPed(-1), "isLoggingOut", true)
 end
end)

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(5)
  if isLoggingOut then 
   drawTxt('~y~Saliendo de tu cuenta: ~w~'..LoggingTime.." ~y~Segundos")
   if IsControlJustPressed(0, 38) then 
    isLoggingOut = false
    ClearPedTasksImmediately(GetPlayerPed(-1))
    DecorSetBool(GetPlayerPed(-1), "isLoggingOut", false)
    FreezeEntityPosition(GetPlayerPed(-1), false)
   end
  end
 end
end)

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(1000)
  if isLoggingOut then 
   if LoggingTime > 0 then 
    LoggingTime = LoggingTime - 1 
   end
   if LoggingTime == 1 then 
    ClearPedTasksImmediately(GetPlayerPed(-1))
    DecorSetBool(GetPlayerPed(-1), "isLoggingOut", false)
    TriggerServerEvent('admin:logout')
    isLoggingOut = false
    FreezeEntityPosition(GetPlayerPed(-1), false)
   end
  end
 end
end)

--========================================================================================--
--=================================== Spectating =========================================--
--========================================================================================--
local weapons = {[453432689] = "PISTOL",[3219281620] = "PISTOL MK2",[1593441988] = "COMBAT PISTOL",[584646201] = "AP PISTOL",[2578377531] = "PISTOL .50",[324215364] = "MICRO SMG",[736523883] = "SMG",[2024373456] = "SMG MK2",[4024951519] = "ASSAULT SMG",[3220176749] = "ASSAULT RIFLE",[961495388] = "ASSAULT RIFLE MK2",[2210333304] = "CARBINE RIFLE",[4208062921] = "CARBINE RIFLE MK2",[2937143193] = "ADVANCED RIFLE",[2634544996] = "MG",[2144741730] = "COMBAT MG",[3686625920] = "COMBAT MG MK2",[487013001] = "PUMP SHOTGUN",[1432025498] = "PUMP SHOTGUN MK2",[2017895192] = "SAWNOFF SHOTGUN",[3800352039] = "ASSAULT SHOTGUN",[2640438543] = "BULLPUP SHOTGUN",[100416529] = "SNIPER RIFLE",[205991906] = "HEAVY SNIPER",[177293209] = "HEAVY SNIPER MK2",[856002082] = "REMOTE SNIPER",[2726580491] = "GRENADE LAUNCHER",[1305664598] = "GRENADE LAUNCHER SMOKE",[2982836145] = "RPG",[1752584910] = "STINGER",[1119849093] = "MINIGUN",[3218215474] = "SNS PISTOL",[2009644972] = "SNS PISTOL MK2",[1627465347] = "GUSENBERG",[3231910285] = "SPECIAL CARBINE",[-1768145561] = "SPECIAL CARBINE MK2",[3523564046] = "HEAVY PISTOL",[2132975508] = "BULLPUP RIFLE",[-2066285827] = "BULLPUP RIFLE MK2",[137902532] = "VINTAGE PISTOL",[-1746263880] = "DOUBLE ACTION REVOLVER",[2828843422] = "MUSKET",[984333226] = "HEAVY SHOTGUN",[3342088282] = "MARKSMAN RIFLE",[1785463520] = "MARKSMAN RIFLE MK2",[1198879012] = "FLARE GUN",[171789620] = "COMBAT PDW",[3696079510] = "MARKSMAN PISTOL",[1834241177] = "RAILGUN",[3675956304] = "MACHINE PISTOL",[3249783761] = "REVOLVER",[-879347409] = "REVOLVER MK2",[4019527611] = "DOUBLE BARREL SHOTGUN",[1649403952] = "COMPACT RIFLE",[317205821] = "AUTO SHOTGUN",[125959754] = "COMPACT LAUNCHER",[3173288789] = "MINI SMG",}
local Spectating = {}
local InSpectatorMode = false
local TargetSpectate = nil
local LastPosition = nil
local polarAngleDeg = 0;
local azimuthAngleDeg = 90;
local radius = -3.5;
local cam = nil
local targetinfo = {}

function polar3DToWorld3D(entityPosition, radius, polarAngleDeg, azimuthAngleDeg)    
 local polarAngleRad   = polarAngleDeg   * math.pi / 180.0
 local azimuthAngleRad = azimuthAngleDeg * math.pi / 180.0
 local pos = {
  x = entityPosition.x + radius * (math.sin(azimuthAngleRad) * math.cos(polarAngleRad)),
  y = entityPosition.y - radius * (math.sin(azimuthAngleRad) * math.sin(polarAngleRad)),
  z = entityPosition.z - radius * math.cos(azimuthAngleRad)
 }
 return pos
end

function spectate(target)
 local ped = GetPlayerPed(-1)
 if not InSpectatorMode then
  LastPosition = GetEntityCoords(ped)
 end
 SetEntityCollision(ped, false, false)
 SetEntityVisible(ped, false)
 Citizen.CreateThread(function() 
  if not DoesCamExist(cam) then
   cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
  end
  SetCamActive(cam, true)
  RenderScriptCams(true, false, 0, true, true)
  InSpectatorMode = true
  TargetSpectate = target
  end)
end

function resetNormalCamera()
 local ped = GetPlayerPed(-1)
 InSpectatorMode = false
 TargetSpectate = nil
 SetCamActive(cam, false)
 RenderScriptCams(false, false, 0, true, true)
 SetEntityCollision(ped, true, true)
 SetEntityVisible(ped, true) 
 SetEntityCoords(ped, LastPosition.x, LastPosition.y, LastPosition.z)
end

AddEventHandler('playerSpawned', function()
 TriggerServerEvent('spectate:requestSpectating')
end)

RegisterNetEvent('spectate:spectate')
AddEventHandler('spectate:spectate', function(target, targinfo)
 if InSpectatorMode and target == -1 then
  resetNormalCamera()
 end
 if target ~= -1 then
  spectate(target)
  targetinfo = targinfo
 end
end)

RegisterNetEvent('spectate:onSpectate')
AddEventHandler('spectate:onSpectate', function(spectating)
 Spectating = spectating
end)

Citizen.CreateThread(function()
 while true do
  Wait(0)
  if InSpectatorMode then
   local targetPlayerId = GetPlayerFromServerId(TargetSpectate)
   local playerPed = GetPlayerPed(-1)
   local targetPed = GetPlayerPed(targetPlayerId)
   local coords = GetEntityCoords(targetPed)
   local xMagnitude = GetDisabledControlNormal(0,  1);
   local yMagnitude = GetDisabledControlNormal(0,  2);
   local data = targetinfo 
   azimuthAngleDeg = azimuthAngleDeg + yMagnitude * 10;
   polarAngleDeg = polarAngleDeg + xMagnitude * 10;
   
   for i=0, 256, 1 do
    if i ~= PlayerId() then
     local otherPlayerPed = GetPlayerPed(i)
     SetEntityNoCollisionEntity(playerPed,  otherPlayerPed,  true)
    end
   end

   if IsControlPressed(2, 241) then
    radius = radius + 0.5;
   elseif IsControlPressed(2, 242) then
    radius = radius - 0.5;
   end
   
   if radius > -1 then
    radius = -1
   elseif polarAngleDeg >= 360 then
    polarAngleDeg = 0
   elseif azimuthAngleDeg >= 360 then
    azimuthAngleDeg = 0;
   end

   local nextCamLocation = polar3DToWorld3D(coords, radius, polarAngleDeg, azimuthAngleDeg)

   SetCamCoord(cam,  nextCamLocation.x,  nextCamLocation.y,  nextCamLocation.z)
   PointCamAtEntity(cam,  targetPed)
   SetEntityCoords(playerPed,  coords.x, coords.y, coords.z + 10)
   
   DrawRect(0.850, 0.1250, 0.130, 0.130, 0, 0, 0, 155)
   drawUI(1.300, 0.580, 1.0, 1.0, 0.45, "~b~NAME ~w~"..data.id.fullname, 255, 255, 255, 255, false)
   drawUI(1.300, 0.620, 1.0, 1.0, 0.45, "~g~BANK ~g~$~w~"..data.bank, 255, 255, 255, 255, false)
   drawUI(1.300, 0.600, 1.0, 1.0, 0.45, "~g~WALLET ~g~$~w~"..data.money, 255, 255, 255, 255, false)
   if IsPedInAnyVehicle(targetPed, false) then 
    local vehicle = GetVehiclePedIsIn(targetPed, false)
    --local speed = math.floor(GetEntitySpeed(vehicle) * 2.236936)
    local speed = math.floor(GetEntitySpeed(vehicle) * 3.6)	
    drawUI(1.300, 0.640, 1.0, 1.0, 0.45, "~y~SPEED ~w~"..speed.." KMH", 255, 255, 255, 255, false)
   --[[else
    local status, hash = GetCurrentPedWeapon(targetPed)
    if status then
     drawUI(1.300, 0.640, 1.0, 1.0, 0.45, "~y~WEAPON ~w~"..weapons[hash].."", 255, 255, 255, 255, false)]]--- Error (field '?')
   end
  end
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

function drawTxt(text)
  SetTextFont(4)
  SetTextProportional(0)
  SetTextScale(0.7, 0.8)
  SetTextCentre(1)
  SetTextColour(255, 255, 255, 255)
  SetTextDropShadow(0, 0, 0, 0,255)
  SetTextEdge(1, 0, 0, 0, 255)
  SetTextDropShadow()
  SetTextOutline()
  SetTextCentre(1)
  SetTextEntry("STRING")
  AddTextComponentString(text)
  DrawText(0.5 , 0.93)  
end

function stringsplit(inputstr, sep)
  if (sep == nil) then
    sep = "%s"
  end

  local t = {} ; i = 1
  
  for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
    t[i] = str
    i = i + 1
  end

  return t
end

function trim(s)
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end






-----------------------------
-----  Instance Checker -----
-----------------------------
local myPlayers = {}
local queueCount = 0
local time = 900

Citizen.CreateThread(function()
 while true do
  Wait(30000)
  myPlayers = {} 
  -- Checking 
  for i = 0, 256 do
   if NetworkIsPlayerActive(i) then
    table.insert(myPlayers, i)
   end
  end
  TriggerServerEvent('instance:check', myPlayers)
 end
end)

Citizen.CreateThread(function()
 while true do
  Wait(1000)
  currentPos = GetEntityCoords(PlayerPedId(), true)
  if currentPos == prevPos and queueCount >= 5 and not IsEntityDead(PlayerPedId()) then
   if time > 0 then
    if time == math.ceil(900/4) then
     TriggerEvent("chatMessage", "WARNING", {255, 0, 0}, "^1Serás pateado en "..math.floor(time/60).." minutos para ser AFK!")
    end
    time = time - 1
   else
    TriggerServerEvent("afk:kick")
   end
  else
   time = 900
   prevPos = currentPos
  end
 end
end)

RegisterNetEvent('debug:queueCount')
AddEventHandler('debug:queueCount', function(count)
 queueCount = count
end)

-- Pushing 
local First = vector3(0.0, 0.0, 0.0)
local Second = vector3(5.0, 5.0, 5.0)

local Vehicle = {Coords = nil, Vehicle = nil, Dimension = nil, IsInFront = false, Distance = nil}
Citizen.CreateThread(function()
    Citizen.Wait(200)
    while true do
        local ped = PlayerPedId()
        local posped = GetEntityCoords(GetPlayerPed(-1))
        local entityWorld = GetOffsetFromEntityInWorldCoords(ped, 0.0, 20.0, 0.0)
        local rayHandle = CastRayPointToPoint(posped.x, posped.y, posped.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, ped, 0)
        local a, b, c, d, closestVehicle = GetRaycastResult(rayHandle)
        local Distance = GetDistanceBetweenCoords(c.x, c.y, c.z, posped.x, posped.y, posped.z, false);

        local vehicleCoords = GetEntityCoords(closestVehicle)
        local dimension = GetModelDimensions(GetEntityModel(closestVehicle), First, Second)
        if Distance < 6.0  and not IsPedInAnyVehicle(ped, false) then
            Vehicle.Coords = vehicleCoords
            Vehicle.Dimensions = dimension
            Vehicle.Vehicle = closestVehicle
            Vehicle.Distance = Distance
            if GetDistanceBetweenCoords(GetEntityCoords(closestVehicle) + GetEntityForwardVector(closestVehicle), GetEntityCoords(ped), true) > GetDistanceBetweenCoords(GetEntityCoords(closestVehicle) + GetEntityForwardVector(closestVehicle) * -1, GetEntityCoords(ped), true) then
                Vehicle.IsInFront = false
            else
                Vehicle.IsInFront = true
            end
        else
            Vehicle = {Coords = nil, Vehicle = nil, Dimensions = nil, IsInFront = false, Distance = nil}
        end
        Citizen.Wait(500)
    end
end)


RegisterCommand('push', function(source, args, rawCommand)
    local ped = PlayerPedId()
    if Vehicle.Vehicle ~= nil then
        if IsVehicleSeatFree(Vehicle.Vehicle, -1) and not IsEntityAttachedToEntity(ped, Vehicle.Vehicle) then
            NetworkRequestControlOfEntity(Vehicle.Vehicle)
            local coords = GetEntityCoords(ped)
            if Vehicle.IsInFront then    
                AttachEntityToEntity(PlayerPedId(), Vehicle.Vehicle, GetPedBoneIndex(6286), 0.0, Vehicle.Dimensions.y * -1 + 0.1 , Vehicle.Dimensions.z + 1.0, 0.0, 0.0, 180.0, 0.0, false, false, true, false, true)
            else
                AttachEntityToEntity(PlayerPedId(), Vehicle.Vehicle, GetPedBoneIndex(6286), 0.0, Vehicle.Dimensions.y - 0.3, Vehicle.Dimensions.z  + 1.0, 0.0, 0.0, 0.0, 0.0, false, false, true, false, true)
            end

            RequestAnimDict('missfinale_c2ig_11')
            TaskPlayAnim(ped, 'missfinale_c2ig_11', 'pushcar_offcliff_m', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
            Citizen.Wait(200)
             while true do
                Citizen.Wait(5)
                if IsControlJustPressed(0, 34) then
                    TaskVehicleTempAction(PlayerPedId(), Vehicle.Vehicle, 11, 1000)
                end

                if IsControlJustPressed(0, 9) then
                    TaskVehicleTempAction(PlayerPedId(), Vehicle.Vehicle, 10, 1000)
                end

                if Vehicle.IsInFront then
                    SetVehicleForwardSpeed(Vehicle.Vehicle, -1.0)
                else
                    SetVehicleForwardSpeed(Vehicle.Vehicle, 1.0)
                end

                if HasEntityCollidedWithAnything(Vehicle.Vehicle) then
                    SetVehicleOnGroundProperly(Vehicle.Vehicle)
                end

                if IsControlJustPressed(0, 38) then
                    DetachEntity(ped, false, false)
                    StopAnimTask(ped, 'missfinale_c2ig_11', 'pushcar_offcliff_m', 2.0)
                    FreezeEntityPosition(ped, false)
                    break
                end
            end
        end
    end
end)