-- /gps
RegisterCommand('gps', function(source, args, rawCommand)
 if args[1] == nil then 
  local pos = GetEntityCoords(GetPlayerPed(-1))
  TriggerEvent('chatMessage', '^5Latitude: ^3'..string.format("%.3f", pos.x).." ^0| ^5Longitude: ^3"..string.format("%.3f", pos.y))
 elseif args[1] == 'waypoint' or args[1] == 'Waypoint' then 
  if IsWaypointActive() then 
   local waypointBlip = GetFirstBlipInfoId(8) -- 8 = Waypoint ID
   local x,y,z = table.unpack(Citizen.InvokeNative(0xFA7C7F0AADF25D09, waypointBlip, Citizen.ResultAsVector())) 
   TriggerEvent('chatMessage', '^5Latitude: ^3'..string.format("%.3f", x).." ^0| ^5Longitude: ^3"..string.format("%.3f", y))
  else
   TriggerEvent('chatMessage', '^1No Waypoint')
  end
 else
  SetNewWaypoint(tonumber(args[1]), tonumber(args[2]))
  local waypointBlip = GetFirstBlipInfoId(8) -- 8 = Waypoint ID
  local x,y,z = table.unpack(Citizen.InvokeNative(0xFA7C7F0AADF25D09, waypointBlip, Citizen.ResultAsVector())) 
  local var1, var2 = GetStreetNameAtCoord(x, y, z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
  TriggerEvent('chatMessage', '^5Street Name: ^3'..GetStreetNameFromHashKey(var1))
 end
end)


-- Peds
Citizen.CreateThread(function()
 spawnHospitalWorkers()
end)

-- Hospital Peds
local doctorWho = nil
local nurseWho = nil
local shopKeeper = nil


function spawnHospitalWorkers()
 if doctorWho == nil then
  RequestModel(GetHashKey('s_m_m_doctor_01'))
  while not HasModelLoaded(GetHashKey('s_m_m_doctor_01')) do
   Wait(1)
  end

  doctorWho = CreatePed(2, GetHashKey('s_m_m_doctor_01'), 308.418, -595.099, 43.284, 13.582, false, false)
  SetPedFleeAttributes(doctorWho, 0, 0)
  SetPedDiesWhenInjured(doctorWho, false)
  TaskStartScenarioInPlace(doctorWho, "WORLD_HUMAN_CLIPBOARD", 0, true)
  SetPedKeepTask(doctorWho, true)
 end
 if nurseWho == nil then 
  RequestModel(GetHashKey('s_f_y_scrubs_01'))
  while not HasModelLoaded(GetHashKey('s_f_y_scrubs_01')) do
   Wait(1)
  end

  nurseWho = CreatePed(2, GetHashKey('s_f_y_scrubs_01'), 319.894, -586.301, 43.284, 340.769, false, false)
  SetPedFleeAttributes(nurseWho, 0, 0)
  SetPedDiesWhenInjured(nurseWho, false)
  SetPedKeepTask(nurseWho, true)
 end
 -- if shopKeeper == nil then 
  -- RequestModel(GetHashKey('mp_m_shopkeep_01'))
  -- while not HasModelLoaded(GetHashKey('mp_m_shopkeep_01')) do
   -- Wait(1)
  -- end

  -- shopKeeper = CreatePed(2, GetHashKey('mp_m_shopkeep_01'), 316.434, -587.124, 43.292, 177.200, false, false)
  -- SetPedFleeAttributes(shopKeeper, 0, 0)
  -- SetPedDiesWhenInjured(shopKeeper, false)
  -- SetPedKeepTask(shopKeeper, true)
 -- end
end

-- Weed Seller
local weedSellerPed = {}  
local weedSeller = {
 [1] = {x = 82.281, y = -1962.868, z = 17.836}, -- ballas
 [2] = {x = 977.499, y = -101.065, z = 74.845}, -- Moteros Area
 [3] = {x = -17.165, y = -1430.232, z = 31.102}, -- vende Area
 [4] = {x = 974.115, y = -1842.339, z = 36.107}, --vagos
}


Citizen.CreateThread(function()
 spawnWeedDealer()
 while true do
  Wait(5)
  if DecorGetInt(GetPlayerPed(-1), "faction") == 229 or DecorGetInt(GetPlayerPed(-1), "faction") == 234 or DecorGetInt(GetPlayerPed(-1), "faction") == 212 or DecorGetInt(GetPlayerPed(-1), "Job") == 29 or DecorGetInt(GetPlayerPed(-1), "Job") == 30 then
  for i,v in pairs(weedSeller) do 
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 3.0) then
    drawTxt('~b~Press ~g~E~b~ To Buy 1x Weed Seed [$200]')
    if IsControlJustPressed(0, 38) then 
     TriggerServerEvent('weed:sellSeed', 200)
	 exports.pNotify:SendNotification({text = "<font color='lightgreen'> +1 Semilla de Marihuena"})
    end
   end
  end
  end
 end
end)

