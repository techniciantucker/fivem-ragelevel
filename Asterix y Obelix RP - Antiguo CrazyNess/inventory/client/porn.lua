local pawnable = {
    {id = 52, name = "Catalytic Converter"},
    {id = 53, name = "Car Stereo"},
    {id = 54, name = "Vehicle Airbag"},
    {id = 55, name= "Electrical Wire"},
    {id = 11, name = "Cleaning Kit"},
    {id = 12, name = "Umbrella"},
    {id = 8, name = "Binoculars"},
    {id = 6, name = "Repair Kit"},
    {id = 67, name = "Rollex"},
    {id = 127, name = "Necklace"},
    {id = 129, name = "Watch"},
    {id = 128, name = "Ring"},
   }

RegisterNetEvent("pawnshop:Open")
AddEventHandler("pawnshop:Open", function()
    openPawnShop()
end)

function openPawnShop()
    loadPlayerInventory()
    isInInventory = true

    SendNUIMessage(
        {
            action = "setInfoText",
            text = "PAWN SHOP"
        }
    )

    SendNUIMessage(
        {
            action = "display",
            type = "pawn"
        }
    )

    SetNuiFocus(true, true)
end

RegisterNUICallback(
    "SellToPawnShop",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
        local count = tonumber(data.number)
         if data.item.q >= data.number then
          for k,v in pairs(pawnable) do
            if v.id == data.item.id then
             TriggerServerEvent('pawnshop:pawn', data.item.id, v.name, data.number)
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