function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end
Citizen.CreateThread(function()
    AddTextEntry('twizy', 'Renault Twizy') -- Enter Gamename from vehicles.lua and what you want it to display.
    --AddTextEntry('gameName', 'Display_name')
end)