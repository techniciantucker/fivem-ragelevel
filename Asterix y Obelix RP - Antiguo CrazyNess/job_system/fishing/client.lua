local SuccessLimit = 0.175
local FishingRod = nil
local IsFishing = false
local CFish = false
local BarAnimation = 0
local PosX = 0.5
local PosY = 0.2
local TimerAnimation = 0.2
local Fish = {
 [1] = {name = 'Catfish', price = 25, item = 3},
 [2] = {name = 'Catfish', price = 25, item = 3},
 [3] = {name = 'Catfish', price = 25, item = 3},
 [4] = {name = 'Catfish', price = 25, item = 3},
 [5] = {name = 'Cod', price = 35, item = 4},
 [6] = {name = 'Cod', price = 35, item = 4},
 [7] = {name = 'Salmon', price = 40, item = 5}
}
local fishing_zones = {
 {x = 4240.930, y = 5164.693, z = 0.412, dist = 200, drawmarker = false, markerdist = 200},
 {x = -1837.302, y = -1260.918, z = 8.616, dist = 1.1, drawmarker = true, markerdist = 20.0},
 {x = -1836.012, y = -1262.066, z = 8.616, dist = 1.1, drawmarker = true, markerdist = 20.0},
}

Citizen.CreateThread(function()
 WarMenu.CreateMenu('fisherman_boss', 'Fisherman')
 while true do
  Citizen.Wait(0)
  if DecorGetInt(GetPlayerPed(-1), "Job") == 5 then
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 3866.848, 4464.227, 1.736, true) < 40)  and not IsPedInAnyBoat(GetPlayerPed(-1)) then
    DrawMarker(25, 3866.848, 4464.227, 1.736, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 100, 252, 255, 200, 0, 0, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 3866.848, 4464.227, 1.736, true) < 1.5) then
     drawTxt('~b~Press ~g~E~b~ To Hire A Boat')
     if IsControlJustPressed(0, 38) then
      WarMenu.OpenMenu('fisherman_boss')
     end
    end

   elseif(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 3866.78, 4479.975, 0.923, true) < 50) and IsPedInAnyBoat(GetPlayerPed(-1)) then
    DrawMarker(1, 3866.78, 4479.975, 0.943, 0, 0, 0, 0, 0, 0, 10.0, 10.0, 2.0, 100, 252, 255, 200, 0, 0, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 3866.78, 4479.975, 0.923, 1.736, true) < 25) then
     drawTxt('~b~Press ~g~E~b~ To Return The Boat')
     if IsControlJustPressed(0, 38) then
      local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
    SetEntityAsMissionEntity(vehicle, true, true)
    Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle))
      SetEntityCoords(GetPlayerPed(-1), 3866.848, 4464.227, 2.736)
     end
    end

   -- Fishing | Sell Point
   elseif(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -245.244,-354.201, 29.985, true) < 50) then
    DrawMarker(25, -245.244,-354.201, 29.985-0.95, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 3.0, 50, 102, 255, 200, 0, 0, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -245.244,-354.201, 29.985, true) < 2.0) then
     drawTxt('~b~Press ~g~E~b~ To Sell Fish')
     if IsControlJustPressed(0, 38) then
      SuccessLimit = 0.175
      --TriggerServerEvent('jobs:sellfish')
	        TriggerEvent('inventory:sellFish')
     end
    end
   end
  -- Fishing Zone
   for k,v in pairs(fishing_zones) do
    if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < v.markerdist) then
     if v.drawmarker then DrawMarker(27, v.x, v.y, v.z-0.95, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 3.0, 50, 102, 255, 200, 0, 0, 2, 0, 0, 0, 0) end
     if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < v.dist) then
      drawTxt('~b~Press ~g~E~b~ To Start Fishing')
      if IsControlJustPressed(0, 38) and not CFish then
       IsFishing = true
       BarAnimation = 0
      end
     end
    end
   end
  end

  -- Fisherman Menu
  if WarMenu.IsMenuOpened('fisherman_boss') then
   if WarMenu.Button('Go On Duty') then
    FishingBlips()
  Notify("You Are Now On Duty As A Fisherman")
   elseif WarMenu.Button('Go Off Duty') then
  Notify("You Are Now Off Duty")
   elseif WarMenu.Button('Hire Boat') then
    RequestModel("tug")
  local vehicle = CreateVehicle("tug", 3866.848, 4484.227, 1.736, 115, 1, 0)
  TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
    SetVehicleNumberPlateText(vehicle, 'JOB')
    Notify("Return The Boat Before Going Off Duty")
   end
   WarMenu.Display()
  end
 end
