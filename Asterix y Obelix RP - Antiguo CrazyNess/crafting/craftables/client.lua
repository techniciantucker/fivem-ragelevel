--[[
    TriggerEvent("inventory:addQty", ITEMID, AMOUNT)
    TriggerEvent("inventory:removeQty", ITEMID, AMOUNT)
    exports['core']:GetItemQuantity(ITEMID) >= 1

    TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You do not have the correct materials to craft this item!")
    TriggerEvent('chatMessage', "SUCCESS", {0, 173, 66}, "You have successfully crafted XX")

]]--


-- DRUGS 
-- 2 Blunts
RegisterNetEvent("crafting:trigger:1")
AddEventHandler("crafting:trigger:1", function()
 if exports['core']:GetItemQuantity(121) >= 1 or exports['core']:GetItemQuantity(268) >= 1 and exports['core']:GetItemQuantity(122) >= 1 then
  TriggerEvent("inventory:removeQty", 121, 1)
  TriggerEvent("inventory:removeQty", 267, 1)
  TriggerEvent("inventory:addQty", 123, 2)
  TriggerEvent('chatMessage', "SUCCESS", {0, 173, 66}, "You have successfully crafted 2x Blunt")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You do not have the correct materials to craft this item!")
 end
end)

-- 4 Spliffs
RegisterNetEvent("crafting:trigger:2")
AddEventHandler("crafting:trigger:2", function()
 if exports['core']:GetItemQuantity(121) >= 1 or exports['core']:GetItemQuantity(268) >= 1 and exports['core']:GetItemQuantity(15) >= 1 and exports['core']:GetItemQuantity(125) >= 1 then
  TriggerEvent("inventory:removeQty", 121, 1)
  TriggerEvent("inventory:removeQty", 15, 1)
  TriggerEvent("inventory:removeQty", 125, 1)
  TriggerEvent("inventory:addQty", 124, 4)
  TriggerEvent('chatMessage', "SUCCESS", {0, 173, 66}, "You have successfully crafted 4x Spliff")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You do not have the correct materials to craft this item!")
 end
end)

-- Oz of Weed > 28 x Bags of Weed
RegisterNetEvent("crafting:trigger:3")
AddEventHandler("crafting:trigger:3", function()
 if exports['core']:GetItemQuantity(119) >= 1 and exports['core']:GetItemQuantity(120) >= 1 and exports['core']:GetItemQuantity(113) >= 1 then
  TriggerEvent("inventory:removeQty", 119, 1)
  TriggerEvent("inventory:removeQty", 120, 1)
  TriggerEvent("inventory:addQty", 121, 28)
  TriggerEvent('chatMessage', "SUCCESS", {0, 173, 66}, "You have successfully crafted 28x Gram of Weed")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You do not have the correct materials to craft this item!")
 end
end)

-- Oz of SuperSkunk > 28 x Bags of SuperSkunk
RegisterNetEvent("crafting:trigger:4")
AddEventHandler("crafting:trigger:4", function()
 if exports['core']:GetItemQuantity(119) >= 1 and exports['core']:GetItemQuantity(173) >= 1 and exports['core']:GetItemQuantity(113) >= 1 then
  TriggerEvent("inventory:removeQty", 119, 1)
  TriggerEvent("inventory:removeQty", 173, 1)
  TriggerEvent("inventory:addQty", 268, 28)
  TriggerEvent('chatMessage', "SUCCESS", {0, 173, 66}, "You have successfully crafted 28x Gram of SuperSkunk")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You do not have the correct materials to craft this item!")
 end
end)

-- Oz of Weed > 28 x grams of Purple Haze
RegisterNetEvent("crafting:trigger:30")
AddEventHandler("crafting:trigger:30", function()
 if exports['core']:GetItemQuantity(273) >= 1 and exports['core']:GetItemQuantity(119) >= 1 and exports['core']:GetItemQuantity(113) >= 1 then
  TriggerEvent("inventory:removeQty", 119, 1)
  TriggerEvent("inventory:removeQty", 273, 1)
  TriggerEvent("inventory:addQty", 287, 28)
  TriggerEvent('chatMessage', "SUCCESS", {0, 173, 66}, "You have successfully crafted 28x Gram of Purple Haze")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You do not have the correct materials to craft this item!")
 end
end)

