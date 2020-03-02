Citizen.CreateThread(function()
	while true do
        --This is the Application ID (Replace this with you own)
		SetDiscordAppId(662805058856943640)

        --Here you will have to put the image name for the "large" icon.
		SetDiscordRichPresenceAsset('logo')
        
        --(11-11-2018) New Natives:

        --Here you can add hover text for the "large" icon.
        SetDiscordRichPresenceAssetText('ProLife #64 SLOTS')
       
        --Here you will have to put the image name for the "small" icon.
        SetDiscordRichPresenceAssetSmall('sin_t_tulo-1')

        --Here you can add hover text for the "small" icon.
        SetDiscordRichPresenceAssetSmallText('Únete a Nuestro Discord "https://discord.gg/7PSyKgs"')

        --It updates every one minute just in case.
		Citizen.Wait(1)
	end
end)