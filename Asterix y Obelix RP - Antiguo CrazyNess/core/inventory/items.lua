local prop = nil
local IsDrunk = false
local oxygenTank = false
local oxygenCapacity = 0 

local fov_max = 70.0
local fov_min = 4.0 -- max zoom level (smaller fov is more zoom)
local zoomspeed = 10.0 -- camera zoom speed
local speed_lr = 8.0 -- speed by which the camera pans left-right
local speed_ud = 8.0 -- speed by which the camera pans up-down

local binoculars = false
local fov = (fov_max+fov_min)*0.5
local keybindEnabled = false -- When enabled, binocular are available by keybind
local binocularKey = 47
local storeBinoclarKey = 177

RegisterNetEvent('items:beer')
AddEventHandler('items:beer', function() 
	TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_PARTYING", 0, true)
	Citizen.Wait(30000)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	IsDrunk = true
	SetPedRagdollOnCollision(GetPlayerPed(-1), true)
	ClearPedTasksImmediately(GetPlayerPed(-1))
	SetPedMotionBlur(GetPlayerPed(-1), true)
	SetPedIsDrunk(GetPlayerPed(-1), true)
	Drunk("MOVE_M@DRUNK@VERYDRUNK")
	DoScreenFadeIn(1000)
	Citizen.Wait(190000)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	DoScreenFadeIn(1000)
	ClearTimecycleModifier()
	ResetScenarioTypesEnabled()
	ResetPedMovementClipset(GetPlayerPed(-1), 0)
	SetPedIsDrunk(GetPlayerPed(-1), false)
	SetPedMotionBlur(GetPlayerPed(-1), false)
	IsDrunk = false
	SetPedRagdollOnCollision(GetPlayerPed(-1), false)
	StopAllScreenEffects()
end)


RegisterNetEvent('items:ketamine')
AddEventHandler('items:ketamine', function() 
	if not IsPlayerDead(PlayerId()) then
		local playerPed = GetPlayerPed(-1)
		local ped = PlayerPedId()
		ExecuteCommand("me gets 1g of ketamine out")
		Wait(5000)
		ExecuteCommand("me dips key into bag of ket")
		Wait(5000)
		DoScreenFadeOut(1000)
		ExecuteCommand("me dips key into bag of ket")
		Wait(1000)
		SetTimecycleModifier("spectator5")
		SetPedMotionBlur(GetPlayerPed(-1), true)
		SetPedIsDrunk(GetPlayerPed(-1), true)
		DoScreenFadeIn(1000)
		SetRunSprintMultiplierForPlayer(playerID, 1.10)         ---- xzurv ketamine
		if GetPedArmour(ped) >= 75 then
		  SetPedArmour(GetPlayerPed(-1), 100)
		elseif GetPedArmour(ped) >= 50 then
		  SetPedArmour(GetPlayerPed(-1), 75) 
		elseif GetPedArmour(ped) >= 25 then
		  SetPedArmour(GetPlayerPed(-1), 50)
		elseif GetPedArmour(ped) >= 0 then
		  SetPedArmour(GetPlayerPed(-1), 25)
		end	  
		Wait(160000)
		SetRunSprintMultiplierForPlayer(playerID, 1.00)
		DoScreenFadeOut(1000)
		Wait(1000)
		DoScreenFadeIn(1000)
		ClearTimecycleModifier()
		ResetScenarioTypesEnabled()
		ResetPedMovementClipset(GetPlayerPed(-1), 0)
		SetPedIsDrunk(GetPlayerPed(-1), false)
		SetPedMotionBlur(GetPlayerPed(-1), false)
	end
end)

