local storage_boxes = {}
local storage_boxes_props = {}
local box_inventory = {}
local box_id = nil

DecorRegister("isInStorage", 2);

Citizen.CreateThread(function()
 while true do
  Wait(5)
  local coords = GetEntityCoords(GetPlayerPed(-1))
  for k,v in pairs(storage_boxes) do
   if(GetDistanceBetweenCoords(coords, v.location.x, v.location.y, v.location.z-0.95, true) < 1.2) then
    drawTxt('~b~Press ~g~E~b~ To Access Storage Box')
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
      TriggerServerEvent("storage_box:getInventory", box_id)
      WarMenu.OpenMenu('storage_box')
     else
      exports.pNotify:SendNotification({text = "Wrong Pass Code"})
     end
    end
   end
  end
 end
end)


Citizen.CreateThread(function()
 WarMenu.CreateLongMenu('storage_box', 'Storage Box')
 WarMenu.CreateSubMenu('storage_inv', 'storage_box', 'storage_inv')
 WarMenu.CreateSubMenu('player_inv', 'storage_box', 'player_inv')
 while true do
  Citizen.Wait(5)
  if WarMenu.IsMenuOpened('storage_box') then
   DecorSetBool(GetPlayerPed(-1), 'isInStorage', true)
   if WarMenu.MenuButton('Store Items', 'player_inv') then
   elseif WarMenu.MenuButton('Take Items', 'storage_inv') then
   elseif WarMenu.Button('Move Storage Box') then
    moveStorageBox(box_id)
   elseif WarMenu.Button('Remove Storage Box') then
    DeleteObject(storage_boxes_props[box_id].prop)
    TriggerServerEvent('storage_box:removebox', box_id)
   end
   WarMenu.Display()
  elseif WarMenu.IsMenuOpened('storage_inv') then
   for i = 1,#box_inventory do
    if (box_inventory[i].q > 0) then
     if WarMenu.Button(box_inventory[i].name, box_inventory[i].q) then
      StorageItemTake(box_inventory[i].item, box_inventory[i].q, box_inventory[i].meta)
     end
    end
   end
   if WarMenu.MenuButton('Back', 'storage_box') then
   end
   WarMenu.Display()
  elseif WarMenu.IsMenuOpened('player_inv') then
   local inventory = exports['core']:getInventory()
   for i = 1,#inventory do
    if (inventory[i].q > 0) then
     if WarMenu.Button(tostring(inventory[i].name), tonumber(inventory[i].q)) then
      StorageItemStore(inventory[i].id, inventory[i].name, inventory[i].q) 
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

function StorageItemStore(item, name, quantity)
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
  if amount + getBoxQuantity() <= 80 then
   if tonumber(quantity) >= tonumber(amount) then
    TriggerServerEvent('storage_box:additems', box_id, item, name, amount)
   end
  else
   exports.pNotify:SendNotification({text = "Storage Boxes Can Only Hold 80 Items"})
  end
 end
end

function StorageItemTake(item, qty, meta)
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
    TriggerServerEvent('storage_box:removeitems', box_id, item, amount, meta)
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

function openNumberBox(text)
 local amount = "xxsdrtghyuujhdjsjenenfjfjtjtjtj"
 if(amount == "xxsdrtghyuujhdjsjenenfjfjtjtjtj") then
  showLoadingPrompt(text, 3)
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
  return amount
 end
end

RegisterNetEvent('storage_box:updateitems')
AddEventHandler('storage_box:updateitems', function(items)
 box_inventory = items
end)

AddEventHandler('storage_box:new', function()
 WarMenu.CloseMenu()
 local pos = GetEntityCoords(GetPlayerPed(-1))
 local pin = openNumberBox("Create A Pass Code, (Numbers Only)")
 TriggerServerEvent('storage_box:addbox', pos.x, pos.y, pos.z, pin)
end)

RegisterNetEvent('storage_box:updateboxes')
AddEventHandler('storage_box:updateboxes', function(boxes)
 storage_boxes = boxes
 -- Create new props
 for _,v in pairs(boxes) do 
  if not storage_boxes_props[v.box_id] then 
   SpawnObject(v.box_id, v.location)
  end
 end
end)

function SpawnObject(id, coords)
 local prophash = GetHashKey('v_serv_abox_04')
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

function moveStorageBox(id)
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
   TriggerServerEvent('storage_box:move', id, pos.x,pos.y,pos.z)
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
