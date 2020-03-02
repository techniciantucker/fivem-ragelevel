outfits = {}
local clothing_shops = {
	{x=1932.76989746094, y=3727.73510742188, z=32.8444557189941},
	{x=1693.26, y=4822.27, z=42.06},
  {x = 118.449, y = -232.267, z = 54.558}, --Hawick Ave Store
	{x = -700.992, y = -152.028, z = 37.415}, --Portola Drive Store
	{x = -819.886, y = -1067.357, z = 11.328}, --South Rockford Drive Store
	{x = -1181.839, y = -764.799, z = 17.326}, --Prosp Street Prom Store
	{x = -170.154, y = -296.710, z = 39.733}, --Las Lagunas Blvd Store
	{x = 71.291, y = -1387.834, z = 29.376}, --Innocence Blvd Store
	{x = 3.727, y = 6505.919, z = 31.878}, --Paleto Store
	{x = 429.539, y = -811.290, z = 29.491}, --Sinner Street Store
	{x = -3178.542, y = 1035.987, z = 20.863}, --Great Ocean Highway Store
	{x=1117.0151, y=-3162.772, z=-36.870},
	{x=8.6996431350708, y=528.50665283203, z=170.63502502441},
	{x=334.0302734375, y=428.37963867188, z=145.57084655762},
	{x=1269.0017089844, y=-1710.4593505859, z=54.771446228027},
	{x = -1446.538, y = -245.742, z = 49.827}, --Cougar Ave Store
	{x = -1100.277, y = 2717.144, z = 19.108}, --Route 68 Fort Zancudo
	{x = 617.445, y = 2773.259, z = 42.088}, --Route 68 Harmony Store
	{x=1201.789, y=2714.452, z=38.223}, --Route 68 Senora Desert Store
	{x=1830.504, y=3674.560, z=-118.762}, --Sandy SO
	{x=-429.181, y=5994.865, z=-118.762}, --Paleto SO
	{x=259.89224243164, y=-1003.932434082, z=-99.008613586426}, -- Low End Apartment
	{x=351.310577392, y=-993.736145019, z=-99.1961746215},  -- Med End Apartment
	{x = -899.36334228516, y = -433.00628662109, z = 89.264610290527},  -- High End Apartment
	{x = 299.053, y = -597.825, z = 43.284}, -- Hospital
	{x= 152.053, y= -1001.464, z= -98.989}, -- Motel
	{x=1397.905, y=1164.010, z=114.293}, -- La Fuerte Blanca
  {x = 105.045, y = -1303.050, z = 28.769}, -- Stripclub
  {x = -797.923, y = 328.089, z = 219.439}, -- Apartments
  {x = 374.228, y = 411.527, z = 142.100}, -- Red Interior Apartment
  {x = -1390.998, y = -600.905, z = 30.320}, --Bahama Mamas
  {x = 473.877, y = -1313.496, z = 29.207},
  {x = 450.718, y = -992.539, z = 30.690},
  {x = -867.807, y = -2888.465, z = -102.316}, -- Anvil
  {x = -167.371, y = 487.939, z = 133.844}, --Apartment
    {x = -1619.777, y = -3020.471, z = -75.205}, -- mafia discoteca  
    {x = -2093.196, y = -1012.740, z = 5.884}, -- yacte discoteca  
    {x = -2087.141, y = -1013.216, z = 5.884}, -- yacte discoteca  	
	    {x = -709.359, y = -906.732, z = 19.216}, -- tiendaç
	    {x = 1993.165, y = 3051.151, z = 47.215}, -- pj 
			    {x = -132.488, y = -632.788, z = 168.821}, -- seguridad
				{x = 1096.417, y = 200.856, z = -49.440}, -- CASINO
				{x = 1165.000, y = -3191.705, z = -39.008}, -- taxi
}

Citizen.CreateThread(function()
 while true do
  Wait(5)
  local coords = GetEntityCoords(GetPlayerPed(-1))
  -- Outfit Saving
  for k,v in pairs(clothing_shops) do
   if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z-0.95, true) < 50) then
    DrawMarker(27, v.x, v.y, v.z-0.95, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 0, 255, 123, 200, 0, 0, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z-0.95, true) < 2.0) then
     drawTxt('~b~Pulse ~g~E~b~ Para acceder al vestidor')
     if IsControlJustPressed(0, 38) then
      WarMenu.OpenMenu('outfits')
      TriggerServerEvent('outfits:getoutfits')
     end
    end
   end
  end
 end
end) 


Citizen.CreateThread(function()
 while true do
  Wait(5)
  local coords = GetEntityCoords(GetPlayerPed(-1))
  if(GetDistanceBetweenCoords(coords, -838.335, 318.153, 114.995, false) < 1.5) then
   drawTxt('~b~Pulse ~g~E~b~ Para acceder al vestidor')
   if IsControlJustPressed(0, 38) then
    WarMenu.OpenMenu('outfits')
    TriggerServerEvent('outfits:getoutfits')
   end
  else 
   Citizen.Wait(2500)
  end
 end
end) 

