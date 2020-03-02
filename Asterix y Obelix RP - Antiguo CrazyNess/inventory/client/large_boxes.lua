local large_box_id = nil

RegisterNetEvent('storage_box2:updateitems')
AddEventHandler('storage_box2:updateitems', function(inv)
    setLBoxItems(inv)
end)

RegisterNetEvent("storage_box2:openInventory")
AddEventHandler("storage_box2:openInventory", function(boxid)
    print("Opening Inventory")
    large_box_id = boxid
    openLBoxInventory()
end)

function setLBoxItems(data)

    SendNUIMessage(
        {
            action = "setInfoText",
            text = "LARGE STORAGE BOX"
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

function openLBoxInventory()
    loadPlayerInventory()
    isInInventory = true

    SendNUIMessage(
        {
            action = "display",
            type = "lbox"
        }
    )

    SetNuiFocus(true, true)
end

RegisterNUICallback(
    "PutIntoLBox",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
        local count = tonumber(data.number)
         if data.item.q >= data.number then
            TriggerServerEvent('storage_box2:additems', large_box_id, data.item.id, data.item.name, data.number, data.item.meta)
         else
            exports['clrp_notify']:DoHudText('inform', 'You do not have enough of that item to put in the box!')
         end
        end

        Wait(250)
        loadPlayerInventory()

        cb("ok")
    end
)

RegisterNUICallback(
    "TakeFromLBox",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
         if data.item.q >= data.number then
            TriggerServerEvent('storage_box2:removeitems', large_box_id, data.item.item, data.number, data.item.meta)
         else
            exports['clrp_notify']:DoHudText('inform', 'You can not take out more than what is in the box!')
         end
        end

        Wait(250)
        loadPlayerInventory()

        cb("ok")
    end
)
