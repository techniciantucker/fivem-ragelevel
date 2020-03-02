local componentScroller = 0

local subComponentScroller = 0

local textureScroller = 0

local paletteScroller = 0

local removeScroller = 0

local opacityScroller = 0

local colourScroller = 0

local mask = {drawables = 0, textures = 0, status = true}

local glasses = {drawables = 0, textures = 0, status = true}

local helmet = {drawables = 0, textures = 0, status = true}

local pants = {drawables = 0, textures = 0, status = true}

local shoes = {drawables = 0, textures = 0, status = true}

local clothing = {}

local menu_options = {{name = "Clothing", f = customise, param = nil}, {name = "Accessories", f = accessories, param = nil},}

player_data  = {

    model = nil,

    clothing = {

        drawables = {},

        textures = {

            1,1,1

        },

        palette = {},

    },

    props = {

        drawables = {},

        textures = {},

    },

}



function OpenClothes()

    Menu.SetupMenu("clothing_main","Clothing Store")

    Menu.Switch(nil, "clothing_main")

    for k,v in pairs(menu_options) do

        Menu.addOption("clothing_main", function()

         if(Menu.Option(v.name))then

          if v.name == 'Clothing' then

           customise()

          elseif v.name == 'Accessories' then 

           accessories()

          end

         end

        end)

    end

end



