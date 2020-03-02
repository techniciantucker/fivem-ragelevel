local trunkData = nil
local veh_inventory = {}
local vehicle_plate = nil
local vehicleType = nil
local totalAmount = 0

local maxCapacity = {
    [0] = {["item"] = 80, ["weapons"] = 1}, --Compact
    [1] = {["item"] = 120, ["weapons"] = 2}, --Sedan
    [2] = {["item"] = 150, ["weapons"] = 3}, --SUV
    [3] = {["item"] = 110, ["weapons"] = 2}, --Coupes
    [4] = {["item"] = 90, ["weapons"] = 1}, --Muscle
    [5] = {["item"] = 100, ["weapons"] = 1}, --Sports Classics
    [6] = {["item"] = 80, ["weapons"] = 1}, --Sports
    [7] = {["item"] = 30, ["weapons"] = 1}, --Super
    [8] = {["item"] = 15, ["weapons"] = 1}, --Motorcycles
    [9] = {["item"] = 40, ["weapons"] = 1}, --Off-road
    [10] = {["item"] = 600, ["weapons"] = 8}, --Industrial
    [11] = {["item"] = 25, ["weapons"] = 1}, --Utility
    [12] = {["item"] = 200, ["weapons"] = 4}, --Vans
    [14] = {["item"] = 0, ["weapons"] = 1}, --Boats
    [15] = {["item"] = 0, ["weapons"] = 1}, --Helicopters
    [16] = {["item"] = 0, ["weapons"] = 1}, --Planes
    [17] = {["item"] = 40, ["weapons"] = 1}, --Service
    [18] = {["item"] = 40, ["weapons"] = 2}, --Emergency
    [20] = {["item"] = 250, ["weapons"] = 5}, --Commercial
  }

RegisterNetEvent('vehicle_inventory:settype')
AddEventHandler('vehicle_inventory:settype', function(vehtype)
 vehicleType = vehtype
end)

RegisterNetEvent('vehicle_inventory:updateitems')
AddEventHandler('vehicle_inventory:updateitems', function(inv, weapons, total)
 setTrunkInventoryData(inv)
 veh_inventory = {}
 veh_weapons = {}
 veh_inventory = inv
 veh_weapons = weapons
 totalAmount = total
end)

RegisterNetEvent("vehicle_inventory:openInventory")
AddEventHandler("vehicle_inventory:openInventory", function(plate)
    vehicle_plate = plate
    openTrunkInventory()
end)

function setTrunkInventoryData(data)

    trunkData = data

    SendNUIMessage(
        {
            action = "setInfoText",
            text = "VEHICLE TRUNK"
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

function openTrunkInventory()
    loadPlayerInventory()
    isInInventory = true

    SendNUIMessage(
        {
            action = "display",
            type = "trunk"
        }
    )

    SetNuiFocus(true, true)
end

RegisterNUICallback(
    "PutIntoTrunk",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if totalAmount + data.number <= maxCapacity[vehicleType].item then
         if type(data.number) == "number" and math.floor(data.number) == data.number then
         local count = tonumber(data.number)
          print("Attempting to put "..data.number.." of ID: "..data.item.id.." into the vehicle plate: "..vehicle_plate.." with meta data as: "..data.item.meta)
          if data.item.q >= data.number then
             TriggerServerEvent('vehicle_inventory:additems', vehicle_plate, data.item.id, data.item.name, data.number, data.item.meta)
          else
             exports['clrp_notify']:DoHudText('inform', 'You do not have enough of that item to put in the vehicle!')
          end
         end
        else
            exports['clrp_notify']:DoHudText('inform', 'You can only store up to '..maxCapacity[vehicleType].item..' items in this vehicle!')
        end

        Wait(250)
        loadPlayerInventory()

        cb("ok")
    end
)

RegisterNUICallback(
    "TakeFromTrunk",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
            print("Attempting to take "..data.number.." of ID: "..data.item.item.." from the vehicle plate: "..vehicle_plate.." with meta data as: "..data.item.meta)
         if data.item.q >= data.number then
            TriggerServerEvent('vehicle_inventory:removeitems', vehicle_plate, data.item.item, data.number, data.item.meta)
         else
            exports['clrp_notify']:DoHudText('inform', 'You can not take out more than what is in the vehicle!')
         end
        end

        Wait(250)
        loadPlayerInventory()

        cb("ok")
    end
)
