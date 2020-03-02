local Fish = {
    [4] = {name = 'Catfish', price = 6, item = 3},
    [5] = {name = 'Cod', price = 9, item = 4},
    [7] = {name = 'Salmon', price = 15, item = 5}
   }

RegisterNetEvent("inventory:sellFish")
AddEventHandler("inventory:sellFish", function()
    openFishShop()
end)

function openFishShop()
    loadPlayerInventory()
    isInInventory = true

    SendNUIMessage(
        {
            action = "setInfoText",
            text = "FISH SHOP"
        }
    )

    SendNUIMessage(
        {
            action = "display",
            type = "fish"
        }
    )

    SetNuiFocus(true, true)
end

RegisterNUICallback(
    "SellToFishStore",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end
        print("This is running bitch")
        if type(data.number) == "number" and math.floor(data.number) == data.number then
        local count = tonumber(data.number)
         if data.item.q >= data.number then
          for k,v in pairs(Fish) do
            if v.item == data.item.id then
             TriggerServerEvent('jobs:sellfish', data.item.id, v.price, data.number, data.item.name)
            end
          end
         else
            exports['clrp_notify']:DoHudText('inform', 'You do not have enough of that item to sell.')
         end
        end

        Wait(250)
        loadPlayerInventory()

        cb("ok")
    end
)