Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local FirstSpawn, PlayerLoaded = true, false

IsDead = false
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerLoaded = true
	PlayerData = ESX.GetPlayerData()
end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	PlayerLoaded = true
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

--[[ ***************CAMILLAS PROPS*************** ]]

local lit_1 = {
    {anim = "savecouch@",lib = "t_sleep_loop_couch",name = Config.Language.anim.lie_back, x = 0, y = 0, z = 0.7, r = 180.0},
	{anim = "amb@prop_human_seat_chair_food@male@base",lib = "base",name = Config.Language.anim.sit_right, x = 0.3, y = -0.2, z =0.15, r = -90.0},
	{anim = "amb@prop_human_seat_chair_food@male@base",lib = "base",name = Config.Language.anim.sit_left, x = -0.25, y = -0.2, z =0.15, r = 90.0},
	{anim = "missheistfbi3b_ig8_2",lib = "cpr_loop_victim",name = Config.Language.anim.convulse, x = -0.1, y = 0, z = 1.2, r = 180.0},
	{anim = "amb@world_human_bum_slumped@male@laying_on_right_side@base",lib = "base",name = Config.Language.anim.pls, x = 0.2, y = 0.1, z = 1.2, r = 90.0},
}

local lit_2 = {
    {anim = "savecouch@",lib = "t_sleep_loop_couch",name = Config.Language.anim.lie_back, x = 0, y = 0, z = 0.9, r = 180.0},
	{anim = "amb@prop_human_seat_chair_food@male@base",lib = "base",name = Config.Language.anim.sit_right, x = 0.2, y = -0.2, z =0.35, r = -90.0},
	{anim = "amb@prop_human_seat_chair_food@male@base",lib = "base",name = Config.Language.anim.sit_left, x = -0.3, y = -0.2, z =0.35, r = 90.0},
	{anim = "missheistfbi3b_ig8_2",lib = "cpr_loop_victim",name = Config.Language.anim.convulse, x = -0.1, y = 0, z = 1.35, r = 180.0},
	{anim = "amb@world_human_bum_slumped@male@laying_on_right_side@base",lib = "base",name = Config.Language.anim.pls, x = 0.2, y = 0.1, z = 1.35, r = 90.0},
}

local lit_3 = {
    {anim = "savecouch@",lib = "t_sleep_loop_couch",name = Config.Language.anim.lie_back, x = 0, y = 0, z = 0.9, r = 180.0},
	{anim = "amb@prop_human_seat_chair_food@male@base",lib = "base",name = Config.Language.anim.sit_right, x = 0.2, y = -0.2, z =0.35, r = -90.0},
	{anim = "amb@prop_human_seat_chair_food@male@base",lib = "base",name = Config.Language.anim.sit_left, x = -0.3, y = -0.2, z =0.35, r = 90.0},
	{anim = "missheistfbi3b_ig8_2",lib = "cpr_loop_victim",name = Config.Language.anim.convulse, x = -0.1, y = 0, z = 1.35, r = 180.0},
	{anim = "amb@world_human_bum_slumped@male@laying_on_right_side@base",lib = "base",name = Config.Language.anim.pls, x = 0.2, y = 0.1, z = 1.35, r = 90.0},
}

local lit = {
	{lit = "v_med_emptybed", distance_stop = 2.4, name = lit_1, title = Config.Language.lit_1},
}

prop_amb = false
veh_detect = 0

