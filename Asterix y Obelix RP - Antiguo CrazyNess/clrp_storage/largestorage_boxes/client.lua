local storage_boxes = {}
local storage_boxes_props = {}
local box_inventory = {}
local box_id = nil

Citizen.CreateThread(function()
 while true do
  Wait(5)
  local coords = GetEntityCoords(GetPlayerPed(-1))
  for k,v in pairs(storage_boxes) do
   if(GetDistanceBetweenCoords(coords, v.location.x, v.location.y, v.location.z, true) < 1.6) then
    drawTxt('~b~Press ~g~E~b~ To Access Large Storage Box')
    if IsControlJustPressed(0, 38) then
     box_id = v.box_id
     print('[DEV INFO] Storage Box ID: '..box_id)
     local amount = "xxsdrtghyuujhdjsjenenfjfjtjtjtj"
     if(amount == "xxsdrtghyuujhdjsjenenfjfjtjtjtj") then
      showLoadingPrompt('Enter Pass Code', 3)
      DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8S", "", "", "", "", "", 20)
      while (UpdateOnscreenKeyboard() == 0) do
       DisableAllControlActions(0);
       Wait(0);
      end
      if (GetOnscreenKeyboardResult()) then
       local option = tonumber(GetOnscreenKeyboardResult())
       if(option ~= nil and option ~= 0) then
        amount = option
       end
      end
     end
     stopLoadingPrompt()
     if amount == v.pin then
      TriggerServerEvent("storage_box2:getInventory", box_id)
      WarMenu.OpenMenu('storage_box2')
     else
      exports.pNotify:SendNotification({text = "Wrong Pass Code"})
     end
    end
   end
  end
 end
end)


Citizen.CreateThread(function()
 WarMenu.CreateLongMenu('storage_box2', 'Storage Box')
 WarMenu.CreateSubMenu('storage_inv2', 'storage_box2', 'storage_inv2')
 WarMenu.CreateSubMenu('player_inv2', 'storage_box2', 'player_inv2')
 while true do
  Citizen.Wait(5)
  if WarMenu.IsMenuOpened('storage_box2') then
   DecorSetBool(GetPlayerPed(-1), 'isInStorage', true)
   if WarMenu.MenuButton('Store Items', 'player_inv2') then
   elseif WarMenu.MenuButton('Take Items', 'storage_inv2') then
   elseif WarMenu.Button('Move Storage Box') then
    moveStorageBox2(box_id)
   elseif WarMenu.Button('Remove Storage Box') then
    DeleteObject(storage_boxes_props[box_id].prop)
    TriggerServerEvent('storage_box2:removebox', box_id)
   end
   WarMenu.Display()
  elseif WarMenu.IsMenuOpened('storage_inv2') then
   for i = 1,#box_inventory do
    if (box_inventory[i].q > 0) then
     if WarMenu.Button(box_inventory[i].name, box_inventory[i].q) then
      StorageItemTake2(box_inventory[i].item, box_inventory[i].q, box_inventory[i].meta)
     end
    end
   end
   if WarMenu.MenuButton('Back', 'storage_box') then
   end
   WarMenu.Display()
  elseif WarMenu.IsMenuOpened('player_inv2') then
   local inventory = exports['core']:getInventory()
   for i = 1,#inventory do
    if (inventory[i].q > 0) then
     if WarMenu.Button(tostring(inventory[i].name), tonumber(inventory[i].q)) then
      StorageItemStore2(inventory[i].id, inventory[i].name, inventory[i].q) 
     end
    end
   end
   if WarMenu.MenuButton('Back', 'storage_box') then
   end
   WarMenu.Display()
  elseif DecorGetBool(GetPlayerPed(-1), 'isInStorage') then 
   DecorSetBool(GetPlayerPed(-1), 'isInStorage', false)
  end       
 end
end)

