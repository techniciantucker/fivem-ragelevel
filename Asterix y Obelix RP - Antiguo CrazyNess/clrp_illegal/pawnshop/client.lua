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
    {id = 136, name = "Mobile Phone"},
    {id = 135, name = "ID Card"},
    {id = 114, name = "Metal Spring"},
    {id = 54, name = "Airbag"},
    {id = 137, name = "Drivers License"}

   }



Citizen.CreateThread(function()

 WarMenu.CreateLongMenu('pawn_shop', 'Pawn Shop')

 while true do

  Wait(5)

  if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 412.50555419922, 314.26840209961, 103.02094268799, true) < 20) then

   DrawMarker(27, 412.50555419922, 314.26840209961, 103.02094268799-0.95, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 0, 82, 165, 240, 0, 0, 2, 0, 0, 0, 0)

   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 412.50555419922, 314.26840209961, 103.02094268799, true) < 1.2) then 

    drawTxt('~b~Press ~g~E~b~ To Pawn Items')

    if IsControlJustPressed(0, 38) then 

     TriggerEvent('pawnshop:Open')

    end

   end

  end

  if WarMenu.IsMenuOpened('pawn_shop') then

   for k,v in pairs(pawnable)do

    if exports['core']:GetItemQuantity(v.id) >= 1 then

     if WarMenu.Button(v.name, exports['core']:GetItemQuantity(v.id)) then

      pawnItem(v.id, v.name, exports['core']:GetItemQuantity(v.id))

     end

    end

   end

   WarMenu.Display()

  end

 end

end)





function pawnItem(item, name, quantity)

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

  TriggerServerEvent('pawnshop:pawn', item, name, amount)

 end

end



Citizen.CreateThread(function()

 WarMenu.CreateLongMenu('recycle', 'Recycle')

 while true do

  Wait(5)

  if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 2357.720, 3138.358, 48.209, true) < 20) then 

   DrawMarker(27, 2357.720, 3138.358, 48.209-0.95, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 0, 82, 165, 240, 0, 0, 2, 0, 0, 0, 0)

   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 2357.720, 3138.358, 48.209, true) < 1.2) then 

    drawTxt('~b~Press ~g~E~b~ To Recycle Items')

    if IsControlJustPressed(0, 38) then 

     TriggerEvent('recycling:Open')

    end

   end

  end

  if WarMenu.IsMenuOpened('recycle') then

   local inventory = exports['core']:getInventory()

   for i = 1,#inventory do

    if (inventory[i].q > 0) and (inventory[i].isRecyclable == 1) then

     if WarMenu.Button(tostring(inventory[i].name), tonumber(inventory[i].q)) then

      recycleItem(inventory[i].id, inventory[i].name, inventory[i].q)

     end

    end

   end

   WarMenu.Display()

  end

 end

end)





function recycleItem(item, name, quantity)

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

  TriggerServerEvent('pawnshop:recycle', item, name, amount)

 end

end





--mall pawn shop  -914.72381591797, -151.32005310059, 46.272205352783 



Citizen.CreateThread(function()

 WarMenu.CreateLongMenu('pawn_shop', 'Pawn Shop')

 while true do

  Wait(5)

  if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -914.72381591797, -151.32005310059, 46.272205352783, true) < 20) then

   DrawMarker(27, -914.72381591797, -151.32005310059, 46.272205352783-0.95, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 0, 82, 165, 240, 0, 0, 2, 0, 0, 0, 0)

   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -914.72381591797, -151.32005310059, 46.272205352783, true) < 1.2) then 

    drawTxt('~b~Press ~g~E~b~ To Pawn Items')

    if IsControlJustPressed(0, 38) then 

     TriggerEvent('pawnshop:Open')

    end

   end

  end

  if WarMenu.IsMenuOpened('pawn_shop') then

   for k,v in pairs(pawnable)do

    if exports['core']:GetItemQuantity(v.id) >= 1 then

     if WarMenu.Button(v.name, exports['core']:GetItemQuantity(v.id)) then

      pawnItem(v.id, v.name, exports['core']:GetItemQuantity(v.id))

     end

    end

   end

   WarMenu.Display()

  end

 end

end)





--joeys  964.4609375, -3003.4072265625, -39.639896392822



Citizen.CreateThread(function()

 WarMenu.CreateLongMenu('pawn_shop', 'Pawn Shop')

 while true do

  Wait(5)

  if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 964.4609375, -3003.4072265625, -39.639896392822, true) < 20) then

   DrawMarker(27, 964.4609375, -3003.4072265625, -39.639896392822-0.95, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 0, 82, 165, 240, 0, 0, 2, 0, 0, 0, 0)

   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 964.4609375, -3003.4072265625, -39.639896392822, true) < 1.2) then 

    drawTxt('~b~Press ~g~E~b~ To Pawn Items')

    if IsControlJustPressed(0, 38) then 

     TriggerEvent('pawnshop:Open')

    end

   end

  end

  if WarMenu.IsMenuOpened('pawn_shop') then

   for k,v in pairs(pawnable)do

    if exports['core']:GetItemQuantity(v.id) >= 1 then

     if WarMenu.Button(v.name, exports['core']:GetItemQuantity(v.id)) then

      pawnItem(v.id, v.name, exports['core']:GetItemQuantity(v.id))

     end

    end

   end

   WarMenu.Display()

  end

 end

end)


Citizen.CreateThread(function()
 while true do
  Wait(5)
  if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 722.409, 4190.136, 41.093, true) < 20) and DecorGetInt(GetPlayerPed(-1), 'Faction') == 3 then
   DrawMarker(27, 722.409, 4190.136, 41.093, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 0,255,123,255, 0, 0, 2, 0, 0, 0, 0)
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 722.409, 4190.136, 41.093, true) < 1.2) then
    showMessage('~w~Press ~g~E~w~ To Clean Dirty Money')
    if IsControlJustPressed(0, 38) then
     TriggerServerEvent("drugs:cleanMoney")
    end
   end
  else
   Wait(2500)
  end
 end
end)

function showMessage(msg)
 BeginTextCommandDisplayHelp("STRING")
 AddTextComponentScaleform(msg)
 EndTextCommandDisplayHelp(0, false, true, -1)
end