local inv = {}
local Keys = {
    ["ESC"] = 322,
    ["F1"] = 288,
    ["F2"] = 289,
    ["F3"] = 170,
    ["F5"] = 166,
    ["F6"] = 167,
    ["F7"] = 168,
    ["F8"] = 169,
    ["F9"] = 56,
    ["F10"] = 57,
    ["~"] = 243,
    ["1"] = 157,
    ["2"] = 158,
    ["3"] = 160,
    ["4"] = 164,
    ["5"] = 165,
    ["6"] = 159,
    ["7"] = 161,
    ["8"] = 162,
    ["9"] = 163,
    ["-"] = 84,
    ["="] = 83,
    ["BACKSPACE"] = 177,
    ["TAB"] = 37,
    ["Q"] = 44,
    ["W"] = 32,
    ["E"] = 38,
    ["R"] = 45,
    ["T"] = 245,
    ["Y"] = 246,
    ["U"] = 303,
    ["P"] = 199,
    ["["] = 39,
    ["]"] = 40,
    ["ENTER"] = 18,
    ["CAPS"] = 137,
    ["A"] = 34,
    ["S"] = 8,
    ["D"] = 9,
    ["F"] = 23,
    ["G"] = 47,
    ["H"] = 74,
    ["K"] = 311,
    ["L"] = 182,
    ["LEFTSHIFT"] = 21,
    ["Z"] = 20,
    ["X"] = 73,
    ["C"] = 26,
    ["V"] = 0,
    ["B"] = 29,
    ["N"] = 249,
    ["M"] = 244,
    [","] = 82,
    ["."] = 81,
    ["LEFTCTRL"] = 36,
    ["LEFTALT"] = 19,
    ["SPACE"] = 22,
    ["RIGHTCTRL"] = 70,
    ["HOME"] = 213,
    ["PAGEUP"] = 10,
    ["PAGEDOWN"] = 11,
    ["DELETE"] = 178,
    ["LEFT"] = 174,
    ["RIGHT"] = 175,
    ["TOP"] = 27,
    ["DOWN"] = 173,
    ["NENTER"] = 201,
    ["N4"] = 108,
    ["N5"] = 60,
    ["N6"] = 107,
    ["N+"] = 96,
    ["N-"] = 97,
    ["N7"] = 117,
    ["N8"] = 61,
    ["N9"] = 118
}

isInInventory = false

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            DisableControlAction(0, 289)
            if IsDisabledControlJustReleased(0, 289) and IsInputDisabled(0) then
                openInventory()
            end
        end
    end
)

function openInventory()
    loadPlayerInventory()
    isInInventory = true
    SendNUIMessage(
        {
            action = "display",
            type = "normal"
        }
    )
    SetNuiFocus(true, true)
end

function closeInventory()
    isInInventory = false
    SendNUIMessage(
        {
            action = "hide"
        }
    )
    SetNuiFocus(false, false)
end

RegisterNUICallback(
    "NUIFocusOff",
    function()
        closeInventory()
    end
)

RegisterNUICallback(
    "UseItem",
    function(data, cb)
        use(data.item, data.meta)
        closeInventory()

        cb("ok")
    end
)

RegisterNUICallback(
    "DropItem",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end


        if type(data.number) == "number" and math.floor(data.number) == data.number then
         if exports['core']:GetItemQuantity(data.item.id) >= data.number then
           local pos = GetEntityCoords(GetPlayerPed(-1), 0)
            ExecuteCommand("me drops something on ground")
            TaskPlayAnim(GetPlayerPed(-1), "anim@mp_snowball", "pickup_snowball", 8.0, -1, -1, false, 1, 0, 0, 0)
            TriggerServerEvent("inventory:drop", tonumber(data.item.id), tonumber(data.number), {x = pos.x, y = pos.y, z = pos.z}, data.item.meta)
         end
        end

        Wait(250)
        loadPlayerInventory()

        cb("ok")
    end
)


RegisterNUICallback(
    "GiveItem",
    function(data, cb)
    if exports['core']:GetItemQuantity(data.item.id) >= data.number then
        local t, distance = GetClosestPlayer()
        if(distance ~= -1 and distance < 3) then
         --TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_ATM", 0, true)
         TriggerServerEvent("inventory:give", tonumber(data.item.id), tonumber(data.number), tostring(data.item.meta), GetPlayerServerId(t))
        else
         exports['clrp_notify']:DoHudText('inform', 'No Player Near')
        end
    else
        exports['clrp_notify']:DoHudText('inform', 'You do not have enough of that item to give!')
    end

    Wait(250)
    loadPlayerInventory()
        cb("ok")
    end
)