Citizen.CreateThread(function()
	WarMenu.CreateMenu('hopital', Config.Language.name_hospital)
	while true do
		local sleep = 2000	
		local pedCoords = GetEntityCoords(GetPlayerPed(-1))
		for _,i in pairs(lit) do
			local closestObject = GetClosestObjectOfType(pedCoords, 1.0, GetHashKey(i.lit), false)
		
			if DoesEntityExist(closestObject) then
				sleep = 5
				local propCoords = GetEntityCoords(closestObject)
				local propForward = GetEntityForwardVector(closestObject)
				local litCoords = (propCoords + propForward)
				local sitCoords = (propCoords + propForward * 0.1)
				local pickupCoords = (propCoords + propForward * 1.2)
				local pickupCoords2 = (propCoords + propForward * - 1.2)

				if GetDistanceBetweenCoords(pedCoords, litCoords, true) <= 5.0 then
					if GetDistanceBetweenCoords(pedCoords, sitCoords, true) <= 1.4 then
						hintToDisplay(Config.Language.do_action)
						if IsControlJustPressed(0, Config.Press.do_action) then
							WarMenu.OpenMenu('hopital')
						end
					end
					if IsEntityAttachedToEntity(closestObject, GetPlayerPed(-1)) == false then
						if GetDistanceBetweenCoords(pedCoords, pickupCoords, true) <= 0.8 then
							hintToDisplay(Config.Language.take_bed)
							if IsControlJustPressed(0, Config.Press.take_bed) then
								prendre(closestObject)
							end
						end

						if GetDistanceBetweenCoords(pedCoords, pickupCoords2, true) <= 0.8 then
							hintToDisplay(Config.Language.take_bed)
							if IsControlJustPressed(0, Config.Press.take_bed) then
								prendre(closestObject)
							end
						end
					end
				end

				if WarMenu.IsMenuOpened('hopital') then
					for _,k in pairs(i.name) do
						if WarMenu.Button(k.name) then
							LoadAnim(k.anim)
							AttachEntityToEntity(GetPlayerPed(-1), closestObject, GetPlayerPed(-1), k.x, k.y, k.z, 0.0, 0.0, k.r, 0.0, false, false, false, false, 2, true)
							WarMenu.CloseMenu('hopital')
							TaskPlayAnim(GetPlayerPed(-1), k.anim, k.lib, 8.0, 8.0, -1, 1, 0, false, false, false)
						end
					end
					if WarMenu.Button(Config.Language.go_out_bed) then
						DetachEntity(GetPlayerPed(-1), true, true)
						local x, y, z = table.unpack(GetEntityCoords(closestObject) + GetEntityForwardVector(closestObject) * - i.distance_stop)
						SetEntityCoords(GetPlayerPed(-1), x, y, z)
						WarMenu.CloseMenu('hopital')
					end
					WarMenu.Display()
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)

function prendre(propObject, hash)
	NetworkRequestControlOfEntity(propObject)

	LoadAnim("anim@heists@box_carry@")
	
	AttachEntityToEntity(propObject, GetPlayerPed(-1), GetPlayerPed(-1), 0.0, 1.6, -0.43 , 180.0, 180.0, 180.0, 0.0, false, false, true, false, 2, true)

	while IsEntityAttachedToEntity(propObject, GetPlayerPed(-1)) do

		Citizen.Wait(5)

		if not IsEntityPlayingAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 3) then
			TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 8.0, 8.0, -1, 50, 0, false, false, false)
		end

		if IsPedDeadOrDying(GetPlayerPed(-1)) then
			ClearPedTasksImmediately(GetPlayerPed(-1))
			DetachEntity(propObject, true, true)
		end
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), GetEntityCoords(veh_detect), true) <= 7.0 then
			hintToDisplay(Config.Language.in_vehicle_bed)
			if (IsControlJustPressed(0, Config.Press.in_vehicle_bed)) then
				ClearPedTasksImmediately(GetPlayerPed(-1))
				DetachEntity(propObject, true, true)
				prop_amb = true
				in_ambulance(propObject, veh_detect, prop_depth, prop_height)
			end
		else
			hintToDisplay(Config.Language.release_bed)
		end

		if IsControlJustPressed(0, Config.Press.release_bed) then
			ClearPedTasksImmediately(GetPlayerPed(-1))
			DetachEntity(propObject, true, true)
		end
		
	end
end

