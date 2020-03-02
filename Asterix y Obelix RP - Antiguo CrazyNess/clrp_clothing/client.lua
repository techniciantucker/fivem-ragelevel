local cmenu = {show = 0, row = 0, field = 1}
local draw = {0,0,0}
local prop = {0,0,1}
local bar = {x=0.628, y=0.142, x1=0.037,y1=0.014}
local clothing = {}
local mask = {drawables = 0, textures = 0, status = false}
local glasses = {drawables = 0, textures = 0, status = false}
local helmet = {drawables = 0, textures = 0, status = false}
local pants = {drawables = 0, textures = 0, status = false}
local shoes = {drawables = 0, textures = 0, status = false}
local gloves = {drawables = 0, textures = 0, status = false}
local vest = {drawables = 0, textures = 0, status = false}


local clothingList = {
	[1] = "",
	[2] = "Mask",
	[3] = "",
	[4] = "Arms",
	[5] = "Pants",
	[6] = "Backpack",
	[7] = "Shoes",
	[8] = "Neck/Tie",
	[9] = "Undershirt",
	[10] = "Vests",
	[11] = "Decals",
	[12] = "Jacket / Overshirt",
}

local accessoriesList = {
	[1] = "Hat",
	[2] = "Glasses",
	[3] = "Earings",
	[4] = "Unknown",
	[5] = "Unknown",
	[6] = "Unknown",
	[7] = "Watch",
	[8] = "Wrist Jewellery",
}

local resetID = 1
local resetList = {
	[1] = "Remove Hat",
	[2] = "Remove Glasses",
	[3] = "Remove Earings",
	[4] = "Unknown",
	[5] = "Unknown",
	[6] = "Unknown",
	[7] = "Remove Watch",
	[8] = "Remove Jewellery",
}


function DisplayHelpText(str)
 SetTextComponentFormat("STRING")
 AddTextComponentString(str)
 DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function custDrawRect(x, y, width, height, r, g, b, a)
 y = y + 0.5
 y = y * 0.8
 x = x * 0.8
 width = width * 0.8
 height = height * 0.8
 DrawRect(x, y, width, height, r, g, b, a)
end

function drawTxt(x,y ,width,height,scale, text, r,g,b,a)
 y = y + 0.502
 y = y * 0.8
 x = x * 0.8
 width = width * 0.8
 height = height * 0.8
 SetTextFont(6)
 SetTextProportional(0)
 SetTextScale(0.35, 0.35)
 SetTextColour(r, g, b, a)
 SetTextDropShadow(0, 0, 0, 0,255)
 SetTextEdge(1, 0, 0, 0, 255)
 SetTextDropShadow()
 SetTextOutline()
 SetTextEntry("STRING")
 AddTextComponentString(text)
 DrawText(x - width/2, y - height/2 + 0.005)
end

AddEventHandler('clothing:open', function()
 cmenu.show = 1
 cmenu.row = 1
 cmenu.field = 2
end)

function loadAnimDict( dict )
 while ( not HasAnimDictLoaded( dict ) ) do
  RequestAnimDict( dict )
  Citizen.Wait( 5 )
 end
end