RegisterNetEvent('items:moonshine')
AddEventHandler('items:moonshine', function() 
	TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_PARTYING", 0, true)
	Citizen.Wait(30000)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	IsDrunk = true
	SetPedRagdollOnCollision(GetPlayerPed(-1), true)
	ClearPedTasksImmediately(GetPlayerPed(-1))
	SetPedMotionBlur(GetPlayerPed(-1), true)
	SetPedIsDrunk(GetPlayerPed(-1), true)
	Drunk("MOVE_M@DRUNK@VERYDRUNK")
	DoScreenFadeIn(1000)
	Citizen.Wait(290000)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	DoScreenFadeIn(1000)
	ClearTimecycleModifier()
	ResetScenarioTypesEnabled()
	ResetPedMovementClipset(GetPlayerPed(-1), 0)
	SetPedIsDrunk(GetPlayerPed(-1), false)
	SetPedMotionBlur(GetPlayerPed(-1), false)
	IsDrunk = false
	SetPedRagdollOnCollision(GetPlayerPed(-1), false)
	StopAllScreenEffects()
end)

RegisterNetEvent('items:vodka')
AddEventHandler('items:vodka', function() 
	TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_PARTYING", 0, true)
	Citizen.Wait(30000)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	IsDrunk = true
	SetPedRagdollOnCollision(GetPlayerPed(-1), true)
	ClearPedTasksImmediately(GetPlayerPed(-1))
	SetPedMotionBlur(GetPlayerPed(-1), true)
	SetPedIsDrunk(GetPlayerPed(-1), true)
	Drunk("MOVE_M@DRUNK@VERYDRUNK")
	DoScreenFadeIn(1000)
	Citizen.Wait(320000)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	DoScreenFadeIn(1000)
	ClearTimecycleModifier()
	ResetScenarioTypesEnabled()
	ResetPedMovementClipset(GetPlayerPed(-1), 0)
	SetPedIsDrunk(GetPlayerPed(-1), false)
	SetPedMotionBlur(GetPlayerPed(-1), false)
	IsDrunk = false
	SetPedRagdollOnCollision(GetPlayerPed(-1), false)
	StopAllScreenEffects()
end)

RegisterNetEvent('items:wine')
AddEventHandler('items:wine', function() 
	TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_PARTYING", 0, true)
	Citizen.Wait(30000)
    IsDrunk = true
	SetPedRagdollOnCollision(GetPlayerPed(-1), true)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	ClearPedTasksImmediately(GetPlayerPed(-1))
	SetPedMotionBlur(GetPlayerPed(-1), true)
	SetPedIsDrunk(GetPlayerPed(-1), true)
	Drunk("MOVE_M@DRUNK@VERYDRUNK")
	DoScreenFadeIn(1000)
	Citizen.Wait(200000)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	DoScreenFadeIn(1000)
	ClearTimecycleModifier()
	ResetScenarioTypesEnabled()
	ResetPedMovementClipset(GetPlayerPed(-1), 0)
	SetPedIsDrunk(GetPlayerPed(-1), false)
	SetPedMotionBlur(GetPlayerPed(-1), false)
	IsDrunk = false
	SetPedRagdollOnCollision(GetPlayerPed(-1), false)
	StopAllScreenEffects()
end)

RegisterNetEvent('items:smoke')
AddEventHandler('items:smoke', function()
	if math.random(1,100) > 45 then
     TriggerEvent('chatMessage', '^5Smoking Kills ^0| ^1-1 Lung Capacity')
     TriggerServerEvent('stats:remove', 'Lung Capacity', 1)
     if math.random(1,50) > 20 then 
      TriggerEvent('chatMessage', '^5Smoking Kills ^0| ^1-1 Stamina')
      TriggerServerEvent('stats:remove', 'Stamina', 1)
     end
	end
	TaskStartScenarioInPlace(GetPlayerPed(-1), 'WORLD_HUMAN_SMOKING', 0, true)
end)