function in_ambulance(propObject, amb, depth, height)
	veh_detect = 0
	NetworkRequestControlOfEntity(amb)

	AttachEntityToEntity(propObject, amb, 0.0, 0.0, depth, height, 0.0, 0.0, 0.0, 0.0, false, false, true, false, 2, true)

	while IsEntityAttachedToEntity(propObject, amb) do
		Citizen.Wait(5)

		if GetVehiclePedIsIn(GetPlayerPed(-1)) == 0 then
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), GetEntityCoords(amb), true) <= 7.0 then
				hintToDisplay(Config.Language.out_vehicle_bed)
				if IsControlJustPressed(0, Config.Press.out_vehicle_bed) then
					DetachEntity(propObject, true, true)
					prop_amb = false
					SetEntityHeading(GetPlayerPed(-1), GetEntityHeading(GetPlayerPed(-1)) - 180.0)
					prendre(propObject)
				end
			end
		end
	end
end

function LoadAnim(dict)
	while not HasAnimDictLoaded(dict) do
		RequestAnimDict(dict)
		Citizen.Wait(1)
	end
end

function hintToDisplay(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

Drawing = setmetatable({}, Drawing)
Drawing.__index = Drawing

function Drawing.draw3DText(x,y,z,textInput,fontId,scaleX,scaleY,r, g, b, a)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*20
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov

    SetTextScale(scaleX*scale, scaleY*scale)
    SetTextFont(fontId)
    SetTextProportional(1)
    SetTextColour(r, g, b, a)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x,y,z+2, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

Sit = function(wheelchairObject)
	local closestPlayer, closestPlayerDist = GetClosestPlayer()

	if closestPlayer ~= nil and closestPlayerDist <= 1.5 then
		if IsEntityPlayingAnim(GetPlayerPed(closestPlayer), 'missfinale_c2leadinoutfin_c_int', '_leadin_loop2_lester', 3) then
			ShowNotification("Alguien ya está usando la silla de ruedas.!")
			return
		end
	end

	LoadAnim("missfinale_c2leadinoutfin_c_int")

	AttachEntityToEntity(PlayerPedId(), wheelchairObject, 0, 0, 0.0, 0.4, 0.0, 0.0, 180.0, 0.0, false, false, false, false, 2, true)

	local heading = GetEntityHeading(wheelchairObject)

	while IsEntityAttachedToEntity(PlayerPedId(), wheelchairObject) do
		Citizen.Wait(5)

		if IsPedDeadOrDying(PlayerPedId()) then
			DetachEntity(PlayerPedId(), true, true)
		end

		if not IsEntityPlayingAnim(PlayerPedId(), 'missfinale_c2leadinoutfin_c_int', '_leadin_loop2_lester', 3) then
			TaskPlayAnim(PlayerPedId(), 'missfinale_c2leadinoutfin_c_int', '_leadin_loop2_lester', 8.0, 8.0, -1, 69, 1, false, false, false)
		end

		if IsControlPressed(0, 32) then
			local x, y, z  = table.unpack(GetEntityCoords(wheelchairObject) + GetEntityForwardVector(wheelchairObject) * -0.02)
			SetEntityCoords(wheelchairObject, x,y,z)
			PlaceObjectOnGroundProperly(wheelchairObject)
		end

		if IsControlPressed(1,  34) then
			heading = heading + 0.4

			if heading > 360 then
				heading = 0
			end

			SetEntityHeading(wheelchairObject,  heading)
		end

		if IsControlPressed(1,  9) then
			heading = heading - 0.4

			if heading < 0 then
				heading = 360
			end

			SetEntityHeading(wheelchairObject,  heading)
		end

		if IsControlJustPressed(0, 73) then
			DetachEntity(PlayerPedId(), true, true)

			local x, y, z = table.unpack(GetEntityCoords(wheelchairObject) + GetEntityForwardVector(wheelchairObject) * - 0.7)

			SetEntityCoords(PlayerPedId(), x,y,z)
		end
	end
end

PickUp = function(wheelchairObject)
	local closestPlayer, closestPlayerDist = GetClosestPlayer()

	if closestPlayer ~= nil and closestPlayerDist <= 1.5 then
		if IsEntityPlayingAnim(GetPlayerPed(closestPlayer), 'anim@heists@box_carry@', 'idle', 3) then
			ShowNotification("Alguien ya está manejando la silla de ruedas.!")
			return
		end
	end

	NetworkRequestControlOfEntity(wheelchairObject)

	LoadAnim("anim@heists@box_carry@")

	AttachEntityToEntity(wheelchairObject, PlayerPedId(), GetPedBoneIndex(PlayerPedId(),  28422), -0.00, -0.3, -0.73, 195.0, 180.0, 180.0, 0.0, false, false, true, false, 2, true)

	while IsEntityAttachedToEntity(wheelchairObject, PlayerPedId()) do
		Citizen.Wait(5)

		if not IsEntityPlayingAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 3) then
			TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 8.0, 8.0, -1, 50, 0, false, false, false)
		end

		if IsPedDeadOrDying(PlayerPedId()) then
			DetachEntity(wheelchairObject, true, true)
		end

		if IsControlJustPressed(0, 73) then
			DetachEntity(wheelchairObject, true, true)
		end
	end