-- Oz of Weed > 28 x grams of Lemon Haze
RegisterNetEvent("crafting:trigger:31")
AddEventHandler("crafting:trigger:31", function()
 if exports['core']:GetItemQuantity(270) >= 1 and exports['core']:GetItemQuantity(119) >= 1 and exports['core']:GetItemQuantity(113) >= 1 then
  TriggerEvent("inventory:removeQty", 119, 1)
  TriggerEvent("inventory:removeQty", 270, 1)
  TriggerEvent("inventory:addQty", 274, 28)
  TriggerEvent('chatMessage', "SUCCESS", {0, 173, 66}, "You have successfully crafted 28x Gram of Lemon Haze")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You do not have the correct materials to craft this item!")
 end
end)

-- Oz of Cocaine > 28 x Grams of Cocaine
RegisterNetEvent("crafting:trigger:5")
AddEventHandler("crafting:trigger:5", function()
 if exports['core']:GetItemQuantity(109) >= 1 and exports['core']:GetItemQuantity(113) >= 1 and exports['core']:GetItemQuantity(119) >= 1 then
  TriggerEvent("inventory:removeQty", 109, 1)
  TriggerEvent("inventory:removeQty", 119, 1)
  TriggerEvent("inventory:addQty", 110, 28)
  TriggerEvent('chatMessage', "SUCCESS", {0, 173, 66}, "You have successfully crafted 28x Gram of Cocaine")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You do not have the correct materials to craft this item!")
 end
end)

-- Brick Of Weed > 36 x Oz of Weed
RegisterNetEvent("crafting:trigger:6")
AddEventHandler("crafting:trigger:6", function()
 if exports['core']:GetItemQuantity(266) >= 1 and exports['core']:GetItemQuantity(112) >= 1 and exports['core']:GetItemQuantity(179) >= 1 then
  TriggerEvent("inventory:removeQty", 266, 1)
  TriggerEvent("inventory:removeQty", 179, 1)
  TriggerEvent("inventory:addQty", 120, 36)
  TriggerEvent('chatMessage', "SUCCESS", {0, 173, 66}, "You've crafted 36 Oz of Weed")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You do not have the correct materials to craft this item!")
 end
end)

-- Brick Of SuperSkunk > 36 x Oz of SuperSkunk
RegisterNetEvent("crafting:trigger:7")
AddEventHandler("crafting:trigger:7", function()
 if exports['core']:GetItemQuantity(175) >= 1 and exports['core']:GetItemQuantity(112) >= 1 and exports['core']:GetItemQuantity(179) >= 1 then
  TriggerEvent("inventory:removeQty", 175, 1)
  TriggerEvent("inventory:removeQty", 179, 1)
  TriggerEvent("inventory:addQty", 173, 36)
  TriggerEvent('chatMessage', "SUCCESS", {0, 173, 66}, "You've crafted 36 Oz of SuperSkunk")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You do not have the correct materials to craft this item!")
 end
end)

-- Bar Of Cocaine > 9 x Oz of Cocaine
RegisterNetEvent("crafting:trigger:8")
AddEventHandler("crafting:trigger:8", function()
 if exports['core']:GetItemQuantity(108) >= 1 and exports['core']:GetItemQuantity(112) >= 1 and exports['core']:GetItemQuantity(179) >= 1 then
  TriggerEvent("inventory:removeQty", 108, 1)
  TriggerEvent("inventory:removeQty", 179, 1)
  TriggerEvent("inventory:addQty", 109, 9)
  TriggerEvent('chatMessage', "SUCCESS", {0, 173, 66}, "You have crafted 9x Oz of Cocaine")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You do not have the correct materials to craft this item!")
 end
end)



-- Cocaine Block > 4 x Bar of Cocaine
RegisterNetEvent("crafting:trigger:9")
AddEventHandler("crafting:trigger:9", function()
 if exports['core']:GetItemQuantity(107) >= 1 and exports['core']:GetItemQuantity(111) >= 1 and exports['core']:GetItemQuantity(179) >= 1 and exports['core']:GetItemQuantity(112) >= 1 then
  TriggerEvent("inventory:removeQty", 107, 1)
  TriggerEvent("inventory:removeQty", 179, 1)
  TriggerEvent("inventory:addQty", 108, 4)
  TriggerEvent('chatMessage', "SUCCESS", {0, 173, 66}, "You've crafted 4x Bars of Cocaine")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You do not have the correct materials to craft this item!")
 end
end)