function spawnWeedDealer()
 for i,v in pairs(weedSeller) do 
  if not DoesEntityExist(weedSellerPed[i]) then
   RequestModel(GetHashKey('g_m_y_famDNF_01'))
   while not HasModelLoaded(GetHashKey('g_m_y_famDNF_01')) do
    Wait(1)
   end 

   weedSellerPed[i] = CreatePed(2, GetHashKey('g_m_y_famDNF_01'), v.x, v.y, v.z, 90.0, false, false)
   SetPedFleeAttributes(weedSellerPed[i], 0, 0)
   SetPedDiesWhenInjured(weedSellerPed[i], false)
   TaskStartScenarioInPlace(weedSellerPed[i], "WORLD_HUMAN_DRUG_DEALER", 0, true)
   SetPedKeepTask(weedSellerPed[i], true)
  end
 end
end

-- coke Seller
local cokeSellerPed = {}  
local cokeSeller = {
 --[1] = {x = -1148.286, y = -1512.881, z = 10.633, h = 199.816}, -- Legion Area Bloke
 --[2] = {x = -11.716, y = -1478.345, z = 30.501, h = 317.349}, -- Jamestown Area
 --[3] = {x = -1169.923, y = -1168.850, z = 5.625, h = 336.503}, -- McDonald Street Area
}


Citizen.CreateThread(function()
 spawncokeDealer()
 --spawnNoTresspassing()
 while true do
  Wait(5)
  for i,v in pairs(cokeSeller) do 
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 3.0) then
    drawTxt('~b~Pulse ~g~E~b~ Para comprar 1x semillas de cocaina [$750]')
    if IsControlJustPressed(0, 38) then 
     TriggerServerEvent('coke:sellSemilla', 750)
	 exports.pNotify:SendNotification({text = "<font color='lightgreen'> +1 Semilla de Cocaina"})
    end
   end
  end
 end
end)

function spawncokeDealer()
 for i,v in pairs(cokeSeller) do 
  if not DoesEntityExist(cokeSellerPed[i]) then
   RequestModel(GetHashKey('g_m_y_famDNF_01'))
   while not HasModelLoaded(GetHashKey('g_m_y_famDNF_01')) do
    Wait(1)
   end 

   cokeSellerPed[i] = CreatePed(2, GetHashKey('g_m_y_famDNF_01'), v.x, v.y, v.z, 90.0, false, false)
   SetPedFleeAttributes(cokeSellerPed[i], 0, 0)
   SetPedDiesWhenInjured(cokeSellerPed[i], false)
   TaskStartScenarioInPlace(cokeSellerPed[i], "WORLD_HUMAN_DRUG_DEALER", 0, true)
   SetPedKeepTask(cokeSellerPed[i], true)
  end
 end
end

-- Chopped Parts Sell Point
local chopSellerPed = {}  
local chopSeller = {
 [1] = {x = 1697.793, y = 3703.066, z = 34.297, h = 170.825}, 
}


Citizen.CreateThread(function()
 chopDealer()
 while true do
  Wait(5)
  for i,v in pairs(chopSeller) do 
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 2.0) then
    drawTxt('~b~Press ~g~E~b~ To Sell Your Chopped Parts')
    if IsControlJustPressed(0, 38) then 
     if math.random(1,10) > 4 then
      TriggerServerEvent('chop:sellParts')
     else
      TriggerEvent("dispatch:illegalActivity")
     end
    end
   end
  end
 end
end)

