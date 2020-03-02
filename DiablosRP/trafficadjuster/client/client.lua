--			Sync Traffic | Alter Traffic and Vechile Spawns					--
--				By DK - 2019...	Dont forget your Bananas!					--
------------------------------------------------------------------------------

------------------------------------------------------------------------------
--	Global Variables
------------------------------------------------------------------------------



------------------------------------------------------------------------------
--	Local Variables
------------------------------------------------------------------------------



------------------------------------------------------------------------------
--	Local Functions
------------------------------------------------------------------------------

function Clients()
	local Count = 0
	Config.iPlayers = Count
	for _,v in ipairs(GetActivePlayers()) do
		Count = Count + 1
	end
	if (Count ~= nil) then
		Config.iPlayers = (Count * Config.Static)
	end
end

------------------------------------------------------------------------------
--	Events
------------------------------------------------------------------------------



------------------------------------------------------------------------------
--	Threads
------------------------------------------------------------------------------

Citizen.CreateThread(function()
	local iPlayer = GetEntityCoords(PlayerPedId())			-- Your Ped as an Entity. Vector3 (x,y,z)
	DisablePlayerVehicleRewards(PlayerId())					-- Call it once.
	SetAudioFlag("PoliceScannerDisabled", true)				-- Call it once.

	while true do
		Citizen.Wait(0)
		
		for i = 0, 20 do									-- For all gangs and emergancy services.	
			EnableDispatchService(i, Config.Dispatch)		-- Disable responding/dispatch.
		end
		
		if (Config.Wanted and GetPlayerWantedLevel(PlayerId()) > 0) then
            SetPlayerWantedLevel(PlayerId(), 0, false)
            SetPlayerWantedLevelNow(PlayerId(), false)
        end
		
		SetVehicleDensityMultiplierThisFrame((Config.TrafficX - Config.iPlayers) / Config.Divider)
		SetPedDensityMultiplierThisFrame((Config.PedestrianX - Config.iPlayers) / Config.Divider)
		SetRandomVehicleDensityMultiplierThisFrame((Config.TrafficX - Config.iPlayers) / Config.Divider)
		SetParkedVehicleDensityMultiplierThisFrame((Config.ParkedX - Config.iPlayers) / Config.Divider)
		SetScenarioPedDensityMultiplierThisFrame((Config.PedestrianX - Config.iPlayers) / Config.Divider, (Config.PedestrianX - Config.iPlayers) / Config.Divider)

		RemoveVehiclesFromGeneratorsInArea(iPlayer.x - 52.0, iPlayer.y - 52.0, iPlayer.z - 15.0, iPlayer.x + 52.0, iPlayer.y + 52.0, iPlayer.z + 15.0);
		
		ClearAreaOfCops(iPlayer.x, iPlayer.y, iPlayer.z, 5000.0)
		
		SetGarbageTrucks(false)
		SetRandomBoats(true)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60000)		
		Clients()
	end
end)

Citizen.CreateThread(function()
  SwitchTrainTrack(0, true)
  SwitchTrainTrack(3, true)
  N_0x21973bbf8d17edfa(0, 120000)
  SetRandomTrains(true)
end)

------------------------------------------------------------------------------