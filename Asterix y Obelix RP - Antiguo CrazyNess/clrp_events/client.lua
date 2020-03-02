
-- Race  
local IsRacing = false 
local cP = 1
local cP2 = 2
local checkpoint
local blip
local startTime
local checkpoints = {
 [1] = {x = 1882.663, y = 3616.734, z = 32.352, finish = false},
 [2] = {x = 1607.392, y = 3480.706, z = 34.662, finish = false},
 [3] = {x = 1234.785, y = 3536.817, z = 33.230, finish = false},
 [4] = {x = 276.802, y = 3402.757, z = 35.740, finish = false},
 [5] = {x = 92.834, y = 3441.786, z = 37.775, finish = false},
 [6] = {x = 105.292, y = 3573.137, z = 37.765, finish = false},
 [7] = {x = -94.045, y = 3611.021, z = 42.827, finish = false},
 [8] = {x = -225.433, y = 3924.371, z = 35.432, finish = false},
 [9] = {x = -193.279, y = 4221.423, z = 42.928, finish = false},
 [10] = {x = 4.188, y = 4452.394, z = 57.197, finish = false},
 [11] = {x = 187.546, y = 4427.556, z = 71.843, finish = false},
 [12] = {x = 481.189, y = 4354.509, z = 58.700, finish = false},
 [13] = {x = 668.929, y = 4239.935, z = 52.858, finish = false},
 [14] = {x = 859.968, y = 4236.035, z = 48.261, finish = false},
 [15] = {x = 968.632, y = 4424.840, z = 45.524, finish = false},
 [16] = {x = 1209.450, y = 4452.054, z = 53.795, finish = false},
 [17] = {x = 1429.767, y = 4494.897, z = 48.601, finish = false},
 [18] = {x = 1769.049, y = 4570.961, z = 35.956, finish = false},
 [19] = {x = 2131.940, y = 4749.981, z = 39.201, finish = false},
 [20] = {x = 2443.179, y = 4601.519, z = 34.940, finish = false},
 [21] = {x = 2447.861, y = 4282.963, z = 34.857, finish = false},
 [22] = {x = 2507.470, y = 4123.487, z = 36.525, finish = false},
 [23] = {x = 2310.133, y = 3864.216, z = 32.828, finish = false},
 [24] = {x = 2053.831, y = 3716.040, z = 31.062, finish = false},
 [25] = {x = 1882.663, y = 3616.734, z = 32.352, finish = true},
 [26] = {x = 1882.663, y = 3616.734, z = 32.352, finish = true}
}

Citizen.CreateThread(function()
 while true do
  local ped = GetPlayerPed(-1)
  Citizen.Wait(5)
  if(GetDistanceBetweenCoords(GetEntityCoords(ped), 1882.663, 3616.734, 34.352, true) < 25) then
   DrawMarker(25, 1882.663, 3616.734, 33.352,0,0,0,0,0,0,1.75,1.75,1.75,25,165,255,165,0,0,0,0)
   if(GetDistanceBetweenCoords(GetEntityCoords(ped), 1882.663, 3616.734, 34.352, true) < 1.7) then
    drawTxt('\n~b~Pulse ~g~E~b~ Para comenzar la prueba contrarreloj del rally del mar de Alamo')
    if IsControlJustPressed(0, 38) then
     if IsPedInAnyVehicle(GetPlayerPed(-1), false) then 
      IsRacing = true
      SetPedCoordsKeepVehicle(PlayerPedId(), 1882.663, 3616.734, 34.352)
      SetEntityHeading(PlayerPedId(), 118.085)
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
     TriggerEvent('chatMessage', '^4Tu tiempo fue ^2'..formatTimer(startTime, GetGameTimer()))
     ExecuteCommand("yo tuve un tiempo de ^2"..formatTimer(startTime, GetGameTimer()))
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