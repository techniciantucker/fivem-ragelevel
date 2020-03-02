Citizen.CreateThread(function()
	while true do

		SetDiscordAppId(582599532404277257)

		SetDiscordRichPresenceAsset('logo_imagen')
        
	
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1500)
		players = {}
		for i = 0, 254 do
			if NetworkIsPlayerActive( i ) then
				table.insert( players, i )
			end
		end
		SetRichPresence(GetPlayerName(PlayerId()) .. " [".. #players .. "/128]")
	end
end)
        --It updates every one minute just in case.
		Citizen.Wait(60000)
	end
end)