end

DrawText3Ds = function(coords, text, scale)
	local x,y,z = coords.x, coords.y, coords.z
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local pX, pY, pZ = table.unpack(GetGameplayCamCoords())

	SetTextScale(scale, scale)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextEntry("STRING")
	SetTextCentre(1)
	SetTextColour(6, 6, 6, 215)

	AddTextComponentString(text)
	DrawText(_x+0.1, _y+0.002)

	local factor = (string.len(text)) / 370

	DrawRect(_x+0.1, _y + 0.0160, 0.040 + factor, 0.025, 255, 255, 255, 200)
end

GetPlayers = function()
    local players = {}

    for i = 0, 31 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end

GetClosestPlayer = function()
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

LoadAnim = function(dict)
	while not HasAnimDictLoaded(dict) do
		RequestAnimDict(dict)
		
		Citizen.Wait(1)
	end
end

LoadModel = function(model)
	while not HasModelLoaded(model) do
		RequestModel(model)
		
		Citizen.Wait(1)
	end
end

ShowNotification = function(msg)
	SetNotificationTextEntry('STRING')
	AddTextComponentSubstringWebsite(msg)
	DrawNotification(false, true)
end

local Melee = { -1569615261, 1737195953, 1317494643, -1786099057, 1141786504, -2067956739, -868994466 }
  local Knife = { -1716189206, 1223143800, -1955384325, -1833087301, 910830060, }
  local Bullet = { 453432689, 1593441988, 584646201, -1716589765, 324215364, 736523883, -270015777, -1074790547, -2084633992, -1357824103, -1660422300, 2144741730, 487013001, 2017895192, -494615257, -1654528753, 100416529, 205991906, 1119849093 }
  local Animal = { -100946242, 148160082 }
  local FallDamage = { -842959696 }
  local Explosion = { -1568386805, 1305664598, -1312131151, 375527679, 324506233, 1752584910, -1813897027, 741814745, -37975472, 539292904, 341774354, -1090665087 }
  local Gas = { -1600701090 }
  local Burn = { 615608432, 883325847, -544306709 }
  local Drown = { -10959621, 1936677264 }
  local Car = { 133987706, -1553120962 }
  
  function checkArray (array, val)
	  for name, value in ipairs(array) do
		  if value == val then
			  return true
		  end
	  end
  
	  return false
end
  
--[[ Citizen.CreateThread(function()
	Citizen.Wait(1000)
	  while true do
		local sleep = 3000

		if not IsPedInAnyVehicle(GetPlayerPed(-1)) then

			local player, distance = ESX.Game.GetClosestPlayer()

			if distance ~= -1 and distance < 10.0 then

				if distance ~= -1 and distance <= 2.0 then	
					if IsPedDeadOrDying(GetPlayerPed(player)) then
						Start(GetPlayerPed(player))
					end
				end

			else
				sleep = sleep / 100 * distance 
			end

		end

		Citizen.Wait(sleep)

	end
end) ]]