-- Cocaine > Crack 2
RegisterNetEvent("crafting:trigger:26")
AddEventHandler("crafting:trigger:26", function()
 if exports['core']:GetItemQuantity(108) >= 1 and exports['core']:GetItemQuantity(286) >= 1 and exports['core']:GetItemQuantity(13) >= 6 and exports['core']:GetItemQuantity(112) >= 1 then
  TriggerEvent("inventory:removeQty", 108, 1)
  TriggerEvent("inventory:removeQty", 13, 6)
  TriggerEvent("inventory:addQty", 284, 8)
  TriggerEvent('chatMessage', "SUCCESS", {0, 173, 66}, "You've cooked up 8x Oz of Crack")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You do not have the correct materials to craft this item!")
 end
end)

-- Cocaine > Crack 
RegisterNetEvent("crafting:trigger:13")
AddEventHandler("crafting:trigger:13", function()
 if exports['core']:GetItemQuantity(330) >= 10 and exports['core']:GetItemQuantity(286) >= 1 and exports['core']:GetItemQuantity(13) >= 10 and exports['core']:GetItemQuantity(112) >= 1 then
  TriggerEvent("inventory:removeQty", 330, 10)
  TriggerEvent("inventory:removeQty", 13, 10)
  TriggerEvent("inventory:addQty", 284, 30)
  TriggerEvent('chatMessage', "SUCCESS", {0, 173, 66}, "You've cooked up 30 Oz of Crack")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You do not have the correct materials to craft this item!")
 end
end)

-- Crack > Bags of Crack
RegisterNetEvent("crafting:trigger:14")
AddEventHandler("crafting:trigger:14", function()
 if exports['core']:GetItemQuantity(113) >= 1 and exports['core']:GetItemQuantity(284) >= 1 and exports['core']:GetItemQuantity(119) >= 1 then
  TriggerEvent("inventory:removeQty", 284, 1)
  TriggerEvent("inventory:removeQty", 119, 1)
  TriggerEvent("inventory:addQty", 285, 40)
  TriggerEvent('chatMessage', "SUCCESS", {0, 173, 66}, "You've bagged up some Crack")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You do not have the correct materials to craft this item!")
 end
end)

--9 oz Cocaine > Bar of Cocaine
RegisterNetEvent("crafting:trigger:25")
AddEventHandler("crafting:trigger:25", function()
 if exports['core']:GetItemQuantity(109) >= 9 and exports['core']:GetItemQuantity(179) >= 1 and exports['core']:GetItemQuantity(112) >= 1 then
  TriggerEvent("inventory:removeQty", 109, 9)
  TriggerEvent("inventory:removeQty", 179, 1)
  TriggerEvent("inventory:addQty", 108, 1)
  TriggerEvent('chatMessage', "SUCCESS", {0, 173, 66}, "You've crafted a Bar of Cocaine")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You do not have the correct materials to craft this item!")
 end
end)

--36 oz Cocaine > Brick of Cocaine
RegisterNetEvent("crafting:trigger:27")
AddEventHandler("crafting:trigger:27", function()
 if exports['core']:GetItemQuantity(109) >= 36 and exports['core']:GetItemQuantity(179) >= 5 and exports['core']:GetItemQuantity(112) >= 1 then
  TriggerEvent("inventory:removeQty", 109, 9)
  TriggerEvent("inventory:removeQty", 179, 1)
  TriggerEvent("inventory:addQty", 107, 1)
  TriggerEvent('chatMessage', "SUCCESS", {0, 173, 66}, "You've crafted a Brick of Cocaine")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You do not have the correct materials to craft this item!")
 end
end)

-- Bar Of Heroin > 9 x Oz of Heroin
RegisterNetEvent("crafting:trigger:28")
AddEventHandler("crafting:trigger:28", function()
 if exports['core']:GetItemQuantity(162) >= 1 and exports['core']:GetItemQuantity(112) >= 1 and exports['core']:GetItemQuantity(179) >= 1 then
  TriggerEvent("inventory:removeQty", 162, 1)
  TriggerEvent("inventory:removeQty", 179, 1)
  TriggerEvent("inventory:addQty", 158, 9)
  TriggerEvent('chatMessage', "SUCCESS", {0, 173, 66}, "You have crafted 9x Oz of Heroin")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You do not have the correct materials to craft this item!")
 end
end)

-- Oz Heroin > Bags of Heroin
RegisterNetEvent("crafting:trigger:29")
AddEventHandler("crafting:trigger:29", function()
 if exports['core']:GetItemQuantity(113) >= 1 and exports['core']:GetItemQuantity(158) >= 1 and exports['core']:GetItemQuantity(119) >= 1 then
  TriggerEvent("inventory:removeQty", 158, 1)
  TriggerEvent("inventory:removeQty", 119, 1)
  TriggerEvent("inventory:addQty", 32, 42)
  TriggerEvent('chatMessage', "SUCCESS", {0, 173, 66}, "You've bagged up some Heroin")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You do not have the correct materials to craft this item!")
 end
end)