-- Nearest Players
function GetClosestPlayer()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)
    
    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = Vdist(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"])
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
    
    return closestPlayer, closestDistance
end

function GetPlayers()
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end

--==============================================================================================================================--

function use(item, meta)
    if item == 2 then
        removeQty(item,1)
        TriggerEvent('storage_box:new')
       elseif item == 6 then 
        removeQty(item,1)
        TriggerEvent('items:repair2')
		--TriggerEvent('veh:repairing')
       elseif item == 118 then
        TriggerEvent('weed:plantStart')			
       elseif item == 7 then
        removeQty(item,math.random(0,1)) 
        TriggerEvent('items:lockpick')
		TriggerEvent('houseRobberies:rob')
		TriggerEvent('storeBurglary:rob')		
       elseif item == 8 then
        TriggerEvent('items:binoculars')
       elseif item == 9 then 
        removeQty(item,1)
        TriggerEvent('ems:medkit')  
       elseif item == 10 then 
        removeQty(item,1)
        TriggerEvent('ems:bandage')
       elseif item == 11 then
        removeQty(item,1)
        TriggerEvent('items:cleankit')
       elseif item == 12 then
        TriggerEvent('items:umbrella')
       elseif item == 13 then
        removeQty(item,1)
        TriggerEvent('food:drink')
       elseif item == 14 then
        removeQty(item,1)
        TriggerEvent('food:cheeseburger')
       elseif item == 15 then
        removeQty(item,1)
        TriggerEvent('items:smoke')
       elseif item == 21 then
        TriggerEvent('items:lockpick')
       elseif item == 22 or item == 23 or item == 24 then
        removeQty(item,1)
        TriggerEvent('items:beer')
        TriggerEvent('police:bac', 0.05)
       elseif item == 25 then 
        removeQty(item,1)
        TriggerEvent('items:wine')
        TriggerEvent('police:bac', 0.03)
       elseif item == 26 then 
        removeQty(item,1)
        TriggerEvent('items:redbull')
        TriggerEvent('food:eCola')		
       elseif item == 27 then 
        removeQty(item,1)
        TriggerEvent('items:vodka')
        TriggerEvent('police:bac', 0.05)
       elseif item == 28 then 
        removeQty(item,1)
        TriggerEvent('items:vodka')
        TriggerEvent('police:bac', 0.05)
       elseif item == 41 then
        removeQty(item,1)
        TriggerEvent('items:oxygen_mask')
       elseif item == 50 then
        removeQty(item,1)  
        TriggerEvent('items:ketamine')
       elseif item == 57 then 
        removeQty(item,1)
        TriggerEvent('illness:generalAnasteticGiver')
       elseif item == 59 then 
        removeQty(item,1)
        TriggerEvent('illness:bloodTest')
       elseif item == 60 then 
        removeQty(item,1)
        TriggerEvent('illness:useOfCondom')
       elseif item == 61 then 
        removeQty(item,1)
       -- TriggerEvent('illness:cureChlam')
		TriggerEvent('emsItem:ibuprofen')
       --elseif item == 74 then
       elseif item == 85 then
        removeQty(item,1)
        TriggerEvent('storage_box2:new')
       elseif item == 43 then
        removeQty(item,1)
        TriggerEvent('emsItem:paracetamol')		
       elseif item == 86 then
        removeQty(item,1)
        TriggerEvent('weapon_box:new')
       elseif item == 110 then 
        removeQty(item,1)
        TriggerEvent('items:coke')
       elseif item == 123 or item == 124 then 
        removeQty(item,1)
        TriggerEvent('items:weed')
       elseif item == 102 then 
        removeQty(item,1)
        TriggerEvent('ems:giveMorphine')
       elseif item == 103 then
        removeQty(item,1) 
        TriggerEvent('food:eat') 		
       elseif item == 104 then
        TriggerEvent("phone:toggle")
       elseif item == 105 then
        removeQty(item,1)
        TriggerEvent('food:hotdog')
       elseif item == 106 then
        removeQty(item,1)
        TriggerEvent('food:sana')
       elseif item == 126 then
        SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey('WEAPON_BRIEFCASE'))
       elseif item == 42 then
        removeQty(item,1)
        TriggerEvent('items:bulletproof_vest')
       elseif item == 139 then
        removeQty(item,1)
        TriggerEvent('items:campfire')
       elseif item == 140 then
        removeQty(item,1)
        TriggerEvent('items:tent')
       elseif item == 144 then
        removeQty(item,1)
        TriggerEvent('ML:items:medkit')
       elseif item == 145 then
        removeQty(item,1)
        TriggerEvent('ems:medkit')  
       elseif item == 147 then
        TriggerEvent('ML:items:vicodin')
        removeQty(item,1)  
       elseif item == 148 then
        TriggerEvent('ML:items:hydrocodone')
        removeQty(item,1)
       elseif item == 149 then
        TriggerEvent('ML:items:morphine')
        removeQty(item,1)
       elseif item == 150 then 
        TriggerEvent("ML-hospital:items:gauze")
        removeQty(item,1)
       elseif item == 152 then 
        TriggerServerEvent('ML-B-Cashstacks-10k')  
        removeQty(item,1)
       elseif item == 153 then 
        TriggerServerEvent('ML-B-Cashstacks-5k')  
        removeQty(item,1)
       elseif item == 154 then 
        TriggerServerEvent('ML-B-Cashstacks-1k')  
        removeQty(item,1)
       elseif item == 176 then 
        TriggerServerEvent('ML-B-Dirtystacks-10k')  
        removeQty(item,1)
       elseif item == 177 then 
        TriggerServerEvent('ML-B-Dirtystacks-5k')  
        removeQty(item,1)
       elseif item == 178 then 
        TriggerServerEvent('ML-B-Dirtystacks-1k')  
        removeQty(item,1)
       elseif item == 128 then 
        TriggerEvent('weed:newPlant', 0, 128)  		
       elseif item == 73 then 
        TriggerEvent("ML-hospital:items:firstaid")
        removeQty(item,1)
       elseif item == 96 then 
          TriggerEvent('ML-Mech:Gearbox')
          removeQty(item,1)
       elseif item == 97 then 
          TriggerEvent("ML-Mech:Clutch")
          removeQty(item,1)
       elseif item == 59 then 
          TriggerEvent('emsItem:bloodBag')
          removeQty(item,1)		  
       elseif item == 98 then 
          TriggerEvent("ML-Mech:Exhuast")
          removeQty(item,1)
       elseif item == 100 then 
          TriggerEvent("ML-Mech:Muffler")
          removeQty(item,1)
       elseif item == 101 then 
          TriggerEvent("ML-Mech:SparkPlug")
          removeQty(item,1)
       elseif item == 99 then 
          TriggerEvent("ML-Mech:AirFilter")
          removeQty(item,1)
       elseif item == 52 then 
          TriggerEvent("ML-Mech:CConverter")
          removeQty(item,1)
       elseif item == 173 then 
          TriggerEvent("ML-Mech:Radiator")
          removeQty(item,1)
       elseif item == 157 then 
          TriggerEvent("items:meth")
          removeQty(item,1)
       elseif item == 159 then 
          TriggerEvent("items:heroin")
          removeQty(item,1)
       elseif item == 160 then
          if exports['core']:GetItemQuantity(121) >= 1 and exports['core']:GetItemQuantity(15) >= 1 and exports['core']:GetItemQuantity(160) >= 1 then
              TriggerEvent("mythic_progbar:client:progress", {
                  name = "rolling_joint",
                  duration = 10000,
                  label = "Rolling A Joint",
                  useWhileDead = false,
                  canCancel = true,
                  controlDisables = {
                      disableMovement = false,
                      disableCarMovement = false,
                      disableMouse = false,
                      disableCombat = true,
                  },
                  animation = {
                      animDict = "missheistdockssetup1clipboard@idle_a",
                      anim = "idle_a",
                  },
                  prop = {
                      model = "prop_weed_bottle",
                  }
              }, function(status)
                  if not status then
                      TriggerEvent("inventory:removeQty", 121, 1)
                      TriggerEvent("inventory:removeQty", 15, 1)
                      TriggerEvent("inventory:removeQty", 160, 1)
                      TriggerEvent("inventory:addQty", 124, 4)
                      TriggerEvent('chatMessage', "SUCCESS", {0, 173, 66}, "You have successfully made 4x Joints")
                  end
              end)     
          else
              TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You need a Gram of Weed and a Cigarette to make some Joints!")
          end
       elseif item == 257 then
          removeQty(item,1)
          TriggerEvent('food:coffee')
    elseif item == 205 then
     removeQty(item,1)
     local veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
     local currentFuel = DecorGetInt(veh, "_Fuel_Level")
     if tonumber(currentFuel+10000) <= 100000 then
      DecorSetInt(veh, "_Fuel_Level", tonumber(currentFuel+10000))
     end		  
       elseif item == 260 then
          removeQty(item,1)
          TriggerEvent('food:donut')
       elseif item == 258 then
          removeQty(item,1)
          TriggerEvent('food:')
       elseif item == 259 then
          removeQty(item,1)
          TriggerEvent('food:sprunk')
       elseif item == 250 then
          TriggerEvent('items:cuff')
       elseif item == 251 then
          TriggerEvent('items:cuff')      
      end
    loadPlayerInventory()