function Start(ped)
	checking = true

	while checking do
		Citizen.Wait(5)

		local distance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), GetEntityCoords(ped))

		local x,y,z = table.unpack(GetEntityCoords(ped))

		if distance < 2.0 then			
			OpenDeathMenu(ped)
		end

		if distance > 7.5 or not IsPedDeadOrDying(ped) then
			checking = false
		end

  end

end
  
function OpenDeathMenu(player)
  
	loadAnimDict('amb@medic@standing@kneel@base')
	loadAnimDict('anim@gangops@facility@servers@bodysearch@')
  
	local elements   = {}
  
	table.insert(elements, {label = 'Intenta identificar la causa de muerte', value = 'deathcause'})
	table.insert(elements, {label = 'Intenta identificar dónde ocurrió el daño', value = 'damage'})

	--gets deathcause
	local d = GetPedCauseOfDeath(player)		
	local playerPed = GetPlayerPed(-1)
  
			  --starts animation
  
	TaskPlayAnim(GetPlayerPed(-1), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
	TaskPlayAnim(GetPlayerPed(-1), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )
  
			  Citizen.Wait(5000)
  
			  --exits animation			
  
			  ClearPedTasksImmediately(playerPed)
  
			  if checkArray(Melee, d) then
				Notify(_U('hardmeele'))
			elseif checkArray(Bullet, d) then
				Notify(_U('bullet'))
			elseif checkArray(Knife, d) then
				Notify(_U('knifes'))
			elseif checkArray(Animal, d) then
				Notify(_U('bitten'))
			elseif checkArray(FallDamage, d) then
				Notify(_U('brokenlegs'))
			elseif checkArray(Explosion, d) then
				Notify(_U('explosive'))
			elseif checkArray(Gas, d) then
				Notify(_U('gas'))
			elseif checkArray(Burn, d) then
				Notify(_U('fire'))
			elseif checkArray(Drown, d) then
				Notify(_U('drown'))
			elseif checkArray(Car, d) then
				Notify(_U('caraccident'))
			else
				Notify(_U('unknown'))
			end

end
  
function loadAnimDict(dict)
	  while (not HasAnimDictLoaded(dict)) do
		  RequestAnimDict(dict)
		  Citizen.Wait(1)
	  end
end
  
function Notify(message)
	  ESX.ShowNotification(message)
end
  
function DrawText3D(x, y, z, text, scale)
	  local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	  local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
   
	  SetTextScale(scale, scale)
	  SetTextFont(4)
	  SetTextProportional(1)
	  SetTextEntry("STRING")
	  SetTextCentre(1)
	  SetTextColour(255, 255, 255, 215)
   
	  AddTextComponentString(text)
	  DrawText(_x, _y)
end

--[[ ***************EVENTO SERVIDOR MENU*************** ]]

RegisterNetEvent('esx_ems:menu')
AddEventHandler('esx_ems:menu', function()
	WarMenu.OpenMenu('prop')
end)

--[[ ***************THREAD MENU*************** ]]

-- Citizen.CreateThread(function()
	-- while true do
		-- Citizen.Wait(0)

		-- if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'ambulance' and not IsDead then
			-- if IsControlJustReleased(0, Keys['F5']) then
				-- WarMenu.OpenMenu('prop')
			-- end
		-- end
	-- end
-- end)

--[[ ***************THREAD CAMILLA AMBULANCIA*************** ]]

Citizen.CreateThread(function()
	prop_exist = 0
	while true do
		for _,g in pairs(Config.Hash) do
			local closestObject = GetClosestVehicle(GetEntityCoords(GetPlayerPed(-1)), 7.0, GetHashKey(g.hash), 18)
			if closestObject ~= 0 then
				veh_detect = closestObject
				veh_detection = g.detection
				prop_depth = g.depth
				prop_height = g.height
			end
		end
		Wait(300)
		if prop_amb == false and ESX.PlayerData.job.name == 'ambulance' then
			if GetVehiclePedIsIn(GetPlayerPed(-1)) == 0 then
				if DoesEntityExist(veh_detect) then
					local coords = GetEntityCoords(veh_detect) + GetEntityForwardVector(veh_detect) * - veh_detection
					if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), coords.x , coords.y, coords.z, true) <= 1.0 then
						hintToDisplay(Config.Language.out_vehicle_bed)
						for _,m in pairs(lit) do
							local prop = GetClosestObjectOfType(GetEntityCoords(GetPlayerPed(-1)), 4.0, GetHashKey(m.lit))
							if prop ~= 0 then
								prop_exist = prop
							end
						end
						if IsEntityAttachedToEntity(prop, GetPlayerPed(-1)) ~= 0 or prop ~= 0 then
							if IsControlJustPressed(0, Config.Press.out_vehicle_bed) then
								while not HasModelLoaded("v_med_emptybed") do
									RequestModel("v_med_emptybed")
									Citizen.Wait(1)
								end
								local object = CreateObject(GetHashKey("v_med_emptybed"), GetEntityCoords(GetPlayerPed(-1)), true)
								SetEntityHeading(GetPlayerPed(-1), GetEntityHeading(GetPlayerPed(-1)) - 180.0)
								prendre(object, vehicle)
								prop_exist = 0
							end
						end
					end
				end
			end
		end
		Citizen.Wait(100)
	end