function customise()

    Menu.SetupMenu("clothing_customise", 'Clothing')

    Menu.Switch("clothing_main", "clothing_customise")

    if GetEntityModel(GetPlayerPed(-1)) == GetHashKey("mp_m_freemode_01") or GetEntityModel(GetPlayerPed(-1)) == GetHashKey("mp_f_freemode_01") then

        componentScroller = 0

        subComponentScroller = GetPedDrawableVariation(GetPlayerPed(-1), componentScroller)

        textureScroller = GetPedTextureVariation(GetPlayerPed(-1), componentScroller)

        paletteScroller = GetPedPaletteVariation(GetPlayerPed(-1), componentScroller)

        Menu.addOption("clothing_customise", function()

            if(Menu.ScrollBarString({"None","Mask","Hair","Arms","Pants","Parachutes","Shoes","Necklace & Ties","Undershirt","Body Armour","Decals","Shirts"}, componentScroller, function(cb)  componentScroller = cb end)) then

                if componentScroller ~= 0 then

                	subComponentScroller = GetPedDrawableVariation(GetPlayerPed(-1), componentScroller)

                	textureScroller = GetPedTextureVariation(GetPlayerPed(-1), componentScroller)

                	paletteScroller = GetPedPaletteVariation(GetPlayerPed(-1), componentScroller)

            	end

            end

        end)

        Menu.addOption("clothing_customise", function()

            if(Menu.ScrollBarInt("Components", subComponentScroller, GetNumberOfPedDrawableVariations(GetPlayerPed(-1), componentScroller), function(cb)  subComponentScroller = cb end)) then

                if componentScroller ~= 0 then

                SetPedComponentVariation(GetPlayerPed(-1), componentScroller, 0, 240, 0)

                SetPedComponentVariation(GetPlayerPed(-1), componentScroller, subComponentScroller, textureScroller, paletteScroller)

                textureScroller = 0

                paletteScroller = 0

               	end

            end

        end)

        Menu.addOption("clothing_customise", function()

            local textureMax = 0

            if componentScroller == 2 then textureMax = GetNumHairColors() else textureMax = GetNumberOfPedTextureVariations(GetPlayerPed(-1), componentScroller, subComponentScroller) end

            if(Menu.ScrollBarInt("Textures", textureScroller, textureMax, function(cb)  textureScroller = cb end)) then

                if componentScroller == 2 then

                    SetPedComponentVariation(GetPlayerPed(-1), componentScroller, subComponentScroller, 0, 1)

                    SetPedHairColor(GetPlayerPed(-1), textureScroller, textureScroller)

                    player_data.clothing.textures[3] = textureScroller

                else

                    SetPedComponentVariation(GetPlayerPed(-1), componentScroller, subComponentScroller, textureScroller, paletteScroller)

                end

            end

        end)

        Menu.addOption("clothing_customise", function()

            if(Menu.ScrollBarInt("Colour Palette", paletteScroller, 2, function(cb)  paletteScroller = cb end)) then

                SetPedComponentVariation(GetPlayerPed(-1), componentScroller, subComponentScroller, textureScroller, paletteScroller)

            end

        end)

        Menu.addOption("clothing_customise", function()

            if(Menu.Option("Remove Undershirt"))then

                SetPedComponentVariation(GetPlayerPed(-1), 8, 0, 240, 0)

            end

        end)

    else

        componentScroller = 0

        subComponentScroller = GetPedDrawableVariation(GetPlayerPed(-1), componentScroller)

        textureScroller = GetPedTextureVariation(GetPlayerPed(-1), componentScroller)

        paletteScroller = GetPedPaletteVariation(GetPlayerPed(-1), componentScroller)

        Menu.addOption("clothing_customise", function()

            local precomponentTable = {"Head","No idea","Hair","Shirts","Pants","No idea","No idea","No idea","Necklace & Ties","No idea","No idea","No idea"}

            local componentTable = {}

            for i = 0, 11 do

                if GetNumberOfPedDrawableVariations(GetPlayerPed(-1), i) ~= 0 and GetNumberOfPedDrawableVariations(GetPlayerPed(-1), i) ~= false then

                    componentTable[i+1] = precomponentTable[i+1]

                else

                    componentTable[i+1] = "Empty slot"

                end

            end

            if(Menu.ScrollBarString(componentTable, componentScroller, function(cb)  componentScroller = cb end)) then

                subComponentScroller = GetPedDrawableVariation(GetPlayerPed(-1), componentScroller)

                textureScroller = GetPedTextureVariation(GetPlayerPed(-1), componentScroller)

                paletteScroller = GetPedPaletteVariation(GetPlayerPed(-1), componentScroller)

            end

        end)

        Menu.addOption("clothing_customise", function()

            if(Menu.ScrollBarInt("Components", subComponentScroller, GetNumberOfPedDrawableVariations(GetPlayerPed(-1), componentScroller), function(cb)  subComponentScroller = cb end)) then

                SetPedComponentVariation(GetPlayerPed(-1), componentScroller, 0, 240, 0)

                SetPedComponentVariation(GetPlayerPed(-1), componentScroller, subComponentScroller, textureScroller, paletteScroller)

                textureScroller = 0

                paletteScroller = 0

            end

        end)

        Menu.addOption("clothing_customise", function()

            if(Menu.ScrollBarInt("Textures", textureScroller, GetNumberOfPedTextureVariations(GetPlayerPed(-1), componentScroller, subComponentScroller), function(cb)  textureScroller = cb end)) then

                if componentScroller == 2 then player_data.clothing.textures[3] = textureScroller end

                SetPedComponentVariation(GetPlayerPed(-1), componentScroller, subComponentScroller, textureScroller, paletteScroller)

            end

        end)

        Menu.addOption("clothing_customise", function()

            if(Menu.ScrollBarInt("Colour Palette", paletteScroller, 2, function(cb)  paletteScroller = cb end)) then

                SetPedComponentVariation(GetPlayerPed(-1), componentScroller, subComponentScroller, textureScroller, paletteScroller)

            end

        end)

        Menu.addOption("clothing_customise", function()

            if(Menu.Option("Randomize"))then

                SetPedRandomComponentVariation(GetPlayerPed(-1), true)

            end

        end)

    end

end