function chopDealer()
 for i,v in pairs(chopSeller) do 
  if not DoesEntityExist(chopSellerPed[i]) then
   RequestModel(GetHashKey('ig_benny'))
   while not HasModelLoaded(GetHashKey('ig_benny')) do
    Wait(1)
   end 

   chopSellerPed[i] = CreatePed(2, GetHashKey('ig_benny'), v.x, v.y, v.z, v.h, false, false)
   SetPedFleeAttributes(chopSellerPed[i], 0, 0)
   SetPedDiesWhenInjured(chopSellerPed[i], false)
   TaskStartScenarioInPlace(chopSellerPed[i], "WORLD_HUMAN_STAND_MOBILE", 0, true)
   SetPedKeepTask(chopSellerPed[i], true)
  end
 end
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

-- Race  
local IsRacing = false 
local cP = 1
local cP2 = 2
local checkpoint
local blip
local startTime
local checkpoints = {
 [1] = {x = -704.72, y = 5401.20, z = 34.21, finish = false},
 [2] = {x = -707.56, y = 5286.41, z = 72.79, finish = false},
 [3] = {x = -637.18, y = 5209.41, z = 82.33, finish = false},
 [4] = {x = -570.84, y = 5053.54, z = 132.13, finish = false},
 [5] = {x = -381.00, y = 4908.91, z = 193.61, finish = false},
 [6] = {x = -301.82, y = 4970.74, z = 243.78, finish = false},
 [7] = {x = -219.58, y = 4902.72, z = 314.37, finish = false},
 [8] = {x = -94.44, y = 4938.72, z = 378.89, finish = false},
 [9] = {x = 16.47, y = 5028.70, z = 451.93, finish = false},
 [10] = {x = 99.42, y = 5088.46, z = 502.69, finish = false},
 [11] = {x = 134.96, y = 5213.44, z = 546.21, finish = false},
 [12] = {x = 230.67, y = 5300.07, z = 619.84, finish = false},
 [13] = {x = 402.28, y = 5504.77, z = 728.41, finish = false},
 [14] = {x = 523.91, y = 5615.44, z = 780.27, finish = true},
 [15] = {x = 523.91, y = 5615.44, z = 780.27, finish = true}
}
local checkpoints2 = {
 [15] ={x = -704.72, y = 5401.20, z = 34.21, finish = true},
 [14] = {x = -704.72, y = 5401.20, z = 34.21, finish = true},
 [13] = {x = -707.56, y = 5286.41, z = 72.79, finish = false},
 [12] = {x = -637.18, y = 5209.41, z = 82.33, finish = false},
 [11] = {x = -570.84, y = 5053.54, z = 132.13, finish = false},
 [10] = {x = -381.00, y = 4908.91, z = 193.61, finish = false},
 [9] = {x = -301.82, y = 4970.74, z = 243.78, finish = false},
 [8] = {x = -219.58, y = 4902.72, z = 314.37, finish = false},
 [7] = {x = -94.44, y = 4938.72, z = 378.89, finish = false},
 [6] = {x = 16.47, y = 5028.70, z = 451.93, finish = false},
 [5] = {x = 99.42, y = 5088.46, z = 502.69, finish = false},
 [4] = {x = 134.96, y = 5213.44, z = 546.21, finish = false},
 [3] = {x = 230.67, y = 5300.07, z = 619.84, finish = false},
 [2] = {x = 402.28, y = 5504.77, z = 728.41, finish = false},
 [1] = {x = 523.91, y = 5615.44, z = 780.27, finish = false}
}

