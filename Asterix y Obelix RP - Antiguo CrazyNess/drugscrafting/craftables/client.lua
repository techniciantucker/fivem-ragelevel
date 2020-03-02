-- Brick of Cocaine > Bars of Cocaine
RegisterNetEvent("craftingballas:trigger:1")
AddEventHandler("craftingballas:trigger:1", function()
 if exports['core']:GetItemQuantity(282) >= 1 and exports['core']:GetItemQuantity(119) >= 1 and exports['core']:GetItemQuantity(112) >= 1 and exports['core']:GetItemQuantity(113) >= 1 then
  TriggerEvent("inventory:removeQty", 282, 1)
  TriggerEvent("inventory:removeQty", 119, 1)
  TriggerEvent("inventory:addQty", 109, 9)
  TriggerEvent('chatMessage', "SUCCESS", {0, 173, 66}, "You have successfully crafted bar into nine oz's of cocaine")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You do not have the correct items in your inventory!")
 end
end)
-- Bars of Cocaine > 9 x Oz of Cocaine
RegisterNetEvent("craftingballas:trigger:2")
AddEventHandler("craftingballas:trigger:2", function()
 if exports['core']:GetItemQuantity(107) >= 1 and exports['core']:GetItemQuantity(137) >= 1 and exports['core']:GetItemQuantity(111) >= 1 and exports['core']:GetItemQuantity(112) >= 1 then
  TriggerEvent("inventory:removeQty", 107, 1)
  TriggerEvent("inventory:removeQty", 137, 1)
  TriggerEvent("inventory:addQty", 282, 4)  
  TriggerEvent('chatMessage', "SUCCESS", {0, 173, 66}, "You have successfully cut down your brick into four bars")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You do not have the correct items in your inventory!")
 end
end)