RegisterNetEvent('items:lockpick')
AddEventHandler('items:lockpick', function()
 local coords    = GetEntityCoords(GetPlayerPed(-1))
 if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
  local vehicle = nil
  if IsPedInAnyVehicle(playerPed, false) then
   vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
pickanim()
  else
   vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
  end

  if DoesEntityExist(vehicle) then
  	 RequestAnimDict('mp_common_heist')
	TaskPlayAnim(GetPlayerPed(-1), "mp_common_heist", "use_terminal_loop", 8.0, -8, -1, 49, 0, 0, 0, 0)
	Wait(3000)
	TaskPlayAnim(GetPlayerPed(-1), "mp_common_heist", "pick_door", 8.0, -8, -1, 49, 0, 0, 0, 0)
	FreezeEntityPosition(GetPlayerPed(-1), true)
	Citizen.CreateThread(function()
	 Citizen.Wait(7000)
	 FreezeEntityPosition(GetPlayerPed(-1), false)
	 SetVehicleDoorsLocked(vehicle, 1)
	 SetVehicleDoorsLockedForAllPlayers(vehicle, false)
	 ClearPedTasksImmediately(GetPlayerPed(-1))
	end)
  end
 end
end)


RegisterNetEvent('items:repair')
AddEventHandler('items:repair', function()
  local ped = GetPlayerPed(-1)
  local coords = GetEntityCoords(ped)
  if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
    local vehicle = nil
    if IsPedInAnyVehicle(ped, false) then
      vehicle = GetVehiclePedIsIn(ped, false)
    else
      vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
    end
    if DoesEntityExist(vehicle) then
      TaskStartScenarioInPlace(ped, "PROP_HUMAN_BUM_BIN", 0, true)
      Citizen.CreateThread(function()
        Citizen.Wait(15000)
        SetVehicleEngineHealth(vehicle, GetEntityMaxHealth(vehicle)/2)
        SetVehicleUndriveable(vehicle, false)
        SetVehicleBodyHealth(vehicle, GetEntityMaxHealth(vehicle)/4)
        ClearPedTasksImmediately(ped)
        exports['clrp_notify']:DoHudText('inform', "Vehicle Repaired")
      end)
    end
  end
end)

RegisterNetEvent('event:repair')
AddEventHandler('event:repair', function()
  local ped = GetPlayerPed(-1)
  local coords = GetEntityCoords(ped)
  if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
    local vehicle = nil
    if IsPedInAnyVehicle(ped, false) then
      vehicle = GetVehiclePedIsIn(ped, false)
    else
      vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
    end
    if DoesEntityExist(vehicle) then
      TaskStartScenarioInPlace(ped, "PROP_HUMAN_BUM_BIN", 0, true)
      Citizen.CreateThread(function()
        Citizen.Wait(10000)
        SetVehicleEngineHealth(vehicle, 1000)
        SetVehicleUndriveable(vehicle, false)
        SetVehicleBodyHealth(vehicle, 1000)
        ClearPedTasksImmediately(ped)
        exports['clrp_notify']:DoHudText('inform', "Vehicle Repaired")
      end)
    end
  end
end)

RegisterNetEvent('items:cleankit')
AddEventHandler('items:cleankit', function()
  local ped = GetPlayerPed(-1)
  local coords = GetEntityCoords(ped)
  if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
    local vehicle = nil
    if IsPedInAnyVehicle(ped, false) then
      vehicle = GetVehiclePedIsIn(ped, false)
    else
      vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
    end
    if DoesEntityExist(vehicle) then
	  TaskStartScenarioInPlace(ped, "WORLD_HUMAN_MAID_CLEAN", 0, true)
      Citizen.CreateThread(function()
        Citizen.Wait(20000)
        SetVehicleDirtLevel(vehicle, 0)
        ClearPedTasksImmediately(ped)
        exports['clrp_notify']:DoHudText('inform', "Vehicle Cleaned")
      end)
    end
  end
end)

