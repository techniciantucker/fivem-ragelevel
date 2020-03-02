function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end
Citizen.CreateThread(function()
    AddTextEntry('T20', 'Jaguar T20') -- Enter Gamename from vehicles.lua and what you want it to display.
    AddTextEntry('EAGLE', 'Jaguar Eagle')
	AddTextEntry('project7', 'Jaguar Project 7')
end)