function clothingbad()
 loadAnimDict( "clothingshirt" )
 TaskPlayAnim( GetPlayerPed(-1), "clothingshirt", "try_shirt_negative_d", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
end

function clothinggood()
 loadAnimDict( "clothingshirt" )
 TaskPlayAnim( GetPlayerPed(-1), "clothingshirt", "try_shirt_positive_d", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
 Wait(3100)
 ClearPedSecondaryTask(GetPlayerPed(-1))
end

function ClothShop()
	custDrawRect(0.12,0.07,0.22,0.09,40,40,40,180) -- header
	drawTxt(0.177, 0.066, 0.25, 0.03, 0.40,"Clothing Store",255,255,255,255) -- header
	custDrawRect(0.12,0.024,0.216,0.005,30, 96, 201,220) -- blue_head
	if cmenu.show == 1 then
		if cmenu.row == 1 then custDrawRect(0.12,0.135,0.22,0.035,30, 96, 201, 215) else custDrawRect(0.12,0.135,0.22,0.035,40,40,40,180) end
		if cmenu.row == 2 then custDrawRect(0.12,0.172,0.22,0.035,30, 96, 201, 215) else custDrawRect(0.12,0.172,0.22,0.035,40,40,40,180) end
		if cmenu.row == 3 then custDrawRect(0.12,0.209,0.22,0.035,30, 96, 201, 215) else custDrawRect(0.12,0.209,0.22,0.035,40,40,40,180) end
		drawTxt(0.177, 0.128, 0.25, 0.03, 0.40,"Body Changes",255,255,255,255)
		drawTxt(0.177, 0.165, 0.25, 0.03, 0.40,"Accessories",255,255,255,255) -- row_2 (+0.037)
		drawTxt(0.177, 0.202, 0.25, 0.03, 0.40,"Exit",255,255,255,255) -- row_2 (+0.037)



	elseif cmenu.show == 2 then
		-- debug_you_can_delete_it
		local drawstr = string.format("Object: %d | Color: %d",draw[1],draw[2])

		drawTxt(0.242, 0.225, 0, 0, 0.40,drawstr,255,255,255,255)

		custDrawRect(0.328,0.244,0.18,0.035,40,40,40,180)

		-- debug_end
		custDrawRect(0.12,0.135,0.22,0.035,76,88,102,220)
		custDrawRect(0.12,0.172,0.22,0.035,40,40,40,180)
		custDrawRect(0.12,0.209,0.22,0.035,40,40,40,180)

		drawTxt(0.177, 0.128, 0.25, 0.03, 0.40,"Body Changes",255,255,255,255)
		drawTxt(0.177, 0.165, 0.25, 0.03, 0.40,"Accessories",255,255,255,255) -- row_2 (+0.037)
		drawTxt(0.177, 0.202, 0.25, 0.03, 0.40,"Exit",255,255,255,255) -- row_2 (+0.037)
		---
		custDrawRect(0.328,0.051,0.18,0.049,40,40,40,180) -- title
		drawTxt(0.382,0.048,0.175,0.035, 0.40,"Body Changes",255,255,255,255)
		custDrawRect(0.328,0.024,0.175,0.005,30, 96, 201,220)

		if cmenu.row == 1 then custDrawRect(0.328,0.096,0.18,0.035,76,88,102,220) else custDrawRect(0.328,0.096,0.18,0.035,40,40,40,180) end
		if cmenu.row == 2 then custDrawRect(0.328,0.133,0.18,0.035,76,88,102,220) else custDrawRect(0.328,0.133,0.18,0.035,40,40,40,180) end
		if cmenu.row == 3 then custDrawRect(0.328,0.170,0.18,0.035,76,88,102,220) else custDrawRect(0.328,0.170,0.18,0.035,40,40,40,180) end
		if cmenu.row == 4 then custDrawRect(0.328,0.207,0.18,0.035,76,88,102,220) else custDrawRect(0.328,0.207,0.18,0.035,40,40,40,180) end

		local draw_str = "Slot: " .. clothingList[cmenu.field] .. " " .. cmenu.field .. "/12"

		drawTxt(0.328,0.093,0.175,0.035, 0.40,draw_str,255,255,255,255)
		--
		if GetNumberOfPedDrawableVariations(GetPlayerPed(-1), cmenu.field-1) ~= 0 and GetNumberOfPedDrawableVariations(GetPlayerPed(-1), cmenu.field-1) ~= false then
			custDrawRect(0.328,0.142,0.175,0.014,222,222,222,220)
			local link = 0.138/(GetNumberOfPedDrawableVariations(GetPlayerPed(-1), cmenu.field-1)-1)

			local new_x = (bar.x-0.069)+(link*GetPedDrawableVariation(PlayerPedId(), cmenu.field-1))
			new_x = new_x - 0.3
			if new_x < 0.259 then new_x = 0.259 end
			if new_x > 0.397 then new_x = 0.397 end
			custDrawRect(new_x,bar.y,bar.x1,bar.y1,0,25,201,220)
			-- row_3


			custDrawRect(0.328,0.179,0.175,0.014,222,222,222,220) -- bar_main
			local link = 0.138/(GetNumberOfPedTextureVariations(GetPlayerPed(-1), cmenu.field-1, draw[1])-1)
			local new_x = (bar.x-0.069)+(link*GetPedTextureVariation(PlayerPedId(), cmenu.field-1))
			new_x = new_x - 0.3
			if new_x < 0.259 then new_x = 0.259 end
			if new_x > 0.397 then new_x = 0.397 end
			custDrawRect(new_x,bar.y+0.037,bar.x1,bar.y1,0,25,201,220)
			--


		  drawTxt(0.242, 0.185, 0, 0, 0.40, 'Remove Undershirt', 255,255,255,255)



      if IsControlJustPressed(1,201) or IsControlJustPressed(1,38) then -- Enter
       PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
       if cmenu.row == 4 then
        SetPedComponentVariation(GetPlayerPed(-1), 8, 0, 240, 0)
       end
  	  end

			if IsControlJustPressed(1, 189) or IsDisabledControlJustPressed(1, 189) then -- left
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				if cmenu.row == 1 then
					if cmenu.field > 1 then
						cmenu.field = cmenu.field-1
            if cmenu.field == 1 then
             cmenu.field = 12
            elseif cmenu.field == 3 then
             cmenu.field = 2
            end
            draw[1] = GetPedDrawableVariation(PlayerPedId(), cmenu.field-1)
            draw[2] = GetPedTextureVariation(PlayerPedId(), cmenu.field-1)
					else
						cmenu.field = 12
            draw[1] = GetPedDrawableVariation(PlayerPedId(), cmenu.field-1)
            draw[2] = GetPedTextureVariation(PlayerPedId(), cmenu.field-1)
					end
				elseif cmenu.row == 2 then
					if draw[1] > 0 then draw[1] = draw[1]-1 else draw[1] =  GetNumberOfPedDrawableVariations(GetPlayerPed(-1), cmenu.field-1)-1 end
					draw[2] = 0
					SetPedComponentVariation(GetPlayerPed(-1), cmenu.field-1, draw[1], draw[2], draw[3])
				elseif cmenu.row == 3 then
					if draw[2] > 0 then draw[2] = draw[2]-1 else draw[2] = GetNumberOfPedTextureVariations(GetPlayerPed(-1), cmenu.field-1, draw[1])-1 end
					SetPedComponentVariation(GetPlayerPed(-1), cmenu.field-1, draw[1], draw[2], draw[3])
				end
			end

			if IsControlJustPressed(1, 190) or IsDisabledControlJustPressed(1, 190) then -- right
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				if cmenu.row == 1 then
					if cmenu.field < 12 then
						cmenu.field = cmenu.field+1
            if cmenu.field == 1 then
             cmenu.field = 2
            elseif cmenu.field == 3 then
             cmenu.field = 4
            end
            draw[1] = GetPedDrawableVariation(PlayerPedId(), cmenu.field-1)
            draw[2] = GetPedTextureVariation(PlayerPedId(), cmenu.field-1)
					else
						cmenu.field = 2
            draw[1] = GetPedDrawableVariation(PlayerPedId(), cmenu.field-1)
            draw[2] = GetPedTextureVariation(PlayerPedId(), cmenu.field-1)
					end
				elseif cmenu.row == 2 then
				 if draw[1] < GetNumberOfPedDrawableVariations(GetPlayerPed(-1), cmenu.field-1)-1 then draw[1] = draw[1]+1 else draw[1] = 0 end
				 draw[2] = 0
				 SetPedComponentVariation(GetPlayerPed(-1), cmenu.field-1, draw[1], draw[2], draw[3])
				elseif cmenu.row == 3 then
					if draw[2] < GetNumberOfPedTextureVariations(GetPlayerPed(-1), cmenu.field-1, draw[1])-1 then draw[2] = draw[2]+1 else draw[2] = 0 end
					SetPedComponentVariation(GetPlayerPed(-1), cmenu.field-1, draw[1], draw[2], draw[3])
				end
			end
		else
			drawTxt(0.328,0.130,0.175,0.035, 0.40,"None Available",255,255,255,255)
			drawTxt(0.328,0.167,0.175,0.035, 0.40,"None Available",255,255,255,255)
			if IsControlJustPressed(1, 189) or IsDisabledControlJustPressed(1, 189) then -- left
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				if cmenu.field > 1 then
					cmenu.field = cmenu.field-1
					draw[1] = 0
					draw[2] = 0
				else
					cmenu.field = 12
					draw[1] = 0
					draw[2] = 0
				end
			end
			if IsControlJustPressed(1, 190) or IsDisabledControlJustPressed(1, 190) then -- right
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				if cmenu.field < 12 then
					cmenu.field = cmenu.field+1
					draw[1] = 0
					draw[2] = 0
				else
					cmenu.field = 2
					draw[1] = 0
					draw[2] = 0
				end
			end
		end
	elseif cmenu.show == 3 then
		local drawstr = string.format("Object: %d | Color: %d",prop[1],prop[2])
		drawTxt(0.242, 0.188+0.037, 0, 0, 0.40,drawstr,255,255,255,255)
		custDrawRect(0.328,0.207+0.037,0.18,0.035,40,40,40,180)
		drawTxt(0.242, 0.185, 0, 0, 0.40, resetList[resetID], 255,255,255,255)

		custDrawRect(0.12,0.135,0.22,0.035,40,40,40,180)
		custDrawRect(0.12,0.172,0.22,0.035,76,88,102,220)
		custDrawRect(0.12,0.209,0.22,0.035,40,40,40,180)
		drawTxt(0.177, 0.128, 0.25, 0.03, 0.40,"Body Changes",255,255,255,255)
		drawTxt(0.177, 0.165, 0.25, 0.03, 0.40,"Accessories",255,255,255,255) -- row_2 (+0.037)
		drawTxt(0.177, 0.202, 0.25, 0.03, 0.40,"Exit",255,255,255,255) -- row_2 (+0.037)

		custDrawRect(0.328,0.051,0.18,0.049,40,40,40,180) -- title
		drawTxt(0.382,0.048,0.175,0.035, 0.40,"Accessories",255,255,255,255)
		custDrawRect(0.328,0.024,0.175,0.005,30, 96, 201,220)
		if cmenu.row == 1 then custDrawRect(0.328,0.096,0.18,0.035,76,88,102,220) else custDrawRect(0.328,0.096,0.18,0.035,40,40,40,180) end
		if cmenu.row == 2 then custDrawRect(0.328,0.133,0.18,0.035,76,88,102,220) else custDrawRect(0.328,0.133,0.18,0.035,40,40,40,180) end
		if cmenu.row == 3 then custDrawRect(0.328,0.170,0.18,0.035,76,88,102,220) else custDrawRect(0.328,0.170,0.18,0.035,40,40,40,180) end
		if cmenu.row == 4 then custDrawRect(0.328,0.170+0.037,0.18,0.035,76,88,102,220) else custDrawRect(0.328,0.170+0.037,0.18,0.035,40,40,40,180) end

		local draw_str = "Slot: " .. accessoriesList[cmenu.field] .. " " .. cmenu.field .. "/8"

		drawTxt(0.328,0.093,0.175,0.035, 0.40,draw_str,255,255,255,255)
		--
		if GetNumberOfPedPropDrawableVariations(GetPlayerPed(-1), cmenu.field-1) ~= 0 and GetNumberOfPedPropDrawableVariations(GetPlayerPed(-1), cmenu.field-1) ~= false then
			custDrawRect(0.328,0.142,0.175,0.014,222,222,222,220)
			local link = 0.138/(GetNumberOfPedPropDrawableVariations(GetPlayerPed(-1), cmenu.field-1)-1)
			local new_x = (bar.x-0.069)+(link*prop[1])


			new_x = new_x - 0.3
			custDrawRect(new_x,bar.y,bar.x1,bar.y1,0,25,201,220)
			-- row_3
			custDrawRect(0.328,0.179,0.175,0.014,222,222,222,220) -- bar_main
			local link = 0.138/(GetNumberOfPedPropTextureVariations(GetPlayerPed(-1), cmenu.field-1, prop[1])-1)
			local new_x = (bar.x-0.069)+(link*prop[2])
			new_x = new_x - 0.3


			custDrawRect(new_x,bar.y+0.037,bar.x1,bar.y1,0,25,201,220)
			--
			if IsControlJustPressed(1, 189) or IsDisabledControlJustPressed(1, 189) then -- left
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				if cmenu.row == 1 then
					if cmenu.field > 1 then
						cmenu.field = cmenu.field-1
						prop[1] = GetPedPropIndex(PlayerPedId(), cmenu.field-1)
						prop[2] = GetPedPropTextureIndex(GetPlayerPed(-1), cmenu.field-1)
					else
						cmenu.field = 8
						prop[1] = GetPedPropIndex(PlayerPedId(), cmenu.field-1)
						prop[2] =  GetPedPropTextureIndex(GetPlayerPed(-1), cmenu.field-1)
					end
				elseif cmenu.row == 2 then
					if prop[1] > 0 then prop[1] = prop[1]-1 else prop[1] = 0 end
					prop[2] = 0
					SetPedPropIndex(GetPlayerPed(-1), cmenu.field-1, prop[1], prop[2], prop[3])
				elseif cmenu.row == 3 then
					if prop[2] > 0 then prop[2] = prop[2]-1 else prop[2] = 0 end
					SetPedPropIndex(GetPlayerPed(-1), cmenu.field-1, prop[1], prop[2], prop[3])
        elseif cmenu.row == 4 then
         if resetID > 1 then resetID = resetID-1 else resetID = 1 end
				end
			end
			if IsControlJustPressed(1, 190) or IsDisabledControlJustPressed(1, 190) then -- right
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				if cmenu.row == 1 then
					if cmenu.field < 8 then
						cmenu.field = cmenu.field+1
						prop[1] = GetPedPropIndex(PlayerPedId(), cmenu.field-1)
						prop[2] = GetPedPropTextureIndex(GetPlayerPed(-1), cmenu.field-1)
					else
						cmenu.field = 2
						prop[1] = GetPedPropIndex(PlayerPedId(), cmenu.field-1)
						prop[2] = GetPedPropTextureIndex(GetPlayerPed(-1), cmenu.field-1)
					end
				elseif cmenu.row == 2 then
					if prop[1] < GetNumberOfPedPropDrawableVariations(GetPlayerPed(-1), cmenu.field-1)-1 then prop[1] = prop[1]+1 else prop[1] = GetNumberOfPedPropDrawableVariations(GetPlayerPed(-1), cmenu.field-1)-1 end
					prop[2] = 0
					SetPedPropIndex(GetPlayerPed(-1), cmenu.field-1, prop[1], prop[2], prop[3])
				elseif cmenu.row == 3 then
					if prop[2] < GetNumberOfPedPropTextureVariations(GetPlayerPed(-1), cmenu.field-1, prop[1])-1 then prop[2] = prop[2]+1 else prop[2] = GetNumberOfPedPropTextureVariations(GetPlayerPed(-1), cmenu.field-1, prop[1])-1 end
					SetPedPropIndex(GetPlayerPed(-1), cmenu.field-1, prop[1], prop[2], prop[3])
        elseif cmenu.row == 4 then
         if resetID < 8 then resetID = resetID+1 else resetID = 1 end
				end
			end
		else
			drawTxt(0.328,0.130,0.175,0.035, 0.40,"None Available",255,255,255,255)
			drawTxt(0.328,0.167,0.175,0.035, 0.40,"None Available",255,255,255,255)
			if IsControlJustPressed(1, 189) or IsDisabledControlJustPressed(1, 189) then -- left
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				if cmenu.field > 1 then
					cmenu.field = cmenu.field-1
          prop[1] = GetPedPropIndex(PlayerPedId(), cmenu.field-1)
          prop[2] = GetPedPropTextureIndex(GetPlayerPed(-1), cmenu.field-1)
				else
					cmenu.field = 8
          prop[1] = GetPedPropIndex(PlayerPedId(), cmenu.field-1)
          prop[2] = GetPedPropTextureIndex(GetPlayerPed(-1), cmenu.field-1)
				end
			end
			if IsControlJustPressed(1, 190) or IsDisabledControlJustPressed(1, 190) then -- right
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				if cmenu.field < 8 then
					cmenu.field = cmenu.field+1
          prop[1] = GetPedPropIndex(PlayerPedId(), cmenu.field-1)
          prop[2] = GetPedPropTextureIndex(GetPlayerPed(-1), cmenu.field-1)
				else
					cmenu.field = 2
          prop[1] = GetPedPropIndex(PlayerPedId(), cmenu.field-1)
          prop[2] = GetPedPropTextureIndex(GetPlayerPed(-1), cmenu.field-1)
				end
			end
		end
	end
end


RegisterNetEvent('outfit:tempOutfit')
AddEventHandler('outfit:tempOutfit', function(jsonData)
 ClearAllPedProps(PlayerPedId())

 Citizen.CreateThread(function()
	for i = 0, 11 do
   if i ~= 0 and i ~= 2 then
    SetPedComponentVariation(GetPlayerPed(-1), i, tonumber(jsonData.clothing.drawables[i+1]), tonumber(jsonData.clothing.textures[i+1]), tonumber(jsonData.clothing.palette[i+1]))
   end
  end

  for i = 0, 7 do
   SetPedPropIndex(GetPlayerPed(-1), i, tonumber(jsonData.props.drawables[i+1]), tonumber(jsonData.props.textures[i+1]), true)
  end
 end)

 helmet.textures = GetPedPropTextureIndex(GetPlayerPed(-1), 0)
 helmet.drawables = GetPedPropIndex(GetPlayerPed(-1), 0)
 glasses.textures = GetPedPropTextureIndex(GetPlayerPed(-1), 1)
 glasses.drawables = GetPedPropIndex(GetPlayerPed(-1), 1)
 mask.textures = GetPedTextureVariation(GetPlayerPed(-1), 1)
 mask.drawables = GetPedDrawableVariation(GetPlayerPed(-1), 1)
 pants.textures = GetPedTextureVariation(GetPlayerPed(-1), 4)
 pants.drawables = GetPedDrawableVariation(GetPlayerPed(-1), 4)
 shoes.textures = GetPedTextureVariation(GetPlayerPed(-1), 6)
 shoes.drawables = GetPedDrawableVariation(GetPlayerPed(-1), 6)
 gloves.textures = GetPedTextureVariation(GetPlayerPed(-1), 3)
 gloves.drawables = GetPedDrawableVariation(GetPlayerPed(-1), 3)
 vest.textures = GetPedTextureVariation(GetPlayerPed(-1), 9)
 vest.drawables = GetPedDrawableVariation(GetPlayerPed(-1), 9)

 DecorSetBool(PlayerPedId(), 'hudStatus', true)
end)

RegisterNetEvent("clothing:load")
AddEventHandler("clothing:load", function(jsonData, firstLoad)
 SetEntityInvincible(GetPlayerPed(-1),true)
 ClearAllPedProps(PlayerPedId())

 Citizen.CreateThread(function()
  if jsonData.model ~= -1667301416 and jsonData.model ~= 1885233650 then
    setModel(jsonData.model)
  end

	for i = 0, 11 do
   if i ~= 0 and i ~= 2 then
    SetPedComponentVariation(GetPlayerPed(-1), i, tonumber(jsonData.clothing.drawables[i+1]), tonumber(jsonData.clothing.textures[i+1]), tonumber(jsonData.clothing.palette[i+1]))
   end
  end

  for i = 0, 7 do
   SetPedPropIndex(GetPlayerPed(-1), i, tonumber(jsonData.props.drawables[i+1]), tonumber(jsonData.props.textures[i+1]), true)
  end
 end)

 helmet.textures = GetPedPropTextureIndex(GetPlayerPed(-1), 0)
 helmet.drawables = GetPedPropIndex(GetPlayerPed(-1), 0)
 glasses.textures = GetPedPropTextureIndex(GetPlayerPed(-1), 1)
 glasses.drawables = GetPedPropIndex(GetPlayerPed(-1), 1)
 mask.textures = GetPedTextureVariation(GetPlayerPed(-1), 1)
 mask.drawables = GetPedDrawableVariation(GetPlayerPed(-1), 1)
 pants.textures = GetPedTextureVariation(GetPlayerPed(-1), 4)
 pants.drawables = GetPedDrawableVariation(GetPlayerPed(-1), 4)
 shoes.textures = GetPedTextureVariation(GetPlayerPed(-1), 6)
 shoes.drawables = GetPedDrawableVariation(GetPlayerPed(-1), 6)
 gloves.textures = GetPedTextureVariation(GetPlayerPed(-1), 3)
 gloves.drawables = GetPedDrawableVariation(GetPlayerPed(-1), 3)
 vest.textures = GetPedTextureVariation(GetPlayerPed(-1), 9)
 vest.drawables = GetPedDrawableVariation(GetPlayerPed(-1), 9)

 Wait(750)

 if firstLoad then
  SetEntityHealth(PlayerPedId(), 2000)
  TriggerServerEvent('core:characterloaded')
 end

 TriggerServerEvent("core:checkjob")

 saveClothing()
 SetEntityInvincible(GetPlayerPed(-1),false)
 DecorSetBool(PlayerPedId(), 'hudStatus', true)

 if firstLoad then
  TriggerEvent('ems:heal')
 end
end)


function saveClothing()
 SetEntityInvincible(GetPlayerPed(-1),true)

 local model = GetEntityModel(GetPlayerPed(-1))
 local drawables = {}
 local textures = {}
 local palette = {}
 local props = {}
 local proptextures = {}

 for i = 0, 11 do
  local drawable = GetPedDrawableVariation(GetPlayerPed(-1), i)
  drawables[i+1] = drawable

  local texture = GetPedTextureVariation(GetPlayerPed(-1), i)
  textures[i+1] = texture

  local palettetexture = GetPedPaletteVariation(GetPlayerPed(-1), i)
  palette[i+1] = palettetexture
 end

 for i = 0, 7 do
  local prop = GetPedPropIndex(GetPlayerPed(-1), i)
  props[i+1] = prop

  local proptexture = GetPedPropTextureIndex(GetPlayerPed(-1), i)
  proptextures[i+1] = proptexture
 end

 helmet.textures = GetPedPropTextureIndex(GetPlayerPed(-1), 0)
 helmet.drawables = GetPedPropIndex(GetPlayerPed(-1), 0)
 glasses.textures = GetPedPropTextureIndex(GetPlayerPed(-1), 1)
 glasses.drawables = GetPedPropIndex(GetPlayerPed(-1), 1)
 mask.textures = GetPedTextureVariation(GetPlayerPed(-1), 1)
 mask.drawables = GetPedDrawableVariation(GetPlayerPed(-1), 1)
 pants.textures = GetPedTextureVariation(GetPlayerPed(-1), 4)
 pants.drawables = GetPedDrawableVariation(GetPlayerPed(-1), 4)
 shoes.textures = GetPedTextureVariation(GetPlayerPed(-1), 6)
 shoes.drawables = GetPedDrawableVariation(GetPlayerPed(-1), 6)
 gloves.textures = GetPedTextureVariation(GetPlayerPed(-1), 3)
 gloves.drawables = GetPedDrawableVariation(GetPlayerPed(-1), 3)
 vest.textures = GetPedTextureVariation(GetPlayerPed(-1), 9)
 vest.drawables = GetPedDrawableVariation(GetPlayerPed(-1), 9)



 local clothing = {
  model = model,
  clothing = {
   drawables = drawables,
   textures = textures,
   palette = palette
  },
  props = {
   drawables = props,
   textures = proptextures
  }
 }

 TriggerServerEvent("clothes:save", clothing)
 clothinggood()
 clothing = clothing
 SetEntityInvincible(GetPlayerPed(-1),false)
end





local clothing_shops = {
 {x = 72.254, y = -1399.102, z = 28.376, showBlip = true},
 {x = -703.776, y = -152.258, z = 36.415, showBlip = true},
 {x = -167.863, y = -298.969, z = 38.733, showBlip = true},
 {x = 428.694, y = -800.106, z = 28.491, showBlip = true},
 {x = -829.413, y = -1073.710, z = 10.328, showBlip = true},
 {x = -1447.797, y = -242.461, z = 48.820, showBlip = true},
 {x = 11.632, y = 6514.224, z = 30.877, showBlip = true},
 {x = 123.646, y = -219.440, z = 53.557, showBlip = true},
 {x = 1696.291, y = 4829.312, z = 41.063, showBlip = true},
 {x = 618.093, y = 2759.629, z = 41.088, showBlip = true},
 {x = 1190.550, y = 2713.441, z = 37.222, showBlip = true},
 {x = -1193.429, y = -772.262, z = 16.324, showBlip = true},
 {x = -3172.496, y = 1048.133, z = 19.863, showBlip = true},
 {x = -1108.441, y = 2708.923, z = 18.107, showBlip = true},
 {x = 454.375, y = -988.707, z = 30.690, showBlip = false},
}

function IsNearClothes()
 local dstchecked = 1000

 for i = 1, #clothing_shops do
  local comparedst = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), clothing_shops[i].x, clothing_shops[i].y, clothing_shops[i].z, true)
  if comparedst < dstchecked then
   dstchecked = comparedst
  end
 end

 return dstchecked