RegisterNetEvent('items:umbrella')
AddEventHandler('items:umbrella', function()
	if prop ~= nil then
		DeleteObject(prop)
		prop = nil
		ClearPedTasks(GetPlayerPed(-1))
	else
		Citizen.CreateThread(function()
			local ped = GetPlayerPed(-1)

			RequestAnimDict("amb@world_human_aa_coffee@base")
			  
			while not HasAnimDictLoaded("amb@world_human_aa_coffee@base") do
				Citizen.Wait(0)
			end

			TaskPlayAnim(ped, "amb@world_human_aa_coffee@base", "base", 1.0, -1, -1, 49, 1, 0, 0, 0)

			local coords     = GetEntityCoords(ped)
			local bone       = GetPedBoneIndex(ped, 28422)

			RequestModel(GetHashKey('p_amb_brolly_01'))

			while not HasModelLoaded(GetHashKey('p_amb_brolly_01')) do
				Citizen.Wait(0)
			end

			prop = CreateObject(GetHashKey('p_amb_brolly_01'), coords.x, coords.y, coords.z, true, true, true)
			globalObject(prop)
			AttachEntityToEntity(prop, ped, bone, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)

			while prop ~= nil do
				Citizen.Wait(100)
				if IsPedInAnyVehicle(ped, false) or not IsEntityPlayingAnim(ped, "amb@world_human_aa_coffee@base", "base", 3) or IsPedArmed(ped, 7) then
					DeleteObject(prop)
					prop = nil
					ClearPedTasks(GetPlayerPed(-1))
				end

				ClearPedWetness(ped)
			end
		end)
	end
end)

--THREADS--

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		local lPed = GetPlayerPed(-1)

		if IsDrunk then
			StartScreenEffect("SuccessFranklin", 0, 0)
		end

		local vehicle = GetVehiclePedIsIn(lPed)

		if binoculars or (keybindEnabled and IsControlJustReleased(1, binocularKey)) then
			binoculars = true
			if not ( IsPedSittingInAnyVehicle( lPed ) ) then
				Citizen.CreateThread(function()
					TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_BINOCULARS", 0, 1)
					PlayAmbientSpeech1(GetPlayerPed(-1), "GENERIC_CURSE_MED", "SPEECH_PARAMS_FORCE")
				end)
			end

			Wait(2000)

			SetTimecycleModifier("default")

			SetTimecycleModifierStrength(0.3)

			local scaleform = RequestScaleformMovie("BINOCULARS")

			while not HasScaleformMovieLoaded(scaleform) do
				Citizen.Wait(10)
			end

			local lPed = GetPlayerPed(-1)
			local vehicle = GetVehiclePedIsIn(lPed)
			local cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA", true)

			AttachCamToEntity(cam, lPed, 0.0,0.0,1.0, true)
			SetCamRot(cam, 0.0,0.0,GetEntityHeading(lPed))
			SetCamFov(cam, fov)
			RenderScriptCams(true, false, 0, 1, 0)
			PushScaleformMovieFunction(scaleform, "SET_CAM_LOGO")
			PushScaleformMovieFunctionParameterInt(0) -- 0 for nothing, 1 for LSPD logo
			PopScaleformMovieFunctionVoid()

			while binoculars and not IsEntityDead(lPed) and (GetVehiclePedIsIn(lPed) == vehicle) and true do
				if IsControlJustPressed(0, storeBinoclarKey) then -- Toggle binoculars
					PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
					ClearPedTasks(GetPlayerPed(-1))
					binoculars = false
				end

				local zoomvalue = (1.0/(fov_max-fov_min))*(fov-fov_min)
				CheckInputRotation(cam, zoomvalue)

				HandleZoom(cam)
				HideHUDThisFrame()

				DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
				Citizen.Wait(10)
			end

			binoculars = false
			ClearTimecycleModifier()
			fov = (fov_max+fov_min)*0.5
			RenderScriptCams(false, false, 0, 1, 0)
			SetScaleformMovieAsNoLongerNeeded(scaleform)
			DestroyCam(cam, false)
			SetNightvision(false)
			SetSeethrough(false)
		end
	end
end)

--EVENTS--

-- Activate binoculars
RegisterNetEvent('items:binoculars')
AddEventHandler('items:binoculars', function()
	binoculars = not binoculars
end)

