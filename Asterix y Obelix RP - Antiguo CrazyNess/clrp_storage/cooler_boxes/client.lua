local cooler_boxes = {}
local cooler_boxes_props = {}
local box_inventory = {}
local box_id = nil

Citizen.CreateThread(function()
 while true do
  Wait(5)
  local coords = GetEntityCoords(GetPlayerPed(-1))
  for k,v in pairs(cooler_boxes) do
   if(GetDistanceBetweenCoords(coords, v.location.x, v.location.y, v.location.z-0.95, true) < 1.2) then
    drawTxt('~b~Press ~g~E~b~ To Access Cooler Box')
    if IsControlJustPressed(0, 38) then
     box_id = v.box_id
     print('[DEV INFO] Cooler Box ID: '..box_id)
     TriggerServerEvent("cooler_box:getInventory", box_id)
     WarMenu.OpenMenu('cooler_box')
    end
   end
  end
 end
end)

Citizen.CreateThread(function()
 WarMenu.CreateLongMenu('cooler_box', 'Cooler Box')
 WarMenu.CreateSubMenu('Cooler_inv', 'cooler_box', 'Cooler_inv')
 WarMenu.CreateSubMenu('Player_inv', 'cooler_box', 'Player_inv')
 while true do
  Citizen.Wait(5)
  if WarMenu.IsMenuOpened('cooler_box') then
   if WarMenu.MenuButton('Store Items', 'Player_inv') then
   elseif WarMenu.MenuButton('Take Items', 'Cooler_inv') then
   elseif WarMenu.Button('Move Cooler Box') then
    moveCoolerBox(box_id)
   elseif WarMenu.Button('Remove Cooler Box') then
    TriggerServerEvent('cooler_box:removebox', box_id)
   end
   WarMenu.Display()
  elseif WarMenu.IsMenuOpened('Cooler_inv') then
   for i = 1,#box_inventory do
    if (box_inventory[i].q > 0) then
     if WarMenu.Button(box_inventory[i].name, box_inventory[i].q) then
      CoolerItemTake(box_inventory[i].item)
     end
    end
   end
   if WarMenu.MenuButton('Back', 'cooler_box') then
   end
   WarMenu.Display()
  elseif WarMenu.IsMenuOpened('Player_inv') then
   local inventory = exports['core']:getInventory()
   for i = 1,#inventory do
    if (inventory[i].q > 0) and (inventory[i].isConsumable == 1) then
     if WarMenu.Button(tostring(inventory[i].name), tonumber(inventory[i].q)) then
      CoolerItemStore(inventory[i].id, inventory[i].name, inventory[i].q) 
     end
    end
   end
   if WarMenu.MenuButton('Back', 'cooler_box') then
   end
   WarMenu.Display()
  end       
 end
end)

function CoolerItemStore(item, name, quantity)
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
  if amount + getCoolerQuantity() <= 40 then
   TriggerServerEvent('cooler_box:additems', box_id, item, name, amount)
  else
   exports.pNotify:SendNotification({text = "Cooler Boxes Can Only Hold 40 Items"})
  end
 end
end

function CoolerItemTake(item)
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
   TriggerServerEvent('cooler_box:removeitems', box_id, item, amount)
  else
   exports.pNotify:SendNotification({text = "Inventory Full"})
  end
 end
end

function getCoolerQuantity()
 local quantity = 0
 for i=1,#box_inventory do
  quantity = quantity + box_inventory[i].q
 end
 return quantity
end

RegisterNetEvent('cooler_box:updateitems')
AddEventHandler('cooler_box:updateitems', function(items)
 box_inventory = items
end)

AddEventHandler('cooler_box:new', function()
 WarMenu.CloseMenu()
 local pos = GetEntityCoords(GetPlayerPed(-1))
 TriggerServerEvent('cooler_box:addbox', pos.x, pos.y, pos.z)
end)

RegisterNetEvent('cooler_box:updateboxes')
AddEventHandler('cooler_box:updateboxes', function(boxes)
 cooler_boxes = boxes
 -- Create new props
 for _,v in pairs(boxes) do 
  if not cooler_boxes_props[v.box_id] then 
   SpawnObject(v.box_id, v.location)
  end
 end
end)


function SpawnCooler(id, coords)
 local prophash = GetHashKey('prop_coolbox_01')
 RequestModel(prophash)
 while not HasModelLoaded(prophash) do
  Citizen.Wait(0)
 end

 local propsobj = CreateObjectNoOffset(prophash, coords.x, coords.y, coords.z-0.90, true, true, true)

 SetEntityHeading(propsobj, 0)
 SetEntityAsMissionEntity(propsobj)
 FreezeEntityPosition(propsobj, true, true)
 SetModelAsNoLongerNeeded(prophash)
 cooler_boxes_props[id] = {prop = propsobj, location = coords}
end

 --- way to move Cooler boxes when moving places you into animation and you hold the box aka carry it until placed back down
local boxObject = nil 
local movingBox = false

function moveCoolerBox(id)
 local pos = GetEntityCoords(GetPlayerPed(-1), false) 
 DeleteObject(cooler_boxes_props[id].prop)
 LoadModel("prop_coolbox_01")
 boxObject = CreateObject(GetHashKey("prop_coolbox_01"), pos.x, pos.y, pos.z, true)
 AttachEntityToEntity(boxObject, PlayerPedId(), GetPedBoneIndex(PlayerPedId(),  28422), 0.0, -0.03, -0.40, 5.0, 0.0, 90.0, 1, 1, 0, 1, 0, 1)
 LoadAnim("anim@heists@box_carry@")
 TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 8.0, 8.0, -1, 50, 0, false, false, false)
 movingBox = true 

 while movingBox do
  Citizen.Wait(1)
  drawTxt('~b~Press ~g~M~b~ To Drop Cooler')
  if not IsPedInAnyVehicle(GetPlayerPed(-1), false) then 
   if not IsEntityPlayingAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 3) then
    TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 8.0, 8.0, -1, 50, 0, false, false, false) 
   end
  end
  if IsControlJustPressed(0, 244) then
   local pos = GetEntityCoords(GetPlayerPed(-1), false) 
   ClearPedTasks(GetPlayerPed(-1))
   DeleteObject(boxObject)
   TriggerServerEvent('cooler_box:move', id, pos.x,pos.y,pos.z)
   movingBox = false
  end
 end
end