end

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(5)
  local nearcloth = IsNearClothes()
  if nearcloth < 2.0 and cmenu.show == 0 then
   DisplayHelpText('Press ~g~E~s~ to Change Clothes')
   if IsControlJustPressed(0, 38) then
    clothingbad()
    cmenu.show = 1
    cmenu.row = 1
    cmenu.field = 2
   end
  else
   if nearcloth > 5 then
    Citizen.Wait(math.ceil(nearcloth * 10))
   end
  end
 end
end)


Citizen.CreateThread(function()
 while true do
  Wait(5)
  if cmenu.show == 1 then
   ClothShop()
   if IsControlJustPressed(1, 188) or IsDisabledControlJustPressed(1, 188) then -- up
    if cmenu.row > 1 then cmenu.row = cmenu.row-1 else cmenu.row = 3 end
     PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
    elseif IsControlJustPressed(1, 187) or IsDisabledControlJustPressed(1, 187) then -- down
     if cmenu.row < 3 then cmenu.row = cmenu.row+1 else cmenu.row = 1 end
     PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
    elseif IsControlJustPressed(1, 202) or IsDisabledControlJustPressed(1, 202) then -- backspase
     PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
     cmenu = {show = 0, row = 0, field = 1}
     saveClothing()
    elseif IsControlJustPressed(1,201) or IsControlJustPressed(1,38) then -- Enter
     PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
     if cmenu.row == 1 then
      cmenu.show = 2
      cmenu.row = 1
     elseif cmenu.row == 2 then
      cmenu.show = 3
      cmenu.row = 1
     end
	  end
 	 elseif cmenu.show == 2 then
 	  ClothShop()
	  if IsControlJustPressed(1, 188) or IsDisabledControlJustPressed(1, 188) then -- up
	 	 if cmenu.row > 1 then cmenu.row = cmenu.row-1 else cmenu.row = 4 end
	 	 PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
	  elseif IsControlJustPressed(1, 187) or IsDisabledControlJustPressed(1, 187) then -- down
	 	 if cmenu.row < 4 then cmenu.row = cmenu.row+1 else cmenu.row = 1 end
		 PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
		elseif IsControlJustPressed(1, 202) or IsDisabledControlJustPressed(1, 202) then -- backspase
     PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
     cmenu.show = 1
     cmenu.row = 1
     cmenu.field = 2
    end
	 elseif cmenu.show == 3 then
    ClothShop()
    if IsControlJustPressed(1, 188) or IsDisabledControlJustPressed(1, 188) then -- up
    if cmenu.row > 1 then cmenu.row = cmenu.row-1 else cmenu.row = 4 end
    PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
   elseif IsControlJustPressed(1, 187) or IsDisabledControlJustPressed(1, 187) then -- down
    if cmenu.row < 4 then cmenu.row = cmenu.row+1 else cmenu.row = 1 end
    PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
   elseif IsControlJustPressed(1, 202) or IsDisabledControlJustPressed(1, 202) then -- backspase
    PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
    cmenu.show = 1
    cmenu.row = 2
    cmenu.field = 2
   elseif IsControlJustPressed(1,201) or IsControlJustPressed(1,38) then -- Enter
    if cmenu.row == 4 then
     ClearPedProp(PlayerPedId(), resetID-1)
    end
   end
  else
   Citizen.Wait(1000)
  end
 end
end)

































