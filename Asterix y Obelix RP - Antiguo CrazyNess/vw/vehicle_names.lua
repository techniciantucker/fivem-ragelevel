function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end
Citizen.CreateThread(function()
    AddTextEntry('beetle74', '1974 Volkswagen Beetle') -- Enter Gamename from vehicles.lua and what you want it to display.
    AddTextEntry('PASSATR', 'VW Passat R Line')
    AddTextEntry('VWVOLEXT2', 'Volkswagen Voltex')
    AddTextEntry('rabbit', '1984 Volkswagen Rabbit')
    AddTextEntry('jetta', '2015 Volkswagen Jetta')
    AddTextEntry('golfgti', '2006 Volkswagen Golf')
end)