end

function removeQty(i,q)
    TriggerServerEvent("inventory:remove", tonumber(i),tonumber(q))
end

function addQty(i,q)
    TriggerServerEvent("inventory:add", tonumber(i),tonumber(q))
end

function shouldCloseInventory(itemName)
    for index, value in ipairs(Config.CloseUiItems) do
        if value == itemName then
            return true
        end
    end

    return false
end

function shouldSkipAccount(accountName)
    for index, value in ipairs(Config.ExcludeAccountsList) do
        if value == accountName then
            return true
        end
    end

    return false
end

RegisterNetEvent("inventory:updateitems")
AddEventHandler("inventory:updateitems", function(inve)
    inv = inve
end)

function loadPlayerInventory()
    items = {}
    inventory = inv


            if inventory ~= nil then
                for key, value in pairs(inventory) do
                    if inventory[key].q <= 0 then
                        inventory[key] = nil
                    else
                        inventory[key].type = "item_standard"
                        inventory[key].canRemove = "true"
                        if inventory[key].meta == "This Item Contains No Meta Data" then inventory[key].desc = "" else inventory[key].desc = inventory[key].meta end
                        table.insert(items, inventory[key])
                    end
                end
            end

            SendNUIMessage(
                {
                    action = "setItems",
                    itemList = items
                }
            )
            