-- Brick Of Purple Haze > 36 x Oz of Purple Haze
RegisterNetEvent("crafting:trigger:32")
AddEventHandler("crafting:trigger:32", function()
 if exports['core']:GetItemQuantity(272) >= 1 and exports['core']:GetItemQuantity(112) >= 1 and exports['core']:GetItemQuantity(179) >= 1 then
  TriggerEvent("inventory:removeQty", 272, 1)
  TriggerEvent("inventory:removeQty", 179, 1)
  TriggerEvent("inventory:addQty", 273, 36)
  TriggerEvent('chatMessage', "SUCCESS", {0, 173, 66}, "You've crafted 36 Oz of Purple Haze")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You do not have the correct materials to craft this item!")
 end
end)


-- Bag of Meth > Pack of Meth
RegisterNetEvent("crafting:trigger:33")
AddEventHandler("crafting:trigger:33", function()
 if exports['core']:GetItemQuantity(34) >= 25 and exports['core']:GetItemQuantity(112) >= 1 and exports['core']:GetItemQuantity(179) >= 1 then
  TriggerEvent("inventory:removeQty", 34, 25)
  TriggerEvent("inventory:removeQty", 179, 1)
  TriggerEvent("inventory:addQty", 359, 1)
  TriggerEvent('chatMessage', "SUCCESS", {0, 173, 66}, "You've crafted a Pack of Meth")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You do not have the correct materials to craft this item!")
 end
end)


-- Pack of Meth > Baggies of Meth
RegisterNetEvent("crafting:trigger:34")
AddEventHandler("crafting:trigger:34", function()
 if exports['core']:GetItemQuantity(359) >= 1 and exports['core']:GetItemQuantity(112) >= 1 and exports['core']:GetItemQuantity(119) >= 1 then
  TriggerEvent("inventory:removeQty", 359, 1)
  TriggerEvent("inventory:removeQty", 119, 1)
  TriggerEvent("inventory:addQty", 34, 25)
  TriggerEvent('chatMessage', "SUCCESS", {0, 173, 66}, "You've crafted 25 Baggies of Meth")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You do not have the correct materials to craft this item!")
 end
end)


-- Ounces of Heroin > Bar of Heroin
RegisterNetEvent("crafting:trigger:35")
AddEventHandler("crafting:trigger:35", function()
 if exports['core']:GetItemQuantity(158) >= 9 and exports['core']:GetItemQuantity(113) >= 1 and exports['core']:GetItemQuantity(179) >= 1 then
  TriggerEvent("inventory:removeQty", 158, 9)
  TriggerEvent("inventory:removeQty", 179, 1)
  TriggerEvent("inventory:addQty", 162, 1)
  TriggerEvent('chatMessage', "SUCCESS", {0, 173, 66}, "You've crafted a Bar of Heroin")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You do not have the correct materials to craft this item!")
 end
end)


-- Bar of Heroin > Ounces of Heroin
RegisterNetEvent("crafting:trigger:36")
AddEventHandler("crafting:trigger:36", function()
 if exports['core']:GetItemQuantity(162) >= 1 and exports['core']:GetItemQuantity(113) >= 1 and exports['core']:GetItemQuantity(119) >= 1 then
  TriggerEvent("inventory:removeQty", 162, 1)
  TriggerEvent("inventory:removeQty", 119, 1)
  TriggerEvent("inventory:addQty", 158, 9)
  TriggerEvent('chatMessage', "SUCCESS", {0, 173, 66}, "You've crafted 9 Ounces of Heroin")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You do not have the correct materials to craft this item!")
 end
end)

-- GunKit
RegisterNetEvent("crafting:trigger:10")
AddEventHandler("crafting:trigger:10", function()
 if exports['core']:GetItemQuantity(128) >= 30 and exports['core']:GetItemQuantity(138) >= 5 then
  TriggerEvent("inventory:removeQty", 128, 30)
  TriggerEvent("inventory:removeQty", 138, 5)
  TriggerEvent("inventory:addQty", 137, 1)
  TriggerEvent('chatMessage', "SUCCESS", {0, 173, 66}, "You have successfully crafted a gunkit")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You do not have the correct materials to craft this item!")
 end
end)