end)

--[[ ***************THREAD SILLA DE RUEDAS*************** ]]

Citizen.CreateThread(function()
	while true do
		local sleep = 500

		local ped = PlayerPedId()
		local pedCoords = GetEntityCoords(ped)

		local closestObject = GetClosestObjectOfType(pedCoords, 3.0, GetHashKey("prop_wheelchair_01"), false)

		if DoesEntityExist(closestObject) then
			sleep = 5

			local wheelChairCoords = GetEntityCoords(closestObject)
			local wheelChairForward = GetEntityForwardVector(closestObject)
			
			local sitCoords = (wheelChairCoords + wheelChairForward * - 0.5)
			local pickupCoords = (wheelChairCoords + wheelChairForward * 0.3)

			if GetDistanceBetweenCoords(pedCoords, sitCoords, true) <= 1.0 then
				DrawText3Ds(sitCoords, "Pulsa [E] para sentarte", 0.4)

				if IsControlJustPressed(0, 38) then
					Sit(closestObject)
				end
			end

			if GetDistanceBetweenCoords(pedCoords, pickupCoords, true) <= 1.0 then
				DrawText3Ds(pickupCoords, "Pulsa [E] para llevarla", 0.4)

				if IsControlJustPressed(0, 38) then
					PickUp(closestObject)
				end
			end
		end

		Citizen.Wait(sleep)
	end
end)

--[[ ***************THREAD WARMENU*************** ]]

