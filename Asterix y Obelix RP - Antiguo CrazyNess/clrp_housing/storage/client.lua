local box_inventory = {}

local storedcash = 0

local weapon_inv = {}







Citizen.CreateThread(function()

 while true do

  Wait(5)

  if lastipl ~= nil then

   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), lastipl.item_storage.x, lastipl.item_storage.y, lastipl.item_storage.z, true) < 25) then

    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), lastipl.item_storage.x, lastipl.item_storage.y, lastipl.item_storage.z, true) < 1.2) then

      DrawText3Ds(lastipl.item_storage.x, lastipl.item_storage.y, lastipl.item_storage.z,'~g~[E]~c~ Storage ')

     if IsControlJustPressed(0, 38) then

      TriggerServerEvent("housing:storage:getInventory", currentHouse.id)

      --WarMenu.OpenMenu('house_item_storage')

     end

    end

   end

  end

 end

end)



function DrawText3Ds(x,y,z, text)

  local onScreen,_x,_y=World3dToScreen2d(x,y,z)

  local px,py,pz=table.unpack(GetGameplayCamCoords())

  

  SetTextScale(0.35, 0.35)

  SetTextFont(4)

  SetTextProportional(1)

  SetTextColour(255, 255, 255, 215)

  SetTextEntry("STRING")

  SetTextCentre(1)

  AddTextComponentString(text)

  DrawText(_x,_y)

  --local factor = (string.len(text)) / 370

  --DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)

end





RegisterNetEvent('housing:storage:updateitems')

AddEventHandler('housing:storage:updateitems', function(items, weapons)

 storedcash = cash

 box_inventory = items

 weapon_inv = weapons

end)



Citizen.CreateThread(function()

 local currentstore = 1

 local selectedstore = 1

 local currenttake = 1 

 local selectedtake = 1

 WarMenu.CreateMenu('house_item_storage', 'Storage')

 WarMenu.CreateSubMenu('storage_depsoit', 'Storage')

 WarMenu.CreateSubMenu('storage_depsoit', 'house_item_storage', 'storage_depsoit') ------------ HERE TO STORE CASH IN HOUSES

 WarMenu.CreateSubMenu('house_listitems', 'house_item_storage', 'house_listitems')

 while true do

  Citizen.Wait(0)

  if WarMenu.IsMenuOpened('house_item_storage') then

   if WarMenu.Button('Store') then

      WarMenu.OpenMenu('storage_depsoit')

   elseif WarMenu.Button('Take') then

      WarMenu.OpenMenu('house_listitems') 

   end

   WarMenu.Display()

  elseif WarMenu.IsMenuOpened('storage_depsoit') then

   local items = exports.core:getInventory()

   for i = 1,#items do

    if (items[i].q > 0) then

     if WarMenu.Button(tostring(items[i].name), tonumber(items[i].q)) then

      HouseItemStore(items[i].id, items[i].name, items[i].q) 

     end

    end

   end

   WarMenu.Display()

  elseif WarMenu.IsMenuOpened('house_listitems') then

   for i = 1,#box_inventory do

    if tonumber(box_inventory[i].q) > 0 then

     if WarMenu.Button(box_inventory[i].name, box_inventory[i].q) then

      HouseItemTake(box_inventory[i].item, box_inventory[i].q, box_inventory[i].meta)

    end

    end

   end

   WarMenu.Display()

  end

 end

end)



function HouseItemTake(item, qty, meta)

  local amount = "xxsdrtghyuujhdjsjenenfjfjtjtjtj"

  if(amount == "xxsdrtghyuujhdjsjenenfjfjtjtjtj") then

   showLoadingPrompt("Enter Quantity", 3)

   DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8S", "", "", "", "", "", 20)

   while (UpdateOnscreenKeyboard() == 0) do

    DisableAllControlActions(0);

    Wait(0);

   end

   if (GetOnscreenKeyboardResult()) then

    local option = tonumber(GetOnscreenKeyboardResult())

    if(option ~= nil and option ~= 0) then

     amount = ""..option

    end

   end

  end

  stopLoadingPrompt()

  if (amount ~= "xxsdrtghyuujhdjsjenenfjfjtjtjtj" and tonumber(amount) > 0) then

   if math.floor(exports['core']:getQuantity() + amount) <= 80 then

    if tonumber(qty) >= tonumber(amount) then

     TriggerServerEvent('housing:storage:removeitems', currentHouse.id, item, amount)

     TaskStartScenarioInPlace(GetPlayerPed(-1), 'PROP_HUMAN_PARKING_METER', false, true) 

     Wait(4000) 

     ClearPedTasksImmediately(GetPlayerPed(-1))

    end

  else

   exports['clrp_notify']:DoHudText('error', 'You Dont Have Enough Space In Your Inventory')

  end

 end

end



function HouseItemStore(item, name, quantity)

 local amount = "xxsdrtghyuujhdjsjenenfjfjtjtjtj"

 if(amount == "xxsdrtghyuujhdjsjenenfjfjtjtjtj") then

  showLoadingPrompt("Enter Quantity", 3)

  DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8S", "", "", "", "", "", 20)

  while (UpdateOnscreenKeyboard() == 0) do

   DisableAllControlActions(0);

   Wait(0);

  end

  if (GetOnscreenKeyboardResult()) then

   local option = tonumber(GetOnscreenKeyboardResult())

   if(option ~= nil and option ~= 0) then

    amount = ""..option

   end

  end

 end

 stopLoadingPrompt()

 if (amount ~= "xxsdrtghyuujhdjsjenenfjfjtjtjtj" and tonumber(amount) > 0) then

  if amount + getHousingQuantity() <= 600 then

    if tonumber(quantity) >= tonumber(amount) then

     TriggerServerEvent('housing:storage:additems', currentHouse.id, item, name, amount)

     TaskStartScenarioInPlace(GetPlayerPed(-1), 'PROP_HUMAN_PARKING_METER', false, true) 

     Wait(4000) 

     ClearPedTasksImmediately(GetPlayerPed(-1))

    end 

  else

   exports['clrp_notify']:DoHudText('error', 'House Storage Can Hold 600 Items Max')

  end

 end

end



function getHousingQuantity()

 local quantity = 0

 for i=1,#box_inventory do

  quantity = quantity + box_inventory[i].q

 end

 return quantity

end



function getHousingWeapons()

 local quantity = 0

 for i=1,#weapon_inv do

  quantity = quantity + 1

 end

 return quantity

end

