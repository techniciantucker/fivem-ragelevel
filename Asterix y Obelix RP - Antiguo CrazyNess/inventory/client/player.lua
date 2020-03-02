local targetPlayer = nil
local inv = nil

RegisterNetEvent("inventory:policeopen")
AddEventHandler("inventory:policeopen", function(inventory, target)
        inv = inventory
        targetPlayer = target
        setPlayerInventoryData(inv)
        openPlayerInventory()
end)

RegisterNetEvent("inventory:otherPlayerRefresh")
AddEventHandler("inventory:otherPlayerRefresh", function(inventory, target)
        targetPlayer = target
        inv = inventory
        setPlayerInventoryData(inv)
end)

function refreshPlayerInventory()
    setPlayerInventoryData()
end

function setPlayerInventoryData(inventory)
    SendNUIMessage(
        {
            action = "setInfoText",
            text = "PLAYER INVENTORY"
        }
    )

    items = {}

    if inventory ~= nil then
        for key, value in pairs(inventory) do
            if inventory[key].q <= 0 then
                inventory[key] = nil
            else
                inventory[key].type = "item_standard"
                inventory[key].usable = false
                inventory[key].limit = -1
                inventory[key].canRemove = false
                if inventory[key].meta == "This Item Contains No Meta Data" then inventory[key].desc = "" else inventory[key].desc = inventory[key].meta end
                print(inventory[key].meta)
                table.insert(items, inventory[key])
            end
        end
    end

    SendNUIMessage(
        {
            action = "setSecondInventoryItems",
            itemList = items
        }
    )
end

function openPlayerInventory()
    loadPlayerInventory()
    isInInventory = true

    SendNUIMessage(
        {
            action = "display",
            type = "player"
        }
    )

    SetNuiFocus(true, true)
end

RegisterNUICallback(
    "PutIntoPlayer",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
            local count = tonumber(data.number)
            TriggerServerEvent("inventory:putItem", targetPlayer, data.item.id, count, data.item.meta)
        end

        Wait(250)
        loadPlayerInventory()

        cb("ok")
    end
)

RegisterNUICallback(
"TakeFromPlayer",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
            local count = tonumber(data.number)
            --if data.item.id == 137 and DecorGetInt(GetPlayerPed(-1), "Job") ~= 1 then
             --TriggerEvent('chatMessage', "INVENTORY", {255, 204, 0}, "You are not able to take this item from the players inventory.")
            --else
             TriggerServerEvent("inventory:takeItem", targetPlayer, data.item.id, count, data.item.meta)
            --end
        end

        Wait(250)
        loadPlayerInventory()

        cb("ok")
    end
)
