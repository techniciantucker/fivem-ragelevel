---------------------------------
-- Created By Toni Morton      --
-- Please, Leave these credits --
-- Edited By Avery M. --
---------------------------------

RegisterNetEvent("TrafficAlert")
AddEventHandler("TrafficAlert",function()
		DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 20)
		local input = true
		Citizen.CreateThread(function()
		while input do
		if input == true then
		HideHudAndRadarThisFrame()
		if UpdateOnscreenKeyboard() == 3 then
		input = false
		elseif UpdateOnscreenKeyboard() == 1 then
		local inputText = GetOnscreenKeyboardResult()
		if string.len(inputText) > 0 then
		TriggerServerEvent('SyncTrafficAlert', inputText)
		input = false
		else
			DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 20)
		end
		elseif UpdateOnscreenKeyboard() == 2 then
		input = false
		end
		end
		 Citizen.Wait(0)
		 end
			
end)
end)

RegisterNetEvent('DisplayTrafficAlert')
AddEventHandler('DisplayTrafficAlert',function(inputText)

SetNotificationTextEntry("STRING");
AddTextComponentString(inputText);
SetNotificationMessage("CHAR_LIFEINVADER", "CHAR_LIFEINVADER", true, 1, "~y~San Andreas News~s~", "");
DrawNotification(false, true);

end)


---------------------------------
-- Created By Toni Morton      --
-- Please, Leave these credits --
---------------------------------