Citizen.CreateThread(function()
 while true do
  local ped = GetPlayerPed(-1)
  Citizen.Wait(5)
  if(GetDistanceBetweenCoords(GetEntityCoords(ped), -799.41, 5401.71, 34.21, true) < 25) then
   DrawMarker(25, -799.41, 5401.71, 34.21-0.95,0,0,0,0,0,0,1.75,1.75,1.75,25,165,255,165,0,0,0,0)
   if(GetDistanceBetweenCoords(GetEntityCoords(ped), -799.41, 5401.71, 34.21, true) < 1.7) then
    drawTxt('\n~b~Press ~g~E~b~ To Begin Hill Climb Time Trial')
    if IsControlJustPressed(0, 38) then
     if IsPedInAnyVehicle(GetPlayerPed(-1), false) then 
      IsRacing = true
      SetPedCoordsKeepVehicle(PlayerPedId(), -791.645, 5428.288, 34.899)
      SetEntityHeading(PlayerPedId(), 296.067)
      Citizen.CreateThread(function()
       local time = GetGameTimer() + 6*1000
       while math.floor((time-GetGameTimer())/1000) > 0 do
        Citizen.Wait(1)
        DrawHudText(math.floor((time-GetGameTimer())/1000),0.5,0.4,4.0,4.0)
       end
       TriggerEvent("race:begin")
      end)
     else
      TriggerEvent('chatMessage', '^4You Are Not In Any Vehicle')
     end
    end
   end
  end
 end
end)

RegisterNetEvent("race:begin")
AddEventHandler("race:begin", function()
 startTime = GetGameTimer()
 Citizen.CreateThread(function()
  checkpoint = CreateCheckpoint(checkpoints[cP].type, checkpoints[cP].x, checkpoints[cP].y, checkpoints[cP].z + 2, checkpoints[cP2].x, checkpoints[cP2].y, checkpoints[cP2].z, 8.0, 255, 0, 1, 100, 0)
  blip = AddBlipForCoord(checkpoints[cP].x, checkpoints[cP].y, checkpoints[cP].z)          
  while IsRacing do 
   Citizen.Wait(5)
   if GetDistanceBetweenCoords(checkpoints[cP].x, checkpoints[cP].y, checkpoints[cP].z, GetEntityCoords(GetPlayerPed(-1))) < 10.0 then
    if not checkpoints[cP].finish then
     DeleteCheckpoint(checkpoint) RemoveBlip(blip)
     PlaySoundFrontend(-1, "RACE_PLACED", "HUD_AWARDS")
     cP = math.ceil(cP+1) cP2 = math.ceil(cP2+1)
     checkpoint = CreateCheckpoint(checkpoints[cP].type, checkpoints[cP].x, checkpoints[cP].y, checkpoints[cP].z+2, checkpoints[cP2].x, checkpoints[cP2].y, checkpoints[cP2].z, 8.0, 255, 0, 1, 100, 0)
     blip = AddBlipForCoord(checkpoints[cP].x, checkpoints[cP].y, checkpoints[cP].z)
    else
     PlaySoundFrontend(-1, "ScreenFlash", "WastedSounds")
     DeleteCheckpoint(checkpoint) RemoveBlip(blip)
     IsRacing = false cP = 1 cP2 = 2
     TriggerEvent('chatMessage', '^4Your Time Was ^2'..formatTimer(startTime, GetGameTimer()))
    end
   end
  end
 end)
end)

function formatTimer(startTime, currTime)
 local newString = currTime - startTime
 local ms = string.sub(newString, -3, -2)
 local sec = string.sub(newString, -5, -4)
 local min = string.sub(newString, -7, -6)
 newString = string.format("%s%s.%s", min, sec, ms)
 return newString
end

function DrawHudText(text,coordsx,coordsy,scalex,scaley) --courtesy of driftcounter
 SetTextFont(4)
 SetTextProportional(7)
 SetTextScale(scalex, scaley)
 SetTextColour(255,255,255, 255)
 SetTextDropshadow(0, 0, 0, 0, 255)
 SetTextEdge(1, 0, 0, 0, 255)
 SetTextDropShadow()
 SetTextOutline()
 SetTextEntry("STRING")
 AddTextComponentString(text)
 DrawText(coordsx,coordsy)
end

