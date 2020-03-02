_barberPool = NativeUI.CreatePool()
barberMenu = NativeUI.CreateMenu("Barberia")
_barberPool:Add(barberMenu)
_barberPool:RefreshIndex()
local barbershops = {
  {x = -814.308,  y = -183.823,  z = 36.568},
  {x = 136.826,   y = -1708.373, z = 28.291},
  {x = -1282.604, y = -1116.757, z = 5.990},
  {x = 1931.513,  y = 3729.671,  z = 31.844},
  {x = 1212.840,  y = -472.921,  z = 65.208},
  {x = -32.885,   y = -152.319,  z = 56.076},
  {x = -278.077,  y = 6228.463,  z = 30.695}
}

Citizen.CreateThread(function()
 showBarberMenu(barberMenu)
 for k,v in ipairs(barbershops)do
  local blip = AddBlipForCoord(v.x, v.y, v.z)
  SetBlipSprite(blip, 71)
  SetBlipDisplay(blip, 4)
  SetBlipScale(blip, 0.6)
  SetBlipColour(blip, 51)
  SetBlipAsShortRange(blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString("Barberia")
  EndTextCommandSetBlipName(blip)
 end
 while true do
  Wait(5)
  for k,v in pairs(barbershops) do
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 50) then
    DrawMarker(27, v.x, v.y, v.z+0.05, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 66,197,244, 200, 0, 0, 2, 0, 0, 0, 0)
 	if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 2) then 
     _barberPool:ProcessMenus()
	 drawTxt('~b~Presiona ~g~E~b~ Para entrar a la barberia')
	 if IsControlJustPressed(0, 38) then
      barberMenu:Visible(not barberMenu:Visible())
	 end
    end
   end
  end
 end
end)

