RegisterNetEvent("inventory:openTrash")
AddEventHandler("inventory:openTrash", function()
    openTrashCan()
end)

function openTrashCan()
    loadPlayerInventory()
    isInInventory = true

    SendNUIMessage(
        {
            action = "setInfoText",
            text = "TRASH CAN"
        }
    )

    SendNUIMessage(
        {
            action = "display",
            type = "trash"
        }
    )

    SetNuiFocus(true, true)
end

RegisterNUICallback(
    "PutIntoTrash",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
        local count = tonumber(data.number)
         if data.item.q >= data.number then
            TriggerServerEvent('inventory:trashItem', data.item.id, data.number, data.item.meta)
         else
            exports['clrp_notify']:DoHudText('inform', 'You do not have enough of that item to put in the trash!')
         end
        end

        Wait(250)
        loadPlayerInventory()

        cb("ok")
    end
)