Citizen.CreateThread(function()
 while true do
  local ped = GetPlayerPed(-1)
  Citizen.Wait(5)
  if(GetDistanceBetweenCoords(GetEntityCoords(ped), 523.91, 5615.44, 780.27, true) < 25) then
   DrawMarker(25, 523.91, 5615.44, 780.27,0,0,0,0,0,0,1.75,1.75,1.75,25,165,255,165,0,0,0,0)
   if(GetDistanceBetweenCoords(GetEntityCoords(ped), 523.91, 5615.44, 780.27, true) < 1.7) then
    drawTxt('\n~b~Press ~g~E~b~ To Begin Hill Climb Time Trial')
    if IsControlJustPressed(0, 38) then
     if IsPedInAnyVehicle(GetPlayerPed(-1), false) then 
      IsRacing = true
      Citizen.CreateThread(function()
       local time = GetGameTimer() + 6*1000
       while math.floor((time-GetGameTimer())/1000) > 0 do
        Citizen.Wait(1)
        DrawHudText(math.floor((time-GetGameTimer())/1000),0.5,0.4,4.0,4.0)
       end
       TriggerEvent("race:begin2")
      end)
     else
      TriggerEvent('chatMessage', '^4You Are Not In Any Vehicle')
     end
    end
   end
  end
 end
end)

RegisterNetEvent("race:begin2")
AddEventHandler("race:begin2", function()
 startTime = GetGameTimer()
 Citizen.CreateThread(function()
  checkpoint = CreateCheckpoint(checkpoints2[cP].type, checkpoints2[cP].x, checkpoints2[cP].y, checkpoints2[cP].z + 2, checkpoints2[cP2].x, checkpoints2[cP2].y, checkpoints2[cP2].z, 8.0, 255, 0, 1, 100, 0)
  blip = AddBlipForCoord(checkpoints2[cP].x, checkpoints2[cP].y, checkpoints2[cP].z)          
  while IsRacing do 
   Citizen.Wait(5)
   if GetDistanceBetweenCoords(checkpoints2[cP].x, checkpoints2[cP].y, checkpoints2[cP].z, GetEntityCoords(GetPlayerPed(-1))) < 10.0 then
    if not checkpoints2[cP].finish then
     DeleteCheckpoint(checkpoint) RemoveBlip(blip)
     PlaySoundFrontend(-1, "RACE_PLACED", "HUD_AWARDS")
     cP = math.ceil(cP+1) cP2 = math.ceil(cP2+1)
     checkpoint = CreateCheckpoint(checkpoints2[cP].type, checkpoints2[cP].x, checkpoints2[cP].y, checkpoints2[cP].z+2, checkpoints2[cP2].x, checkpoints2[cP2].y, checkpoints2[cP2].z, 8.0, 255, 0, 1, 100, 0)
     blip = AddBlipForCoord(checkpoints2[cP].x, checkpoints2[cP].y, checkpoints2[cP].z)
    else
     PlaySoundFrontend(-1, "ScreenFlash", "WastedSounds")
     DeleteCheckpoint(checkpoint) RemoveBlip(blip)
     IsRacing = false cP = 1 cP2 = 2
     TriggerEvent('chatMessage', '^4Your Time Was ^2'..formatTimer(startTime, GetGameTimer()))
    end
   end
  end
 end)
end)

--[[Citizen.CreateThread(function()
  SwitchTrainTrack(0, true)
  SwitchTrainTrack(3, true)
  N_0x21973bbf8d17edfa(0, 120000)
  SetRandomTrains(1)
end)]]

SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_HILLBILLY"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_BALLAS"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_MEXICAN"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_FAMILY"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_MARABUNTE"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_SALVA"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("GANG_1"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("GANG_2"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("GANG_9"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("GANG_10"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("FIREMAN"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("MEDIC"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("COP"), GetHashKey('PLAYER'))

local disabledPeds = {

  "s_m_y_cop_01",

  "s_f_y_sheriff_01",

  "s_m_y_sheriff_01",

  "s_m_y_hwaycop_01",

  "s_m_y_swat_01",

  "s_m_m_snowcop_01",

  "s_m_m_paramedic_01"

}



Citizen.CreateThread(function()

    while true do

        Citizen.Wait(1000) 

        for ped in EnumeratePeds() do

            if DoesEntityExist(ped) then

        for i,model in pairs(disabledPeds) do

          if (GetEntityModel(ped) == GetHashKey(model)) then

            veh = GetVehiclePedIsIn(ped, false)

            SetEntityAsNoLongerNeeded(ped)

            SetEntityCoords(ped,10000,10000,10000,1,0,0,1)

            if veh ~= nil then

              SetEntityAsNoLongerNeeded(veh)

              SetEntityCoords(veh,10000,10000,10000,1,0,0,1)

            end

          end

        end

      end

    end

    end

end)