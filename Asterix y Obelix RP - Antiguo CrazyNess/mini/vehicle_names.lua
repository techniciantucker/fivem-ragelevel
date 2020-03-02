function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end
Citizen.CreateThread(function()
    AddTextEntry('cooperworks', 'Mini Cooper') -- Enter Gamename from vehicles.lua and what you want it to display.
    AddTextEntry('COOPERS', '1965 Austin Mini Cooper')
end)