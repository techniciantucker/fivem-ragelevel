function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end
Citizen.CreateThread(function()
    AddTextEntry('MODELS', 'Tesla Model S') -- Enter Gamename from vehicles.lua and what you want it to display.
    AddTextEntry('MODEL3', 'Tesla Model 3')
    AddTextEntry('teslax', 'Tesla Model X')
end)