function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end
Citizen.CreateThread(function()
    AddTextEntry('DLOADER', 'Duneloader') -- Enter Gamename from vehicles.lua and what you want it to display.
    AddTextEntry('DLOADER3', 'Duneloader 6W')
    AddTextEntry('DLOADER4', 'Duneloader 6W King Cab')
    AddTextEntry('DLOADER5', 'Duneloader King Cab')
end)