Citizen.CreateThread(function()
 WarMenu.CreateMenu('outfits', 'Vestidor')
 WarMenu.CreateMenu('change_outfit', 'Dressing Room')
 WarMenu.CreateMenu('share_outfit', 'Dressing Room')
 while true do
  Citizen.Wait(5)
  if WarMenu.IsMenuOpened('outfits') then
   if WarMenu.Button('Crear Traje') then
    SaveOutfit()
    WarMenu.CloseMenu('outfits')
   elseif WarMenu.Button('Borrar Traje') then
   	DeleteOutfit()
   	WarMenu.CloseMenu('outfits')
   elseif WarMenu.Button('Cambiar Traje') then
   	WarMenu.OpenMenu('change_outfit')
   elseif WarMenu.Button('Compartir Traje') then 
    WarMenu.OpenMenu('share_outfit')
   end
   WarMenu.Display()
  elseif WarMenu.IsMenuOpened('change_outfit') then
   for _,v in pairs(outfits) do
    if WarMenu.Button(v.name) then
     TriggerEvent('clothes:load', json.decode(v.skin))
    end
   end
   WarMenu.Display()
  elseif WarMenu.IsMenuOpened('share_outfit') then
   for _,v in pairs(outfits) do
    if WarMenu.Button(v.name) then
     local id = GetResult()
     TriggerServerEvent('outfits:share', id, v.name, v.skin)
    end
   end
   WarMenu.Display()
  end
 end
end) 

function SaveOutfit()
  DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP9", "", "", "", "", "", 32)
  while (UpdateOnscreenKeyboard() == 0) do
    DisableAllControlActions(0);
    Wait(0);
  end
  if (GetOnscreenKeyboardResult()) then
   local result = GetOnscreenKeyboardResult()
   local clothing = exports['core']:GetClothes()
   TriggerServerEvent('outfits:saveskin', clothing, result)
  end
end

function DeleteOutfit()
  DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP9", "", "", "", "", "", 32)
  while (UpdateOnscreenKeyboard() == 0) do
    DisableAllControlActions(0);
    Wait(0);
  end
  if (GetOnscreenKeyboardResult()) then
   local result = GetOnscreenKeyboardResult()
   TriggerServerEvent('outfits:deleteoutfit', result)
  end
end

RegisterNetEvent('outfits:outfitlist')
AddEventHandler('outfits:outfitlist', function(listoutfits)
 outfits = {}
 outfits = listoutfits
end)

function GetResult()
 local amount = "xxsdrtghyuujhdjsjenenfjfjtjtjtj"
 showLoadingPrompt("Enter Player's ID", 3)
 DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 6)
  while (UpdateOnscreenKeyboard() == 0) do
    DisableAllControlActions(0);
    Wait(0);
  end
  if (GetOnscreenKeyboardResult()) then
    local option = GetOnscreenKeyboardResult()
    stopLoadingPrompt()
    if(option ~= nil and option ~= 0) then
     amount = ""..option
     if (amount ~= "xxsdrtghyuujhdjsjenenfjfjtjtjtj" and tonumber(amount) > 0) then
      return tonumber(amount)
     end
    end
  end
end

function showLoadingPrompt(showText, showType)
    Citizen.CreateThread(function()
        Citizen.Wait(0)
        N_0xaba17d7ce615adbf("STRING") -- set type
        AddTextComponentString(showText) -- sets the text
        N_0xbd12f8228410d9b4(showType) -- show promt (types = 3)
    end)
end

function stopLoadingPrompt()
    Citizen.CreateThread(function()
        Citizen.Wait(0)
        N_0x10d373323e5b9c0d()
    end)
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

RegisterNetEvent('outfit:set')
AddEventHandler('outfit:set', function(data)
	if data.model == 1885233650 or data.model == -1667301416 then
	 for i = 0, 11 do
	  if i ~= 0 and i ~= 2 then
	   SetPedComponentVariation(GetPlayerPed(-1), i, data.clothing.drawables[i+1], data.clothing.textures[i+1], data.clothing.palette[i+1])
	  end
	 end
	 for i = 0, 7 do
	  SetPedPropIndex(GetPlayerPed(-1), i, data.props.drawables[i+1], data.props.textures[i+1], false)
	 end
	else
	    setModel(data.model)
	    for i = 0, 11 do
	        SetPedComponentVariation(GetPlayerPed(-1), i, player_data.clothing.drawables[i+1], player_data.clothing.textures[i+1], player_data.clothing.palette[i+1])
	    end
	    for i = 0, 7 do
	        SetPedPropIndex(GetPlayerPed(-1), i, player_data.props.drawables[i+1], player_data.props.textures[i+1], false)
	    end
	end
end)

AddEventHandler('outfit:open', function()
 WarMenu.OpenMenu('outfits')
 TriggerServerEvent('outfits:getoutfits')
end)