function accessories()

    Menu.SetupMenu("clothing_accessories", 'Accessories')

    Menu.Switch("clothing_main", "clothing_accessories")

    if GetEntityModel(GetPlayerPed(-1)) == GetHashKey("mp_m_freemode_01") or GetEntityModel(GetPlayerPed(-1)) == GetHashKey("mp_f_freemode_01") then

        componentScroller = 0

        subComponentScroller = GetPedPropIndex(GetPlayerPed(-1), componentScroller)

        textureScroller = GetPedPropTextureIndex(GetPlayerPed(-1), componentScroller)

        Menu.addOption("clothing_accessories", function()

            if(Menu.ScrollBarString({"Hats/Helmets","Glasses","Earrings","Empty slot","Empty slot","Empty slot","Left Wrist","Right Wrist"}, componentScroller, function(cb)  componentScroller = cb end)) then

                subComponentScroller = GetPedPropIndex(GetPlayerPed(-1), componentScroller)

                textureScroller = GetPedPropTextureIndex(GetPlayerPed(-1), componentScroller)

            end

        end)

        Menu.addOption("clothing_accessories", function()

            if(Menu.ScrollBarInt("Components", subComponentScroller, GetNumberOfPedPropDrawableVariations(GetPlayerPed(-1), componentScroller), function(cb)  subComponentScroller = cb end)) then

                SetPedPropIndex(GetPlayerPed(-1), componentScroller, 0, 240, 0)

                SetPedPropIndex(GetPlayerPed(-1), componentScroller, subComponentScroller, textureScroller, false)

                textureScroller = 0

            end

        end)

        Menu.addOption("clothing_accessories", function()

            if(Menu.ScrollBarInt("Textures", textureScroller, GetNumberOfPedPropTextureVariations(PlayerPedId(), componentScroller, subComponentScroller), function(cb)  textureScroller = cb end)) then

                SetPedPropIndex(GetPlayerPed(-1), componentScroller, subComponentScroller, textureScroller, false)

            end

        end)

        Menu.addOption("clothing_accessories", function()

            if(Menu.ScrollBarStringSelect({"Remove helmets","Remove glasses","Remove earrings","Remove left wrist","Remove right wrist"}, removeScroller, function(cb)  removeScroller = cb end)) then

                if removeScroller ~= 3 and removeScroller ~= 4 then

                    ClearPedProp(GetPlayerPed(-1), tonumber(removeScroller))

                elseif removeScroller == 3 then

                    ClearPedProp(GetPlayerPed(-1), 6)

                else

                    ClearPedProp(GetPlayerPed(-1), 7)

                end

            end

        end)

    else

        local precomponentTable = {"Hats/Helmets","Glasses","Earrings","Empty slot","Empty slot","Empty slot","Left Wrist","Right Wrist"}

        local componentTable = {}

        for i = 0, 7 do

            if GetNumberOfPedPropDrawableVariations(GetPlayerPed(-1), i) ~= 0 and GetNumberOfPedPropDrawableVariations(GetPlayerPed(-1), i) ~= false then

                componentTable[i+1] = precomponentTable[i+1]

            else

                componentTable[i+1] = "Empty slot"

            end

        end

        componentScroller = 0

        subComponentScroller = GetPedDrawableVariation(GetPlayerPed(-1), componentScroller)

        textureScroller = GetPedTextureVariation(GetPlayerPed(-1), componentScroller)

        Menu.addOption("clothing_accessories", function()

            if(Menu.ScrollBarString(componentTable, componentScroller, function(cb)  componentScroller = cb end)) then

                subComponentScroller = GetPedPropIndex(GetPlayerPed(-1), componentScroller)

                textureScroller = GetPedPropTextureIndex(GetPlayerPed(-1), componentScroller)

            end

        end)

        Menu.addOption("clothing_accessories", function()

            if(Menu.ScrollBarInt("Components", subComponentScroller, GetNumberOfPedPropDrawableVariations(GetPlayerPed(-1), componentScroller), function(cb)  subComponentScroller = cb end)) then

                SetPedPropIndex(GetPlayerPed(-1), componentScroller, 0, 240, 0)

                SetPedPropIndex(GetPlayerPed(-1), componentScroller, subComponentScroller, textureScroller, false)

                textureScroller = 0

            end

        end)

        Menu.addOption("clothing_accessories", function()

            if(Menu.ScrollBarInt("Textures", textureScroller, GetNumberOfPedPropTextureVariations(PlayerPedId(), componentScroller, subComponentScroller), function(cb)  textureScroller = cb end)) then

                SetPedPropIndex(GetPlayerPed(-1), componentScroller, subComponentScroller, textureScroller, false)

            end

        end)

        Menu.addOption("clothing_accessories", function()

            if(Menu.ScrollBarStringSelect({"Remove helmets","Remove glasses","Remove earrings","Remove left wrist","Remove right wrist"}, removeScroller, function(cb)  removeScroller = cb end)) then

                if removeScroller ~= 3 and removeScroller ~= 4 then

                    ClearPedProp(GetPlayerPed(-1), tonumber(removeScroller))

                elseif removeScroller == 3 then

                    ClearPedProp(GetPlayerPed(-1), 6)

                else

                    ClearPedProp(GetPlayerPed(-1), 7)

                end

            end

        end)

    end

