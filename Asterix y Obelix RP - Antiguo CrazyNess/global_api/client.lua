local API = {}

--=================================================================================================
--======================================= API Vehicles ============================================
--=================================================================================================
local currentVehicle = nil

function API_CreateVehicle(model, x, y, z)
 local vehicleHash = GetHashKey(model)
 RequestModel(vehicleHash)
 while not HasModelLoaded(vehicleHash) do
  Citizen.Wait(0)
 end

 currentVehicle = CreateVehicle(vehicleHash, x, y, z, GetEntityHeading(GetPlayerPed(-1)), true, false)
 local id = NetworkGetNetworkIdFromEntity(currentVehicle)
 SetNetworkIdCanMigrate(id, true)
 SetNetworkIdExistsOnAllMachines(id, true)

 SetVehicleDirtLevel(currentVehicle, 0)
 TaskWarpPedIntoVehicle(GetPlayerPed(-1), currentVehicle, -1)
 SetVehicleHasBeenOwnedByPlayer(currentVehicle, true)
 SetEntityAsMissionEntity(currentVehicle, true, true)
 SetVehicleEngineOn(currentVehicle, true)
 print(model.." Has Been Spawned")
end
function API_DeleteVehicle()
 if currentVehicle ~= nil then 
  DeleteVehicle(currentVehicle)
 else
  DeleteVehicle(GetVehiclePedIsIn(GetPlayerPed(-1), false))
 end
end

--=================================================================================================
--================================ API Drawing And Locations ======================================
--=================================================================================================
function API_DrawMarker(marker, x, y, z, size, colour)
 DrawMarker(27, x, y, z, 0, 0, 0, 0, 0, 0, size, size, 0.5, colour.r, colour.g, colour.b, colour.a, 0, 0, 2, 0, 0, 0, 0)
end

function API_IsPlayerAtLocation(x, y, z, text, size)
 if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), x, y, z, true) < 25) then
  DrawMarker(27, x, y, z, 0, 0, 0, 0, 0, 0, size, size, 0.5, 12, 95, 205, 255, 0, 0, 2, 0, 0, 0, 0)
  if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), x, y, z, true) < size+0.2) then
   API_DrawTxt(text)
   return true
  end
 end
end

function API_DrawBlip(x, y, z, text, id, colour)
  local blip = AddBlipForCoord(x, y, z)
  SetBlipSprite (blip, id)
  SetBlipDisplay(blip, 4)
  SetBlipScale  (blip, 0.6)
  SetBlipColour (blip, colour)
  SetBlipAsShortRange(blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString(text)
  EndTextCommandSetBlipName(blip)
end

function API_DrawTxt(text)
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

function API_IsAtDrawText(x, y, z, text)
 if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), x, y, z, true) < 5) then
  API_DrawTxt(text)
  return true
 end
end

--=================================================================================================
--===================================== Progress Bar ==============================================
--=================================================================================================
local progress_time = 0.20
local progress_bar = false
local progress_bar_duration = 20
local progress_bar_text = ''

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(progress_bar_duration)
  if(progress_time > 0)then
   progress_time = progress_time - 0.002
  end
 end
end)

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(5)
  if progress_bar then 
   DrawRect(0.50, 0.90, 0.20, 0.05, 0, 0, 0, 100)
   drawUI(0.910, 1.375, 1.0, 1.0, 0.55, progress_bar_text, 255, 255, 255, 255, false)
   if progress_time > 0 then
   	DrawRect(0.50, 0.90, 0.20-progress_time, 0.05, 75, 156, 237, 225)
   elseif progress_time < 1 and progress_bar then 
    progress_bar = false
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
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
	  SetTextCentre(center)
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

function API_ProgressBar(text, time)
 progress_bar_text = text
 progress_bar_duration = time
 progress_time = 0.20
 progress_bar = true
end

