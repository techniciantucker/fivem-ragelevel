function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end
Citizen.CreateThread(function()
    AddTextEntry('RATTFUKT', 'Dooms Day Hauler') -- Enter Gamename from vehicles.lua and what you want it to display.
    AddTextEntry('kitt', 'Knight Industries 2000')
    AddTextEntry('VINDICATOR', 'Kaneda Hyperbike')
end)