Citizen.CreateThread(function()
	WarMenu.CreateMenu('prop', Config.Language.name_hospital)
	while true do
		if (Vdist(GetEntityCoords(GetPlayerPed(-1), false), Config.OpenMenuSpawn.x, Config.OpenMenuSpawn.y, Config.OpenMenuSpawn.z) <= 0.8) then
			if(Vdist(GetEntityCoords(GetPlayerPed(-1), false), Config.OpenMenuSpawn.x, Config.OpenMenuSpawn.y, Config.OpenMenuSpawn.z) < 400.0) then
				DrawMarker(1, Config.OpenMenuSpawn.x, Config.OpenMenuSpawn.y, Config.OpenMenuSpawn.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, .801, 255, 255, 255,255, 0, 0, 0,0)
				Drawing.draw3DText(Config.OpenMenuSpawn.x, Config.OpenMenuSpawn.y, Config.OpenMenuSpawn.z - 0.800, Config.Language.name_hospital, 1, 0.3, 0.2, 255, 255, 255, 215)
				Drawing.draw3DText(Config.OpenMenuSpawn.x, Config.OpenMenuSpawn.y, Config.OpenMenuSpawn.z - 1.100, Config.Language.open_menu, 1, 0.2, 0.1, 125, 125, 125, 215)
			end  
			if IsControlJustReleased(0, Config.Press.open_menu) then
				WarMenu.OpenMenu('prop')
			end
		end
		if WarMenu.IsMenuOpened('prop') then
			--[[ ***************CAMILLA*************** ]]
			for _,e in pairs(lit) do
				if WarMenu.Button(e.title) then
					while not HasModelLoaded(e.lit) do
						RequestModel(e.lit)
						Citizen.Wait(1)
					end
					local ped = GetEntityCoords(GetPlayerPed(-1), false)
					local object = CreateObject(GetHashKey(e.lit), ped.x, ped.y, ped.z-1.0, true)
					prendre(object)
					WarMenu.CloseMenu('prop')
				end
			end
			--[[ ***************BORRAR CAMILLA*************** ]]
			if WarMenu.Button(Config.Language.delete_bed) then
				for _,z in pairs(lit) do
					local prop = GetClosestObjectOfType(GetEntityCoords(GetPlayerPed(-1), false), 4.0, GetHashKey(z.lit))
					if IsEntityAttachedToEntity(prop, GetPlayerPed(-1)) ~= 0 or prop ~= 0 then
						if DoesEntityExist(prop) then
							SetEntityAsMissionEntity(prop, true, true)
							DeleteEntity(prop)
							Citizen.Wait(5)
							ClearPedTasksImmediately(GetPlayerPed(-1))
						end
					end
				end
				WarMenu.CloseMenu('prop')
			end
			--[[ ***************COMPROBAR CUERPO*************** ]]
--[[ 			if WarMenu.Button(Config.Language.comprobar_cuerpo) then
				
				checking = true

				while checking do
					Citizen.Wait(5)
			
					local distance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), GetEntityCoords(ped))
			
					local x,y,z = table.unpack(GetEntityCoords(ped))
			
					if distance < 2.0 then			
							OpenDeathMenu(ped)
					end
			
					if distance > 7.5 or not IsPedDeadOrDying(ped) then
						checking = false
					end
				end
				
				WarMenu.CloseMenu('prop')
			end ]]
			--[[ ***************SILLA DE RUEDAS*************** ]]
			if WarMenu.Button(Config.Language.silladeruedas) then
				LoadModel('prop_wheelchair_01')
				local ped = GetEntityCoords(GetPlayerPed(-1), false)
				local wheelchair = CreateObject(GetHashKey('prop_wheelchair_01'), ped.x+0.4, ped.y-0.8, ped.z-1, true)
				WarMenu.CloseMenu('prop')
			end
			--[[ ***************BORRAR SILLA DE RUEDAS*************** ]]
			if WarMenu.Button(Config.Language.borrarsilladeruedas) then
				local wheelchair = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 10.0, GetHashKey('prop_wheelchair_01'))
					
					if DoesEntityExist(wheelchair) then
					DeleteEntity(wheelchair)
					end
					ClearPedTasks(ped)
				WarMenu.CloseMenu('prop')	
			end
			--[[ ***************VENDAS*************** ]]
			if WarMenu.Button(Config.Language.bendas) then
					TriggerServerEvent('esx_srpems:giveItem', 'bandage')
					WarMenu.CloseMenu('prop')
			end
			--[[ ***************MEDKIT*************** ]]
			if WarMenu.Button(Config.Language.medikit) then
				TriggerServerEvent('esx_srpems:giveItem', 'medikit')
				WarMenu.CloseMenu('prop')
			end

			WarMenu.Display()
		end
		Citizen.Wait(0)
	end
end)