function StorageItemStore2(item, name, quantity)
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
  if amount + getBoxQuantity() <= 320 then
   if tonumber(quantity) >= tonumber(amount) then
    TriggerServerEvent('storage_box2:additems', box_id, item, name, amount)
   end
  else
   exports.pNotify:SendNotification({text = "Storage Boxes Can Only Hold 320 Items"})
  end
 end
end

function StorageItemTake2(item, qty, meta)
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
  if math.floor(exports['core']:getQuantity() + amount) <= 120 then
   if tonumber(qty) >= tonumber(amount) then
    TriggerServerEvent('storage_box2:removeitems', box_id, item, amount, meta)
   end
  else
   exports.pNotify:SendNotification({text = "Inventory Full"})
  end
 end
end

function getBoxQuantity()
 local quantity = 0
 for i=1,#box_inventory do
  quantity = quantity + box_inventory[i].q
 end
 return quantity
end

RegisterNetEvent('storage_box2:updateitems')
AddEventHandler('storage_box2:updateitems', function(items)
 box_inventory = items
end)

AddEventHandler('storage_box2:new', function()
 WarMenu.CloseMenu()
 local pos = GetEntityCoords(GetPlayerPed(-1))
 local pin = openNumberBox("Create A Pass Code, (Numbers Only)")
 TriggerServerEvent('storage_box2:addbox', pos.x, pos.y, pos.z, pin)
end)

RegisterNetEvent('storage_box2:updateboxes')
AddEventHandler('storage_box2:updateboxes', function(boxes)
 storage_boxes = boxes
 -- Create new props
 for _,v in pairs(boxes) do 
  if not storage_boxes_props[v.box_id] then 
   SpawnObject2(v.box_id, v.location)
  end
 end
end)

function SpawnObject2(id, coords)
 local prophash = GetHashKey('prop_boxpile_04a')
 RequestModel(prophash)
 while not HasModelLoaded(prophash) do
  Citizen.Wait(0)
 end

 local propsobj = CreateObjectNoOffset(prophash, coords.x, coords.y, coords.z-0.90, true, true, true)

 SetEntityHeading(propsobj, 0)
 SetEntityAsMissionEntity(propsobj)
 FreezeEntityPosition(propsobj, true, true)
 SetModelAsNoLongerNeeded(prophash)
 storage_boxes_props[id] = {prop = propsobj, location = coords}
end

--- way to move storage boxes when moving places you into animation and you hold the box aka carry it until placed back down
local boxObject = nil 

function moveStorageBox2(id)
 local pos = GetEntityCoords(GetPlayerPed(-1), false) 
 DeleteObject(storage_boxes_props[id].prop)
 LoadModel("prop_cs_cardbox_01")
 boxObject = CreateObject(GetHashKey("prop_cs_cardbox_01"), pos.x, pos.y, pos.z, true)
 AttachEntityToEntity(boxObject, PlayerPedId(), GetPedBoneIndex(PlayerPedId(),  28422), 0.0, -0.03, 0.0, 5.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
 LoadAnim("anim@heists@box_carry@")
 TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 8.0, 8.0, -1, 50, 0, false, false, false)
 movingBox = true 

 while movingBox do
  Citizen.Wait(1)
  drawTxt('~b~Press ~g~M~b~ To Drop Box')
  if not IsPedInAnyVehicle(GetPlayerPed(-1), false) then 
   if not IsEntityPlayingAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 3) then
    TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 8.0, 8.0, -1, 50, 0, false, false, false) 
   end
  end
  if IsControlJustPressed(0, 244) then
   local pos = GetEntityCoords(GetPlayerPed(-1), false) 
   ClearPedTasks(GetPlayerPed(-1))
   DeleteObject(boxObject)
   TriggerServerEvent('storage_box2:move', id, pos.x,pos.y,pos.z)
   movingBox = false
  end
 end
end

function LoadAnim(animDict)
  RequestAnimDict(animDict)

  while not HasAnimDictLoaded(animDict) do
    Citizen.Wait(10)
  end
end

function LoadModel(model)
  RequestModel(model)

  while not HasModelLoaded(model) do
    Citizen.Wait(10)
  end
end