--FUNCTIONS--
function HideHUDThisFrame()
	HideHelpTextThisFrame()
	HideHudAndRadarThisFrame()
	HideHudComponentThisFrame(1) -- Wanted Stars
	HideHudComponentThisFrame(2) -- Weapon icon
	HideHudComponentThisFrame(3) -- Cash
	HideHudComponentThisFrame(4) -- MP CASH
	HideHudComponentThisFrame(6)
	HideHudComponentThisFrame(7)
	HideHudComponentThisFrame(8)
	HideHudComponentThisFrame(9)
	HideHudComponentThisFrame(13) -- Cash Change
	HideHudComponentThisFrame(11) -- Floating Help Text
	HideHudComponentThisFrame(12) -- more floating help text
	HideHudComponentThisFrame(15) -- Subtitle Text
	HideHudComponentThisFrame(18) -- Game Stream
	HideHudComponentThisFrame(19) -- weapon wheel
end

function CheckInputRotation(cam, zoomvalue)
	local rightAxisX = GetDisabledControlNormal(0, 220)
	local rightAxisY = GetDisabledControlNormal(0, 221)
	local rotation = GetCamRot(cam, 2)
	if rightAxisX ~= 0.0 or rightAxisY ~= 0.0 then
		new_z = rotation.z + rightAxisX*-1.0*(speed_ud)*(zoomvalue+0.1)
		new_x = math.max(math.min(20.0, rotation.x + rightAxisY*-1.0*(speed_lr)*(zoomvalue+0.1)), -89.5)
		SetCamRot(cam, new_x, 0.0, new_z, 2)
	end
end

function HandleZoom(cam)
	local lPed = GetPlayerPed(-1)
	if not ( IsPedSittingInAnyVehicle( lPed ) ) then

		if IsControlJustPressed(0,241) then -- Scrollup
			fov = math.max(fov - zoomspeed, fov_min)
		end
		if IsControlJustPressed(0,242) then
			fov = math.min(fov + zoomspeed, fov_max) -- ScrollDown
		end
		local current_fov = GetCamFov(cam)
		if math.abs(fov-current_fov) < 0.1 then
			fov = current_fov
		end
		SetCamFov(cam, current_fov + (fov - current_fov)*0.05)
	else
		if IsControlJustPressed(0,17) then -- Scrollup
			fov = math.max(fov - zoomspeed, fov_min)
		end
		if IsControlJustPressed(0,16) then
			fov = math.min(fov + zoomspeed, fov_max) -- ScrollDown
		end
		local current_fov = GetCamFov(cam)
		if math.abs(fov-current_fov) < 0.1 then -- the difference is too small, just set the value directly to avoid unneeded updates to FOV of order 10^-5
			fov = current_fov
		end
		SetCamFov(cam, current_fov + (fov - current_fov)*0.05) -- Smoothing of camera zoom
	end
end

function Drunk(anim)
 	Citizen.CreateThread(function()
	 
	    local playerPed = GetPlayerPed(-1)
	
	    RequestAnimSet(anim)
	      
	    while not HasAnimSetLoaded(anim) do
	        Citizen.Wait(0)
	    end
	    SetPedMovementClipset(playerPed, anim, true)
	end)

end

local prevtent = 0
local prevfire = 0
local prevchair = 0

RegisterNetEvent('items:tent')
AddEventHandler('items:tent', function() 
 if prevtent == 0 then
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.95))
    local tents = {
        'prop_skid_tent_01',
        'prop_skid_tent_01b',
        'prop_skid_tent_03',
    }
    local randomint = math.random(1,3)
    local tent = GetHashKey(tents[randomint])
    local prop = CreateObject(tent, x, y, z-0.95, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    prevtent = prop
 else
    SetEntityAsMissionEntity(prevtent)
    DeleteObject(prevtent)
    prevtent = 0
 end
end)