-- GUNS

RegisterNetEvent("crafting:trigger:11")
AddEventHandler("crafting:trigger:11", function()
 if exports['core']:GetItemQuantity(114) >= 1 and exports['core']:GetItemQuantity(115) >= 1 and exports['core']:GetItemQuantity(116) >= 1 and exports['core']:GetItemQuantity(117) >= 1 then
  TriggerEvent("inventory:removeQty", 114, 1)
  TriggerEvent("inventory:removeQty", 115, 1)
  TriggerEvent("inventory:removeQty", 116, 1)
  TriggerEvent("inventory:removeQty", 117, 1)  
  TriggerEvent("inventory:addQty", 232, 1)
  TriggerEvent('chatMessage', "SUCCESS", {0, 173, 66}, "You have successfully crafted 1x SNS Pistol")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You do not have the correct materials to craft this item!")
 end
end)

RegisterNetEvent("crafting:trigger:12")
AddEventHandler("crafting:trigger:12", function()
 if exports['core']:GetItemQuantity(143) >= 2 and exports['core']:GetItemQuantity(144) >= 1 and exports['core']:GetItemQuantity(146) >= 1 and exports['core']:GetItemQuantity(147) >= 1 then
  TriggerEvent("inventory:removeQty", 143, 2)
  TriggerEvent("inventory:removeQty", 144, 1)
  TriggerEvent("inventory:removeQty", 146, 1)
  TriggerEvent("inventory:removeQty", 147, 1)  
  TriggerEvent("inventory:addQty", 204, 2)
  TriggerEvent('chatMessage', "SUCCESS", {0, 173, 66}, "You have successfully crafted 2x Molotov")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You do not have the correct materials to craft this item!")
 end
end)

----------------------------------((((( CASH STACKS)))))----------------------
-- Cash 10k
RegisterNetEvent("crafting:trigger:17")
AddEventHandler("crafting:trigger:17", function()
 if exports['core']:GetItemQuantity(292) >= 3 then
  TriggerServerEvent("craftcash1-10k")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You have no Envelopes!")
 end  
end)
-- cash 5k
RegisterNetEvent("crafting:trigger:16")
AddEventHandler("crafting:trigger:16", function()
 if exports['core']:GetItemQuantity(292) >= 2 then
  TriggerServerEvent("craftcash2-5k")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You have no Envelopes!")
 end  
end)
-- cash 1k
RegisterNetEvent("crafting:trigger:15")
AddEventHandler("crafting:trigger:15", function()
 if exports['core']:GetItemQuantity(292) >= 1 then
  TriggerServerEvent("craftcash3-1k")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You have no Envelope!")
 end  
end)
-----------------------((((( CASH STACKS Dirty )))))--------------------------------
RegisterNetEvent("crafting:trigger:20")
AddEventHandler("crafting:trigger:20", function()
 if exports['core']:GetItemQuantity(291) >= 3 then
  TriggerServerEvent("craftcashd1-10k")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You have no rubber Bands!")
 end  
end)
-- cash 5k
RegisterNetEvent("crafting:trigger:19")
AddEventHandler("crafting:trigger:19", function()
 if exports['core']:GetItemQuantity(291) >= 2 then
  TriggerServerEvent("craftcashd1-5k")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You have no rubber Bands!")
 end  
end)
-- cash 1k
RegisterNetEvent("crafting:trigger:18")
AddEventHandler("crafting:trigger:18", function()
 if exports['core']:GetItemQuantity(291) >= 1 then
  TriggerServerEvent("craftcashd2-1k")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You have no rubber Bands!")
 end  
end)

RegisterNetEvent("crafting:trigger:21")
AddEventHandler("crafting:trigger:21", function()
 if exports['core']:GetItemQuantity(291) >= 1 then
  TriggerServerEvent("craftcashd2-100")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You have no rubber Bands!")
 end  
end)

RegisterNetEvent("crafting:trigger:22")
AddEventHandler("crafting:trigger:22", function()
 if exports['core']:GetItemQuantity(291) >= 1 then
  TriggerServerEvent("craftcashd2-50")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You have no rubber Bands!")
 end  
end)

RegisterNetEvent("crafting:trigger:23")
AddEventHandler("crafting:trigger:23", function()
 if exports['core']:GetItemQuantity(126) >= 1 then
  TriggerServerEvent("craftcashd2-50k")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You have no Suitcase!")
 end  
end)
-----------------------((((( CASH STACKS END )))))--------------------------------