end



function save()

    player_data.model = GetEntityModel(GetPlayerPed(-1))

    for i = 0, 11 do

        player_data.clothing.drawables[i+1] = GetPedDrawableVariation(GetPlayerPed(-1), i)

        if i ~= 2 then

            player_data.clothing.textures[i+1] = GetPedTextureVariation(GetPlayerPed(-1), i)

        end

        player_data.clothing.palette[i+1] = GetPedPaletteVariation(GetPlayerPed(-1), i)

    end

    for i = 0, 7 do

        player_data.props.drawables[i+1] = GetPedPropIndex(GetPlayerPed(-1), i)

        player_data.props.textures[i+1] = GetPedPropTextureIndex(GetPlayerPed(-1), i)

    end

    if player_data.clothing.drawables[12] == 55 and GetEntityModel(GetPlayerPed(-1)) == GetHashKey("mp_m_freemode_01") then player_data.clothing.drawables[12] = 56 SetPedComponentVariation(GetPlayerPed(-1), 11, 56, 0, 2) end

    if player_data.clothing.drawables[12] == 48 and GetEntityModel(GetPlayerPed(-1)) == GetHashKey("mp_f_freemode_01") then player_data.clothing.drawables[12] = 49 SetPedComponentVariation(GetPlayerPed(-1), 11, 49, 0, 2) end

    clothing = player_data

    mask.drawables = GetPedDrawableVariation(GetPlayerPed(-1), 1)

    mask.textures = GetPedTextureVariation(GetPlayerPed(-1), 1)

    glasses.drawables = GetPedPropIndex(GetPlayerPed(-1), 1)

    glasses.textures = GetPedPropTextureIndex(GetPlayerPed(-1), 1)

    helmet.drawables = GetPedPropIndex(GetPlayerPed(-1), 0)

    helmet.textures = GetPedPropTextureIndex(GetPlayerPed(-1), 0)

    TriggerServerEvent('clothes:save', player_data)

end



RegisterNetEvent('clothes:load')

AddEventHandler('clothes:load', function(data)

    ClearPedProp(GetPlayerPed(-1), 0)

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

        SetPedDefaultComponentVariation(GetPlayerPed(-1))

        for i = 0, 11 do

            SetPedComponentVariation(GetPlayerPed(-1), i, player_data.clothing.drawables[i+1], player_data.clothing.textures[i+1], player_data.clothing.palette[i+1])

        end

        for i = 0, 7 do

            SetPedPropIndex(GetPlayerPed(-1), i, player_data.props.drawables[i+1], player_data.props.textures[i+1], false)

        end

    end

    mask.drawables = GetPedDrawableVariation(GetPlayerPed(-1), 1)

    mask.textures = GetPedTextureVariation(GetPlayerPed(-1), 1)

    glasses.drawables = GetPedPropIndex(GetPlayerPed(-1), 1)

    glasses.textures = GetPedPropTextureIndex(GetPlayerPed(-1), 1)

    helmet.drawables = GetPedPropIndex(GetPlayerPed(-1), 0)

    helmet.textures = GetPedPropTextureIndex(GetPlayerPed(-1), 0)

    clothing = data

    save()

    Wait(1000)

    TriggerServerEvent('core:giveweapons')

    TriggerServerEvent('core:checkjob')

    TriggerServerEvent('core:characterloaded')

end)





function GetClothes()

 return clothing

end



