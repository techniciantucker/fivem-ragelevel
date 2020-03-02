function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end
Citizen.CreateThread(function()
    AddTextEntry('2017CHIRON', '2017 Bugatti Chiron') -- Enter Gamename from vehicles.lua and what you want it to display.
    AddTextEntry('2019CHIRON', '2019 Bugatti Chiron Sport')
end)