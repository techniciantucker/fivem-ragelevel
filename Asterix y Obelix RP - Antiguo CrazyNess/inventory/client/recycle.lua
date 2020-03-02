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

RegisterNetEvent("recycling:Open")
AddEventHandler("recycling:Open", function()
    openRecycleShop()
end)

function openRecycleShop()
    loadPlayerInventory()
    isInInventory = true

    SendNUIMessage(
        {
            action = "setInfoText",
            text = "RECYCLING"
        }
    )

    SendNUIMessage(
        {
            action = "display",
            type = "recycle"
        }
    )

    SetNuiFocus(true, true)
end

RegisterNUICallback(
    "SellToRecycling",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
        local count = tonumber(data.number)
         if data.item.q >= data.number then
          if data.item.isRecyclable == 1 then
           TriggerServerEvent('pawnshop:recycle', data.item.id, data.item.name, data.number)
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