RegisterNetEvent('items:chair')
AddEventHandler('items:chair', function() 
 if prevchair == 0 then
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.02))
    local chair = {
        'prop_chair_02',
        'prop_chair_05',
		'prop_chair_10'
    }
    local randomint = math.random(1,3)
    local chair = GetHashKey(chair[randomint])
    local prop = CreateObject(chair, x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    prevchair = prop
 else
    SetEntityAsMissionEntity(prevchair)
    DeleteObject(prevchair)
    prevchair = 0
 end
end)

RegisterNetEvent('items:campfire')
AddEventHandler('items:campfire', function() 
 if prevfire == 0 then
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local prop = CreateObject(GetHashKey("prop_beach_fire"), x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    prevfire = prop
 else
    SetEntityAsMissionEntity(prevchair)
    DeleteObject(prevchair)
    prevchair = 0
 end
end)

RegisterNetEvent('ems:bandage')
AddEventHandler('ems:bandage', function()
 local health = GetEntityHealth(GetPlayerPed(-1))
 TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_BUM_WASH", 0, true)
 Wait(5000)
 TriggerEvent('hospital:client:ReduceBleed')
 ClearPedTasks(GetPlayerPed(-1))
 local newHealth = GetEntityMaxHealth(GetPlayerPed(-1))/4
 SetEntityHealth(GetPlayerPed(-1), math.floor(health+newHealth))
end)

local online_ems = 0
local online_cops = 0

RegisterNetEvent('hud:updatepresence')
AddEventHandler('hud:updatepresence', function(copss, emss)
 local online_ems = emss
 local online_cops = copss
end)

RegisterNetEvent('ems:medkit')
AddEventHandler('ems:medkit', function()
  local t, distance = GetClosestPlayer()
  if(distance ~= -1 and distance < 5) then
   TaskStartScenarioInPlace(GetPlayerPed(-1), 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
   Citizen.Wait(30000)
   ClearPedTasks(GetPlayerPed(-1))
   if math.random(1, 100) >= 85 then
	TriggerServerEvent('ems:revive', GetPlayerServerId(t))
		--TriggerEvent('hospital:client:ReduceBleed')
	--TriggerEvent('hospital:client:ReduceBleed')
   else
    ExecuteCommand('me still notices bleeding')
   end
  else
   TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_BUM_WASH", 0, true)
   Wait(5000)
   ClearPedTasks(GetPlayerPed(-1))
   SetEntityHealth(GetPlayerPed(-1), GetEntityMaxHealth(GetPlayerPed(-1)))
   end
end)

RegisterNetEvent('items:redbull')
AddEventHandler('items:redbull', function()
	local playerID = PlayerId()
	ClearPedTasksImmediately(GetPlayerPed(-1))
	ExecuteCommand('me drinks red bull')
	SetRunSprintMultiplierForPlayer(playerID, 1.39)
	Wait(15000)
	SetRunSprintMultiplierForPlayer(playerID, 1.00)
end)

RegisterNetEvent('items:weed')
AddEventHandler('items:weed', function() 
	if not IsPlayerDead(PlayerId()) then
		local playerPed = GetPlayerPed(-1)
		TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_SMOKING_POT", 0, true)
		Citizen.Wait(25000)
		DoScreenFadeOut(1000)
		Citizen.Wait(1000)
		if GetVehiclePedIsIn(playerPed, false) ~= 0 then
		 ClearPedTasks(GetPlayerPed(-1))
		end
		SetTimecycleModifier("spectator5")
		SetPedMotionBlur(GetPlayerPed(-1), true)
		SetPedIsDrunk(GetPlayerPed(-1), true)
		SetEntityHealth(playerPed, 200)
		DoScreenFadeIn(1000)
		Citizen.Wait(120000)
		DoScreenFadeOut(1000)
		Citizen.Wait(1000)
		DoScreenFadeIn(1000)
		ClearTimecycleModifier()
		ResetScenarioTypesEnabled()
		ResetPedMovementClipset(GetPlayerPed(-1), 0)
		SetPedIsDrunk(GetPlayerPed(-1), false)
		SetPedMotionBlur(GetPlayerPed(-1), false)
	end
end)

RegisterNetEvent('items:coke')
AddEventHandler('items:coke', function()
	local playerID = PlayerId()
    ClearPedTasksImmediately(GetPlayerPed(-1))
    Citizen.Wait(500)
    DoScreenFadeOut(500)
	Citizen.Wait(500)
    SetTimecycleModifier("spectator3")
	SetPedMotionBlur(GetPlayerPed(-1), true)
	DoScreenFadeIn(500)
	SetRunSprintMultiplierForPlayer(playerID, 1.49)
	Wait(30000)
	SetRunSprintMultiplierForPlayer(playerID, 1.00)
	DoScreenFadeOut(500)
	Citizen.Wait(500)
	DoScreenFadeOut(500)
	Citizen.Wait(500)
	DoScreenFadeIn(500)
	ClearTimecycleModifier()
	SetPedMotionBlur(GetPlayerPed(-1), false)
end)

RegisterNetEvent('items:meth')
AddEventHandler('items:meth', function()
    Citizen.Wait(500)
    DoScreenFadeOut(500)
	Citizen.Wait(500)
    SetTimecycleModifier("spectator5")
    SetPedMotionBlur(GetPlayerPed(-1), true)
	DoScreenFadeIn(500)
    if GetPedArmour(ped) >= 50 then
		SetPedArmour(GetPlayerPed(-1), 100) 
	elseif GetPedArmour(ped) >= 0 then
		SetPedArmour(GetPlayerPed(-1), 50)
	end	
	Wait(240000)
	DoScreenFadeOut(500)
	Citizen.Wait(500)
	DoScreenFadeOut(500)
	Citizen.Wait(500)
	DoScreenFadeIn(500)
	ClearTimecycleModifier()
	SetPedArmour(GetPlayerPed(-1), 0)
end)

RegisterNetEvent('items:heroin')
AddEventHandler('items:heroin', function()
	Citizen.Wait(500)
    DoScreenFadeOut(500)
	Citizen.Wait(500)
    SetTimecycleModifier("spectator3")
    SetPedMotionBlur(GetPlayerPed(-1), true)
	DoScreenFadeIn(500)
    if GetPedArmour(ped) >= 50 then
		SetPedArmour(GetPlayerPed(-1), 100) 
	elseif GetPedArmour(ped) >= 0 then
		SetPedArmour(GetPlayerPed(-1), 50)
	end	
	Wait(240000)
	DoScreenFadeOut(500)
	Citizen.Wait(500)
	DoScreenFadeOut(500)
	Citizen.Wait(500)
	DoScreenFadeIn(500)
	ClearTimecycleModifier()
end)

local mask = nil
local tank = nil

RegisterNetEvent('items:oxygen_mask')
AddEventHandler('items:oxygen_mask', function()
	local coords     = GetEntityCoords(GetPlayerPed(-1))
	local boneIndex  = GetPedBoneIndex(GetPlayerPed(-1), 12844)
	local boneIndex2 = GetPedBoneIndex(GetPlayerPed(-1), 24818)
	mask = CreateObject(GetHashKey('p_s_scuba_mask_s'), coords.x, coords.y, coords.z - 3, true, false, true)
	tank = CreateObject(GetHashKey('p_s_scuba_tank_s'), coords.x, coords.y, coords.z - 3, true, false, true)

	AttachEntityToEntity(tank, GetPlayerPed(-1), boneIndex2, -0.30, -0.22, 0.0, 0.0, 90.0, 180.0, true, true, false, true, 1, true)
	AttachEntityToEntity(mask, GetPlayerPed(-1), boneIndex, 0.0, 0.0, 0.0, 0.0, 90.0, 180.0, true, true, false, true, 1, true)
	SetPedDiesInWater(GetPlayerPed(-1), false)
	oxygenCapacity = 100
	oxygenTank = true
end)

RegisterNetEvent('items:bulletproof_vest')
AddEventHandler('items:bulletproof_vest', function()
	SetPedComponentVariation(GetPlayerPed(-1), 9, 27, 5, 2)
	AddArmourToPed(GetPlayerPed(-1), 100)
	SetPedArmour(GetPlayerPed(-1), 100)
end)

Citizen.CreateThread(function()
 while true do
 Wait(5)
  if oxygenTank then
   drawUI(0.514, 1.376, 1.0, 1.0, 0.42, "~o~OXYGEN LEVEL: ~w~"..oxygenCapacity, 255, 255, 255, 255, false)
  end
 end    
end)

Citizen.CreateThread(function()
 while true do
  Wait(2500)
  if oxygenTank then 
   oxygenCapacity = oxygenCapacity-1
   if oxygenCapacity == 1 then 
    oxygenTank = false 
    SetPedDiesInWater(GetPlayerPed(-1), true)
 	DeleteObject(tank)
	DeleteObject(mask)
	ClearPedSecondaryTask(GetPlayerPed(-1))
   end
  end
 end    
end)


function drawUI(x,y ,width,height,scale, text, r,g,b,a, center)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
	SetTextCentre(center)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

local FlashLightWeapons = {
	["WEAPON_PISTOL"] = "COMPONENT_AT_PI_FLSH",
	["WEAPON_PISTOL50"] = "COMPONENT_AT_PI_FLSH",
	["WEAPON_COMBATPISTOL"] = "COMPONENT_AT_PI_FLSH",
	["WEAPON_APPISTOL"] = "COMPONENT_AT_PI_FLSH",
	["WEAPON_HEAVYPISTOL"] = "COMPONENT_AT_PI_FLSH",
	["WEAPON_SMG"] = "COMPONENT_AT_AR_FLSH",
	["WEAPON_MICROSMG"] = "COMPONENT_AT_PI_FLSH",
	["WEAPON_ASSAULTSMG"] = "COMPONENT_AT_AR_FLSH",
	["WEAPON_COMBATPDW"] = "COMPONENT_AT_AR_FLSH",
	["WEAPON_ASSAULTRIFLE"] = "COMPONENT_AT_AR_FLSH",
	["WEAPON_CARBINERIFLE"] = "COMPONENT_AT_AR_FLSH",
	["WEAPON_ADVANCEDRIFLE"] = "COMPONENT_AT_AR_FLSH",
	["WEAPON_SPECIALCARBINE"] = "COMPONENT_AT_AR_FLSH",
	["WEAPON_BULLPUPRIFLE"] = "COMPONENT_AT_AR_FLSH",
	["WEAPON_ASSAULTSHOTGUN"] = "COMPONENT_AT_AR_FLSH",
	["WEAPON_HEAVYSHOTGUN"] = "COMPONENT_AT_AR_FLSH",
	["WEAPON_BULLPUPSHOTGUN"] = "COMPONENT_AT_AR_FLSH",
	["WEAPON_PUMPSHOTGUN"] = "COMPONENT_AT_AR_FLSH",
	["WEAPON_MARKSMANRIFLE"] = "COMPONENT_AT_AR_FLSH",
}

RegisterNetEvent('items:flashlight')
AddEventHandler('items:flashlight', function()
 local CurrentWeaponHash = GetSelectedPedWeapon(GetPlayerPed(-1))
 for k, v in pairs(FlashLightWeapons) do	 
  if GetHashKey(k) == CurrentWeaponHash then 
   if HasPedGotWeaponComponent(GetPlayerPed(-1), CurrentWeaponHash, GetHashKey(v)) then
    RemoveWeaponComponentFromPed(GetPlayerPed(-1), CurrentWeaponHash, GetHashKey(v))
   else
   	GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey(k), GetHashKey(v))
   end
  end
 end
end)