function showBarberMenu(menu)
 local hairstyles = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45}
 local eyebrowstyles = {} for i = 0, 33 do eyebrowstyles[i] = GetLabelText("CC_EYEBRW_"..i) end
 local brusherstyles = {} for i = 0, 6 do brusherstyles[i] = GetLabelText("CC_BLUSH_"..i) end
 local hairColors = {{15,15,15},{55,47,40},{93,70,56},{116,69,46},{114,53,28},{148,71,36},{161,85,48},{157,93,57},{169,112,74},{172,120,81},{184,135,89},{195,152,101},{231,190,115},{235,195,129},{245,214,155},{168,115,73},{166,92,61},{156,55,36},{126,21,17},{141,26,20},{169,29,20},{204,56,31},{234,92,36},{213,105,57},{213,76,35},{125,100,82},{164,138,118},{222,199,179},{235,214,195},{124,85,103},{141,89,115},{172,74,105},{254,85,218},{254,95,159},{246,153,162},{9,160,146},{8,136,148},{8,87,139},{106,176,98},{44,135,88},{42,124,101},{185,189,44},{158,183,19},{99,173,35},{229,184,83},{241,192,14},{249,170,20},{251,143,27},{247,116,39},{257,102,20},{246,101,47},{243,49,15},{190,11,14},{166,9,13},{30,19,17},{69,41,31},{89,48,33},{74,40,30},{75,41,28},{57,35,28},{31,27,24},{223,179,122},{194,152,111}}

 local HairItem = NativeUI.CreateListItem('Pelo', hairstyles, 1)
 local ChestHairItem = NativeUI.CreateListItem('Pelo en pecho', {'None', 'Natural', 'The Strip', 'The Tree','The Tree 2', 'Hairy', 'Grisly', 'Ape', 'Groomed Ape', 'Bikini', 'Lightning Bolt', 'Reverse Lightning', 'Love Heart', 'Chestache', 'Happy Face', 'Skull', 'Snail Trail', 'Slug and Nips', 'Hairy Arms'}, 1)
 local EyebrowsItem = NativeUI.CreateListItem('Cejas', eyebrowstyles, 1)
 local BeardItem = NativeUI.CreateListItem('Barba', {'Clean Shaven','Light Stubble','Mustache','Trimmed Beard','Stubble','Thin Circle Beard','Horseshoe','Pencil & Chops','Chin Strap Beard','Balbo & Sideburns','Mutton Chops','Scruffy Beard','Balbo','Circle Beard','Goatee','Chin','Chin Fuzz','Pencil Chin Strap','Scruffy','Musketeer','1','2','3','4','5','6'}, 1)
 local BlemishesItem = NativeUI.CreateListItem('Manchas', {'Measles', 'Pimples', 'Spots', 'Break Out', 'Blackheads', 'Build Up', 'Pustules', 'Zits', 'Full Acne', 'Acne', 'Cheek Rash', 'Face Rash', 'Picker', 'Puberty', 'Eyesore', 'Chin Rash', 'Two Face', 'T Zone', 'Greasy', 'Marked', 'Acne Scarring', 'Full Acne Scarring', 'Cold Sores', 'Impetigo'}, 1)
 local FrecklesItem = NativeUI.CreateListItem('Moles y pecas', {'Cherub', 'All Over', 'Irregular', 'Dot Dash', 'Over the Bridge', 'Baby Doll', 'Pixie', 'Sun Kissed', 'Beauty Marks', 'Line Up', 'Modelesque', 'Occasional', 'Speckled', 'Rain Drops', 'Double Dip', 'One Sided', 'Pairs', 'Growth'}, 1)
 local EyeMakeupItem = NativeUI.CreateListItem('Maquillaje ojo', {'Smoky Black', 'Bronze', 'Soft Gray', 'Retro Glam', 'Natural Look', 'Cat Eyes', 'Chola', 'Vamp', 'Vinewood Glamour', 'Bubblegum', 'Aqua Dream', 'Pin Up', 'Purple Passion', 'Smoky Cat Eye', 'Smoldering Ruby', 'Pop Princess'}, 1)
 local LipstickItem = NativeUI.CreateListItem('Pintalabios', {'Color Matte', 'Color Gloss', 'Lined Matte', 'Lined Gloss', 'Heavy Lined Matte', 'Heavy Lined Gloss', 'Lined Nude Matte', 'Liner Nude Gloss', 'Smudged', 'Geisha'}, 1)
 local BlusherItem = NativeUI.CreateListItem('Colorete', brusherstyles, 1)

 menu:AddItem(HairItem)
 menu:AddItem(ChestHairItem)
 menu:AddItem(EyebrowsItem)
 menu:AddItem(BeardItem)
 menu:AddItem(BlemishesItem)
 menu:AddItem(FrecklesItem)
 menu:AddItem(EyeMakeupItem)
 menu:AddItem(LipstickItem)
 menu:AddItem(BlusherItem)

 menu.OnListChange = function(sender, item, index)
  SetCamCoord(cam, 402.8553, -999.55, -98.18412)
  if item == HairItem then
   if index == 1 then skinData['Hair'] = 0 else skinData['Hair'] = index end
   SetPedComponentVariation(GetPlayerPed(-1), 2, skinData['Hair'], 0, 1)
  elseif item == EyebrowsItem then 
   skinData['Eyebrows'] = index 
   SetPedHeadOverlay(GetPlayerPed(-1), 2, skinData['Eyebrows'], 10.0)
  elseif item == BeardItem then 
   if index == 1 then skinData['Beard'] = 0 else skinData['Beard'] = index end
   SetPedHeadOverlay(GetPlayerPed(-1), 1, skinData['Beard'], skinData['Beard Opacity'])
  elseif item == BlemishesItem then 
   skinData['Skin Blemishes'] = index
   SetPedHeadOverlay(GetPlayerPed(-1), 0, skinData['Skin Blemishes'], skinData['Skin Blemishes Opacity'])
  elseif item == FrecklesItem then
   skinData['Freckles'] = index-1
   SetPedHeadOverlay(GetPlayerPed(-1), 9, skinData['Freckles'], skinData['Freckles Opacity'])
  elseif item == EyeMakeupItem then
   skinData['Eye Makeup'] = index
   SetPedHeadOverlay(GetPlayerPed(-1), 4, skinData['Eye Makeup'], skinData['Eye Makeup Opacity'])
  elseif item == LipstickItem then
   skinData['Lipstick'] = index
   SetPedHeadOverlay(GetPlayerPed(-1), 8, skinData['Lipstick'], skinData['Lipstick Opacity'])
  elseif item == ChestHairItem then
   skinData['Chest Hair'] = index-3
   SetPedHeadOverlay(GetPlayerPed(-1), 10, skinData['Chest Hair'], skinData['Chest Hair Opacity'])
   SetCamCoord(cam, 402.8553, -999.55, -98.58412)
  elseif item == BlusherItem then
   skinData['Blusher'] = index
   SetPedHeadOverlay(GetPlayerPed(-1), 5, skinData['Blusher'], skinData['Blusher Opacity'])
  end
 end

 local HairPanel = NativeUI.CreateColourPanel('Primary Hair Color', hairColors)
 HairItem:AddPanel(HairPanel)
 HairPanel.UpdateParent = function(sender, item, index)
  skinData['Hair Colour 1'] = HairPanel:CurrentSelection()
  SetPedHairColor(GetPlayerPed(-1), skinData['Hair Colour 1'], skinData['Hair Colour 2'])
 end

 local HairPanel2 = NativeUI.CreateColourPanel('Secondary Hair Color', hairColors)
 HairItem:AddPanel(HairPanel2)
 HairPanel2.UpdateParent = function(sender, item, index)
  skinData['Hair Colour 2'] = HairPanel2:CurrentSelection()
  SetPedHairColor(GetPlayerPed(-1), skinData['Hair Colour 1'], skinData['Hair Colour 2'])
 end

 local ChestHairPanel = NativeUI.CreateColourPanel('Chest Hair Color', hairColors)
 ChestHairItem:AddPanel(ChestHairPanel)
 ChestHairPanel.UpdateParent = function(sender, item, index)
  skinData['Chest Hair Colour'] = ChestHairPanel:CurrentSelection()
  SetPedHeadOverlayColor(GetPlayerPed(-1), 10, 1, skinData['Chest Hair Colour'], 1)
 end

 local ChestHairPanel2 = NativeUI.CreatePercentagePanel('','')
 ChestHairItem:AddPanel(ChestHairPanel2)
 ChestHairPanel2.UpdateParent = function()
  skinData['Chest Hair Opacity'] = ChestHairPanel2:Percentage()
  SetPedHeadOverlay(GetPlayerPed(-1), 10, skinData['Chest Hair'], skinData['Chest Hair Opacity'])
 end

 local EyebrowPanel = NativeUI.CreateColourPanel('Primary Eyebrow Color', hairColors)
 EyebrowsItem:AddPanel(EyebrowPanel)
 EyebrowPanel.UpdateParent = function(sender, item, index)
  skinData['Eyebrow Colour'] = EyebrowPanel:CurrentSelection()
  SetPedHeadOverlayColor(GetPlayerPed(-1), 2, 1, skinData['Eyebrow Colour'], skinData['Eyebrow Colour'])
 end

 local BeardPanel = NativeUI.CreateColourPanel('Primary Beard Color', hairColors)
 BeardItem:AddPanel(BeardPanel)
 BeardPanel.UpdateParent = function(sender, item, index)
  skinData['Beard Colour'] = BeardPanel:CurrentSelection()
  SetPedHeadOverlayColor(GetPlayerPed(-1), 1, 1, skinData['Beard Colour'], skinData['Beard Colour'])
 end

 local BeardPanel2 = NativeUI.CreatePercentagePanel('','')
 BeardItem:AddPanel(BeardPanel2)
 BeardPanel2.UpdateParent = function()
  skinData['Beard Opacity'] = BeardPanel2:Percentage()
  SetPedHeadOverlay(GetPlayerPed(-1), 1, skinData['Beard'], skinData['Beard Opacity'])
 end

 local BlemishesPanel = NativeUI.CreatePercentagePanel('','')
 BlemishesItem:AddPanel(BlemishesPanel)
 BlemishesPanel.UpdateParent = function()
  skinData['Skin Blemishes Opacity'] = BlemishesPanel:Percentage()
  SetPedHeadOverlay(GetPlayerPed(-1), 0, skinData['Skin Blemishes'], skinData['Skin Blemishes Opacity'])
 end

 local FrecklesPanel = NativeUI.CreatePercentagePanel('','')
 FrecklesItem:AddPanel(FrecklesPanel)
 FrecklesPanel.UpdateParent = function()
  skinData['Freckles Opacity'] = FrecklesPanel:Percentage()
  SetPedHeadOverlay(GetPlayerPed(-1), 9, skinData['Freckles'], skinData['Freckles Opacity'])
 end

 local EyeMakeupPanel = NativeUI.CreatePercentagePanel('','')
 EyeMakeupItem:AddPanel(EyeMakeupPanel)
 EyeMakeupPanel.UpdateParent = function()
  skinData['Eye Makeup Opacity'] = EyeMakeupPanel:Percentage()
  SetPedHeadOverlay(GetPlayerPed(-1), 4, skinData['Eye Makeup'], skinData['Eye Makeup Opacity'])
 end

 local EyeMakeupColourPanel = NativeUI.CreateColourPanel('Eye Makeup Color', hairColors)
 EyeMakeupItem:AddPanel(EyeMakeupColourPanel)
 EyeMakeupColourPanel.UpdateParent = function()
  skinData['EyeMakeup Colour'] = EyeMakeupColourPanel:CurrentSelection()
  SetPedHeadOverlayColor(GetPlayerPed(-1), 4, 1, skinData['Eye Makeup Colour'], skinData['EyeMakeup Colour']) 
 end

 local LipstickColourPanel = NativeUI.CreateColourPanel('Lipstick Color', hairColors)
 LipstickItem:AddPanel(LipstickColourPanel)
 LipstickColourPanel.UpdateParent = function()
  skinData['Lipstick Colour'] = LipstickColourPanel:CurrentSelection()
  SetPedHeadOverlayColor(GetPlayerPed(-1), 8, 1, skinData['Lipstick Colour'], skinData['Lipstick Colour'])
 end

 local LipstickPanel = NativeUI.CreatePercentagePanel('0%', '100%')
 LipstickItem:AddPanel(LipstickPanel)
 LipstickPanel.UpdateParent = function()
  skinData['Lipstick Opacity'] = LipstickPanel:Percentage()
  SetPedHeadOverlay(GetPlayerPed(-1), 8, skinData['Lipstick'], skinData['Lipstick Opacity'])
 end

 local BlusherPanel = NativeUI.CreatePercentagePanel('','')
 BlusherItem:AddPanel(BlusherPanel)
 BlusherPanel.UpdateParent = function()
  skinData['Blusher Opacity'] = BlusherPanel:Percentage()
  SetPedHeadOverlay(GetPlayerPed(-1), 5, skinData['Blusher'], skinData['Blusher Opacity'])
 end

 local BlusherColourPanel = NativeUI.CreateColourPanel('Blusher Color', hairColors)
 BlusherItem:AddPanel(BlusherColourPanel)
 BlusherColourPanel.UpdateParent = function()
  skinData['Blusher Colour'] = BlusherColourPanel:CurrentSelection()
  SetPedHeadOverlayColor(GetPlayerPed(-1), 5, 1, skinData['Blusher Colour'], skinData['Blusher Colour'])          -- Lipstick Color
 end

 local saveItem = NativeUI.CreateItem('Sava & Confirma', '')
 barberMenu:AddItem(saveItem)
 barberMenu.OnItemSelect = function(sender, item, index)
  if item == saveItem then
   TriggerServerEvent('skinCreation:save', json.encode(skinData))
   _barberPool:Remove()
  end
 end
end

function drawTxt(text)
  SetTextFont(0)
  SetTextProportional(0)
  SetTextScale(0.32, 0.32)
  SetTextColour(0, 255, 255, 255)
  SetTextDropShadow(0, 0, 0, 0, 255)
  SetTextEdge(1, 0, 0, 0, 255)
  SetTextDropShadow()
  SetTextOutline()
  SetTextCentre(1)
  SetTextEntry("STRING")
  AddTextComponentString(text)
  DrawText(0.5, 0.93)
end