end


Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1)
            if isInInventory then
                local playerPed = PlayerPedId()
                DisableControlAction(0, 1, true) -- Disable pan
                DisableControlAction(0, 2, true) -- Disable tilt
                DisableControlAction(0, 24, true) -- Attack
                DisableControlAction(0, 257, true) -- Attack 2
                DisableControlAction(0, 25, true) -- Aim
                DisableControlAction(0, 263, true) -- Melee Attack 1
                DisableControlAction(0, Keys["W"], true) -- W
                DisableControlAction(0, Keys["A"], true) -- A
                DisableControlAction(0, 31, true) -- S (fault in Keys table!)
                DisableControlAction(0, 30, true) -- D (fault in Keys table!)

                DisableControlAction(0, Keys["R"], true) -- Reload
                DisableControlAction(0, Keys["SPACE"], true) -- Jump
                DisableControlAction(0, Keys["Q"], true) -- Cover
                DisableControlAction(0, Keys["TAB"], true) -- Select Weapon
                DisableControlAction(0, Keys["F"], true) -- Also 'enter'?

                DisableControlAction(0, Keys["F1"], true) -- Disable phone
                DisableControlAction(0, Keys["F2"], true) -- Inventory
                DisableControlAction(0, Keys["F3"], true) -- Animations
                DisableControlAction(0, Keys["F6"], true) -- Job

                DisableControlAction(0, Keys["V"], true) -- Disable changing view
                DisableControlAction(0, Keys["C"], true) -- Disable looking behind
                DisableControlAction(0, Keys["X"], true) -- Disable clearing animation
                DisableControlAction(2, Keys["P"], true) -- Disable pause screen

                DisableControlAction(0, 59, true) -- Disable steering in vehicle
                DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
                DisableControlAction(0, 72, true) -- Disable reversing in vehicle

                DisableControlAction(2, Keys["LEFTCTRL"], true) -- Disable going stealth

                DisableControlAction(0, 47, true) -- Disable weapon
                DisableControlAction(0, 264, true) -- Disable melee
                DisableControlAction(0, 257, true) -- Disable melee
                DisableControlAction(0, 140, true) -- Disable melee
                DisableControlAction(0, 141, true) -- Disable melee
                DisableControlAction(0, 142, true) -- Disable melee
                DisableControlAction(0, 143, true) -- Disable melee
                DisableControlAction(0, 75, true) -- Disable exit vehicle
                DisableControlAction(27, 75, true) -- Disable exit vehicle
            end
        end
    end
)