local clothing_shops = {

  {x=428.75,   y=-803.74,  z=29.49, blip = true},

  {x=72.27,    y=-1395.54, z=29.37, blip = true},

  {x=-705.64,  y=-151.8,  z=37.42, blip = true},

  {x=-166.88,  y=-300.67,  z=39.73, blip = true},

  {x=-826.09,  y=-1072.05, z=11.32, blip = true},

  {x=-1447.91, y=-241.0,  z=49.81, blip = true},

  {x=8.79,     y=6511.88,  z=31.87, blip = true},

  {x=118.28,   y=-224.79,  z=54.56, blip = true},

  {x=1696.71,  y=4825.71,  z=42.06, blip = true},

  {x=620.38,   y=2766.86,  z=42.08, blip = true},

  {x=1194.18,  y=2713.34,  z=38.22, blip = true},

  {x=-1186.33, y=-771.12,  z=17.33, blip = true},

  {x=-3178.13, y=1043.2,  z=20.86, blip = false},

  {x=-1105.51, y=2711.18,  z=19.11, blip = false},

  {x = 454.505, y = -988.925, z = 30.689,blip = false},
}



incircle = false

Citizen.CreateThread(function()

    for k,v in ipairs(clothing_shops)do

     if v.blip then 

        local blip = AddBlipForCoord(v.x, v.y, v.z)

        SetBlipSprite (blip, 73)

        SetBlipDisplay(blip, 4)

        SetBlipScale  (blip, 0.6)

        SetBlipColour (blip, 22)

        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName("STRING")

        AddTextComponentString("Clothing Store")

        EndTextCommandSetBlipName(blip)

     end

    end

    while true do

        Citizen.Wait(5)

        local coords = GetEntityCoords(GetPlayerPed(-1), true)

        for k,v in ipairs(clothing_shops) do

            if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 20 then

                if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 4 then

      				DrawText3Ds(v.x, v.y, v.z,'~c~[~g~E~c~] para acceder a la tienda de ropa')

                    incircle = true

                    if IsControlJustReleased(1, 51) then -- INPUT_CELLPHONE_DOWN

                        GUI.maxVisOptions = 20

                        titleTextSize = {0.85, 0.80} ------------ {p1, Size}                                      

                        titleRectSize = {0.23, 0.085} ----------- {Width, Height}                                 

                        optionTextSize = {0.5, 0.5} ------------- {p1, Size}                                      

                        optionRectSize = {0.23, 0.035} ---------- {Width, Height}           

                        menuX = 0.745 ----------------------------- X position of the menu                          

                        menuXOption = 0.11 --------------------- X postiion of Menu.Option text                  

                        menuXOtherOption = 0.06 ---------------- X position of Bools, Arrays etc text            

                        menuYModify = 0.1500 -------------------- Default: 0.1174   ------ Top bar                

                        menuYOptionDiv = 4.285 ------------------ Default: 3.56   ------ Distance between buttons 

                        menuYOptionAdd = 0.21 ------------------ Default: 0.142  ------ Move buttons up and down

                        clothing_menu = not clothing_menu

                        OpenClothes()

                    end

                elseif GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) > 2.2 and incircle then

                    incircle = false

                    clothing_menu = false

                    save()

                end

            end

        end

    end

end)



function setModel(model)

    local model = model

    if IsModelInCdimage(model) and IsModelValid(model) then

        RequestModel(model)

        while not HasModelLoaded(model) do

            Citizen.Wait(0)

        end

        SetPlayerModel(PlayerId(), model)

        SetPedComponentVariation(GetPlayerPed(-1), 11, 0, 240, 0)

        SetPedComponentVariation(GetPlayerPed(-1), 8, 0, 240, 0)

        SetPedComponentVariation(GetPlayerPed(-1), 11, 6, 1, 0)

        SetModelAsNoLongerNeeded(model)

    end

end



-- Player Toggles

AddEventHandler("clothing:togglemask", function()

 local ped = GetPlayerPed(-1)

 if mask.status then

  SetPedComponentVariation(ped, 1, 0, 0, 2)

  print('Mask Off')

 else

  SetPedComponentVariation(ped, 1, mask.drawables, mask.textures, 2)

  print('Mask On')

 end

 mask.status = not mask.status

end)



AddEventHandler("clothing:toggleglasses", function()

  local ped = GetPlayerPed(-1)

  if glasses.status then

    ClearPedProp(ped, 1)

    print('Glassses Off')

  else

    SetPedPropIndex(ped, 1, glasses.drawables, glasses.textures, true)

    print('Glasses On')

  end

  glasses.status = not glasses.status

end)