end)

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(0)
  while IsFishing do
   local time = 4*3000
   TaskStandStill(GetPlayerPed(-1), time+7000)
   FishingRod = AttachEntityToPed('prop_fishing_rod_01',60309, 0,0,0, 0,0,0)
   PlayAnim(GetPlayerPed(-1),'amb@world_human_stand_fishing@idle_a','idle_c',1,0)
   CFish = true
   IsFishing = false
  end
  while CFish do
   Citizen.Wait(0)
   FishGUI()
   if TimerAnimation <= 0 then
    CFish = false
    TimerAnimation = 0.2
    ClearPedTasksImmediately(GetPlayerPed(-1))
    DeleteEntity(FishingRod)
    print('No Time Left')
   end
   if IsControlJustPressed(1, 201) then
    if BarAnimation >= SuccessLimit then
     Wait(10)
     CFish = false
     TimerAnimation = 0.2
     ClearPedTasksImmediately(GetPlayerPed(-1))
     DeleteEntity(FishingRod)
     SuccessLimit = SuccessLimit+0.00025
     local catch = Fish[math.random(1,7)]
     Notify('You Have Successfully Caught 1x '..catch.name)
     TriggerEvent("inventory:addQty", catch.item, 1)
    else
     CFish = false
     TimerAnimation = 0.2
     ClearPedTasksImmediately(GetPlayerPed(-1))
     DeleteEntity(FishingRod)
     print('Fail')
    end
   end  
  end
 end 
end)

function FishGUI()
    DrawRect(PosX,PosY+0.030,TimerAnimation,0.008,255,255,0,255)
    DrawRect(PosX,PosY,0.2,0.05,0,0,0,255)
    TimerAnimation = TimerAnimation - 0.00050
    if BarAnimation >= SuccessLimit then
        DrawRect(PosX,PosY,BarAnimation,0.05,102,255,102,150)
    else
        DrawRect(PosX,PosY,BarAnimation,0.05,255,51,51,150)
    end
    if BarAnimation <= 0 then
        up = true
    end
    if BarAnimation >= PosY then
        up = false
    end
    if not up then
        BarAnimation = BarAnimation - 0.0015
    else
        BarAnimation = BarAnimation + 0.0015
    end
end

function FishingBlips()
  for k,v in pairs(fishing_zones) do
   local blip = AddBlipForCoord(v.x, v.y, v.z)
   SetBlipSprite (blip, 88)
   SetBlipDisplay(blip, 4)
   SetBlipScale  (blip, 0.6)
   SetBlipColour (blip, 7)
   SetBlipAsShortRange(blip, true)
   BeginTextCommandSetBlipName("STRING")
   AddTextComponentString("Fishing Zone")
   EndTextCommandSetBlipName(blip)
  end

  local blip2 = AddBlipForCoord(-245.244,-354.201, 29.985)
  SetBlipSprite (blip2, 88)
  SetBlipDisplay(blip2, 4)
  SetBlipScale  (blip2, 0.6)
  SetBlipColour (blip2, 7) 
  SetBlipAsShortRange(blip2, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString("Fish Sell Point")
  EndTextCommandSetBlipName(blip2)
end

function AttachEntityToPed(prop,bone_ID,x,y,z,RotX,RotY,RotZ)
    if DoesEntityExist(FishingRod) then DeleteEntity(FishingRod) end
  BoneID = GetPedBoneIndex(GetPlayerPed(-1), bone_ID)
  obj = CreateObject(GetHashKey(prop),  1729.73,  6403.90,  34.56,  true,  true,  true)
  AttachEntityToEntity(obj, GetPlayerPed(-1), BoneID, x,y,z, RotX,RotY,RotZ,  false, false, false, false, 2, true)
  return obj
end

function PlayAnim(ped,base,sub,nr,time) 
  Citizen.CreateThread(function() 
    RequestAnimDict(base) 
    while not HasAnimDictLoaded(base) do 
      Citizen.Wait(1) 
    end
    if IsEntityPlayingAnim(ped, base, sub, 3) then
      ClearPedSecondaryTask(ped) 
    else 
      for i = 1,nr do 
        TaskPlayAnim(ped, base, sub, 4.0, -1, -1, 50, 0, false, false, false)
        Citizen.Wait(time) 
      end 
    end 
  end) 
end
 