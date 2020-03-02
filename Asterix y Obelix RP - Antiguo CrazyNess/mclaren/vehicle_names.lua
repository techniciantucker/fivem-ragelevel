function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end
Citizen.CreateThread(function()
    AddTextEntry('SPYKER', '2008 McLaren Spyker C12') -- Enter Gamename from vehicles.lua and what you want it to display.
    AddTextEntry('MOSS', '2009 McLaren Sterling Moss')
    AddTextEntry('P1', '2014 McLaren P1')
    AddTextEntry('Turismo', 'McLaren Vulcan')
    AddTextEntry('720s', '2019 McLaren 720S')
	--AddTextEntry('', '')
end)