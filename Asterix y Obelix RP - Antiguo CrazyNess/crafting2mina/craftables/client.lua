--[[
    TriggerEvent("inventory:addQty", ITEMID, AMOUNT)
    TriggerEvent("inventory:removeQty", ITEMID, AMOUNT)
    exports['core']:GetItemQuantity(ITEMID) >= 1

    TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You do not have the correct materials to craft this item!")
    TriggerEvent('chatMessage', "SUCCESS", {0, 173, 66}, "You have successfully crafted XX")

]]--

----------------------------------((((( CASH STACKS START)))))----------------------

RegisterNetEvent("crafting2mina:trigger:1")
AddEventHandler("crafting2mina:trigger:1", function()
 if exports['core']:GetItemQuantity(109) >= 1 and exports['core']:GetItemQuantity(119) >= 1 and exports['core']:GetItemQuantity(113) >= 1 then
  TriggerEvent("inventory:removeQty", 133, 1)
  TriggerEvent("inventory:removeQty", 119, 1)
  TriggerEvent("inventory:addQty", 110, 28)
  TriggerEvent('chatMessage', "SUCCESS", {0, 173, 66}, "You have successfully crafted 28 Grams of Cocaine")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You do not have the correct materials to craft this")
 end
end)