local house_contents = nil

RegisterNetEvent('housing:storage:updateitems')
AddEventHandler('housing:storage:updateitems', function(inv)
    setHouseItems(inv)
end)

RegisterNetEvent("housing:storage:openInventory")
AddEventHandler("housing:storage:openInventory", function(boxid)
    house_contents = boxid
    openHouseInventory()
end)

function setHouseItems(data)

    SendNUIMessage(
        {
            action = "setInfoText",
            text = "600 ITEMS MAX"
        }
    )

    items = {}

    if data ~= nil then
        for key, value in pairs(data) do
            if data[key].q <= 0 then
                data[key] = nil
            else
                data[key].type = "item_standard"
                data[key].usable = false
                data[key].limit = -1
                data[key].canRemove = false
                if data[key].meta == "This Item Contains No Meta Data" then data[key].desc = "" else data[key].desc = data[key].meta end
                table.insert(items, data[key])
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

function openHouseInventory()
    loadPlayerInventory()
    isInInventory = true

    SendNUIMessage(
        {
            action = "display",
            type = "home"
        }
    )

    SetNuiFocus(true, true)
end

RegisterNUICallback(
    "PutIntoHome",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
        local count = tonumber(data.number)
         if data.item.q >= data.number then
            TriggerServerEvent('housing:storage:additems', house_contents, data.item.id, data.item.name, data.number, data.item.meta)
         else
            exports['clrp_notify']:DoHudText('inform', 'You do not have enough of that item to put in the storage!')
         end
        end

        Wait(250)
        loadPlayerInventory()

        cb("ok")
    end
)

RegisterNUICallback(
    "TakeFromHome",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
         if data.item.q >= data.number then
            TriggerServerEvent('housing:storage:removeitems', house_contents, data.item.item, data.number, data.item.meta)
         else
            exports['clrp_notify']:DoHudText('inform', 'You can not take out more than what is in the storage!')
         end
        end

        Wait(250)
        loadPlayerInventory()

        cb("ok")
    end
)