-- Togglign
-- Player Toggles
AddEventHandler("clothing:togglemask", function()
 local ped = GetPlayerPed(-1)
 loadAnimDict("mp_masks@on_foot")
 TaskPlayAnim(GetPlayerPed(-1), "mp_masks@on_foot", "put_on_mask", 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
 Citizen.Wait(500)
 if mask.status then
  SetPedComponentVariation(ped, 1, 0, 0, 2)
 else
  SetPedComponentVariation(ped, 1, mask.drawables, mask.textures, 2)
 end
 Citizen.Wait(200)
 ClearPedTasks(GetPlayerPed(-1))
 mask.status = not mask.status
end)

AddEventHandler("clothing:toggleglasses", function()
 local ped = GetPlayerPed(-1)
 loadAnimDict("clothingspecs")
 TaskPlayAnim(GetPlayerPed(-1), "clothingspecs", "take_off", 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
 print( glasses.drawables)
 Citizen.Wait(500)
 if glasses.status then
  ClearPedProp(ped, 1)
 else
  SetPedPropIndex(ped, 1, glasses.drawables, glasses.textures, true)
 end
 Citizen.Wait(200)
 ClearPedTasks(GetPlayerPed(-1))
 glasses.status = not glasses.status
end)

AddEventHandler("clothing:togglehelmet", function()
 local ped = GetPlayerPed(-1)
 loadAnimDict("missfbi4")
 TaskPlayAnim(GetPlayerPed(-1), "missfbi4", "takeoff_mask", 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
 Citizen.Wait(500)
 if helmet.status then
  ClearPedProp(GetPlayerPed(-1), 0)
 else
  SetPedPropIndex(ped, 0, helmet.drawables, helmet.textures, true)
 end
 Citizen.Wait(200)
 ClearPedTasks(GetPlayerPed(-1))
 helmet.status = not helmet.status
end)

AddEventHandler("clothing:togglejacket", function()
 if(GetEntityModel(GetPlayerPed(-1)) == -1667301416) then  -- GIRL SKIN
  SetPedComponentVariation(GetPlayerPed(-1), 8, 34,0, 2)
  SetPedComponentVariation(GetPlayerPed(-1), 3, 15,0, 2)
  SetPedComponentVariation(GetPlayerPed(-1), 11, 101,1, 2)
 else                             -- BOY SKIN
  SetPedComponentVariation(GetPlayerPed(-1), 8, 15,0, 2)
  SetPedComponentVariation(GetPlayerPed(-1), 3, 15,0, 2)
  SetPedComponentVariation(GetPlayerPed(-1), 11, 91,0, 2)
 end
end)

AddEventHandler("clothing:togglepants", function()
 local ped = GetPlayerPed(-1)
 if pants.status then
  if(GetEntityModel(GetPlayerPed(-1)) == -1667301416) then  -- GIRL SKIN
   SetPedComponentVariation(GetPlayerPed(-1), 4, 56,1, 2)
  else
   SetPedComponentVariation(GetPlayerPed(-1), 4, 61, math.random(1,3), 2)
  end
 else
  SetPedComponentVariation(ped, 4, pants.drawables, pants.textures, 2)
 end
 pants.status = not pants.status
end)

AddEventHandler("clothing:toggleshoes", function()
 local ped = GetPlayerPed(-1)
 if shoes.status then
  if(GetEntityModel(GetPlayerPed(-1)) == -1667301416) then  -- GIRL SKIN
   SetPedComponentVariation(GetPlayerPed(-1), 6, 35,0, 2)
  else
   SetPedComponentVariation(GetPlayerPed(-1), 6, 34,0, 2)
  end
 else
  SetPedComponentVariation(ped, 6, shoes.drawables, shoes.textures, 2)
 end
 shoes.status = not shoes.status
end)

AddEventHandler("clothing:togglegloves", function()
 local ped = GetPlayerPed(-1)
 if gloves.status then
  SetPedComponentVariation(GetPlayerPed(-1), 3, 15,0, 2)
 else
  SetPedComponentVariation(ped, 3, gloves.drawables, gloves.textures, 2)
 end
 gloves.status = not gloves.status
end)


AddEventHandler("clothing:togglevest", function()
 local ped = GetPlayerPed(-1)
 if vest.status then
  SetPedComponentVariation(GetPlayerPed(-1), 9, 0, 0, 0)
 else
  SetPedComponentVariation(ped, 9, vest.drawables, vest.textures, 2)
 end
 vest.status = not vest.status
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

function getClothing()
 return clothing
end

function setModel(model)
 local model = model
 if IsModelInCdimage(model) and IsModelValid(model) then
  RequestModel(model)
  while not HasModelLoaded(model) do
   Citizen.Wait(0)
  end
  SetPlayerModel(PlayerId(), model)
  SetModelAsNoLongerNeeded(model)
  SetEntityHealth(PlayerPedId(), 2000)
 end
end


Citizen.CreateThread(function()
 for _, v in pairs(clothing_shops) do
  if v.showBlip then
   local blip = AddBlipForCoord(v.x, v.y, v.z)
   SetBlipSprite(blip, 73)
   SetBlipScale(blip, 0.4)
   SetBlipAsShortRange(blip, true)
   BeginTextCommandSetBlipName("STRING")
   AddTextComponentString('Clothing Store')
   EndTextCommandSetBlipName(blip)
  end
 end
end)
