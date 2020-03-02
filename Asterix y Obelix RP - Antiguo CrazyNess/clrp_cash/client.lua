local hud = true

-- Hud Status


AddEventHandler('hud:status', function(status) hud = status end)
--========================================================================================--
--==================================== carteras =========================================--
--========================================================================================--
local money = 0

Citizen.CreateThread(function()
 while true do
  local ped = PlayerPedId()
  Citizen.Wait(5)
  if hud then
   if IsPedOnFoot(ped) then 
    drawUI(0.514, 1.436, 1.0, 1.0, 0.42, "~g~CARTERA ~y~$~w~"..money, 255, 255, 255, 255, false)
   end 
  else 
   Citizen.Wait(20)
  end
 end
end)

RegisterNetEvent('hud:money')
AddEventHandler('hud:money', function(data)
 money = data
end)