AddEventHandler("clothing:togglehelmet", function()

  local ped = GetPlayerPed(-1)

  if helmet.status then

    ClearPedProp(GetPlayerPed(-1), 0)

    print('Helmet Off')

  else

    SetPedPropIndex(ped, 0, helmet.drawables, helmet.textures, true)

    print('Helmet On')

  end

  helmet.status = not helmet.status

end)





RegisterCommand("naked", function(source, args, raw)

 if(GetEntityModel(GetPlayerPed(-1)) == -1667301416) then  -- GIRL SKIN

  SetPedComponentVariation(GetPlayerPed(-1), 8, 34,0, 2)

  SetPedComponentVariation(GetPlayerPed(-1), 3, 15,0, 2)

  SetPedComponentVariation(GetPlayerPed(-1), 11, 101,1, 2)

  SetPedComponentVariation(GetPlayerPed(-1), 4, 56,1, 2)

  SetPedComponentVariation(GetPlayerPed(-1), 6, 35,0, 2)

 else                             -- BOY SKIN

  if args[1] == '1' then

   SetPedComponentVariation(GetPlayerPed(-1), 8, 15,0, 2)

   SetPedComponentVariation(GetPlayerPed(-1), 3, 15,0, 2)

   SetPedComponentVariation(GetPlayerPed(-1), 11, 91,0, 2)

   SetPedComponentVariation(GetPlayerPed(-1), 4, 21,0, 2)

   SetPedComponentVariation(GetPlayerPed(-1), 6, 34,0, 2)

  elseif args[1] == '2' then

   SetPedComponentVariation(GetPlayerPed(-1), 8, 15,0, 2)

   SetPedComponentVariation(GetPlayerPed(-1), 3, 15,0, 2)

   SetPedComponentVariation(GetPlayerPed(-1), 11, 91,0, 2)

   SetPedComponentVariation(GetPlayerPed(-1), 4, 61,0, 2)

   SetPedComponentVariation(GetPlayerPed(-1), 6, 34,0, 2)

  elseif args[1] == '3' then

   SetPedComponentVariation(GetPlayerPed(-1), 8, 15,0, 2)

   SetPedComponentVariation(GetPlayerPed(-1), 3, 15,0, 2)

   SetPedComponentVariation(GetPlayerPed(-1), 11, 91,0, 2)

   SetPedComponentVariation(GetPlayerPed(-1), 4, 61,1, 2)

   SetPedComponentVariation(GetPlayerPed(-1), 6, 34,0, 2)

  elseif args[1] == '4' then

   SetPedComponentVariation(GetPlayerPed(-1), 8, 15,0, 2)

   SetPedComponentVariation(GetPlayerPed(-1), 3, 15,0, 2)

   SetPedComponentVariation(GetPlayerPed(-1), 11, 91,0, 2)

   SetPedComponentVariation(GetPlayerPed(-1), 4, 61,2, 2)

   SetPedComponentVariation(GetPlayerPed(-1), 6, 34,0, 2)

  end

 end

end, false)



RegisterCommand("swimsuit", function(source, args, rawCommand)

 if(GetEntityModel(GetPlayerPed(-1)) == -1667301416) then  -- GIRL SKIN

  SetPedComponentVariation(GetPlayerPed(-1), 8, 34,0, 2)

  SetPedComponentVariation(GetPlayerPed(-1), 3, 15,0, 2)

  SetPedComponentVariation(GetPlayerPed(-1), 11, 101,1, 2)

  SetPedComponentVariation(GetPlayerPed(-1), 4, 56,0, 2)

 else                             -- BOY SKIN

   SetPedComponentVariation(GetPlayerPed(-1), 8, 15,0, 2)

   SetPedComponentVariation(GetPlayerPed(-1), 3, 15,0, 2)

   SetPedComponentVariation(GetPlayerPed(-1), 11, 91,0, 2)

   SetPedComponentVariation(GetPlayerPed(-1), 4, 16,0, 2)

   SetPedComponentVariation(GetPlayerPed(-1), 6, 34,0, 2)

 end

end, false)



AddEventHandler('clothing:save', function()

 save()

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

  local factor = (string.len(text)) / 370

  --DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)

end